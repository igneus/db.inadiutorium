Hanami::Model.migration do
  change do
    create_table :pieces do
      primary_key :id

      foreign_key :source_file_id, :source_files, null: false, on_delete: :cascade
      column :piece_id, String, null: false
      column :source_order, Integer, null: false

      column :genre, String, null: false

      column :lyrics, String, null: false
      column :lyrics_cleaned, String, null: false
      column :header, JSON, null: false
      column :src, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      # piece id must be unique in source file
      index [:source_file_id, :piece_id], unique: true
    end
  end
end
