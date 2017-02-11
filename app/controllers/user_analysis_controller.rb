class UserAnalysisController < ApplicationController
  def index
    @shorteners = Shortener.all
    @total_session = User.all.count
    @total_user = User.select(:ip_address).map(&:ip_address).uniq.count
  end
end
