class CreatePictures < ActiveRecord::Migration[8.0]
  def change
    create_table :pictures do |t|
      t.string :title

      t.timestamps
    end
  end
end
