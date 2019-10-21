module DecidimHacks
	module ParserHelper

		def replace_image(text, image, replacement)
			text.gsub!("<img src=\"#{image}\"", "<img src=\"#{replacement}\"")
		end

		def extract_images(text)
			text.scan(/<img src="([^\"]+)"/).pluck 0
		end

		def multi_render(text)
			if text.respond_to? :each
				text.each do |key, value|
					text[key] = render value
				end
			else
				text = render text
			end
			text
		end

		def render(text)
			markdown.render(text)
		end

		def markdown
		  @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(lax_spacing: true, hard_wrap: true), extensions = {})
		end
	end
end