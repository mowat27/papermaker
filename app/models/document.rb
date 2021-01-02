class Document < ApplicationRecord
  has_one :pdf
  has_one :preview_image

  before_save :update_version

  private

  def update_version
    # Lexegraphically sortable timestamp down to the millisecond
    self.version = DateTime.now.utc.strftime("%Y%m%d%H%M%S%L")
  end
end
