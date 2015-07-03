class Sample
macro
  BLANK         [\ \t\n]
	PRESERVE      (if|else|while|for|return|int|void)
	OPERATOR      (\=\=|\<\=|\>\=|\&\&|\|\|)
rule
  {BLANK}
	{PRESERVE}    { [text.upcase.to_sym, {
		:value  => text,
		:lineno => lineno
	}] }
  \d+           { [:CONSTANT, {
		:value  => text.to_i,
		:lineno => lineno
	}] }
	\w+           { [:IDENTIFIER, {
		:value  => text,
		:lineno => lineno
	}] }
	{OPERATOR}    { [text, {
		:value => text,
		:lineno => lineno
	}] }
  .             { [text, {
		:value  => text,
		:lineno => lineno
	}] }
end
