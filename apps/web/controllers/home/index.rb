module Web::Controllers::Home
  class Index
    include Web::Action
    include Inject['piece_repository']

    expose :created_pieces, :updated_pieces, :count_total

    def call(params)
      @count_total = piece_repository.count
      @created_pieces = piece_repository.newly_created
      @updated_pieces = piece_repository.newly_updated
    end
  end
end
