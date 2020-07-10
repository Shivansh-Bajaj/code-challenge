require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "should raise error for non getmainstreet.com email" do
    company = Company.new(name: "test painting", email: "test_painting@gmail.com", zip_code: 37201, phone: "665544553")
    assert_equal company.valid?, false
    assert_includes company.errors.full_messages, "Email should with domain getmainstreet.com"
  end

  test "should add address attribute to model" do
    company = companies(:hometown_painting)
    assert_equal company.address, {:state_code=>"CA", :state_name=>"California", :city=>"Ventura", :time_zone=>"America/Los_Angeles"}
  end

  test "should update address attribute post update" do
    company = companies(:hometown_painting)
    company.update(zip_code: "30301")
    assert_equal company.address, {:state_code=>"GA", :state_name=>"Georgia", :city=>"Atlanta", :time_zone=>"America/New_York"}
  end
end