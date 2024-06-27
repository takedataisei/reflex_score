require 'rails_helper'

RSpec.describe PeerEvaluation, type: :model do
  before do
    @evaluation = FactoryBot.build(:peer_evaluation)
  end

  describe '他者評価投稿' do
    context '投稿できる場合' do
      it 'scoreとcomment、evaluation_item、evaluator、evaluateeが存在すれば登録できる' do
        expect(@evaluation).to be_valid
      end
    end

    context '投稿できない場合' do
      it 'scoreが空では登録できない' do
        @evaluation.score = nil
        @evaluation.valid?
        expect(@evaluation.errors.full_messages).to include("Score can't be blank")
      end
  
      it 'scoreが1から5の範囲外では登録できない' do
        @evaluation.score = 6
        @evaluation.valid?
        expect(@evaluation.errors.full_messages).to include("Score must be between 1 and 5")
      end
  
      it 'evaluation_itemが空では登録できない' do
        @evaluation.evaluation_item = nil
        @evaluation.valid?
        expect(@evaluation.errors.full_messages).to include("Evaluation item must exist")
      end
  
      it 'evaluatorが空では登録できない' do
        @evaluation.evaluator = nil
        @evaluation.valid?
        expect(@evaluation.errors.full_messages).to include("Evaluator must exist")
      end
  
      it 'evaluateeが空では登録できない' do
        @evaluation.evaluatee = nil
        @evaluation.valid?
        expect(@evaluation.errors.full_messages).to include("Evaluatee must exist")
      end
    end
  end
end
