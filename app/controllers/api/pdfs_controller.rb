class Api::PdfsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def update
    pdf = Pdf.find(params[:id])
    Pdf.update(pdf.id, url: pdf_params, status: 'available')
    render json: {message: "OK"}
  rescue ActiveRecord::RecordNotFound
    render json: {message: "Not found"}, status: 404
  end

  private 
  def pdf_params
    params.require(:url)
  end
end
