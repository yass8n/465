desc "Delete all unconfirmed users after 7 days"
task :delete_unconfirmed_users => :environment do
  three_days_ago = (Time.now.midnight - 3.day)
  three_days_ago =  three_days_ago.strftime("%F")
  users = User.all.where("confirmation_sent_at >= :start_date", {start_date: three_days_ago}).where(confirmed_at: NIL)
  users.each do |user|
    user.destroy
  end
end