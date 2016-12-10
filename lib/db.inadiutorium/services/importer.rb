class Importer
  def initialize(root_path)
    @root_path = root_path.sub /\/*$/, ''
  end

  def import(source_path)
    unless source_path.start_with? @root_path
      raise ArgumentError.new("#{source_path} is not in #{@root_path}.")
    end

    attrs = {
        basename: File.basename(source_path),
        directory: File.dirname(source_path.sub(@root_path, ''))
    }
    p repository.find_by_path(attrs) || repository.create(attrs)
  end

  def repository
    @repository ||= SourceFileRepository.new
  end
end
