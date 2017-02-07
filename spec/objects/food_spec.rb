require 'spec_helper'

include ActiveNutrition::Objects

describe Food do
  subject { ActiveNutrition.search('table salt').first }

  describe '#name' do
    it 'exposes the name attribute' do
      expect(subject.name).to eq('Salt, table')
    end
  end

  describe '#food_group' do
    it 'finds the associated food group' do
      group = subject.food_group
      expect(group).to be_a(FoodGroup)
      expect(group.name).to eq('Spices and Herbs')
    end
  end

  describe '#nutrition_facts' do
    it 'finds the associated nutrition facts' do
      facts = subject.nutrition_facts
      expect(facts).to be_a(NutritionFacts)

      # I think this is like per 100 grams or something
      expect(facts.protein).to eq(0)
      expect(facts.fat).to eq(0)
      expect(facts.sodium).to eq(38758.0)
    end
  end

  describe '#weights' do
    it 'finds the associated (household) weights' do
      weights = subject.weights
      expect(weights).to be_a(Weights)
      weight = weights.get('tsp')
      expect(weight.measurement).to eq('tsp')
      expect(weight.grams).to eq(6.0)
      expect(weight.amount).to eq(1.0)
    end
  end

  describe '#factors' do
    it 'gets the fat and protein factors' do
      # actually find something with fat and protein (salt has nil values for these)
      food = ActiveNutrition.search('salted butter').first
      factors = food.factors
      expect(factors).to eq(fat_factor: 8.79, protein_factor: 4.27)
    end
  end
end
