local module = {}

function module.fetchImage(url: string, fileName: string)
	local path = "huntergui/assets/" .. fileName

	if isfile(path) then
		return getcustomasset(path)
	end

	local success, response = pcall(function()
		return request({
			Url = url,
			Method = "GET"
		})
	end)

	if not success then
		warn("Request error:", response)
		--return nil
	end

	if response.StatusCode ~= 200 then
		warn("HTTP error:", response.StatusCode)
		return nil
	end

	writefile(path, response.Body)

	return getcustomasset(path)
end

return module
