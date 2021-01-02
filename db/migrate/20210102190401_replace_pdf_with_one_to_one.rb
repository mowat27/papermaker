class ReplacePdfWithOneToOne < ActiveRecord::Migration[6.1]
  def change
    drop_table :pdfs

    create_table :pdfs do |t|
      t.integer :document_id
      t.string :url
      t.string :status
      t.datetime :expires_at
      
      t.timestamps
    end
  end
end
