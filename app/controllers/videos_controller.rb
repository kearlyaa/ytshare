require 'uri'

class VideosController < ApplicationController
  

  def index
    @video = Video.first 
    set_watch_id_from_video(@video)
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Video doesn't exist"
    redirect_to root_path
  end

  def show
    @video = Video.find(params[:id])
    set_watch_id_from_video(@video)
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

  private

  def set_watch_id_from_video(video)
    url = video.url unless video.id.nil?
    if url =~ /\A#{URI::regexp(['http', 'https'])}\z/
      params = Rack::Utils.parse_query URI(url).query
      @watch_id = params["v"]
    else
      @watch_id = url
    end
  end  

  def video_params
    params.require(:video).permit(:name, :url)
  end

end