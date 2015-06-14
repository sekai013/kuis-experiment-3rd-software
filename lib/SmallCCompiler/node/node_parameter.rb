require_relative 'node'

module SmallCCompiler
	class ParameterNode < Node
		attr_reader :type, :parameter

		def initialize(args)
			@lineno = args[:lineno]
			@type = args[:type]
			@parameter = args[:parameter]
			@pointer = args[:pointer]
		end

		def to_original_code
			"#{@type} #{@pointer ? "*" : ''}#{@parameter}"
		end
	end
end
