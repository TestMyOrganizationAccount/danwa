class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
      t.text :body

      t.timestamps
    end
    add_index :comments , [:user_id, :micropost_id, :created_at] #<-インデックスを複合キーにて追加
  end
end
