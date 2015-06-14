require_relative 'node'

module SmallCCompiler
	class ProgramNode < Node
		attr_reader :declarations

		def initialize(args)
			@lineno = args[:lineno]
			@declarations = args[:declarations]
		end

		def to_original_code
			@declarations.map { |d| d.to_original_code }.join "\n"
		end
	end
end
