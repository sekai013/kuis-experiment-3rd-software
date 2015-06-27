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

		def transform_syntactic_suger
			self.instance_variables.each do |var|
				eval <<EVAL
				if #{var}.is_a? Node
					#{var} = #{var}.transform_syntactic_suger

					if #{var}.is_a? Array
						if #{var}.size == 1
							#{var} = #{var}[0]
						else
							cs = CompoundStatementNode.new({
										 :lineno => @lineno,
		  							 :declarations => [BrankNode.new],
										 :statements => #{var}
									 })
							#{var} = StatementNode.new({
										 		 :lineno => @lineno,
										 		 :value => cs
											 })
						end
					end
				elsif #{var}.is_a? Array
					#{var} = #{var}.map{|i| i.transform_syntactic_suger}
					#{var}.flatten!
				end
EVAL
			end

			self
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
