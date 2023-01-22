local all_planes={"A-10C", "A-10C_2", "A-4E-C", "AH-64D", "AJS37", "AV8BNA", "Bf-109K-4", "C-101CC", "C-101EB", "Christen Eagle II", "F-16C", "F-5E", "F-86", "F14", "FA-18C", "FW-190A8", "FW-190D9", "I-16", "JF-17", "Ka-50", "L-39C", "L-39ZA", "M-2000C", "MIG-21bis", "Mi-24P", "Mi-8MTV2", "MiG-15bis", "MiG-19P", "MosquitoFBMkVI", "P-47D-30", "SA342", "SpitfireLFMkIX", "Su-25T", "Su-33", "TF-51D", "UH-60L", "Uh-1H", "Yak-52"}

--Not working P-51D submodel  P-51D-25-NA -> Crashes
--Not working AV8BNA, Wrong location clickabledata.lua ->  \Cockpit\
--Not working F14, Wrong location clickabledata.lua ->  \Cockpit\  * FIXED 22.1.2023 * 
--Not working M-21bis, Wrong location clickabledata.lua ->  \Cockpit\
--Not working SA342, Wrong location clickabledata.lua ->  \Cockpit\  * FIXED 22.1.2023 * 
--Not working Su-25T, no clickabledata.lua
--Not working Su-33, no clickabledata.lua

local onlist = 1
local size1 = 0
local miss = 0
for _ in pairs(all_planes) do size1 = size1 + 1 end
print("How many planes we got on list :" , size1, "\n")



-- Instructions:
-- Specify DCS Installation path and module to extract below
-- local dcs_install_path = [[C:\Program Files\Eagle Dynamics\DCS World OpenBeta]]
local dcs_install_path = [[F:\\Pelit\\Steam\\steamapps\\common\\DCSWorld]]
dofile("clickabledata_extract_functions.lua")

while onlist <= size1 do


local module_name = all_planes[onlist]
local module_name_no_cockpit = all_planes[onlist]
print("Running for "..module_name)

--print("location: " .. dcs_install_path .. "\\Mods\\aircraft\\" .. module_name .. "\\Cockpit\\Scripts\\clickabledata.lua")
local location = dcs_install_path .. "\\Mods\\aircraft\\" .. module_name .. "\\Cockpit\\Scripts\\clickabledata.lua"
local location_no_cocpit = dcs_install_path .. "\\Mods\\aircraft\\" .. module_name_no_cockpit .. "\\Cockpit\\clickabledata.lua"
-- print(location)


local function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then 
			--print(name, "\n test")
			io.close(f)
		--print("still work")
		local list = load_module(dcs_install_path, module_name)
		--local list_no_cockpit = load_module(dcs_install_path, module_name_no_cockpit)
		--print("printing list ", list)
		table.sort(list)
		--table.sort(list_no_cockpit)
		--print(list)
		--print(list_no_cockpit)
		-- Write extracted clickabledata elements to a CSV file
		local csv_file = io.open(module_name .. "_clickabledata.csv", "w")
		local header = "Device (ID),Command ID,Element ID,Class Type,Arg ID,Value,Limit Min,Limit Max,Hints\n"
		csv_file:write(header)
			for _,row in pairs(list) do
				csv_file:write(row .. "\n")
			end
		miss= miss + 1
		--return print("found here")
	else
		--print(f, name)
		--print(element_list)
		--print("not found here ", module_name)
		--print("not found here ", module_name_no_cockpit)
		--print("number is ",onlist, "\n")
		--onlist = onlist + 1
		return
	end
end

file_exists(location)
file_exists(location_no_cocpit)

onlist = onlist + 1

end
print(onlist-1, "Planes on list")
print(miss, "Planes generated")
print(onlist-miss-1, "Planes didn't generate")
