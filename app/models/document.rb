class Document < ApplicationRecord
  has_many :pdfs, -> { order('id desc') }
  has_one :preview_image

  def latest_pdf  
    pdfs.limit(1).first
  end

  def pdf  
    pdfs.where(status: 'available').limit(1).first
  end
end
