module Users
  class PostsController < ApplicationController
    before_action :correct_user?, only:[:edit, :update, :destroy]

    def index
      @user = current_user
      @posts = @user.posts
    end

    def show
      @post = Post.find(params[:id])
      @comments = @post.comments
    end

    def new
      @user = User.find(params[:user_id])
      @post = @user.posts.build
    end

    def create
      @user = User.find(params[:user_id])
      @post = @user.posts.build(post_params)
      if @post.save
        flash[:success] = "投稿が完了しました"
        redirect_to user_posts_path
      else
        flash.now[:danger] = "投稿に失敗しました"
        render 'new'
      end
    end

    def update
      @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        flash[:success] = "投稿の編集が完了しました"
        redirect_to @post
      else
        flash.now[:warning] = "投稿の編集に失敗しました"
        render 'edit'
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def destroy
      @post = Post.find(params[:id])
      if @post.destroy
        flash[:success] = "投稿を削除しました"
        redirect_to 'index'
      else
        flash[:warning] = "投稿を削除できませんでした"
        redirect_to 'index'
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def correct_user?
      return true
    end
  end
end