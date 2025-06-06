class AddColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :confirmation_token,   :string
    add_column :users, :confirmed_at,         :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email,      :string
  end
end
