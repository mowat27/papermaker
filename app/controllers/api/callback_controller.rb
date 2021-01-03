class Api::CallbackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]


  def create
    message = Message.new(data_params)
    case message.type
    when "pdf_document"
      document = Document.find(message.relationships.requester.data.document_id.to_i)
      if document
        if document.version == message.relationships.requester.data.version
          document.pdf.update(url: message.attributes.url, 
            status: "available",
            expires_at: DateTime.parse(message.attributes.expires)
          )
          render json: {message: "OK"}, status: 200
        else
          render json: {message: "Document has changed since the request"}, status: 406 
        end
      else
        render json: {message: "Document not found"}, status: 406
      end

    when "pdf_preview"
      render json: {status: "OK", message: payload[:type] + " received"}
    when "pdf_thumbnail"
      render json: {status: "Not Implemented", message: payload[:type] + " cannot be processed yet"}, status: 406
    else 
      render json: {message: "Unexpected type #{payload[:type]}"}, status: 406
    end
  end

  private 
  
  def data_params
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

class Message
  delegate :type, :attributes, :relationships, to: :@ostruct

  def initialize(data_params)
    @ostruct = JSON.parse(data_params.to_json, object_class: OpenStruct)
  end
end