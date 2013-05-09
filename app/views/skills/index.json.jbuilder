json.array!(@skills) do |skill|
  json.extract! skill, :name, :skill_type, :min_coverage
  json.url skill_url(skill, format: :json)
end