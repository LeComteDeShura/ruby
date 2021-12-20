require_relative '../abstract/context'
require_relative '../abstract/state'
require 'io/console'
require 'coingecko_ruby'
require 'json'
require 'fuzzystringmatch'

class Converter < Context
  attr_accessor :coin, :coins, :coin_names_list, :coin_tickers_list, :similar_names, :value, :from_coin, :to_coin,
                :current_coin

  def initialize(state)
    super(state)
    @current_coins = []
    @current_coin = ''
    @from_coin = ''
    @to_coin = ''
    @markets = []
    @similar_names = []
    @client = CoingeckoRuby::Client.new
    @current_coin_names_list = []
    @names_to_ticker = []
    @jarow = FuzzyStringMatch::JaroWinkler.create(:native)
  end

  def find_similar_names
    @similar_names = {}
    @current_coin_names_list.each do |item|
      score = @jarow.getDistance(@current_coin, item[0])
      @similar_names[item[0]] = item[1] if score >= 0.7
    end
    @similar_names = @similar_names.compact.to_h
    @similar_names = @similar_names.sort_by { |_k, v| v }.to_h.keys
    @similar_names
  end

  def read_data_coins_lists
    file = File.read('./data/markets.json')
    @markets = JSON.parse(file)
  end

  def parse_coins_list
    @current_coin_names_list = @markets.map { |item| [item['id'], item['market_cap_rank']] }.to_h
    @names_to_ticker = @markets.map { |item| [item['id'], item['symbol']] }.to_h
  end

  def get_current_rate(coin)
    lol = @client.get_exchange_rate(from: coin, to: 'usd')
    lol[coin]['usd']
  end

  def add_key_to_coin(key = '')
    if !@current_coin.empty? && (key == "\u007F")
      @current_coin[-1] = ''
      return @current_coin
    end
    return @current_coin if key == "\n"

    @current_coin += key if symbol?(key)
    @current_coin
  end

  def symbol?(key)
    return false unless key[/\w/]

    true
  end
end
