require_relative '../abstract/context'
require_relative '../abstract/state'
require 'io/console'
require 'coingecko_ruby'
require 'json'
require 'fuzzystringmatch'

class Converter < Context
  attr_accessor :coin, :coins, :coin_names_list, :coin_tickers_list, :similarNames, :value

  def initialize(state)
    super(state)
    @coins = []
    @coin = ''
    @markets = []
    @similarNames = []
    @client = CoingeckoRuby::Client.new
    @coin_names_list = []
    @namesToTicker = []
    @jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    puts 'Input ticker: '
  end

  def getSimilarNames
    @similarNames = {}
    @coin_names_list.each do |item|
      score = @jarow.getDistance(@coin, item[0])
      @similarNames[item[0]] = item[1] if score >= 0.7
    end
    @similarNames = @similarNames.compact.to_h
    @similarNames = @similarNames.sort_by { |_k, v| v }.to_h.keys
    @similarNames
  end

  def readDataCoinsLists
    file = File.read('./data/markets.json')
    @markets = JSON.parse(file)
  end

  def parseCoinsList
    @coin_names_list = @markets.map { |item| [item['id'], item['market_cap_rank']] }.to_h
    @namesToTicker = @markets.map { |item| [item['id'], item['symbol']] }.to_h
  end

  def getCurrentRate(coin)
    lol = @client.get_exchange_rate(from: coin, to: 'usd')
    lol[coin]['usd']
  end

  def convert(rate1, rate2, number)
    ((rate1 / rate2) * number).round(2)
  end

  def gcoin(c = '')
    if !@coin.empty? && (c == "\u007F")
      @coin[-1] = ''
      return @coin
    end
    return @coin if c == "\n"

    @coin += c if symbol?(c)
    @coin
  end

  def symbol?(c)
    return false unless c[/\w/]

    true
  end

  def isYorN?(c)
    return false unless c[/[y|n]/]

    true
  end

  def isNumber?(n)
    return false unless n[/^[0-9]*[.,]?[0-9]+([eE][+-][0-9]+)?$/]

    true
  end
end
