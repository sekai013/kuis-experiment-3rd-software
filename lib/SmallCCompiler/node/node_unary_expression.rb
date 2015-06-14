require_relative 'node'

module SmallCCompiler
	class UnaryExpressionNode < Node
		attr_reader :symbol, :value

		def initialize(args)
			@lineno = args[:lineno]
			@symbol = args[:symbol]
			@value  = args[:value]
		end

		def to_original_code
			"#{@symbol} #{@value.to_original_code}"
		end
	end
end
