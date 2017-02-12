Hanami::Model.migration do
  change do
    add_column :pieces, :mode, String
  end
end
