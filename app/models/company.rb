class Company < ApplicationRecord

  attr_accessor :address

  REGEX_EMAIL = /\A([^@\s]+)@getmainstreet.com/i

  has_rich_text :description
  validates :email, format: { with: REGEX_EMAIL, message: I18n.t('company.email_domain_invalid'), on: :create }, :allow_blank => true

  before_save :update_address
  before_update :update_address

  # address taken from zip code as string
  def address
    return "" unless [city, state, state_code].all?(&:present?)
    "#{city}, #{state}(#{state_code})"
  end

  # function will populate city state state_code
  def update_address
    address_zip = ZipCodes.identify(zip_code) || {}
    self.city = address_zip[:city]
    self.state = address_zip[:state_name]
    self.state_code = address_zip[:state_code]
  end
end
