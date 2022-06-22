json.extract! recipe, :id, :name, :preparation_time, :cooking_time, :description, :public, :user_id, :created_at,
              :updated_at
json.url user_recipe_path(recipe, format: :json)
