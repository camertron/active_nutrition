module ActiveNutrition
  class Weight < ActiveRecord::Base
    set_table_name "weight"
    set_primary_key :NDB_No

    validates :NDB_No, :uniqueness => { :scope => [:Seq] }
    validates :Seq, :uniqueness => { :scope => [:NDB_No] }

    alias_attribute :amount, :Amount
    alias_attribute :grams, :Gm_Wgt
    alias_attribute :measurement, :Msre_Desc
  end
end