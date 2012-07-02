# encoding: UTF-8

module ActiveNutrition
  module Models
    autoload :Migration, 'active_nutrition/models/migration'
    autoload :DataSrc,   'active_nutrition/models/data_src'
    autoload :Datsrcln,  'active_nutrition/models/datsrcln'
    autoload :DerivCd,   'active_nutrition/models/deriv_cd'
    autoload :FdGroup,   'active_nutrition/models/fd_group'
    autoload :FoodDes,   'active_nutrition/models/food_des'
    autoload :Footnote,  'active_nutrition/models/footnote'
    autoload :Langdesc,  'active_nutrition/models/langdesc'
    autoload :Langual,   'active_nutrition/models/langual'
    autoload :NutData,   'active_nutrition/models/nut_data'
    autoload :NutrDef,   'active_nutrition/models/nutr_def'
    autoload :SrcCd,     'active_nutrition/models/src_cd'
    autoload :Weight,    'active_nutrition/models/weight'
  end
end