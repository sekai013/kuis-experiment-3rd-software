require_relative 'node'

module SmallCCompiler
	class BrankNode < Node
		def initialize
		end

		def get_type
			{ :type => "void", :pointer => 0 }
		end

		def to_original_code
			''
		end
	end
end
