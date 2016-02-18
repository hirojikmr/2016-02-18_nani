json.array!(@tasks) do |task|
  json.extract! task, :id, :start, :end, :dur, :body
  json.url task_url(task, format: :json)
end
