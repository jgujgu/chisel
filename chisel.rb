require 'byebug'
class Chisel
	def initialize
		@new_document = []
		@string = []
	end

	def parse(document)
		@document = document.split(/\n\n/)
		@document.each do |x|
			x = x.delete("\t")
			if x[0] == "#"
				@new_document << pound_to_header(x) 
			else
				@new_document << paragrapher(x)
			end
		end
		@new_document.join
	end

	def pound_to_header(string)
		pound_count = string.count("#")
		"<h#{pound_count}>"+string[pound_count+1..string.length]+"</h#{pound_count}>\n\n"
	end

	def paragrapher(string)
		new_string = "<p>\n" + emphasizer(string) + "\n</p>\n"
	end

	def emphasizer(string)
		new_string = string
		emphasized = nil
		while new_string[/\*.+\*/] != nil
			asterisk_phrase = new_string[/\*.+\*/]
			case asterisk_phrase.count("*")
			when 2
				emphasized = "<em>" + asterisk_phrase[1..asterisk_phrase.length-2] + "</em>"
				new_string = new_string.gsub(asterisk_phrase, emphasized)
			when 4
				emphasized = "<strong>" + asterisk_phrase[2..asterisk_phrase.length-3] + "</strong>"
				new_string = new_string.gsub(asterisk_phrase, emphasized)
			end
		end
		new_string = new_string.gsub("&", "&amp;")
	end
end

# 1. convert document to string array by newlines
# 2. get rid of whitespace
# 3. for strings that begin with pound, count the occurences and put hpound around
# 	the string
# 4. for strings without this, split according to asterisk_phrases
# 5. find the number of asterisk_phrases + 1 and then pad with either <em> or <strong
# 6. join these originals then pad with <p>

if __FILE__ == $0
	document = '# My Life in Desserts

	## Chapter 1: The Beginning

	"You just *have* to try the cheesecake," he said. "Ever since it appeared in
	**Food & Wine** this place has been packed every night."'

	parser = Chisel.new
	output = parser.parse(document)
	puts output

	# parser = Chisel.new
	# paragraph =  "\"You just *have* to try the cheesecake,\" he said. \"Ever since it appeared in\n**Food & Wine** this place has been packed every night.\""
	# new_paragraph = "<p>\n\"You just <em>have</em> to try the cheesecake,\" he said. \"Ever since it appeared in\nstrong>Food & Wine</strong> this place has been packed every night.\"\n</p>\n"
	# puts parser.paragrapher(paragraph)
end
