require 'securerandom'
class ShortenerController < ApplicationController
  def show
    shortener = User.find(params[:id])
                    .shorteners.find_by_unique_key(params[:unique_key])
    @shortener_url = shortener.blank? ?  nil : "http://#{request.host_with_port}/#{shortener.unique_key}"
  end

  def fetch_shortener
    unique_key = params[:unique_key]
    shortener = Shortener.find_by_unique_key unique_key
    uri = URI.parse(shortener.url)
    if %w( http https ).include?(uri.scheme)
      redirect_to shortener.url
    else
      redirect_to "http://#{shortener.url}"
    end
  end

  def create
    url = params[:shortener][:origin_url]
    unique_key = SecureRandom.hex(5)
    session[:ip] = request.remote_ip
    user = User.find_or_create_by session_id: session[:session_id]
    browser_detail = Browser.new(request.env['HTTP_USER_AGENT'],
                                 accept_language: 'en-us')
    user.shorteners.create(url: url, unique_key: unique_key)
    redirect_to shortener_path(user.id) + "/#{unique_key}"
  end
end
