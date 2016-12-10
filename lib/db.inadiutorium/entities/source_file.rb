class SourceFile < Hanami::Entity
  def full_path
    File.join directory, basename
  end
end
