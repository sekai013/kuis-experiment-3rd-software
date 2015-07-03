require_relative 'node_binary_expression'

module SmallCCompiler
	class ArithmeticNode < BinaryExpressionNode
		def get_type
			left_type = @left.get_type
			right_type = @right.get_type
			case @symbol
			when '+'
				if left_type[:pointer] == 0 or right_type[:pointer] == 0
					{
						:type => left_type[:type],
						:pointer => [left_type[:pointer], right_type[:pointer]].max
					}
				else
					raise "TypeError: near line #{@lineno} : invalid operands to binary expression #{@symbol}"
				end
			when '-'
				if right_type[:pointer] == 0
					{
						:type => left_type[:type],
						:pointer => left_type[:pointer]
					}
				else
					raise "TypeError: near line #{@lineno} : invalid operands to binary expression #{@symbol}"
				end
			when '*', '/'
				if left_type[:pointer] == 0 and right_type[:pointer] == 0
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
end
