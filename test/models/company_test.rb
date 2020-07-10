require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "should raise error for non getmainstreet.com email" do
    company = Company.new(name: "huffman painting", email: "huffman_painting@coding.com", zip_code: "85015", phone: "4433-898-3324")
    refute company.valid?
    assert_includes company.errors.full_messages, "Email should be with domain getmainstreet.com"
  end

  test "should allow getmainstreet domain email" do
    company = Company.new(name: "Alan Turing painting", email: "alan.turing@getmainstreet.com", zip_code: "85001", phone: "4433-898-3322")
    assert company.valid?
  end

  test "should allow blank email" do
    company = Company.new(name: "Martin Fowler painting", zip_code: "85001", phone: "4433-898-3322")
    assert company.valid?
  end

  test "should add address attribute to model" do
    company = companies(:huffman_painting)
    assert_equal company.address, "Ventura, California(CA)"
  end

  test "should update address attribute post update" do
    company = companies(:turing_painting)
    company.update(zip_code: "85002")
    assert_equal company.address, "Phoenix, Arizona(AZ)"
  end

  test "should update address to empty string when zip code is updated blank" do
    company = companies(:huffman_painting)
    company.update(zip_code: "")
    assert_equal "", company.address
  end
end