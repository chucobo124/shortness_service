class User < ApplicationRecord
  before_update :check_device_type
  enum device_type: [:safari, :chrome, :firefox, :ie, :device]
  has_many :shorteners
  def check_device_type
    browser_detail = Browser.new(user_agent,
                                 accept_language: 'en-us')
    borwser_name = browser_detail.name.downcase.delete(' ')
    self.device_type = User.device_types[borwser_name]
  end
  def os
    browser_detail = Browser.new(user_agent,
                                 accept_language: 'en-us')
    browser_detail.platform
  end
end
