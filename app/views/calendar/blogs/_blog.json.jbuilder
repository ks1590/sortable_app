json.date event.date
json.title " : #{event.amount}円"
json.update_url blog_path(event, method: :patch)
json.edit_url edit_blog_path(event)