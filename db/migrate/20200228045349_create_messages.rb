class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :receive_user, foreign_key: { to_table: :users }
      #t.references :receive_user_id_checked_message, foreign_key: { to_table: :messages }

      t.timestamps
    end
  end
end
