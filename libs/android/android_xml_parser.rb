require 'nokogiri'
class AndroidXmlParser
  def parse(path)
    Nokogiri::HTML(open(path))
  end
end