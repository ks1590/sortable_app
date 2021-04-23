json.array! @events do |event|  
  json.title " : #{event.amount}円"
  json.amount event.amount
  json.update_url event_path(event, method: :patch)
  json.edit_url edit_event_path(event)
end