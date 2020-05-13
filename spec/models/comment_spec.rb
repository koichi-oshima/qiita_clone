# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "正常系" do
    context "コメントが入力されている場合" do
      let(:comment) { build(:comment) }
      it "コメント投稿できる" do
        expect(comment).to be_valid
      end
    end
  end

  describe "異常系" do
    context "コメントが入力されていない場合" do
      let(:comment) { build(:comment, body: nil) }
      it "エラーになる" do
        expect(comment).not_to be_valid
        expect(comment.errors.messages[:body]).to include "can't be blank"
      end
    end
  end
end
