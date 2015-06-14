require_relative 'node'

module SmallCCompiler
	class ArrayNode < Node
		attr_reader :id, :index

		def initialize(args)
			@lineno = args[:lineno]
			@id = args[:id]
			@index = args[:index]
		end

		def to_original_code
			"#{@id.to_original_code}[#{@index.to_original_code}]"
		end
	end
end
