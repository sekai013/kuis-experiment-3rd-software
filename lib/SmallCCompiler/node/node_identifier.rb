require_relative 'node'

module SmallCCompiler
	class IdentifierNode < Node
		attr_reader :value

		def initialize(args)
			@lineno = args[:lineno]
			@value = args[:value]
		end

		def to_original_code
			@value
		end
	end
end
