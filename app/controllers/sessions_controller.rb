class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)               # paramsハッシュで受け取ったemail値を小文字化し、email属性に渡してUserモデルから同じemailの値のUserを探して、user変数に代入
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user                   # user変数がデータベースに存在し、なおかつparamsハッシュで受け取ったpassword値と、userのemail値が同じ(パスワードとメールアドレスが同じ値であれば)true
    else
      flash.now[:danger] = "Invalid email/password combination"                     
      render 'new'                                                              # newビューの出力
    end
  end

  def destroy
    log_out                                                                     # ログアウトする
    redirect_to root_url 
  end
end
