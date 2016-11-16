# is a common element for ALL!!! I use it for names, dates and other
class Element
  attr_accessor :coordinate, :value
  def initialize(*args)
    @coordinate = args.first[:coordinats]
    @value = args.first[:value]
  end
end