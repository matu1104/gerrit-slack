require 'rspec'

describe NotifierConfig do
  let(:config) { NotifierConfig.new('spec/fixtures/config/notifications.yml') }

  before(:each) do
    Application.instance.stub(:use_database?).and_return(false)
  end

  describe "#notifications_for" do
    context "when project" do
      it "is not in notification.yml" do
        config.notifications_for('not_exist', :minus_one).should == :group
      end

      it "is in notifications.yml" do
        config.notifications_for('test', :plus_one).should == :group
        config.notifications_for('test', :jenkins_success).should == :none
        config.notifications_for('test', :minus_one).should == :individual
      end
    end

    context 'when notification' do
      it "is not in notifications.yml" do
        config.notifications_for('test', :not_exist).should == :group
      end
    end
  end
end
