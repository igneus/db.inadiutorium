module Web::Controllers::Pieces
  class Modes
    include Web::Action

    expose :modes

    def call(params)
      @modes = Routing::ModeMap.to_a
    end
  end
end
