require_relative 'node'

module SmallCCompiler
	class ParameterNode < Node
		attr_reader :type, :id

		def initialize(args)
			@lineno = args[:lineno]
			@type = args[:type]
			@id = args[:id]
			@pointer = args[:pointer]
		end

		def semantic_analysis(env)
			env.register self
			self
		end

		def get_type
			raise "TypeError argument may not have 'void' type" if @type == 'void'

			type = {
				:type => @type,
				:pointer => (@pointer) ? 1 : 0
			}
			type
		end

		def to_original_code
			"#{@type} #{@pointer ? "*" : ''}#{@id}"
		end
	end
end
