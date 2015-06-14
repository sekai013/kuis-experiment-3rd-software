require_relative 'node'
require_relative 'node_statement'
require_relative 'node_compound_statement'

module SmallCCompiler
	class ForNode < Node
		attr_reader :initial, :condition, :next, :statement

		def initialize(args)
			@lineno = args[:lineno]
			@initial = args[:initial]
			@condition = args[:condition]
			@next = args[:next]
			@statement = args[:statement]
		end

		def to_original_code
			"for (#{@initial.to_original_code}; #{@condition.to_original_code}; #{@next.to_original_code}) #{@statement.to_original_code}"
		end
	end
end
