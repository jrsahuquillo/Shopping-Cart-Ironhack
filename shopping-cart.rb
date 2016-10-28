require 'pry'
require 'colorize'



class ShoppingCart
	def initialize(shop_products)
		@cart1 = {}
		@cart2 = {}
		@shop_products = shop_products
		@total = 0
		@bananas_free = 0
	end

	def add_item_to_cart(item)
		if @shop_products.key?(item)
			puts "How many #{item} would you buy?: "
			number = gets.chomp
			@cart1[item] = number.to_i
			puts @cart1
		else
			puts "#{item} is not in the shop"
		end
	
	end

	def show
		#binding pry

		apple_deals
		orange_deals
		grape_deals
		banana_deals
		watermelon_deals

		@cart2.each do |key,value|
			bill = "#{@cart1[key]} ud: #{key}: #{@shop_products[key] * value} $"
			puts bill
		end
	end

	def saved
		@no_deal_total = 0
		@cart1.each do |key,value|
			@no_deal_total += @shop_products[key]*value 
		end
	end


	def cost
		@cart2.each do |key,value|
			@total += @shop_products[key]*value 
		end

		puts "Total cost is: #{@total}$" .colorize(:green)
		saved
		puts "You saved #{@no_deal_total - @total} $ with deals!".colorize(:yellow)
	end

	def apple_deals #2x1 deal
		@cart1.each do |key,value|
			if key == :apples
				if value%2 == 0
					@cart2[:apples] = value/2
				else
					@cart2[:apples] = ((value-1)/2)+1
				end
			end
		end		
	end

	def orange_deals #3x2 deal
		@cart1.each do |key,value|
			if key == :oranges
				if value%3 == 0
					@cart2[:oranges] = value/3*2
				else
					@cart2[:oranges] = ((value-(value%3))/3*2)+value%3
				end
			end
		end		
	end

	def banana_deals #No deal
		#@cart2[:bananas] = @cart1[:bananas]
		if @cart1[:bananas] > 0
			@cart2[:bananas] = @cart1[:bananas] - @bananas_free

		end
	end

	def grape_deals #1 banana for each 4 grapes
		if @shop_products.key?(:grapes)
			puts "Deal: 1 banana free for each 4 grapes"
			if @cart1[:grapes] >= 4
			 	@bananas_free = (@cart1[:grapes] - @cart1[:grapes]%4)/4
			end
				@cart2[:grapes] = @cart1[:grapes]
		end
	end

	def watermelon_deals #No deal
		@cart2[:watermelons] = @cart1[:watermelons]
	end
end

class Shop
	attr_accessor :shop_products, :apple_deals
	def initialize
		@shop_products = {
			apples: 10,
			oranges: 5,
			grapes: 15,
			bananas: 20,
			watermelons: 50
		}	
	end	

	

	
=begin
	def grapes_deals #4 grapes = 1 free banana
		@cart.each do |key,value|
			if key == :grapes
				if value == 
					@cart[:banana] = 0
			end
		end		
	end
=end
end





shop1 = Shop.new
shop1.shop_products

cart = ShoppingCart.new(shop1.shop_products)

cart.add_item_to_cart :apples
cart.add_item_to_cart :oranges
cart.add_item_to_cart :grapes
cart.add_item_to_cart :bananas
cart.add_item_to_cart :watermelons

cart.show
cart.cost


