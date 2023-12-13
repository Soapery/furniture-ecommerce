class CreateAboutContents < ActiveRecord::Migration[7.0]
  def change
    create_table :about_contents do |t|
      t.text :content

      t.timestamps
    end
  end
end
