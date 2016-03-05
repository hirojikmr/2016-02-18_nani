json.array!(@task_colors) do |task_color|
  json.extract! task_color, :id, :text, :color
  json.url task_color_url(task_color, format: :json)
end
