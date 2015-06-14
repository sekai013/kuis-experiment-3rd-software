require_relative 'node_binary_expression'

module SmallCCompiler
	class AssignNode < BinaryExpressionNode
		def initialize(args)
			@lineno = args[:lineno]
			@left = args[:left]
			@symbol = '='
			@right = args[:right]
		end
	end
end
