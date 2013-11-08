require 'spec_helper'

describe "attentions/show" do
  before(:each) do
    @attention = assign(:attention, stub_model(Attention,
      :url => "Url",
      :scan_or_screengrab => "Scan Or Screengrab",
      :body_text => "MyText",
      :publication => "Publication",
      :reason => "Reason"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/Scan Or Screengrab/)
    rendered.should match(/MyText/)
    rendered.should match(/Publication/)
    rendered.should match(/Reason/)
  end
end