class AddWalkthroughToTeamMembers < ActiveRecord::Migration[8.1]
  def change
    add_column :team_members, :walkthrough, :text
  end
end
