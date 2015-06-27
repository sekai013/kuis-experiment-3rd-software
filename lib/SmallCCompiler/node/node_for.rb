require_relative 'node'
require_relative 'node_compound_statement'
require_relative 'node_while'
require_relative 'node_brank'

module SmallCCompiler
	class ForNode < Node
		attr_reader :initial, :condition, :next, :statement

		def initialize(args)
			@lineno = args[:lineno]
			@initial = args[:initial]
			@condition = args[:condition]
			@next = args[:next]
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

			n = StatementNode.new({
				:lineno => @lineno,
				:value => @next
			})

			stmt = if @statement.value.is_a? CompoundStatementNode
							 s = Marshal.load(Marshal.dump(@statement))
							 s.value.statements << n
							 s
						 else
							 cs = CompoundStatementNode.new({
								 :lineno => @lineno,
								 :declarations => [BrankNode.new],
								 :statements => [@statement, n]
							 })
							 StatementNode.new({
								 :lineno => @lineno,
								 :value => cs
							 })
						 end

			init = StatementNode.new({
				:lineno => @lineno,
				:value => @initial
			})
			wh = WhileNode.new({
				:lineno => @lineno,
				:condition => @condition,
				:statement => stmt
			})

			[init, wh]
		end

		def to_original_code
			"for (#{@initial.to_original_code}; #{@condition.to_original_code}; #{@next.to_original_code}) #{@statement.to_original_code}"
		end
	end
end
