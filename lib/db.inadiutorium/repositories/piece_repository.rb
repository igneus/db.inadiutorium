class PieceRepository < Hanami::Repository
  def count
    pieces.count
  end

  def list(limit: 10, page: 1)
    pieces
      .order(:lyrics_cleaned)
      .limit(limit)
      .offset((page - 1) * limit)
      .as(Piece)
  end

  def pages_total(limit: 10)
    (pieces.count.to_f / limit).ceil
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
end
