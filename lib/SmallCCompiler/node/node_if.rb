require_relative 'node'
require_relative 'node_brank'

module SmallCCompiler
	class IfNode < Node
		attr_reader :condition, :then, :else

		def initialize(args)
			@lineno = args[:lineno]
			@condition = args[:condition]
			@then = args[:then]
			@else = args[:else]
		end

		def to_original_code
			if @else.is_a? SmallCCompiler::BrankNode
				"if (#{@condition.to_original_code}) #{@then.to_original_code}"
			else
				"if (#{@condition.to_original_code}) #{@then.to_original_code}\n
				else #{@else.to_original_code}"
			end
		end
	end
end
