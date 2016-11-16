# Is a class with all data for file
class OnlyofficeFile
  attr_accessor :name, :owner, :size, :date
  def initialize(*args)
    @name = args.first[:filename]
    @owner = args.first[:fileowner]
    @size = args.first[:filesize]
    @date = args.first[:filedate]
  end
end