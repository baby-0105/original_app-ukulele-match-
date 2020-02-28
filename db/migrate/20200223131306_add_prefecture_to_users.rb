class AddPrefectureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Prefecture, :integer
  end
end
