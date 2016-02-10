class RemoveAgendaFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :agenda, :text
  end
end
