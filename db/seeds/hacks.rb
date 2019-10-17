# Tune a little the default seeds to add meaningful content

if !Rails.env.production? || ENV["SEED"]
	puts "Creating custom content for the hacking course..."

  seeds_root = File.join(__dir__)

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
  params = {
    title: {
      en: "Hacking examples (level 1)"
    },
    slug: 'level1',
    subtitle: {
      en: "Learn some basics to customize Decidim"
    },
    hashtag: "#decidim-hacks",
    short_description: {
      en: '<p>This lesson covers some basics customizations.</p>'
    },
    description: {
      en: '<p style="font-size:0.8em">Photo credits: <em>Beginners by <a href="http://www.nyphotographic.com/">Nick Youngson</a> <a rel="license" href="https://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA 3.0</a> <a href="http://www.imagecreator.co.uk/">ImageCreator</a></em></p>'
    },
    hero_image: image,
    banner_image: image,
    promoted: true,
    organization: organization,
    developer_group: {
      en: "Platoniq"
    },
    local_area: {
      en: "The Internet"
    },
    target: {
      en: "Coders starting with Decidim"
    },
    end_date: 2.months.from_now,
  }
  level1 = Decidim::ParticipatoryProcess.find_by(slug: 'level1') || Decidim::ParticipatoryProcess.create!(params.merge({
    start_date: Date.current,
    published_at: 2.weeks.ago,
  }))
  level1.update_attributes params
  level1.save!

  hero_content_block = Decidim::ContentBlock.find_by(organization: organization, manifest_name: :hero, scope: :homepage)
  # hero_content_block.images_container.background_image = File.new(File.join(seeds_root, "homepage_image.jpg"))
  hero_content_block.settings = {
    welcome_text_en: "How to personalize Decidim, hacks and tricks!"
  }
  hero_content_block.save!

end