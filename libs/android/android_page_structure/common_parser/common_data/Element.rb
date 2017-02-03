# is a common element for ALL!!! I use it for names, dates and other
class Element
  attr_accessor :coordinate, :value
  def initialize(*args)
    @coordinate = args.first[:coordinats]
    @value = args.first[:value]
  end

  # @param [Array] coord
  def to_coord(coord)
    return nil if ((coord[1] && coord[2] && coord[4] && coord[5]) == ('0' || nil))
    [Coordinates.new(coord[1], coord[2]), Coordinates.new(coord[4], coord[5])]
  end
end