require_relative 'node'

module SmallCCompiler
	class ExpressionNode < Node
		attr_reader :values

		def initialize(args)
			@lineno = args[:lineno]
			@values = args[:values]
		end

		def to_original_code
			@values.map { |v| v.to_original_code }.join ', '
		end
	end
end
