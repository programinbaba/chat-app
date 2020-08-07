require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it "ログインしていない場合、サインページに移動する" do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
  end

  it "ログインに成功し、ルートパスに遷移する" do
    # 予め、ユーザーをDBに保存する (最初にbeforeで予め書いておけばいちいち書かなくても良い。)
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    visit new_user_session_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path #ここの記述は上の方ですでに書いたためいらない気がする。

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in "Email", with: @user.email  # Emailは検証ツールで書く確認したときのidである"user_email"でも良い。
    fill_in "Password", with: @user.password  # 上と同様にPasswordは"user_password"でも良い。

    # ログインボタンをクリックする
    click_on("Log in")   # find('input[name="commit"]').click

    # ルートページに遷移することを期待する
    expect(current_path).to eq root_path
  end

  it "ログインに失敗し、再びサインインページに戻ってくる" do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path

    # 誤ったユーザー情報を入力する
    fill_in "Email", with: "test" #確実に失敗する必要があるため、@を付けていない。
    fill_in "Password", with: "example@test.com" #上と同様の理由で、@をわざと付けている。

    # ログインボタンをクリックする
    click_on("Log in")

    # サインインページに遷移していることを期待する
    expect(current_path).to eq new_user_session_path
  end
end