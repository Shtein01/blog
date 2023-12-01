class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:id])
    comment.destroy
    # @article.find_by(comment_params1).destroy
    redirect_to article_path(article), status: :see_other
  end

  # def show
  #   @article = Article.find(params[:article_id])
  #   redirect_to article_path(@article)
  # end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def comment_params1
    params.permit(:id, :article_id)
  end
end
