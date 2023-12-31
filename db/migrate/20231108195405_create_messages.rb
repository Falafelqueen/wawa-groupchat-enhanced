class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true
      t.string :text
      t.timestamps
    end
  end
end
