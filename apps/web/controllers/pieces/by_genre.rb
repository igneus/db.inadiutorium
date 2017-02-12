module Web::Controllers::Pieces
  class ByGenre
    include Web::Action
    include Inject['piece_repository']

    # maps URL names to db names
    GENRE_MAP = {
      'antifona' => 'antiphona',
      'responsorium' => 'responsorium breve',
      'responsorium.pr' => 'responsorium',
    }

    expose :page, :items, :pieces, :pages_total, :genre

    params do
      optional(:page).filled(:int?, gt?: 1)
      optional(:items).filled(:int?, included_in?: 1..500)

      required(:genre).filled(included_in?: GENRE_MAP)
    end

    def call(params)
      @genre = GENRE_MAP[params[:genre]]
      @page = params[:page] || 1
      @items = params[:items] || 20
      @pieces = piece_repository.list(genre: @genre, page: @page, limit: @items)
      @pages_total = piece_repository.pages_total(limit: @items)
    end
  end
end
