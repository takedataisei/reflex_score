require 'rails_helper'

RSpec.describe CommunityMembership, type: :model do
  before do
    @membership = FactoryBot.build(:community_membership)
  end

  describe 'コミュニティメンバーシップ登録' do
    context '登録できる場合' do
      it 'userとcommunityが存在すれば登録できる' do
        expect(@membership).to be_valid
      end
    end

    context '登録できない場合' do
      it 'userが空では登録できない' do
        @membership.user = nil
        @membership.valid?
        expect(@membership.errors.full_messages).to include("User must exist")
      end
  
      it 'communityが空では登録できない' do
        @membership.community = nil
        @membership.valid?
        expect(@membership.errors.full_messages).to include("Community must exist")
      end
  
      it 'roleが空では登録できない' do
        @membership.role = nil
        @membership.valid?
        expect(@membership.errors.full_messages).to include("Role can't be blank")
      end
    end
  end
end
