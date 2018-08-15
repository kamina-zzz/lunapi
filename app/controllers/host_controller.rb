class HostController < ApplicationController
  def index
    render json: {host: `hostname`}
  end
end
