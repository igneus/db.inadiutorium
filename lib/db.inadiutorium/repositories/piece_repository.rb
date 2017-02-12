class PieceRepository < Hanami::Repository
  def count
    pieces.count
  end

  def list(**query)
    list_query(**query).as(Piece)
  end

  def pages_total(limit: 10, **query)
    list_query(**query).count
    (list_query(**query).count.to_f / limit).ceil
  end

  def newly_created(limit: 10)
    pieces
      .order(:created_at)
      .reverse
      .limit(limit)
      .as(Piece)
  end

  def newly_updated(limit: 10)
    pieces
      .order(:updated_at)
      .reverse
      .limit(limit)
      .as(Piece)
  end

  private

  def list_query(limit: nil, page: nil, genre: nil, mode: nil)
    result = pieces
             .order(:lyrics_cleaned)

    if limit
      result = result.limit(limit)
    end

    if page
      result = result.offset((page - 1) * limit)
    end

    if genre
      result = result.where(genre: genre)
    end

    if mode
      result = result.where(mode: mode)
    end

    result
  end
end
