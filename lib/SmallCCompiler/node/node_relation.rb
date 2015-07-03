require_relative 'node_binary_expression'

module SmallCCompiler
	class RelationNode < BinaryExpressionNode
		def get_type
			if @left.get_type == @right.get_type
				{
					:type => "int",
					:pointer => 0
				}
			else
				raise "TypeError: near line #{@lineno} : invalid operands to binary expression #{@symbol}"
			end
		end
	end
end
