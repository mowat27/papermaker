class Document < ApplicationRecord
  has_many :pdfs, -> { order('version desc') }

  def latest_pdf  
    pdfs.limit(1).first
  end
end
