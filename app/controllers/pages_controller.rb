class PagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:slug])

    # Handle page not found
    if @page
      render layout: 'application' # Ensure the default layout is used
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end
end
