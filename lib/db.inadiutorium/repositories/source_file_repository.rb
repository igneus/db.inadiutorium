class SourceFileRepository < Hanami::Repository
  associations do
    has_many :pieces
  end

  def find_by_path(basename:, directory:)
    aggregate(:pieces)
        .where(basename: basename, directory: directory)
        .as(SourceFile)
        .one
  end
end
