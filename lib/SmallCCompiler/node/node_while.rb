require_relative 'node'

module SmallCCompiler
	class WhileNode < Node
		attr_reader :condition, :statement

		def initialize(args)
			@lineno = args[:lineno]
			@condition = args[:condition]
			@statement = args[:statement]
		end

		def to_original_code
			"while (#{@condition.to_original_code}) #{@statement.to_original_code}"
		end
	end
end
