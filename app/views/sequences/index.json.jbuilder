json.array!(@sequences) do |sequence|
  json.extract! sequence, :id, :seq
  json.url sequence_url(sequence, format: :json)
end
