module Web::Controllers::Pieces
  class Show
    include Web::Action

    expose :piece

    def call(params)
      repo = PieceRepository.new
      @piece = repo.find params[:id]
    end
  end
end
