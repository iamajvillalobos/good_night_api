class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.datetime :clock_in, allow_nil: false
      t.datetime :clock_out, allow_nil: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
