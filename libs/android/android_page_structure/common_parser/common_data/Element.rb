
class Element
  attr_accessor :coordinate, :value
  def initialize(*args)
    @coordinate = args.first[:coordinats]
  end
end