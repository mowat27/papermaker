class CreatePdfs < ActiveRecord::Migration[6.1]
  def change
    create_table :pdfs do |t|
      t.integer :document_id
      t.integer :version
      t.string :url

      t.timestamps
    end
  end
end
