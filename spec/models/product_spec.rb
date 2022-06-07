require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "product will save" do
      @category = Category.new(name: "test")
      @category.save
      
      @product = Product.new(
        name: "nil", 
        description: "this is a plant",
        category_id: @category.id,
        quantity: 10,
        image: "image",
        price_cents: 10.99)
      saved = @product.save

      expect(saved).to be_truthy

    end

    it "name presence" do
      @category = Category.new(name: "test")
      @category.save

      @product = Product.new(
        name: nil, 
        description: "this is a plant",
        category_id: @category.id,
        quantity: 10,
        image: "image",
        price_cents: 10.99)
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")

    end

    it "price presence" do
      @category = Category.new(name: "test")
      @category.save

      @product = Product.new(
        name: "plant 1", 
        description: "this is a plant",
        category_id: @category.id,
        quantity: 10,
        image: "image",
        price_cents: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")

    end

    it "quantity presence" do
      @category = Category.new(name: "test")
      @category.save

      @product = Product.new(
        name: "plant 1", 
        description: "this is a plant",
        category_id: @category.id,
        quantity: nil,
        image: "image",
        price_cents: 10.99)
      @product.save
      
      expect(@product.errors.full_messages).to include("Quantity can't be blank")

    end

    it "category presence" do
      @category = nil
      @product = Product.new(
        name: "plant 1", 
        description: "this is a plant",
        category_id: @category,
        quantity: 10,
        image: "image",
        price_cents: 10.99)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
