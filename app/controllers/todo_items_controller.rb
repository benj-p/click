class TodoItemsController < ApplicationController
  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.user = current_user

    if @todo_item.save
      redirect_to root_path
    else
      flash[:error] = "There was an error, please try again"
      redirect_to :back
    end
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:name)
  end
end
