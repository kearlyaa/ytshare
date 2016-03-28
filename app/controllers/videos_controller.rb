class VideosController < ApplicationController
  attr_reader :watch_id

  def index

  end

  def show
    
    @video = Video.find(params[:id])
    url = @video.url
    get_watch_id(url)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Video doesn't exist"
      redirect_to root_path
    
    
  end

  def create
    @video = Video.create(video_params)
    if @video.invalid?
      flash[:error] = 'Unable to add video.  Please provide a valid name and url.'
    end

    redirect_to root_path
  end

  def get_watch_id(url)
    params = Rack::Utils.parse_query URI(url).query
    @watch_id = params["v"]
  end

  private

  def video_params
    params.require(:video).permit(:name, :url)
  end

end
