task import: :environment do |t|
  import_root = ENV['IMPORT_ROOT']

  unless import_root && File.directory?(import_root)
    STDERR.puts 'Please provide import root in environment variable IMPORT_ROOT'
    exit 1
  end

  Importer.new(import_root).call
end
