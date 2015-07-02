require_relative 'node'
require_relative 'node_return'
require_relative 'node_statement'
require_relative 'node_compound_statement'
require_relative 'node_if'

module SmallCCompiler
	class FunctionNode < Node
		attr_reader :type, :id, :params, :compound_statement, :pointer

		def initialize(args)
			@lineno = args[:lineno]
			@type = args[:type]
			@id = args[:id]
			@params = args[:params]
			@compound_statement = args[:compound_statement]
			@pointer = args[:pointer]
		end

		def semantic_analysis(env)
			raise "ReturnError control may reach end of non-void function #{@id}" if @type != "void" and value_returned?(@compound_statement) == false
			env.register self
			env.define_function self
			env.nest
			@params.map! { |param| param.semantic_analysis env }
			@compound_statement = @compound_statement.semantic_analysis env
			env.unnest

			self
		end

		def get_type
			{
				:type => @type,
				:pointer => (@pointer) ? 1 : 0
			}
		end

		def well_typed?
			@compound_statement.well_typed?
		end

		def to_original_code
			"#{@type} #{@pointer ? '*' : ''}#{@id}(#{@params.map { |param| param.to_original_code}.join ', ' }) #{@compound_statement.to_original_code}"
		end

		private

		def value_returned?(stmts)
			statements = [Marshal.load(Marshal.dump stmts)].flatten
			if_nodes = []

			while statements.size > 0
				s = statements.shift
				return true if s.is_a? ReturnNode
				statements += s.statements if s.is_a? CompoundStatementNode
				statements += s.value.statements if s.is_a? StatementNode and s.value.is_a? CompoundStatementNode
				if_nodes << s if s.is_a? IfNode
			end

			if_nodes.size > 0 and ((if_nodes.map { |i| value_returned?(i.then) and value_returned?(i.else) }.include? false) ? false : true)
		end
	end
end
