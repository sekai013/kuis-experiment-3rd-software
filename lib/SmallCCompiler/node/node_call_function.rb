require_relative 'node'

module SmallCCompiler
	class CallFunctionNode < Node
		attr_reader :id, :args

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@args = args[:args]
		end

		def to_original_code
			"#{@id.to_original_code}(#{@args.map { |arg| arg.to_original_code }.join ', '})"
		end
	end
end
