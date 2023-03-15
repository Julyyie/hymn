class AddResponseTimeToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :response_time, :float
  end
end
