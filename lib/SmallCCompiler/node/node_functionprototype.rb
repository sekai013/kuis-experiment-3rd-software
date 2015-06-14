require_relative 'node'

module SmallCCompiler
	class FunctionPrototypeNode < Node
		attr_reader :type, :id, :params

		def initialize(args)
			@lineno = args[:lineno]
			@type = args[:type]
			@id = args[:id]
			@params = args[:params]
			@pointer = args[:pointer]
		end

		def to_original_code
			"#{@type} #{@pointer ? '*' : ''}#{@id}(#{@params.map {|p| p.to_original_code}.join(', ')});"
		end
	end
end
