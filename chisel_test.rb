gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'chisel'

class ChiselTest < MiniTest::Test
	def test_pounder_works
		parser = Chisel.new
		assert_equal "<h2>hello</h2>\n\n",parser.pound_to_header("## hello")
	end

	def test_emphasizer_works
		parser = Chisel.new
		sentence = "\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in\n**Food & Wine** this place has been packed every night.\""
		new_sentence = "\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in\n<strong>Food &amp; Wine</strong> this place has been packed every night.\""
		assert_equal  new_sentence, parser.emphasizer(sentence)
	end

	def test_paragrapher_works
		parser = Chisel.new
		paragraph =  "\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in\n**Food & Wine** this place has been packed every night.\""
		new_paragraph = "<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in\nstrong>Food &amp; Wine</strong> this place has been packed every night.\"\n</p>\n"
		assert_equal new_paragraph, parser.paragrapher(paragraph)
	end
end
