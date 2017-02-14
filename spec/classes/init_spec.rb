require 'spec_helper'
describe 'name_service_switch' do
  context 'with default values for all parameters' do
    it { should contain_class('name_service_switch') }
  end
end
