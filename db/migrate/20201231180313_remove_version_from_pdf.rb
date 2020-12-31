class RemoveVersionFromPdf < ActiveRecord::Migration[6.1]
  def change
    remove_column :pdfs, :version
  end
end
