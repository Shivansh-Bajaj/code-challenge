class Company < ApplicationRecord

  attr_accessor :address

  has_rich_text :description
  validates :email, format: { with: /\A([^@\s]+)@getmainstreet.com/i, message: I18n.t('company.email_domain_invalid'), on: :create }, :allow_blank => true

  before_save :update_address
  before_update :update_address

  def address
    return "" unless [city, state, state_code].all?(&:present?)
    "#{city}, #{state}(#{state_code})"
  end

  private

  def update_address
    address_zip = ZipCodes.identify(zip_code) || {}
    self.city = address_zip[:city]
    self.state = address_zip[:state_name]
    self.state_code = address_zip[:state_code]
  end
end
