class Importer
  def initialize(root_path)
    @root_path = root_path.sub /\/*$/, ''
    @config = load_config
  end

  def call
    source_files.each do |path|
      import path
    end
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

  def source_files
    source_globs.collect {|g| Dir.glob(File.join(@root_path, g)) }.reduce :+
  end

  def source_globs
    @config['include'] || ['**/*.ly']
  end

  def load_config
    config_path = File.join(@root_path, '.indexing.yml')
    config = nil
    if File.exist?(config_path)
      config = YAML.load(File.read(config_path))
    end
    config || {}
  end

  def repository
    @repository ||= SourceFileRepository.new
  end
end
