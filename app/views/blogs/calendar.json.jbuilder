json.array! @blogs do |blog|
  # json.id blog.id
  json.date blog.date
  json.title "#{blog.category.name} : #{blog.amount}円"
  # json.amount blog.amount
  # json.note blog.note
  json.update_url blog_path(blog, method: :patch)
  json.edit_url edit_blog_path(blog)
end