class Api::CallbackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]


  def create
    case payload[:type]
    when "pdf_document"
      render json: {status: "In Progress", message: payload[:type]}, status: 406
    when "pdf_preview"
      render json: {status: "OK", message: payload[:type] + " received"}
    when "pdf_thumbnail"
      render json: {status: "Not Implemented", message: payload[:type] + " cannot be processed yet"}, status: 406
    else 
      render json: {message: "Unexpected type #{payload[:type]}"}, status: 406
    end
  end

  private 
  
  def payload
    params.require(:data).permit(
      :type,
      attributes: [:url, :expires],
      relationships: {
        requester: {
          data: [:name, :document_id, :version]
        }
      }
    )
  end
end
