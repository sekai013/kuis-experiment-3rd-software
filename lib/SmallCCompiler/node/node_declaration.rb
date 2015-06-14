require_relative 'node'

module SmallCCompiler
	class DeclarationNode < Node
		attr_reader :type, :declarators

		def initialize(args) 
			@lineno = args[:lineno]
			@type = args[:type]
			@declarators = args[:declarators]
		end

		def to_original_code
			"#{@type} #{@declarators.map { |d| d.to_original_code }.join ', '};"
		end
	end
end
