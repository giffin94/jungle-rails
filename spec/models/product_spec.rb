require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.new(name: 'New')}
  subject { described_class.new(name: 'Item', price: 2, quantity: 10, category: category) }
  describe 'Validations' do
    it 'should be valid with all fields' do
      expect(subject).to be_valid
    end

    it 'should be invalid without a name' do
      subject.name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Name can't be blank/
    end

    it 'should be invalid without a price' do
      subject.price_cents = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Price cents is not a number/
    end

    it 'should be invalid without a category' do
      subject.category = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Category can't be blank/
    end

    it 'should be invalid without a quantity' do
      subject.quantity = nil
      subject.save
      expect(subject.errors.full_messages[0]).to match /Quantity can't be blank/
    end

  end
end

# describe '#id' do
#   it 'should not exist for new records' do
#     @widget = Widget.new
#     expect(@widget.id).to be_present
#   end

#   it 'should be auto-assigned by AR for saved records' do
#     @widget = Widget.new
#     @widget.save!
#     expect(@widget.id).to be_nil
#   end
# end