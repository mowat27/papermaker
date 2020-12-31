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

  def create
    document = Document.new(document_params)
    if document.save
      redirect_to documents_path
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    Document.update(params[:id], document_params)
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
end
