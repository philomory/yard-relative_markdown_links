# frozen_string_literal: true

require_relative "../test_helper"

module YARD
  class RelativeMarkdownLinksTest < Minitest::Test
    def setup
      @template = Class.new {
        include YARD::Templates::Helpers::MarkupHelper
        prepend YARD::RelativeMarkdownLinks

        def resolve_links(text)
          text
        end
      }.new
    end

    def test_relative_markdown_links
      input = <<~HTML
        <p>Hello, <a href="world.md">World</a></p>
      HTML

      expected_output = <<~HTML
        <p>Hello, {file:world.md World}</p>
      HTML

      assert_equal expected_output, @template.resolve_links(input)
    end

    def test_absolute_markdown_links
      input = <<~HTML
        <p>Hello, <a href="https://github.com/haines/yard-relative_markdown_links/blob/master/README.md">World</a></p>
      HTML

      assert_equal input, @template.resolve_links(input)
    end
  end
end
