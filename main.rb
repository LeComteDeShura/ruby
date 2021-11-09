require './src/app'

App.new.run

#
# class Converter < Context
#     attr_accessor :coin, :coins, :coin_names_list, :coin_tickers_list, :similarNames, :value
#
#     def initialize(state)
#         super(state)
#         @coins = []
#         @coin = ''
#         @markets = Array.new
#
#         @client = CoingeckoRuby::Client.new
#         @coin_names_list = []
#         # @coins_list.push "asd"
#         @namesToTicker = []
#         @jarow = FuzzyStringMatch::JaroWinkler.create( :native )
#         # puts "123123"
#         puts 'Input ticker: '
#     end
#
#     def getSimilarNames()
#         @similarNames = Hash.new
#         for item in @coin_names_list do
#             score = @jarow.getDistance(@coin, item[0])
#             if score >= 0.7 then
#                 @similarNames[item[0]] = item[1]
#                 # p item[0]
#             end
#         end
#         @similarNames = @similarNames.select{ |k,v| v!=nil}.to_h
#         @similarNames = @similarNames.sort_by {|k,v| v}.to_h.keys
#         # p @similarNames
#
#         # @similarNames = @client.markets(similarNames, vs_currency: 'usd')
#         # @similarNames = @markets.select{ |item| item["market_cap_rank"]}.map{|item| item["id"] }
#         # @similarNames = @similarNames.select { |item| item["market_cap_rank"] != nil and @similarNames.include? item["id"]}.map{|item| item["id"] }
#
#         return @similarNames
#     end
#
#     def readDataCoinsLists()
#         # file = File.read('./coins')
#         # @data_coins_list = JSON.parse(file)
#         file = File.read('./markets.json')
#         @markets = JSON.parse(file)
#         # for item in @markets do
#         #     p item["id"]
#         # end
#     end
#
#     def parseCoinsList()
#         # @coin_names_list = @data_coins_list.map {|item| item["id"]}
#         # @markets = @client.markets(@coin_names_list.join(', '), vs_currency: 'usd')
#         # for item in @markets do
#         #     p item["id"]
#         # end
#         @coin_names_list = @markets.map{|item| [item["id"],item["market_cap_rank"]]}.to_h
#         @namesToTicker = @markets.map{|item| [item["id"],item["symbol"]]}.to_h
#     end
#
#     def getCurrentRate(coin)
#         # ticker = @namesToTicker[coins[1]]
#         lol = @client.get_exchange_rate(from: coin, to: "usd")
#         # p ticker, lol, coins[1]
#         return lol[coin]['usd']
#     end
#
#     def convert(rate1, rate2, number)
#         # p @value ,rate
#         return (rate1/rate2) * number
#     end
#     # def coin(c='')
#     #     if @coin1[-1] != "\n" then
#     #         @coin1 += c
#     #         return @coin1
#     #     end
#     #     if @coin2[-1] != "\n" then
#     #         @coin2 += c
#     #         return @coin2
#     #     end
#     #     return 1
#     # end
#
#     def coin(c="")
#         if not @coin.empty? and c == "\u007F" then
#             @coin[-1] = ""
#             return @coin
#         end
#         if c == "\n" then
#             return @coin
#         end
#
#         if symbol?(c) then
#             @coin += c
#         end
#         return @coin
#     end
#
#     def symbol?(c)
#        return false unless c[/[\w]/]
#
#        true
#     end
#
#     def isYorN?(c)
#        return false unless c[/[y|n]/]
#
#        true
#     end
#
#     def isNumber?(n)
#         return false unless n[/^[0-9]*[.,]?[0-9]+([eE][+-][0-9]+)?$/]
#
#         true
#     end
#     # def coin
#     #     if not @coin1.empty? and @coin1[-1] != "\n" then
#     #         return @coin1
#     #         if not @coin2.empty? and @coin2[-1] != "\n" then
#     #             return @coin2
#     #         end
#     #     end
#     #
#     # end
# end
#
# class InputName < State
#
#     def initialize()
#         @a = ''
#
#     end
#
#     def do
#         @a = STDIN.getch
#         @context.coin(@a)
#     end
#
#     def next
#         # puts "asdasd"
#         if @a == "\e" then
#             exit 0
#         end
#
#         if @a == "\r" then
#             @context.transition_to(SetFirstCoin.new)
#         else
#             @context.transition_to(OutputSimularNames.new)
#         end
#     end
# end
#
# class OutputSimularNames < State
#
#     def printSimilarNames()
#         index = 0
#         for item in @context.similarNames do
#             puts item
#             index += 1
#             break if index >= 10
#         end
#     end
#     def do
#         system "clear"
#
#         puts 'Input ticker: ' + @context.coin
#         puts "similar names: "
#         @context.getSimilarNames
#         printSimilarNames
#     end
#
#     def next
#         @context.transition_to(InputName.new)
#     end
# end
#
# class SetFirstCoin < State
#     def do
#     end
#
#     def next
#         if @context.coins.empty? then
#             if not @context.coin.empty? then
#
#                 if @context.coin != @context.similarNames[0]
#                     @context.transition_to(IsRightName.new)
#                     @context.coin = ""
#                 else
#                     @context.coins.push @context.coin
#                     @context.coin = ""
#                     @context.transition_to(SetSecondCoin.new)
#                 end
#             else
#                 @context.transition_to(InputName.new)
#             end
#             # puts @context.coin
#         else
#             @context.transition_to(SetSecondCoin.new)
#         end
#
#         # exit 0
#     end
# end
#
# class SetSecondCoin < State
#     def do
#     end
#
#     def next
#         if @context.coin.empty? and @context.coins.size == 1 then
#             @context.transition_to(InputName.new)
#         elsif  @context.coin != @context.similarNames[0] and @context.coins.size == 1 then
#             @context.transition_to(IsRightName.new)
#         else
#             @context.coins.push @context.coin
#             @context.transition_to(InputValue.new)
#         end
#     end
# end
#
# class IsRightName < State
#     def do
#         puts "Do you mean " + @context.similarNames[0] + "?"
#         loop do
#             @yn = STDIN.getch
#             break if @context.isYorN? @yn
#         end
#     end
#
#     def next
#         system "clear"
#         puts 'Input ticker: '
#         if @yn == "y" then
#             @context.coins.push @context.similarNames[0]
#             @context.coin = ""
#             @context.transition_to(SetFirstCoin.new)
#         else
#             @context.coin = ""
#             @context.transition_to(SetFirstCoin.new)
#         end
#     end
# end
#
# class InputValue < State
#     def do
#         system "clear"
#         print "Enter amount to convert: "
#         STDOUT.flush
#         @context.value = $stdin.gets.chomp
#     end
#
#     def next
#         if @context.isNumber? @context.value
#             @context.value = @context.value.to_f
#             @context.transition_to(Convert.new)
#         else
#             @context.transition_to(InputValue.new)
#         end
#         # exit 0
#     end
# end
#
# class Convert < State
#     def do
#         rate1 = @context.getCurrentRate(@context.coins[0])
#         rate2 = @context.getCurrentRate(@context.coins[1])
#
#         converted = @context.convert(rate1, rate2, @context.value)
#         puts "Converted #{@context.value} #{@context.coins[0]} = #{converted} #{@context.coins[1]}"
#     end
#
#     def next
#         # @context.transition_to(InputValue.new)
#         exit 0
#     end
# end
#
# class EndState < State
#     def do
#         exit 0
#     end
#
#     def next
#
#     end
# end
#

#################################################################################

################################################################################
# for item in context.coin_names_list do
#
#     p item[0]
#
# end

# puts context.coin_names_list
# puts context.coin_tickers_list
#

# context.coin = "btc"
# p context.getSimilarNames

# p client.markets('bitz', vs_currency: 'gbp')

# file = File.read('./coins')
# data_hash = JSON.parse(file)
# file.close
# puts data_hash[0]["id"]
# for item in data_hash do
#   puts item
# end
#
#
#
#
#
#
#

# require 'fuzzystringmatch'
# jarow = FuzzyStringMatch::JaroWinkler.create( :native )
#
#
# # coins = context.coin_tickers_list
# coins = context.coin_names_list
# similar = Hash.new
# for item in coins do
#     l = jarow.getDistance("do", item)
#     if item == "dogecoin" then
#         p l
#     end
#     if l >= 0.8 then
#         similar[item] = l
#         # similar[l] = item
#     end
# end
#
# keys = similar.keys
# keys = keys.join(', ')
# # p keys
# p '\r'
# p arra
# similar.clear
# for item in arra do
#     puts item["id"]
#     puts item["market_cap_rank"] == nil
#     # similar[item["id"]]
# end
#
# arra2 = arra.select { |item| item["market_cap_rank"] != nil}.map{|item| item["id"] }
# p arra2
# market_cap_rank
# similar = similar.sort {|a,b| a[1]<=>b[1]}.reverse

# a = ''
# old_state = "stty -g"
# disable echoing and enable raw (not having to press enter)
# system "stty raw -echo"
# a += STDIN.getc.chr
# a = STDIN.getch
# if a == "\u007F" then
#     p "looool"
# end
# loop do
#     a = STDIN.getch
#     # context.isYorN a
#   break if context.isYorN? a
# end

# file = File.new("./file.txt", "a:UTF-8")

#
# File.open("markets.json","w") do |f|
#   f.write(tempHash.to_json)
# end
#
# file = File.read('./coins')
# data_coins_list = JSON.parse(file)
#
# coin_names_list = data_coins_list.map {|item| item["id"]}
# markets = client.markets(coin_names_list.join(', '), vs_currency: 'usd')

#
# p context.symbol?(a)
#

# a = [1, 2, 3, 4, 5, 6, 7]
# p a[2,1]
# sleep(10)
# p context.coin_names_list.size
#############################
# client = CoingeckoRuby::Client.new
# count = 0
# arra = []
# countcoins = 200
# sizelist = context.coin_names_list.size
# while count+200 < sizelist do
#     arra = arra | client.markets(context.coin_names_list[count,countcoins].join(', '), vs_currency: 'usd')
#     count += 200
#     if count+200 >= sizelist then
#         countcoins = sizelist-1-count
#     end
#     p count, countcoins
#     sleep 1.5
# end
# # arra = arra | client.markets(context.coin_names_list[100,100].join(', '), vs_currency: 'usd')
#
# File.open("markets.json","w") do |f|
#   f.write(arra.to_json)
# end
#############################
# p arra

# p 0.7 if 1 el 0
