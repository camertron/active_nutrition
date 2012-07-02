# encoding: UTF-8

module ActiveNutrition
  module Objects
    autoload :Base,           'active_nutrition/objects/base'
    autoload :Food,           'active_nutrition/objects/food'
    autoload :Weight,         'active_nutrition/objects/weight'
    autoload :Weights,        'active_nutrition/objects/weights'
    autoload :FoodGroup,      'active_nutrition/objects/food_group'
    autoload :NutritionFact,  'active_nutrition/objects/nutrition_fact'
    autoload :NutritionFacts, 'active_nutrition/objects/nutrition_facts'
  end
end