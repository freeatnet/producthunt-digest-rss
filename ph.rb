require 'hunting_season'

puts "Initializing client with token #{ENV['PH_API_TOKEN']}"
client = ProductHunt::Client.new(ENV['PH_API_TOKEN'])

DAYS_AGO_DEFAULT = 1
days_ago = (ENV['DAYS_AGO'] || DAYS_AGO_DEFAULT).to_i
content_date = Date.today - days_ago

puts "Getting posts #{days_ago} days ago"
posts = client.posts(days_ago: days_ago)

output_file = File.open("_posts/#{content_date}-entry.md", "w")

output_file.write <<-eos
---
layout: post
title:  "Product Hunt Tech for #{content_date}"
date:   #{(DateTime.now - (days_ago - 1)).to_s}
---

eos


posts.sort_by { |p| -1 * p["votes_count"] }.take(10).map do |post|
  product_line = "* **[#{post["name"]}](#{post["discussion_url"]})** – #{post["tagline"]}\n"
  output_file.write(product_line)
end

output_file.write("\n… and [#{posts.size - 10} more](https://www.producthunt.com/tech) products") if posts.size > 10
output_file.close
