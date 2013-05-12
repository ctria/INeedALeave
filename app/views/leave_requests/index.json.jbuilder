json.array!(@leave_requests) do |leave_request|
  json.extract! leave_request, :requestor, :date, :leave_type, :status
  json.url leave_request_url(leave_request, format: :json)
end