module CompaniesHelper
  def identify_zipcode
    return "" unless @company.address.present?
    "#{@company.address[:city]}, #{@company.address[:state_name]}(#{@company.address[:state_code]})"
  end
end