class UrlsController < ApplicationController
  before_action :set_url, only: :show

  def new
    @url = Url.new
  end

  def create
    @url = Url.create_unique(url_params)

    if @url.persisted?
      redirect_to edit_url_path(@url)
    else
      render action: :new
    end
  end

  def edit
    @url = Url.find(params[:id])
  end

  def show
    if @url.present?
      redirect_to @url.url
    else
      head :not_found
    end
  end

  private

  def set_url
    @url = Url.find_by(code: params[:code])
  end

  def url_params
    params.require(:url).permit(:url)
  end
end
