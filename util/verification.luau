local API = {}

API.Url = "https://hunterbot-production.up.railway.app/api/verify-key"

function API.Verify(key : string, hwid : string) : boolean
	local success, response = pcall(function()
		return request({
			Url = API.Url,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HTTPservice:JSONEncode({
				key = key,
				hwid = hwid
			})
		})
	end)

	if not success then
		warn("[KEY API] Request failed:",
			response
		)
		return false
	end

	if not response.Success then
		warn("[KEY API] HTTP error:",
			response.StatusCode
		)
		return false
	end
	local data
	local decoded, decodeErr = pcall(function()
		data = HTTPservice:JSONDecode(
			response.Body
		)
	end)

	if not decoded then
		warn("[KEY API] Invalid response:",
			decodeErr
		)
		return false
	end

	return data.valid == true
end

return API
