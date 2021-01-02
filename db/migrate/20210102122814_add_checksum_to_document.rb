class AddVersionToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :version, :string
  end
end
