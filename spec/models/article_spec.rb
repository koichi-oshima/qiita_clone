require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "正常系" do
    context "titleとbodyが入力されている場合" do
      let(:article) { build(:article) }
      it "記事を投稿できる" do
        expect(article).to be_valid
      end
    end
  end
  describe "異常系" do
    context "titleが入力されていない場合" do
      let(:article) { build(:article, title: nil) }
      it "記事を投稿できない" do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title]).to include "can't be blank"
      end
    end
    context "bodyが入力されていない場合" do
      let(:article) { build(:article, body: nil) }
      it "記事を投稿できない" do
        expect(article).not_to be_valid
        expect(article.errors.messages[:body]).to include "can't be blank"
      end
    end
    context "titleの文字数が50字を超える場合" do
      let(:article) { build(:article, title: "a" * 51) }
      it "記事を投稿できない" do
        expect(article).not_to be_valid
        expect(article.errors.messages[:title]).to include "is too long (maximum is 50 characters)"
      end
    end
  end
end
