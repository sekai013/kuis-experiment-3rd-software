require_relative 'node'

module SmallCCompiler
	class WhileNode < Node
		attr_reader :condition, :statement

		def initialize(args)
			@lineno = args[:lineno]
			@condition = args[:condition]
			@statement = args[:statement]
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
			"while (#{@condition.to_original_code}) #{@statement.to_original_code}"
		end
	end
end
