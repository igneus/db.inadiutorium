task import: :environment do |t|
  import_root = ENV['IMPORT_ROOT']

  unless import_root && File.directory?(import_root)
    STDERR.puts 'Please provide import root in environment variable IMPORT_ROOT'
    exit 1
  end

  importer = Importer.new import_root
  Dir.glob(File.join(import_root, '**/*.ly')).each do |full_path|
    importer.import full_path
  end
end
