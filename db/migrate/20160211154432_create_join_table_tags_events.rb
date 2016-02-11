class CreateJoinTableTagsEvents < ActiveRecord::Migration
  def change
    create_join_table :tags, :events do |t|
      t.index [:tag_id, :event_id]
      t.index [:event_id, :tag_id]
    end
  end
end
