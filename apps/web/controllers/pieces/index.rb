module Web::Controllers::Pieces
  class Index
    include Web::Action
    include Inject['piece_repository']

    expose :page, :items, :pieces, :pages_total

    params do
      optional(:page).filled(:int?, gt?: 1)
      optional(:items).filled(:int?, included_in?: 1..500)
    end

    def call(params)
      @page = params[:page] || 1
      @items = params[:items] || 20
      @pieces = piece_repository.list(page: @page, limit: @items)
      @pages_total = piece_repository.pages_total(limit: @items)
    end
  end
end
