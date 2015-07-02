require_relative 'node'
require_relative 'node_brank'
require_relative 'node_compound_statement'
require_relative 'node_expression'
require_relative 'node_call_function'

module SmallCCompiler
	class StatementNode < Node
		attr_reader :value

		def initialize(args)
			@lineno = args[:lineno]
			@value = args[:value]
		end

		def well_typed?
			if @value.is_a? CompoundStatementNode
				@value.well_typed?
			elsif @value.is_a? BrankNode
				true
			elsif @value.is_a? ExpressionNode and @value.values.last.is_a? CallFunctionNode
				v = @value.get_type
				(v[:type] == "void" and v[:pointer] == 0) or (v[:type] == "int" and 0 <= v[:pointer] and v[:pointer] < 3)
			else
				v = @value.get_type
				v[:type] == "int" and 0 <= v[:pointer] and v[:pointer] < 3
			end
		end

		def to_original_code
			if @value.is_a? CompoundStatementNode
				@value.to_original_code
			else
				"#{@value.to_original_code};"
			end
		end
	end
end
