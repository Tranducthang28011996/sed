module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title }
	end

	def markdown(text)
		options = { :autolink => true, :hard_wrap => true, :filter_html => true, :no_intra_emphasis => true, :fenced_code_blocks => true }
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
		markdown.render(text).html_safe
	end
end
