require 'rails_helper'

RSpec.describe EvaluationItem, type: :model do
  before do
    @item = FactoryBot.build(:evaluation_item)
  end

  describe '評価項目登録' do
    context '登録できる場合' do
      it 'nameとcommunityが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
  
      it 'communityが空では登録できない' do
        @item.community = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Community must exist")
      end
    end
  end
end
