class VideosController < ApplicationController
  attr_reader :watch_id

  def index
    @video = Video.first
    url = @video.url unless @video.id.nil?
    get_watch_id(url)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Video doesn't exist"
    redirect_to root_path
  end

  def show
    @video = Video.find(params[:id])
    url = @video.url unless params[:id].nil?
    get_watch_id(url)
  rescue ActiveRecord::RecordNotFound
      flash[:error] = "Video doesn't exist"
      redirect_to video_path(@video)
  end

  def create
    @video = Video.create(video_params)
    if @video.invalid?
      flash[:error] = 'Unable to add video.  Please provide a valid name and url.'
    end
    redirect_to(@video, :notice=> 'Video Added!')
  end

  def get_watch_id(url)
    require 'uri'

    if url =~ /\A#{URI::regexp(['http', 'https'])}\z/
      params = Rack::Utils.parse_query URI(url).query
      @watch_id = params["v"]
    else
      @watch_id = url
    end
  end

  private

  def video_params
    params.require(:video).permit(:name, :url)
  end

end
