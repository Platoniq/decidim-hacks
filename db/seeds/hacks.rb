# frozen_string_literal: true

# Tune a little the default seeds to add meaningful content
require "decidim_hacks/parser_helper"
require "decidim_hacks/seed_helper"

include DecidimHacks::ParserHelper
include DecidimHacks::SeedHelper

if !Rails.env.production? || ENV["SEED"]
	puts "Creating custom content for the hacking course..."

  seeds_root = File.join(__dir__)
  content_root = File.join(seeds_root, 'content')

	organization = Decidim::Organization.first
  organization.name = "Hacking Decidim"
  organization.description = {
    en: "<p>Learn how to hack and manipulate the default Decidim UI/UX and more advanced tunings.</p>"
  }

  organization.cta_button_path = "processes"
  organization.cta_button_text = {
    en: "Go to lessons"
  }
  organization.logo = File.new(File.join(seeds_root, "logo_platoniq_white.png"))
  organization.save!


  hero_content_block = Decidim::ContentBlock.find_by(organization: organization, manifest_name: :hero, scope: :homepage)
  # hero_content_block.images_container.background_image = File.new(File.join(seeds_root, "homepage_image.jpg"))
  hero_content_block.settings = {
    welcome_text_en: "How to personalize Decidim, hacks and tricks!"
  }
  hero_content_block.save!

  help = Decidim::ContextualHelpSection.find_by(section_id: "participatory_processes")
  if help
    help.content = { en: "<p>Find the exercices as proposals of a process here</p>" }
    help.save!
  end

  DecidimHacks::SeedHelper.class_variable_set(:@@seeds_root, seeds_root)
  DecidimHacks::SeedHelper.class_variable_set(:@@content_root, content_root)
  DecidimHacks::SeedHelper.class_variable_set(:@@organization, organization)

  unpromote_all
  # Create/update processes that will hold the examples
  seed_process('processes.yml')

end
