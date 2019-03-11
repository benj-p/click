class AddImageToCurriculums < ActiveRecord::Migration[5.2]
  def change
    add_column :curriculums, :image, :string
  end
end
