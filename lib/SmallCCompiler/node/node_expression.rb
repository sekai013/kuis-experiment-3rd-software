require_relative 'node'

module SmallCCompiler
	class ExpressionNode < Node
		attr_reader :values

		def initialize(args)
			@lineno = args[:lineno]
			@values = args[:values]
			@parentheses = false
		end

		def prior
			@parentheses = true
		end

		def to_original_code
			c = @values.map { |v| v.to_original_code }.join ', '
			if @parentheses
				"(#{c})"
			else
				c
			end
		end
	end
end
