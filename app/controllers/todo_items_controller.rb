class TodoItemsController < ApplicationController
  def index
    @todo_items = policy_scope(TodoItem)
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.user = current_user

    authorize @todo_item

    if @todo_item.save
      flash[:notice] = "Reminder created"
      redirect_to todo_items_path
    else
      flash[:error] = "There was an error, please try again"
      redirect_to :back
    end
  end

  def mark_complete
    if !@todo_item.completed
      if @todo_item.complete
        redirect_to todo_items_path
        flash[:notice] = "Task complete"
      else
        flash[:error] = "There was an error, please try again"
        redirect_to :back
      end
    else
      redirect_to todo_items_path
      flash[:notice] = "Reminder already complete"
    end
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:name)
  end

  def set_todo_item
    @todo_item = TodoItem.find(params[:id])
  end
end
