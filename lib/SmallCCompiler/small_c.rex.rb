#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.5
# from lexical definition file "small_c.rex".
#++

require 'racc/parser'
class Sample < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader   :lineno
  attr_reader   :filename
  attr_accessor :state

  def scan_setup(str)
    @ss = StringScanner.new(str)
    @lineno =  1
    @state  = nil
  end

  def action
    yield
  end

  def scan_str(str)
    scan_setup(str)
    do_parse
  end
  alias :scan :scan_str

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_setup(f.read)
    end
  end

  def scan_file( filename )
    load_file(filename)
    do_parse
  end


  def next_token
    return if @ss.eos?
    
    # skips empty actions
    until token = _next_token or @ss.eos?; end
    token
  end

  def _next_token
    text = @ss.peek(1)
    @lineno  +=  1  if text == "\n"
    token = case @state
    when nil
      case
      when (text = @ss.scan(/[ \t\n]+/))
        ;

      when (text = @ss.scan(/(if|else|while|for|return|int|void)/))
         action { [text.upcase.to_sym, {
		:value  => text,
		:lineno => lineno
	}] }


      when (text = @ss.scan(/\d+/))
         action { [:CONSTANT, {
		:value  => text.to_i,
		:lineno => lineno
	}] }


      when (text = @ss.scan(/\w+/))
         action { [:IDENTIFIER, {
		:value  => text,
		:lineno => lineno
	}] }


      when (text = @ss.scan(/./))
         action { [text, {
		:value  => text,
		:lineno => lineno
	}] }


      else
        text = @ss.string[@ss.pos .. -1]
        raise  ScanError, "can not match: '" + text + "'"
      end  # if

    else
      raise  ScanError, "undefined state: '" + state.to_s + "'"
    end  # case state
    token
  end  # def _next_token

end # class

if __FILE__ == $0
  exit  if ARGV.size != 1
  filename = ARGV.shift
  rex = Sample.new
  begin
    rex.load_file  filename
    while  token = rex.next_token
      p token
    end
  rescue
    $stderr.printf  "%s:%d:%s\n", rex.filename, rex.lineno, $!.message
  end
end
