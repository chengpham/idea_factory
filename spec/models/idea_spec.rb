require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe "validates" do
    describe "title" do
      it "requires a title" do
        idea = FactoryBot.build(:idea, title: nil)
        idea.valid?
        expect(idea.errors.messages).to(have_key(:title))
      end
      it 'title is unique' do
        persisted_idea= FactoryBot.create(:idea)
        idea=FactoryBot.build(:idea, title: persisted_idea.title)
        idea.valid?
        expect(idea.errors.messages).to(have_key(:title))
      end
    end
    describe 'body' do  
      it 'requires body' do
        idea=FactoryBot.build(:idea, description: nil)
        idea.valid?
        expect(idea.errors.messages).to(have_key(:description))
      end
    end
  end
end
