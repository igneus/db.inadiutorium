# DI container
class Container
  extend Dry::Container::Mixin

  register 'piece_repository',
           -> { PieceRepository.new }
  register 'source_file_repository',
           -> { SourceFileRepository.new }
end

Inject = Dry::AutoInject(Container)
