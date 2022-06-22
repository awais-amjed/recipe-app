class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  before_action :set_user
  before_action :redirect_if_not_signed_in

  def index
    @recipes = @user.recipes
  end

  def show
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = @user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe added successfully' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def get_time_in_string_format(time)
    m = time % 60
    minutes = m == 1 ? '1 minute' : "#{m} minutes"
    h = (time / 60).floor
    hours = h == 1 ? '1 hour ' : "#{h} hours "

    "#{hours unless h.zero?}#{minutes}"
  end

  helper_method :get_time_in_string_format

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def redirect_if_not_signed_in
    redirect_to new_user_session_path, alert: 'You must be logged in access this page' if @user.nil?
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
