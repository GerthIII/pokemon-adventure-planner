class AddProgressionToTeamMember < ActiveRecord::Migration[8.1]
  def change
    add_column :team_members, :progression_strategy, :string
  end
end
