class PieceRepository < Hanami::Repository
  def newly_created(limit: 10)
    pieces
      .order(:created_at)
      .reverse
      .limit(10)
      .as(Piece)
  end

  def newly_updated(limit: 10)
    pieces
      .order(:updated_at)
      .reverse
      .limit(10)
      .as(Piece)
  end
end
