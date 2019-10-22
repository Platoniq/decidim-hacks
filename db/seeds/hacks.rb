# frozen_string_literal: true

# Tune a little the default seeds to add meaningful content
require "decidim_hacks/parser_helper"

include DecidimHacks::ParserHelper

if !Rails.env.production? || ENV["SEED"]
	puts "Creating custom content for the hacking course..."

  seeds_root = File.join(__dir__)
  content_root = File.join(seeds_root, 'content')

	organization = Decidim::Organization.first
  organization.name = "Hacking Decidim"
  organization.description = {
    en: "<p>Learn how to hack and manipulate the default Decidim UI/UX and more advanced tunings.</p>"
  }

  organization.cta_button_path = "processes/level1"
  organization.cta_button_text = {
    en: "Go to lessons"
  }
  organization.logo = File.new(File.join(seeds_root, "logo_platoniq_white.png"))
  organization.save!

  # Create/update processes that will hold the examples
  image = File.new(File.join(seeds_root, "beginners.jpg"))
  process = YAML.load_file(File.join(content_root, 'processes.yml'))

  params = {
    slug: 'level1',
    hero_image: image,
    banner_image: image,
    promoted: true,
    organization: organization,
    end_date: 2.months.from_now,
  }
  process["level1"].each do |key, text|
    text = multi_render(text) if key.in? ["short_description", "description"]
    params[key] = text
  end

  level1 = Decidim::ParticipatoryProcess.find_by(slug: 'level1') || Decidim::ParticipatoryProcess.create!(params.merge({
    start_date: Date.current,
    published_at: 2.weeks.ago,
  }))
  level1.update_attributes params
  level1.save!

  extract_images_from_html(level1.description["en"]).each do |image|
    # file uploads
    Decidim::Attachment.find_by(title: {en: image}).try(:destroy)
    attach = Decidim::Attachment.create!(
        title: {en: image},
        file: File.open(File.join(seeds_root, image)),
        attached_to: level1
      )
    replace_html_image(level1.description["en"], image, attach.url)
  end
  level1.save!

  hero_content_block = Decidim::ContentBlock.find_by(organization: organization, manifest_name: :hero, scope: :homepage)
  # hero_content_block.images_container.background_image = File.new(File.join(seeds_root, "homepage_image.jpg"))
  hero_content_block.settings = {
    welcome_text_en: "How to personalize Decidim, hacks and tricks!"
  }
  hero_content_block.save!

  # Proposals for level1
  params = {
    name: {
      en: "Exercises"
    },
    manifest_name: :proposals,
    published_at: Time.current,
    participatory_space: level1,
  }
  example1 = Decidim::Component.find_by(participatory_space_type: "Decidim::ParticipatoryProcess",
                                         participatory_space_id: level1.id,
                                         name: {en: "Exercises"}) || Decidim::Component.create!(params)

  exercises = YAML.load_file(File.join(content_root, 'proposals.yml'))
  exercises.each do |key, parts|
    params = {
      component: example1,
      title: "[#{key}] #{parts['title']}",
      body: parts['body'],
      answered_at: Time.current,
      published_at: Time.current
    }
    proposal = find_exercise(example1.id, key) || Decidim::Proposals::Proposal.new(params)
    proposal.add_coauthor(organization)
    proposal.save!
    extract_images_from_md(params[:body]).each do |image|
      # file uploads
      Decidim::Attachment.find_by(title: {en: image}).try(:destroy)
      attach = Decidim::Attachment.create!(
          title: {en: image},
          file: File.open(File.join(seeds_root, image)),
          attached_to: proposal
        )
      replace_md_image(params[:body], image, attach.url)
    end

    extract_links_from_md(params[:body]).each do |link|
      # find proposal
      exercise = find_exercise(example1.id, link.sub("/",""))
      replace_md_link(params[:body], link, Decidim::ResourceLocatorPresenter.new(exercise).url)
    end
    proposal.update_attributes params
    proposal.save!
  end
end
