class ChangeDataYearToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :year, :string
  end
end
