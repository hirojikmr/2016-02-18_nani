json.array!(@memos) do |memo|
  json.extract! memo, :id, :date, :body
  json.url memo_url(memo, format: :json)
end
