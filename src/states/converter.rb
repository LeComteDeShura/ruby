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

    @client = CoingeckoRuby::Client.new
    @coin_names_list = []
    # @coins_list.push "asd"
    @namesToTicker = []
    @jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    # puts "123123"
    puts 'Input ticker: '
  end

  def getSimilarNames
    @similarNames = {}
    @coin_names_list.each do |item|
      score = @jarow.getDistance(@coin, item[0])
      if score >= 0.7
        @similarNames[item[0]] = item[1]
        # p item[0]
      end
    end
    @similarNames = @similarNames.select { |_k, v| !v.nil? }.to_h
    @similarNames = @similarNames.sort_by { |_k, v| v }.to_h.keys
    # p @similarNames

    # @similarNames = @client.markets(similarNames, vs_currency: 'usd')
    # @similarNames = @markets.select{ |item| item["market_cap_rank"]}.map{|item| item["id"] }
    # @similarNames = @similarNames.select { |item| item["market_cap_rank"] != nil and @similarNames.include? item["id"]}.map{|item| item["id"] }

    @similarNames
  end

  def readDataCoinsLists
    # file = File.read('./coins')
    # @data_coins_list = JSON.parse(file)
    file = File.read('./data/markets.json')
    @markets = JSON.parse(file)
    # for item in @markets do
    #     p item["id"]
    # end
  end

  def parseCoinsList
    # @coin_names_list = @data_coins_list.map {|item| item["id"]}
    # @markets = @client.markets(@coin_names_list.join(', '), vs_currency: 'usd')
    # for item in @markets do
    #     p item["id"]
    # end
    @coin_names_list = @markets.map { |item| [item['id'], item['market_cap_rank']] }.to_h
    @namesToTicker = @markets.map { |item| [item['id'], item['symbol']] }.to_h
  end

  def getCurrentRate(coin)
    # ticker = @namesToTicker[coins[1]]
    lol = @client.get_exchange_rate(from: coin, to: 'usd')
    # p ticker, lol, coins[1]
    lol[coin]['usd']
  end

  def convert(rate1, rate2, number)
    # p @value ,rate
    (rate1 / rate2) * number
  end
  # def coin(c='')
  #     if @coin1[-1] != "\n" then
  #         @coin1 += c
  #         return @coin1
  #     end
  #     if @coin2[-1] != "\n" then
  #         @coin2 += c
  #         return @coin2
  #     end
  #     return 1
  # end

  def coin(c = '')
    if !@coin.empty? and c == "\u007F"
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
  # def coin
  #     if not @coin1.empty? and @coin1[-1] != "\n" then
  #         return @coin1
  #         if not @coin2.empty? and @coin2[-1] != "\n" then
  #             return @coin2
  #         end
  #     end
  #
  # end
end
