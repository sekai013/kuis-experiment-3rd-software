module SmallCCompiler
	class Node
		attr_reader :lineno

		def initialize(args)
			@lineno = args[:lineno]
		end

		def transform_syntactic_suger
			self.instance_variables.each do |var|
				eval <<EVAL
				if #{var}.is_a? Node
					#{var} = #{var}.transform_syntactic_suger
				elsif #{var}.is_a? Array
					#{var}.map! {|i| i.transform_syntactic_suger}
					#{var}.flatten!
				end
EVAL
			end

			self
		end

		def semantic_analysis(env)
			self.instance_variables.each do |var|
				eval <<EVAL
				if #{var}.is_a? Node
					#{var} = #{var}.semantic_analysis env
				elsif #{var}.is_a? Array
					#{var}.map! { |i| i.semantic_analysis env }
				end
EVAL
			end

			self
		end

		def get_type
			raise "must implement get_type"
		end

		def well_typed?
			raise "must implement well_typed?"
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
