module Web::Controllers::Pieces
  class Index
    include Web::Action

    expose :pieces

    def call(params)
      repo = PieceRepository.new
      @pieces = repo.all
    end
  end
end
