class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :record_title
      t.datetime :record_date
      t.string :record_type
      t.string :record_notes

      t.timestamps
    end
  end
end
