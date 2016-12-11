module Web::Controllers::Home
  class Index
    include Web::Action

    expose :created_pieces, :updated_pieces, :count_total

    def call(params)
      repo = PieceRepository.new
      @count_total = repo.count
      @created_pieces = repo.newly_created
      @updated_pieces = repo.newly_updated
    end
  end
end
