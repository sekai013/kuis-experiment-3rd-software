class Sample
macro
  BLANK         [\ \t]+
	PRESERVE      (if|else|while|for|return|int|void)
rule
  {BLANK}
	{PRESERVE}    { [text.upcase.to_sym, text] }
  \d+           { [:CONSTANT, text.to_i] }
	\w+           { [:IDENTIFIER, text] }
	\n
  .             { [text, text] }
end
