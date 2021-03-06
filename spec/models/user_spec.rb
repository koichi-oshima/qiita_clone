# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  image                  :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  provider               :string(255)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  tokens                 :text(65535)
#  uid                    :string(255)      default(""), not null
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "正常系" do
    context "nameとemailとpasswordが入力されている場合" do
      let(:user) { build(:user) }
      it "ユーザ登録できる" do
        expect(user).to be_valid
      end
    end
  end

  describe "異常系" do
    context "nameが入力されていない場合" do
      let(:user) { build(:user, name: nil) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:name]).to include "can't be blank"
      end
    end

    context "nameが3文字より少ない場合" do
      let(:user) { build(:user, name: "a" * 2) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:name]).to include "is too short (minimum is 3 characters)"
      end
    end

    context "nameが20文字を超える場合" do
      let(:user) { build(:user, name: "a" * 21) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:name]).to include "is too long (maximum is 20 characters)"
      end
    end

    context "emailが入力されていない場合" do
      let(:user) { build(:user, email: nil) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include "can't be blank"
      end
    end

    context "emailが重複している場合" do
      before { create(:user, email: "test@example.com") }

      let(:user) { build(:user, email: "test@example.com") }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include "has already been taken"
      end
    end

    context "emailに@が含まれていない場合" do
      let(:user) { build(:user, email: "testexample.com") }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include "is not an email"
      end
    end

    context "passwordが入力されていない場合" do
      let(:user) { build(:user, password: nil) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to include "can't be blank"
      end
    end

    context "passwordが8文字より少ない場合" do
      let(:user) { build(:user, password: "a" * 7) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to include "is invalid"
      end
    end

    context "passwordが20文字を超える場合" do
      let(:user) { build(:user, password: "a" * 21) }
      it "ユーザ登録できない" do
        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to include "is invalid"
      end
    end
  end
end
