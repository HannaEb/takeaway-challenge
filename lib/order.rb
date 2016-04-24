require_relative 'menu'
require_relative 'restaurant'
require_relative 'messager'

class Order

attr_reader :restaurant_class, :basket

  def initialize(restaurant_class = Restaurant.new)
    @restaurant_class = restaurant_class
    @basket = Hash.new(0)
  end

  def add(dish, quantity = 1)
    fail 'Dish not available' unless menu.include?(dish)
    @basket[dish] += quantity
  end

  def summary
    @basket.keys.zip(menu.map { |k, v| sprintf('%.2f', (@basket[k] * v.to_f)) if @basket.key? k }.compact.reverse).to_h
  end

  # def to_pay
  #   @sum.values.inject { |a, b| a += b }
  # end

  # def checkout
  #   fail 'Incorrect price. Order cancelled' unless correct_price?

  # end

  private

  def menu
    restaurant_class.display_menu
  end

  def correct_price?(price)
    to_pay == price
  end
end