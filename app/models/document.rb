class Document < ApplicationRecord
  has_many :pdfs, -> { order('id desc') }
  has_one :preview_image

  before_save :update_version

  def latest_pdf  
    pdfs.limit(1).first
  end

  def pdf  
    pdfs.where(status: 'available').limit(1).first
  end

  private
  def update_version
    self.version = Digest::SHA1.hexdigest(name+title+content)
  end
end
