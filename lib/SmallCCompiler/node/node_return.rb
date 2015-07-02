require_relative 'node'

module SmallCCompiler
	class ReturnNode < Node
		attr_reader :expression, :function

		def initialize(args)
			@lineno = args[:lineno]
			@expression = args[:expression]
		end

		def semantic_analysis(env)
			@function = env.defining_function
			@expression = @expression.semantic_analysis env
			self
		end

		def well_typed?
			(@function and (@function.get_type == @expression.get_type)) or raise "TypeError: #{@function.id} should return a value of type #{@function.type}#{@function.pointer ? ' *' : ''}"
		end

		def to_original_code
			"return #{@expression.to_original_code};"
		end
	end
end
