require "rails_helper"

RSpec.describe ResourceTyper do
  describe "validations" do
    subject { create(:resource_typer) }

    it { is_expected.to validate_presence_of(:typer) }
    it { is_expected.to validate_uniqueness_of(:typer).scoped_to(:resource_type, :resource_id) }
  end
end
