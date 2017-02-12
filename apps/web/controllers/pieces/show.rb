module Web::Controllers::Pieces
  class Show
    include Web::Action
    include Inject['piece_repository']

    expose :piece

    def call(params)
      @piece = piece_repository.find_with_source_file params[:id]
    end
  end
end
