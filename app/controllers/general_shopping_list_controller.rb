class GeneralShoppingListController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @recipe_foods = recipe_foods_of_other_users
    @foods = @recipe_foods.map(&:food).uniq
    @shopping_list = @foods.map do |food|
      {
        food:,
        quantity: @recipe_foods.select { |recipe_food| recipe_food.food_id == food.id }
          .reduce(0) { |sum, recipe_food| sum + recipe_food.quantity }
      }
    end
  end

  def total_price
    @shopping_list.reduce(0) { |sum, item| sum + (item[:food].price * item[:quantity]) }
  end

  helper_method :total_price

  private

  def recipe_foods_of_other_users
    recipes = current_user.recipes.includes(:recipe_foods)
    not_user_foods_ids = Food.where.not(user_id: current_user.id).ids
    recipe_foods = []
    recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        recipe_foods << recipe_food if not_user_foods_ids.include?(recipe_food.food_id)
      end
    end
    recipe_foods
  end
end
