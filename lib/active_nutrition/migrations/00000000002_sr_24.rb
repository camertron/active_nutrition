# encoding: UTF-8

module ActiveNutrition
  module Migrations
    class Sr24 < ActiveRecord::Migration
      def self.up
        create_table "abbrev", :primary_key => "NDB_No", :force => true do |t|
          t.string  "Shrt_Desc",                  :limit => 60
          t.float   "Water"
          t.integer "Energ_Kcal"
          t.float   "Protein"
          t.float   "Lipid_Tot"
          t.float   "Ash"
          t.float   "Carbohydrt"
          t.float   "Fiber_TD"
          t.float   "Sugar_Tot",                  :default => 0.0
          t.integer "Calcium"
          t.float   "Iron"
          t.float   "Magnesium",                  :default => 0.0
          t.integer "Phosphorus"
          t.integer "Potassium"
          t.integer "Sodium"
          t.float   "Zinc",                       :default => 0.0
          t.float   "Copper",                     :default => 0.0
          t.float   "Manganese",                  :default => 0.0
          t.float   "Selenium",                   :default => 0.0
          t.float   "Vit_C"
          t.float   "Thiamin",                    :default => 0.0
          t.float   "Riboflavin",                 :default => 0.0
          t.float   "Niacin",                     :default => 0.0
          t.float   "Panto_Acid",                 :default => 0.0
          t.float   "Vit_B6",                     :default => 0.0
          t.float   "Folate_Tot",                 :default => 0.0
          t.float   "Folic_Acid",                 :default => 0.0
          t.float   "Food_Folate",                :default => 0.0
          t.float   "Folate_DFE",                 :default => 0.0
          t.float   "Choline_Tot",                :default => 0.0
          t.float   "Vit_B12",                    :default => 0.0
          t.integer "Vit_A_IU"
          t.float   "Vit_A_RAE",                  :default => 0.0
          t.float   "Retinol",                    :default => 0.0
          t.float   "Alpha_Carot",                :default => 0.0
          t.float   "Beta_Carot",                 :default => 0.0
          t.float   "Beta_Crypt",                 :default => 0.0
          t.float   "Lycopene",                   :default => 0.0
          t.float   "Lut+Zea",                    :default => 0.0
          t.float   "Vit_E",                      :default => 0.0
          t.float   "Vit_D_mcg",                  :default => 0.0
          t.float   "ViVit_D_IU",                 :default => 0.0
          t.float   "Vit_K",                      :default => 0.0
          t.float   "FA_Sat"
          t.float   "FA_Mono",                    :default => 0.0
          t.float   "FA_Poly",                    :default => 0.0
          t.integer "Cholestrl"
          t.float   "GmWt_1"
          t.string  "GmWt_Desc1",                 :limit => 120
          t.float   "GmWt_2",                     :default => 0.0
          t.string  "GmWt_Desc2",                 :limit => 120
          t.integer "Refuse_Pct"
        end

        add_index "abbrev", ["Folic_Acid"], :name => "Abbrev_Folic_Acid_Index"
        add_index "abbrev", ["Panto_Acid"], :name => "Abbrev_Panto_Acid_Index"

        create_table "data_src", :id => false, :primary_key => "DataSrc_ID", :force => true do |t|
          t.integer "DataSrc_ID"
          t.string "Authors"
          t.string "Title"
          t.string "Year",        :limit => 4
          t.string "Journal",     :limit => 135
          t.string "Vol_city",    :limit => 16
          t.string "Issue_State", :limit => 5
          t.string "Start_Page",  :limit => 5
          t.string "End_Page",    :limit => 5
        end

        add_index "data_src", ["DataSrc_ID"], :name => "DataSrc_ID_Index"

        create_table "datsrcln", :id => false, :primary_key => "NDB_No", :force => true do |t|
          t.integer "NDB_No",                  :null => false
          t.integer "Nutr_No",                 :null => false
          t.string  "DataSrc_ID", :limit => 6, :null => false
        end

        add_index "datsrcln", ["NDB_No", "Nutr_No", "DataSrc_ID"], :name => "Datsrcln_NDB_No_Nutr_No_DataSrc_ID_Index", :unique => true

        #create_table "deriv_cd", :primary_key => "Deriv_CD", :force => true do |t|
        create_table "deriv_cd", :id => false, :primary_key => "Deriv_CD", :force => true do |t|
          t.integer "Deriv_CD"
          t.string "Deriv_Desc", :limit => 120
        end

        add_index "deriv_cd", ["Deriv_CD"], :name => "Deriv_CD_Deriv_CD_Index"

        create_table "fd_group", :primary_key => "FdGrp_CD", :force => true do |t|
          t.string "FdGrp_Desc", :limit => 60
        end

        create_table "food_des", :primary_key => "NDB_No", :force => true do |t|
          t.string  "FdGrp_Cd",    :limit => 4
          t.string  "Long_Desc",   :limit => 200
          t.string  "Shrt_Desc",   :limit => 60
          t.string  "ComName",     :limit => 100
          t.string  "ManufacName", :limit => 65
          t.string  "Survey",      :limit => 1
          t.string  "Ref_Desc",    :limit => 135
          t.integer "Refuse"
          t.string  "SciName",     :limit => 65
          t.float   "N_Factor"
          t.float   "Pro_Factor"
          t.float   "Fat_Factor"
          t.float   "CHO_Factor"
        end

        create_table "footnote", :id => false, :primary_key => "Footnt_No", :force => true do |t|
          t.integer "NDB_No",      :null => false
          t.integer "Footnt_No"
          t.string  "Footnot_Typ", :limit => 1
          t.integer "Nutr_No"
          t.string  "Footnot_Txt", :limit => 200
        end

        create_table "langdesc", :id => false, :primary_key => "Factor_Code", :force => true do |t|
          t.string "Factor_Code"
          t.string "Description", :limit => 250
        end

        add_index "langdesc", ["Factor_Code"], :name => "LangDesc_Factor_Code_Index"

        create_table "langual", :id => false, :primary_key => "NDB_No", :force => true do |t|
          t.integer "NDB_No", :null => false
          t.string  "Factor_Code", :limit => 6, :null => false
        end

        add_index "langual", ["NDB_No", "Factor_Code"], :name => "Langual_NDB_No_Factor_Code_Index", :unique => true

        create_table "nut_data", :id => false, :primary_key => "NDB_No", :force => true do |t|
          t.integer "NDB_No",        :null => false
          t.integer "Nutr_No",       :null => false
          t.float   "Nutr_Val"
          t.integer "Num_Data_Pts"
          t.float   "Std_Error"
          t.string  "Src_Cd",        :limit => 2
          t.string  "Deriv_Cd",      :limit => 4
          t.integer "Ref_NDB_No"
          t.string  "Add_Nutr_Mark", :limit => 1
          t.integer "Num_Studies"
          t.float   "Min"
          t.float   "Max"
          t.float   "DF"
          t.float   "Low_EB"
          t.float   "Up_EB"
          t.string  "Stat_Cmt",      :limit => 10
          t.date    "AddMod_Date"
          t.string  "CC"
        end

        add_index "nut_data", ["NDB_No", "Nutr_No"], :name => "Nut_Data_NDB_No_Nutr_No_Index", :unique => true
        add_index "nut_data", ["Num_Data_Pts"], :name => "Nut_Data_Num_Data_Pts_Index"
        add_index "nut_data", ["Num_Studies"], :name => "Num_Studies_Index"

        create_table "nutr_def", :primary_key => "Nutr_No", :force => true do |t|
          t.string "Units",    :limit => 7
          t.string "Tagname",  :limit => 20
          t.string "NutrDesc", :limit => 60
          t.string "Num_Dec",  :limit => 1
          t.float  "SR_Order"
        end

        add_index "nutr_def", ["Num_Dec"], :name => "Num_Dec_Index"

        create_table "src_cd", :primary_key => "Src_Cd", :force => true do |t|
          t.string "SrcCd_Desc", :limit => 60
        end

        create_table "weight", :id => false, :primary_key => "NDB_No", :force => true do |t|
          t.integer "NDB_No",       :null => false
          t.integer "Seq",          :null => false
          t.float   "Amount"
          t.string  "Msre_Desc",    :limit => 80
          t.float   "Gm_Wgt"
          t.integer "Num_Data_Pts"
          t.float   "Std_Dev"
        end

        add_index "weight", ["NDB_No", "Seq"], :name => "Weight_NDB_No_Seq_Index", :unique => true
        add_index "weight", ["Num_Data_Pts"], :name => "Weight_Num_Data_Pts_Index"
      end

      def self.down
        drop_table "abbrev"
        drop_table "data_src"
        drop_table "datsrcln"
        drop_table "deriv_cd"
        drop_table "fd_group"
        drop_table "food_des"
        drop_table "footnote"
        drop_table "langdesc"
        drop_table "langual"
        drop_table "nut_data"
        drop_table "nutr_def"
        drop_table "src_cd"
        drop_table "weight"
      end
    end
  end
end