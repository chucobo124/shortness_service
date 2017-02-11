class Shortener < ApplicationRecord
  before_save :add_unique_key
  belongs_to :user

  def add_unique_key
    self.unique_key ||= SecureRandom.hex(5)
  end
end
