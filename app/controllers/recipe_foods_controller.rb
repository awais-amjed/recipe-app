class RecipeFoodsController < ApplicationController
  load_and_authorize_resource

  before_action :set_recipe, only: %i[new create destroy]

  def new
    redirect_to new_food_path, notice: 'You need to add a new food first' if Food.count.zero?

    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe), notice: "#{@recipe_food.food.name} added to #{@recipe.name}" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_path, notice: 'Food deleted successfully' }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
