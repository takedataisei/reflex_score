require 'rails_helper'

RSpec.describe Community, type: :model do
  before do
    @community = FactoryBot.build(:community)
  end

  describe 'コミュニティ作成' do
    context 'コミュニティが作成できる場合' do
      it 'nameとpasswordが存在すれば登録できる' do
        expect(@community).to be_valid
      end
    end

    context 'コミュニティが作成できない場合' do
      it 'nameが空では登録できない' do
        @community.name = ''
        @community.valid?
        expect(@community.errors.full_messages).to include("Name can't be blank")
      end
  
      it 'passwordが空では登録できない' do
        @community.password = nil
        @community.password_confirmation = nil
        @community.valid?
        expect(@community.errors.full_messages).to include("Password can't be blank")
      end
  
      it 'nameが重複している場合は登録できない' do
        @community.save
        another_community = FactoryBot.build(:community, name: @community.name)
        another_community.valid?
        expect(another_community.errors.full_messages).to include("Name has already been taken")
      end
  
      it 'passwordが6文字未満では登録できない' do
        @community.password = '12345'
        @community.valid?
        expect(@community.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @community.password = '123456'
        @community.password_confirmation = '1234567'
        @community.valid?
        expect(@community.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
