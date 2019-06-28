class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
    t.string :title
    t.text :job_description
    t.integer :min_years_exp
    t.string :website_applied
    t.string :resume_used #Man its getting late! 1:02AM Friday June 28 2019.
    t.datetime :contacted
    t.datetime :onsite
    t.datetime :offer
    t.float :offer_amount
    end
  end
end
