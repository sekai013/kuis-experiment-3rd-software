require_relative 'node_binary_expression'

module SmallCCompiler
	class AssignNode < BinaryExpressionNode
		def initialize(args)
			@lineno = args[:lineno]
			@left = args[:left]
			@symbol = '='
			@right = args[:right]
		end

		def get_type
			if @right.get_type == @left.get_type
				@right.get_type
			else
				raise "TypeError: near line #{@lineno} : not assignable"
			end
		end
	end
end
