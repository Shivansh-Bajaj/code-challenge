require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "Ventura, California(CA)"
  end

  test "Update" do
    visit edit_company_path(@company)
    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "37201")
      click_button "Update Company"
    end
    @company.reload
    assert_text "Changes Saved"
    assert_equal "Updated Test Company", @company.name
    assert_equal "37201", @company.zip_code
    assert_equal "Nashville, Tennessee(TN)", @company.address
  end

  test "Create with valid email domain" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "create should not work with non getmainstreet domain email" do
    visit new_company_path
    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@somemail.com")
      click_button "Create Company"
    end
    assert_text "Email should be with domain getmainstreet.com"
  end

  test "create with blank email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Destroy" do
    visit company_path(@company)
    assert_text "Hometown Painting"
    accept_alert do
      click_on "Destroy"
    end
    assert_text "Successfully Deleted"
    assert_no_text "Hometown Painting"
  end

end
