require 'pp'
require_relative 'node/node_program'
require_relative 'small_c.tab'
require_relative 'env'

parser = MyParser.new

begin
	tree = parser.parse

	program = SmallCCompiler::ProgramNode.new({
		:lineno => 1,
		:declarations => tree
	})

	env = SmallCCompiler::Environment.new

	transformed_tree = program.transform_syntactic_suger
	analized_tree = transformed_tree.semantic_analysis env
	pp analized_tree if analized_tree.well_typed?
rescue => e
	puts e.message
end
