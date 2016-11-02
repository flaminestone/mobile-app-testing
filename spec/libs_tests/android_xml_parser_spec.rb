require 'rspec'
require_relative '../../libs/app_manager'

describe 'rotation check' do
  it 'parse xml from android main page | rotation 0' do
    xml = AndroidParser.parse('spec/libs_tests/assets/xml/rotation/rotation_0.xml')
    expect(xml.page.rotation).to eq(0)
  end

  it 'parse xml from android main page | rotation 1' do
    xml = AndroidParser.parse('spec/libs_tests/assets/xml/rotation/rotation_1.xml')
    expect(xml.page.rotation).to eq(1)
  end

  it 'parse xml from android main page | rotation 3' do
    xml = AndroidParser.parse('spec/libs_tests/assets/xml/rotation/rotation_3.xml')
    expect(xml.page.rotation).to eq(3)
  end
end