require 'act'
class Play
  def acts
    return @acts if @acts
    act_numbers = (1..(document.css('div').length))
    @acts = act_numbers.to_a.collect { |act_number| 
      Act.new(self, act_number)
    }
  end

  def act(act_number)
    raise NotFoundError if act_number == 0
    act = acts[act_number.to_i - 1]
    raise NotFoundError if act.nil?
    act
  end
end
