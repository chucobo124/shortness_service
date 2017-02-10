class ShortenerController < ApplicationController
  def index
  end

  def new
  end

  def fetch_shortener
    byebug
    token = ::Shortener::ShortenedUrl.extract_token(params[:id])
    track = Shortener.ignore_robots.blank? || request.human?
    url   = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: params, track: track)
    redirect_to url[:url], status: :moved_permanently
  end

  def create
    session[:ip] = request.remote_ip
    user = UserList.find_or_create_by session_id: session[:session_id]
    browser_detail = Browser.new(request.env['HTTP_USER_AGENT'],
                                 accept_language: 'en-us')
  end
end
