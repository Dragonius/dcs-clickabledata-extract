local all_planes={"A-10C", "A-10C_2", "AJS37", "AH-64D", "AV8BNA", "Bf-109K-4", "C-101CC", "C-101EB", "Christen Eagle II", "F-16C", "F-5E", "F-86", "F14", "FA-18C", "FW-190A8", "FW-190D9", "I-16", "JF-17", "Ka-50", "L-39C", "L-39ZA", "M-2000C", "MIG-21bis", "Mi-8MTV2", "MiG-15bis", "MiG-19P", "SA342", "SpitfireLFMkIX", "Su-25T", "Su-33", "TF-51D", "Uh-1H", "Yak-52", "P-51D"}

local onlist = 1
local size1 = 0
for _ in pairs(all_planes) do size1 = size1 + 1 end
print("How many planes we got on list :" , size1, "\n")



-- Instructions:
-- Specify DCS Installation path and module to extract below
local dcs_install_path = [[C:\Program Files\Eagle Dynamics\DCS World OpenBeta]]

dofile("clickabledata_extract_functions.lua")

while onlist < size1 do

local module_name = all_planes[onlist]

print("Running for ",module_name)

--print("location: " .. dcs_install_path .. "\\Mods\\aircraft\\" .. module_name .. "\\Cockpit\\Scripts\\clickabledata.lua")
local location= dcs_install_path .. "\\Mods\\aircraft\\" .. module_name .. "\\Cockpit\\Scripts\\clickabledata.lua"
--print(location)



local function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f)

		--print("still work")
		local list = load_module(dcs_install_path, module_name)
		--print(list)
		table.sort(list)
		--print(list)
		-- Write extracted clickabledata elements to a CSV file
		local csv_file = io.open(module_name .. "_clickabledata.csv", "w")
		local header = "Device (ID),Command ID,Element ID,Class Type,Arg ID,Value,Limit Min,Limit Max,Hints\n"
		csv_file:write(header)
			for _,row in pairs(list) do
				csv_file:write(row .. "\n")
			end
		list = 0



		--return print("found here")

	else

		print("not found here ", module_name)
		print("number is ",onlist, "\n")
		--onlist = onlist + 1
		return
	end

 end


 file_exists(location)

onlist = onlist + 1

end


