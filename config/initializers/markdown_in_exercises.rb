# frozen_string_literal: true

require "decidim_hacks/parser_helper"

Rails.application.config.to_prepare do

  # Parse markdown content if is an example
  Decidim::Proposals::ProposalPresenter.class_eval do
    include DecidimHacks::ParserHelper

    def body(links: false, extras: true, strip_tags: false)
      text = proposal.body
      # Speciall render for course exercises (markdown processing)
      if participatory_space_slug.start_with? "level"
        text = md_render(text)
        # hack to avoid the replacement of lines to <br> that simple_format does
        return text.gsub(">\n",">").gsub("\n<","<")
      end
      text = strip_tags(text) if strip_tags

      renderer = Decidim::ContentRenderers::HashtagRenderer.new(text)
      text = renderer.render(links: links, extras: extras).html_safe

      text = Decidim::ContentRenderers::LinkRenderer.new(text).render if links
      text
    end

    def participatory_space_slug
      begin
        proposal.participatory_space.slug
      rescue
        ""
      end
    end
  end
end