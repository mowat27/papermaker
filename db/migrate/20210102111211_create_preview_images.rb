class CreatePreviewImages < ActiveRecord::Migration[6.1]
  def change
    create_table :preview_images do |t|
      t.integer :document_id
      t.string :url
      t.string :status
      t.datetime :expires

      t.timestamps
    end
  end
end
