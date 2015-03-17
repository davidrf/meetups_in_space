class CreateMeetupsAndMeetupMembership < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :location, null: false
    end

    create_table :memberships do |t|
      t.integer :user_id, null: false
      t.integer :meetup_id, null: false
      t.index [:user_id, :meetup_id], unique: true
    end
  end
end
