require 'spec_helper'
describe 'name_service_switch' do

  #
  # RedHat
  #
  context "RedHat" do
    let :facts do
      {
        :os => {
          "family"      => "RedHat",
        }
      }
    end
    context "catalog compiles" do
      it { should compile}
    end

    context 'with default values for all parameters' do
      it { should contain_class('name_service_switch') }
    end

    context 'correct permissions' do
      it { should contain_file('/etc/nsswitch.conf').with(
        {
          :owner => "root",
          :group => "root",
          :mode  => "0644",
        }
      )}
    end

    # context 'correct search line' do
    #   let :params do
    #     {
    #       :search => "megacorp.com",
    #     }
    #   end
    #   it { should contain_file('/etc/resolv.conf').with_content(/search megacorp.com/)}
    # end
  end

  #
  # AIX
  #
  context "AIX" do
    let :facts do
      {
        :os => {
          "family"      => "AIX",
        }
      }
    end
    context "catalog compiles" do
      it { should compile}
    end

    context 'with default values for all parameters' do
      it { should contain_class('name_service_switch') }
    end

    context 'correct permissions' do
      it { should contain_file('/etc/netsvc.conf').with(
        {
          :owner => "root",
          :group => "system",
          :mode  => "0664",
        }
      )}
    end
    # context 'correct search line' do
    #   let :params do
    #     {
    #       :search => "megacorp.com",
    #     }
    #   end
    #   it { should contain_file('/etc/resolv.conf').with_content(/domain megacorp.com/)}
    # end

  end

  #
  # Solaris
  #
  context "Solaris" do
    let :facts do
      {
        :os => {
          "family"      => "Solaris",
        }
      }
    end
    context "catalog compiles" do
      it { should compile}
    end

    context 'with default values for all parameters' do
      it { should contain_class('name_service_switch') }
    end

    context 'correct permissions' do
      it { should contain_file('/etc/nsswitch.conf').with(
        {
          :owner => "root",
          :group => "sys",
          :mode  => "0644",
        }
      )}
    end

    # context 'correct search line' do
    #   let :params do
    #     {
    #       :search => "megacorp.com",
    #     }
    #   end
    #   it { should contain_file('/etc/resolv.conf').with_content(/search megacorp.com/)}
    # end
  end
end
