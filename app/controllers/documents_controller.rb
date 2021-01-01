class DocumentsController < ApplicationController
  after_action :request_pdf, only: [:create, :update]

  def index
    @documents = Document.all
  end
  
  def new
    @document = Document.new
  end

  def show
    @document = Document.find(params[:id])
  end

  def generate
    @document = Document.find(params[:document_id])
    if @document
      request_pdf
      redirect_to documents_path
    end    
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to documents_path
    end
  end
  
  def edit
    @document = Document.find(params[:id])
  end
  
  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    redirect_to documents_path
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path
  end

  private
  def document_params
    params.require(:document).permit(:name, :title, :content)
  end

  def request_pdf
    pdf = @document.pdfs.create(status: 'requested')
    queue = Rails.configuration.aws.pdfgen[:input_queue]
    payload = {
      generated_by: "newsify",
      metadata_version: "0.1",
      callback_url: api_pdf_url(pdf),
      document: {
        content: @document.to_json
      }
    }

    puts "Sending #{payload} to #{queue}"

    sqs = Aws::SQS::Client.new(
      region: Rails.configuration.aws.aws_region
    )
    resp = sqs.send_message(
      queue_url: queue,
      message_body: payload.to_json,
      delay_seconds: 0
    )
  end
end
