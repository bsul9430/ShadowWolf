require 'spec_helper'

describe "config/models/index" do
  before(:each) do
    assign(:mobiles, [
      stub_model(Mobile),
      stub_model(Mobile)
    ])
  end

  it "renders a list of config/models" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
