require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Includes all four fields and saves successfully' do
      @category = Category.create(:name => "test")
      product =  Product.new(
        :name => "name",
        :description => "description",
        :price_cents => 444,
        :quantity => 44,
        :category_id => @category.id)

      product.validate
      # should save without error msg
      expect(product.errors.full_messages).to be_empty
    end
    it 'Validates the presence of a name' do
      @category = Category.create(:name => "test")
      product =  Product.new(
        :name => nil,
        :description => "description",
        :price_cents => 444,
        :quantity => 44,
        :category_id => @category.id)
      
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Name can't be blank"
    end
    it 'Validates the presence of a price' do
      @category = Category.create(:name => "test")
      product =  Product.new(
        :name => "name",
        :description => "description",
        :price_cents => nil,
        :quantity => 44,
        :category_id => @category.id)
      
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Price is not a number"
    end
    it 'Validates the presence of a quantity' do
      @category = Category.create(:name => "test")
      product =  Product.new(
        :name => "name",
        :description => "description",
        :price_cents => 444,
        :quantity => nil,
        :category_id => @category.id)
      
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'Validates the presence of a category' do
      @category = Category.create(:name => "test")
      product =  Product.new(
        :name => "name",
        :description => "description",
        :price_cents => 444,
        :quantity => 44,
        :category_id => nil)
      
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Category can't be blank"
      expect(product.errors.full_messages).to include "Category must exist"
    end
    
  end
end
