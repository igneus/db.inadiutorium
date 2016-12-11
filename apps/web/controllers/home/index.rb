module Web::Controllers::Home
  class Index
    include Web::Action

    expose :created_pieces, :updated_pieces

    def call(params)
      repo = PieceRepository.new
      @created_pieces = repo.newly_created
      @updated_pieces = repo.newly_updated
    end
  end
end
