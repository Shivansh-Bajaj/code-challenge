class Company < ApplicationRecord

  attr_accessor :address

  has_rich_text :description
  validates :email, format: { with: /\A([^@\s]+)@getmainstreet.com/i, message: "should with domain getmainstreet.com", on: :create }, :allow_blank => true

  after_initialize do |company|
    @address = ZipCodes.identify(zip_code) || {}
  end

  before_update do |company|
    @address = ZipCodes.identify(zip_code) || {} if zip_code_changed?
  end
end
