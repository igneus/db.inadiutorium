module Web::Controllers::Pieces
  class ByMode
    include Web::Action
    include Inject['piece_repository']

    expose :page, :items, :pieces, :pages_total, :mode

    params do
      optional(:page).filled(:int?, gt?: 1)
      optional(:items).filled(:int?, included_in?: 1..500)

      required(:mode).filled(included_in?: Routing::ModeMap)
    end

    def call(params)
      @mode = Routing::ModeMap[params[:mode]]
      @page = params[:page] || 1
      @items = params[:items] || 20
      filter = {mode: @mode}
      @pieces = piece_repository.list(page: @page, limit: @items, **filter)
      @pages_total = piece_repository.pages_total(limit: @items, **filter)
    end
  end
end
