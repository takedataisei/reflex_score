require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context '投稿できる場合' do
      it 'contentとuser、communityが存在すれば投稿できる' do
        expect(@message).to be_valid
      end
    end

    context '投稿できない場合' do
      it 'contentが空では投稿できない' do
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
  
      it 'userが空では投稿できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
  
      it 'communityが空では投稿できない' do
        @message.community = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Community must exist")
      end
    end
  end
end
