require 'rspec'
require_relative '../../libs/app_manager'

describe 'smoke android xml parser tests' do

  it 'parse xml from android main page' do
    xml = AndroidXmlParser.new.parse('spec/libs_tests/assets/main_page_android.xml')
    expect(xml.class).to eq(Nokogiri::HTML::Document)
  end
end