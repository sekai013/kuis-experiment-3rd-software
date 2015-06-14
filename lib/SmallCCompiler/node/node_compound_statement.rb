require_relative 'node'

module SmallCCompiler
	class CompoundStatementNode < Node
		attr_reader :declarations, :statements

		def initialize(args)
			@lineno = args[:lineno]
			@declarations = args[:declarations]
			@statements = args[:statements]
		end

		def to_original_code
			declaration_part = @declarations.map {|d| "\t#{d.to_original_code}"}.join "\n"
			statement_part = @statements.map {|s| "\t#{s.to_original_code}"}.join "\n"

			<<CODE
{
#{declaration_part}
#{statement_part}
}
CODE
		end
	end
end
