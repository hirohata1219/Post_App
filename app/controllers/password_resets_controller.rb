class PasswordResetsController < ApplicationController

  skip_before_action :require_login
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      PasswordResetMailer.with(user: user).reset.deliver_later
    end

    redirect_to login_path, success: "パスワード再設定の案内をメールアドレス宛に送信しました。"
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:token])

    unless @user
      redirect_to new_password_reset_path, danger: "パスワード再設定リンクが無効または期限切れです。"
    end
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:token])

    unless @user
      redirect_to new_password_reset_path, danger: "パスワード再設定リンクが無効または期限切れです。"

      return
    end

    if @user.update(password_params)
      redirect_to login_path, success: "パスワードを変更しました。新しいパスワードでログインしてください。"
    else
      flash.now[:danger] = "パスワードを変更できませんでした。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.expect(user: [:password, :password_confirmation])
  end

end
