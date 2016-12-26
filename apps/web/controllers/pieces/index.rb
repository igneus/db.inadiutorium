module Web::Controllers::Pieces
  class Index
    include Web::Action
    include Inject['piece_repository']

    expose :pieces

    def call(params)
      @pieces = piece_repository.all
    end
  end
end
