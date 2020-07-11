class AddCityStateStateCodeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    add_column :companies, :state_code, :string
    Company.find_each do |company|
      company.update_address
      company.save
    end
  end
end
