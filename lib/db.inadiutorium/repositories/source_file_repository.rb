class SourceFileRepository < Hanami::Repository
  def find_by_path(basename:, directory:)
    source_files
        .where(basename: basename, directory: directory)
        .as(SourceFile)
        .one
  end
end
