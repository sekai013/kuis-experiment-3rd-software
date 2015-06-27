require_relative 'node'
require_relative 'node_arithmetic'
require_relative 'node_constant'

module SmallCCompiler
	class UnaryExpressionNode < Node
		attr_reader :symbol, :value

		def initialize(args)
			@lineno = args[:lineno]
			@symbol = args[:symbol]
			@value  = args[:value]
		end

		def transform_syntactic_suger
			self.instance_variables.each do |var|
				eval <<EVAL
				if #{var}.is_a? Node
					#{var} = #{var}.transform_syntactic_suger
				elsif #{var}.is_a? Array
					#{var} = #{var}.map{|i| i.transform_syntactic_suger}
					#{var}.flatten!
				end
EVAL
			end

			if @symbol == '-'
				ArithmeticNode.new({
					:lineno => @lineno,
					:left => ConstantNode.new({
						:lineno => @lineno,
						:value => 0
					}),
					:symbol => @symbol,
					:right => @value
				})
			elsif @symbol == '&' and @value.is_a? UnaryExpressionNode and @value.symbol == '*'
					@value.value
			else
				self
			end
		end

		def to_original_code
			"#{@symbol} #{@value.to_original_code}"
		end
	end
end
