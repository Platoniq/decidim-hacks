# frozen_string_literal: true

require "decidim_hacks/parser_helper"

Rails.application.config.to_prepare do

  # Parse markdown content if is an example
  Decidim::Proposals::ProposalPresenter.class_eval do
    include DecidimHacks::ParserHelper

    def body(links: false, extras: true, strip_tags: false)
      text = proposal.body
      if proposal.component.name == {"en" => "Exercises"} && proposal.try(:official?)
        text = md_render(text)
        # hack to avoid the replacement of lines to <br> that simple_format does
        return gsub(">\n",">").gsub("\n<","<")
      end

      text = strip_tags(text) if strip_tags

      renderer = Decidim::ContentRenderers::HashtagRenderer.new(text)
      text = renderer.render(links: links, extras: extras).html_safe

      Anchored::Linker.auto_link(text, target: "_blank", rel: "noopener") if links
    end
  end
end