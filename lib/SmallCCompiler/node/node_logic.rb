require_relative 'node_binary_expression'

module SmallCCompiler
	class LogicNode < BinaryExpressionNode
		def get_type
			left_type = @left.get_type
			int = {
				:type => "int",
				:pointer => 0
			}
			if left_type == @right.get_type and left_type == int
				int
			else
				raise "TypeError: near line #{@lineno} : invalid operands to binary expression #{@symbol}"
			end
		end
	end
end
