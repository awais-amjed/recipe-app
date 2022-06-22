require_relative '../test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:one)
  end

  test 'should get index' do
    get user_recipes_path
    assert_response :success
  end

  test 'should get new' do
    get new_user_recipe_path
    assert_response :success
  end

  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post user_recipes_path,
           params: { recipe: { cooking_time: @recipe.cooking_time, description: @recipe.description, name: @recipe.name,
                               preparation_time: @recipe.preparation_time, public: @recipe.public,
                               user_id: @recipe.user_id } }
    end

    assert_redirected_to user_recipe_path(Recipe.last)
  end

  test 'should show recipe' do
    get user_recipe_path(@recipe)
    assert_response :success
  end

  test 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete user_recipe_path(@recipe)
    end

    assert_redirected_to user_recipes_path
  end
end
