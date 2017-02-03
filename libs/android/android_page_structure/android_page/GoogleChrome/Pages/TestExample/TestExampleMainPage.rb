require_relative '../EmptyPage'
class TestExampleMainPage < EmptyPage

  attr_reader :create_document, :create_spreadsheet, :create_presentation, :page
  def initialize(parent, ip)
    @parent = parent
    @create_document = Button.new(parant: @parent, xpath: '//*[@content-desc="Create Document"]')
  end
end