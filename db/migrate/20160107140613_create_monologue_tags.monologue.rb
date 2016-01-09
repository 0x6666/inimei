# This migration comes from monologue (originally 20120514164158)
class CreateMonologueTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.string :name

    end
  end
end
