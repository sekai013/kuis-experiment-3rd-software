require_relative 'node'

module SmallCCompiler
	class CompoundStatementNode < Node
		attr_reader :declarations, :statements

		def initialize(args)
			@lineno = args[:lineno]
			@declarations = args[:declarations]
			@statements = args[:statements]

			@@nest = 0
		end

		def semantic_analysis(env)
			env.nest
			@declarations.map! { |d| d.semantic_analysis env }
			@statements.map! { |s| s.semantic_analysis env }
			env.unnest

			self
		end

		def well_typed?
			(@statements.map { |s| s.well_typed? }.include? false) ? false : true
		end

		def to_original_code
			@@nest += 1
			declaration_part = @declarations.map {|d| "#{"\t" * @@nest}#{d.to_original_code}"}.join "\n"
			statement_part = @statements.map {|s| "#{"\t" * @@nest}#{s.to_original_code}"}.join "\n"
			@@nest -= 1

			<<CODE
{
#{declaration_part}
#{statement_part}
#{"\t" * @@nest}}
CODE
		end
	end
end
