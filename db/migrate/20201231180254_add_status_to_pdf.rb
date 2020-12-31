class AddStatusToPdf < ActiveRecord::Migration[6.1]
  def change
    add_column :pdfs, :status, :string
  end
end
