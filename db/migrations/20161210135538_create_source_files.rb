Hanami::Model.migration do
  change do
    create_table :source_files do
      primary_key :id

      column :basename, String, null: false
      column :directory, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index [:directory, :basename], unique: true
    end
  end
end
