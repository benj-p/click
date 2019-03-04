class AddReferencesToCurriculums < ActiveRecord::Migration[5.2]
  def change
    add_reference :curriculums, :user, foreign_key: true
  end
end
