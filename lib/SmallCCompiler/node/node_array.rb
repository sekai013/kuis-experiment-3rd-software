require_relative 'node'
require_relative 'node_expression'
require_relative 'node_arithmetic'
require_relative 'node_identifier'
require_relative 'node_constant'
require_relative 'node_unary_expression'

module SmallCCompiler
	class ArrayNode < Node
		attr_reader :id, :index

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@index = args[:index]
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

			add = ArithmeticNode.new({
				:lineno => @lineno,
				:left => @id,
				:symbol => "+",
				:right => @index
			})
			exp = ExpressionNode.new(
				:lineno => @lineno,
				:values => [add]
			)
			exp.prior

			UnaryExpressionNode.new({
				:lineno => @lineno,
				:symbol => "*",
				:value => exp
			})
		end

		def to_original_code
			"#{@id.to_original_code}[#{@index.to_original_code}]"
		end
	end
end
