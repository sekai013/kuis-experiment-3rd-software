module SmallCCompiler
	class Node
		attr_reader :lineno

		def initialize(args)
			@lineno = args[:lineno]
		end

		def to_s
			raise 'must implement to_s'
		end

		def to_original_code
			raise 'must implement to_original_code'
		end

		def to_intermed_code
			raise 'must implement to_intermed_code'
		end
	end
end
