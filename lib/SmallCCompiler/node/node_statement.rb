require_relative 'node'
require_relative 'node_compound_statement'

module SmallCCompiler
	class StatementNode < Node
		attr_reader :value

		def initialize(args)
			@lineno = args[:lineno]
			@value = args[:value]
		end

		def to_original_code
			if @value.is_a? SmallCCompiler::CompoundStatementNode
				@value.to_original_code
			else
				"#{@value.to_original_code};"
			end
		end
	end
end
