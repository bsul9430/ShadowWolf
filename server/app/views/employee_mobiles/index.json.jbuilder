json.array!(@employee_mobiles) do |employee_mobile|
  json.partial! "employee_mobiles/employee_mobile.json.jbuilder", employee_mobile: employee_mobile
end
