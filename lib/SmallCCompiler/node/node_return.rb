require_relative 'node'

module SmallCCompiler
	class ReturnNode < Node
		attr_reader :expression

		def initialize(args)
			@lineno = args[:lineno]
			@expression = args[:expression]
		end

		def to_original_code
			"return #{@expression.to_original_code};"
		end
	end
end
