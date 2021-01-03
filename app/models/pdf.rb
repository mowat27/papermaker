class Pdf < ApplicationRecord
  belongs_to :document

  after_save :notify_channel

  private 

  def notify_channel
    ActionCable.server.broadcast('pdfs_channel', 
      document_id: self.document.id,
      pdf_id: self.document.pdf.id,
      status: self.status
    )
  end
end
