class DocumentsController < ApplicationController
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
    document = Document.find(params[:document_id])
    if document
      request_new_pdf(document.id)
      redirect_to documents_path
    end    
  end
  
  def download
    document = Document.find(params[:document_id])
    if document.pdf.url && document.pdf.status == 'available'
      data = open(document.pdf.url).read
      send_data(data, 
        filename: "#{document.name}.pdf",
        type: 'application/pdf', 
        disposition: 'attachment', 
        stream: 'true', 
        buffer_size: '4096' )
      end
    end
    
    def create
      document = Document.new(document_params)
      if document.save
        request_new_pdf(document.id)
        redirect_to documents_path, notice: "Created \"#{document.name}\""
      end
    end
    
    def edit
      @document = Document.find(params[:id])
    end
    
    def update
      document = Document.find(params[:id])
      document.update(document_params)
      request_new_pdf(document.id)
      redirect_to documents_path, notice: "Updated \"#{document.name}\""
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

  def request_new_pdf(document_id)
    document = Document.find(document_id)
    queue = Rails.configuration.aws.pdfgen[:input_queue]
    pdf = Pdf.create_or_find_by(document_id: document.id)
    pdf.update(status: "pending")
    payload = {
      meta: {
        owner: "papermaker",
        metadata_version: "0.1",
      },
      links: {
        callback: api_callback_url
      },
      data: {
        type: "document",
        id: document.id,
        attributes: {
          name: document.name,
          title: document.title,
          content: document.content,
          version: document.version
        }
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
