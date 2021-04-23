json.date blog.date
# json.title "#{blog.category.name} : #{blog.amount}円"
json.title " : #{blog.amount}円"
json.update_url blog_path(blog, method: :patch)
json.edit_url edit_blog_path(blog)