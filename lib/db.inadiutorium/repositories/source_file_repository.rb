class SourceFileRepository < Hanami::Repository
  def find_by_path(basename:, directory:)
    source_files
        .where(basename: basename, directory: directory)
        .limit(1)
        .first
  end
end
