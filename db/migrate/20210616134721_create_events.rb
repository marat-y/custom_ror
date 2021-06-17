class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.string :location
      t.datetime :starttime, null: false
      t.datetime :endtime
      t.string :organizeremail
      t.string :organizertelegram
      t.string :link

      t.timestamps
    end
  end
end
