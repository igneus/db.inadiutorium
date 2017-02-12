# maps mode names as used in URL to mode names for users and database
module Routing
  class ModeMap
  MAP = {
    'i' => 'I',
    'ii' => 'II',
    'iii' => 'III',
    'iv' => 'IV',
    'iva' => 'IV alt',
    'v' => 'V',
    'vi' => 'VI',
    'vii' => 'VII',
    'viii' => 'VIII',
    'per' => 'per.',
  }.freeze

  def self.[](key)
    MAP[key]
  end

  def self.include?(key)
    MAP.include? key
  end

  def self.to_a
    %w(i ii iii iv iva v vi vii viii per).collect do |i|
      Mode.new(MAP[i], i)
    end
  end

  Mode = Struct.new(:name, :url_name)
end
end
