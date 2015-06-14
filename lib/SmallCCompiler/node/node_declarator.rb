require_relative 'node'

module SmallCCompiler
	class DeclaratorNode < Node
		attr_reader :id, :size

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@size = args[:size] || 0
			@pointer = args[:pointer]
		end

		def to_original_code
			"#{@pointer ? "*" : ""}#{@id}#{get_original_postfix}"
		end

		private

		def get_original_postfix
			if @size > 0
				"[#{@size}]"
			else
				''
			end
		end
	end
end
