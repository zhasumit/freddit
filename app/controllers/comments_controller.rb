class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.account_id = current_account.id

    respond_to do |format|
      if @comment.save
        format.json {
          render json: {
            comments_html: render_to_string(
              partial: "posts/comments",
              locals: { comments: @comment.post.comments },
              formats: [ :html ]
            )
          }
        }
      else
        format.json { render json: { error: "Failed to save comment" }, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :post_id)
  end
end
