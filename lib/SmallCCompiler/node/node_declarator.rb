require_relative 'node'

module SmallCCompiler
	class DeclaratorNode < Node
		attr_reader :id, :size
		attr_accessor :type

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@size = args[:size] || 0
			@pointer = args[:pointer]
		end

		def semantic_analysis(env)
			env.register self

			self
		end

		def get_type
			raise "TypeError: near line #{@lineno} : variable has invalid type 'void'"	if @type == "void"

			p = 0
			p += 1 if @size > 0
			p += 1 if @pointer


			type = {
				:type => @type,
				:pointer => p
			}
			type
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
