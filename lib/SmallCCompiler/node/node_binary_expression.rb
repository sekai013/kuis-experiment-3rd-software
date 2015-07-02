require_relative 'node'

module SmallCCompiler
	class BinaryExpressionNode < Node
		attr_reader :left, :symbol, :right

		def initialize(args)
			@lineno = args[:lineno]
			@left = args[:left]
			@symbol = args[:symbol]
			@right = args[:right]
		end

		def well_typed?
			raise "must implement well_typed?"
		end

		def to_original_code
			"#{@left.to_original_code} #{@symbol} #{@right.to_original_code}"
		end
	end
end
