
class LineAnalyzer
	attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
	def initialize content, line_number
		#@highest_wf_count
		#@highest_wf_words
		@content = content.chomp
		@line_number = line_number
		calculate_word_frequency
	end

	def calculate_word_frequency
		@highest_wf_count = Hash.new(0)
		@content.split.each do |word|
			@highest_wf_count[word.downcase] += 1
		end
		values = []
		@highest_wf_count.each do |k, v|
			values.push v
			#p v
		end
		maximum = values.max 
		@highest_wf_words = @highest_wf_count.select do |k, v| 
			v == maximum
		end
		keys = @highest_wf_words.keys
		count = @highest_wf_words.values
		@highest_wf_words = keys
		@highest_wf_count = values.max
		@highest_wf_words
	end
end

class Solution
	attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
	def initialize 
		@analyzers = []
		#analyze_file
	end

	def analyze_file (file = 'test.txt')
		fh = File.open(file)
		#@analyzers = []
		line_num = 0
		fh.each do |line| 
			@analyzers.push(LineAnalyzer.new line, line_num += 1)
		end
	end

	def calculate_line_with_highest_frequency
		#Find the number that represents the highest freq:
		highest_freq = []
		@analyzers.each do |e|
			highest_freq.push e.highest_wf_count
		end
		@highest_count_across_lines = highest_freq.max 
		@highest_count_words_across_lines = @analyzers.select do |e|
			e.highest_wf_count == highest_count_across_lines
		end
		@highest_count_words_across_lines
	end

	def print_highest_word_frequency_across_lines
		puts "The following words have the highest word frequency per line:"
		@highest_count_words_across_lines.each do |e|
			puts "#{e.highest_wf_words} (appears in line #{e.line_number})"
		end
	end
end

#solution = Solution.new
#solution.calculate_line_with_highest_frequency
#solution.print_highest_word_frequency_across_lines











