require 'rails_helper'

RSpec.describe ArticleLike, type: :model do
  describe "正常系" do
    context "user_idとarticle_idがある場合" do
      let(:article_like) { build(:article_like) }
      it "成功する" do
        expect(article_like).to be_valid
      end
    end
  end
  # describe "異常系" do
  #   context "user_idが無い場合" do
  #     let(:article_like) { build(:article_like, article_id: nil) }
  #     it "エラーになる" do
  #       article_like.valid?
  #       expect(article_like.errors.messages[:article_id]).to include "can't be blank"
  #     end
  #   end
  #   context "article_idが無い場合" do
  #     let(:article_like) { build(:article_like, user_id: nil) }
  #     it "エラーになる" do
  #       article_like.valid?
  #       expect(article_like.errors.messages[:user_id]).to include "can't be blank"
  #     end
  #   end
  # end
end
