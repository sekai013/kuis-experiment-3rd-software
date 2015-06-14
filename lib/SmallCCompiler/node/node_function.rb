require_relative 'node'

module SmallCCompiler
	class FunctionNode < Node
		attr_reader :type, :id, :params, :compound_statement

		def initialize(args)
			@lineno = args[:lineno]
			@type = args[:type]
			@id = args[:id]
			@params = args[:params]
			@compound_statement = args[:compound_statement]
			@pointer = args[:pointer]
		end

		def to_original_code
			"#{@type} #{@pointer ? '*' : ''}#{@id}(#{@params.map { |param| param.to_original_code}.join ', ' }) #{@compound_statement.to_original_code}"
		end
	end
end
