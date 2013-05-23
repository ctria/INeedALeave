json.array!(@leave_requests) do |leave_request|
  json.id leave_request.id
  json.title leave_request.requestor
  json.start leave_request.date.rfc822
  json.recurring false
  json.url leave_request_url(leave_request, format: :html)
  case leave_request.status
  when "Requested"
    json.color "red"
  when "Approved"
    json.color "green"
  when "Covered"
    json.color "blue"
  end
end