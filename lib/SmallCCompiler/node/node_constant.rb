require_relative 'node'

module SmallCCompiler
	class ConstantNode < Node
		attr_reader :value

		def initialize(args)
			@lineno = args[:lineno]
			@value = args[:value]
		end

		def transform_syntactic_suger
			self
		end

		def to_original_code
			@value
		end
	end
end
