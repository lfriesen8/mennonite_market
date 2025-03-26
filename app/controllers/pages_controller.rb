class PagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:slug])
    if @page
      render layout: false # Remove layout to test if the content appears without it
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end
end
