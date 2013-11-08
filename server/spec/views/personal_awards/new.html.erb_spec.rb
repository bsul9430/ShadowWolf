require 'spec_helper'

describe "personal_awards/new" do
  before(:each) do
    assign(:personal_award, stub_model(PersonalAward,
      :name => "MyString",
      :awarding_body => "MyString",
      :description => "MyText",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new personal_award form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", personal_awards_path, "post" do
      assert_select "input#personal_award_name[name=?]", "personal_award[name]"
      assert_select "input#personal_award_awarding_body[name=?]", "personal_award[awarding_body]"
      assert_select "textarea#personal_award_description[name=?]", "personal_award[description]"
      assert_select "input#personal_award_url[name=?]", "personal_award[url]"
    end
  end
end