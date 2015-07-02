require_relative 'node/node_parameter'
require_relative 'node/node_function'
require_relative 'node/node_functionprototype'

module SmallCCompiler
	class Environment
		attr_reader :defining_function

		PRINT = FunctionNode.new({
			:type => 'void',
			:id => 'print',
			:params => [ParameterNode.new({
				:type => 'int',
				:pointer => false
			})],
			:pointer => false
		})

		def initialize
			@level = 0
			@env = [{ :print => PRINT }]
		end

		def register(node)
			if @env[@level].has_key? node.id.to_sym
				env_node = @env[@level][node.id.to_sym]
				if env_node.is_a? FunctionPrototypeNode and
					 (node.is_a? FunctionPrototypeNode or node.is_a? FunctionNode) and
					 node.params.size == env_node.params.size

					node.params.size.times do |n|
						if node.params[n].type != env_node.params[n].type
							raise "DoubleDeclarationError #{node.id}"
						end
					end

					@env[@level][node.id.to_sym] = node
				elsif env_node.is_a? FunctionNode and
							node.is_a? FunctionPrototypeNode and
							node.params.size == env_node.params.size

					node.params.size.times do |n|
						if node.params[n].type != env_node.params[n].type
							raise "DoubleDeclarationError #{node.id}"
						end
					end
				else
					raise "DoubleDeclarationError #{node.id}"
				end
			else
				@env[@level][node.id.to_sym] = node
			end
		end

		def define_function(function_node)
			@defining_function = function_node
		end

		def define_finish
			@defining_function = nil
		end

		def call_function(callfunc_node)
			func_node = callfunc_node.id
			raise "CallFunctionError #{id} is not a function" unless func_node.is_a? FunctionNode
			raise "ArgumentError wrong number of arguments #{callfunc_node.args.size} for #{func_node.params.size}" if callfunc_node.args.size != func_node.params.size

			func_node.params.size.times do |n|
				raise "TypeError wrong type of argument" if callfunc_node.args[n].get_type != func_node.params[n].get_type
			end
		end

		def refer(id_node)
			@level.downto 0 do |n|
				if @env[n].has_key? id_node.value.to_sym
					return @env[n][id_node.value.to_sym]
				end
			end
			raise "ReferenceError #{id_node.value}"
		end

		def nest
			@level += 1
			@env << {}
		end

		def unnest
			@level -= 1
			@env.pop
		end

	end
end
