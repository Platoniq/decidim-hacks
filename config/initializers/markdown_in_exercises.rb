# frozen_string_literal: true

Rails.application.config.to_prepare do

  # Parse markdown content if is an example
  Decidim::Proposals::ProposalPresenter.class_eval do
    def body(links: false, extras: true, strip_tags: false)
      text = proposal.body
      text = strip_tags(text) if strip_tags

      renderer = Decidim::ContentRenderers::HashtagRenderer.new(text)
      text = renderer.render(links: links, extras: extras).html_safe

      text = Anchored::Linker.auto_link(text, target: "_blank", rel: "noopener") if links
      if proposal.component.name == {"en" => "Exercises"} && proposal.try(:official?)
        text = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(text)
      end
      text
    end
  end
end