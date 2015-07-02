require_relative 'node'

module SmallCCompiler
	class CallFunctionNode < Node
		attr_reader :id, :args

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@args = args[:args]
		end

		def semantic_analysis(env)
			@id = @id.semantic_analysis env
			@args.map! { |arg| arg.semantic_analysis env }
			env.call_function self

			self
		end

		def get_type
			{
				:type => @id.type,
				:pointer => @id.pointer ? 1 : 0
			}
		end

		def to_original_code
			"#{@id.to_original_code}(#{@args.map { |arg| arg.to_original_code }.join ', '})"
		end
	end
end
