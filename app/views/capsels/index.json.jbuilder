json.array!(@capsels) do |capsel|
  json.extract! capsel, :id, :start, :end
  json.url capsel_url(capsel, format: :json)
end
