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

    return unless known_to_git?(source_path)

    attrs = {
        basename: File.basename(source_path),
        directory: File.dirname(source_path.sub(@root_path, ''))
    }
    source_file = source_file_repository.find_by_path(attrs) ||
                  source_file_repository.create(attrs)
    puts source_file.full_path

    document = parser.parse_document(File.read(source_path))
    document.scores.each_with_index do |score,i|
      genre = detect_genre(score.header)
      genre || next

      source_file_id = source_file.id
      piece_id = build_piece_id score, i
      puts "##{piece_id}"

      attrs = {
        source_file_id: source_file_id,
        piece_id: piece_id,
        source_order: i,
        genre: genre,
        lyrics: score.lyrics_raw,
        lyrics_cleaned: score.lyrics_pretty,
        header: score.header,
        src: score.text
      }

      piece = source_file.pieces&.find do |p|
        p.source_file_id == source_file_id &&
          p.piece_id == piece_id
      end
      if piece
        piece_repository.update(piece.id, attrs)
      else
        piece_repository.create(attrs)
      end
    end
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

  def detect_genre(score_header)
    case score_header['quid']
    when /ant(\.|ifona)/i
      'antiphona'
    when /(\d\.\s*)?resp(\.|onsorium)/i
      if $1
        'responsorium'
      else
        'responsorium breve'
      end
    else
      nil
    end
  end

  def build_piece_id(score, number)
    header_id = score.header['id']
    if header_id.nil? || header_id.empty?
      number.to_s
    else
      score.header['id']
    end
  end

  def known_to_git?(source_path)
    relative_path = source_path.sub(@root_path + '/', '')
    relative_path
    status = git.status(relative_path)
    !(status.include?(:worktree_new) || status.include?(:ignored))
  end

  def source_file_repository
    @source_file_repository ||= SourceFileRepository.new
  end

  def piece_repository
    @piece_repositoru ||= PieceRepository.new
  end

  def git
    @git ||= Rugged::Repository.new(@root_path)
  end

  def parser
    @parser ||= Lyv::LilyPondParser.new
  end
end
