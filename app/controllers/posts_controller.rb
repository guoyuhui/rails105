class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你还不是本群成员，无法发表文章！"
      redirect_to group_path(@group)
    end


    @post = Post.new

  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])



    @post.destroy

    redirect_to group_path(@group)
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    @post = Post.new
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    @post.update(post_params)

    redirect_to group_path(@group)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end


end
