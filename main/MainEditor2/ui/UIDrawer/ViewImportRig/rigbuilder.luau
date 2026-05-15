--!strict
local players = game:GetService("Players")

local base_hum_desc = Instance.new("HumanoidDescription")
do
	local white = Color3.new(127, 127, 127)
	base_hum_desc.HeadColor = white
	base_hum_desc.TorsoColor = white
	base_hum_desc.RightArmColor = white
	base_hum_desc.LeftArmColor = white
	base_hum_desc.LeftLegColor = white
	base_hum_desc.RightLegColor = white
end
local fem_hum_desc = base_hum_desc:Clone()
fem_hum_desc.Torso = 48474356

local function fix_rig(rig: Model)
	for _, limb in rig:GetChildren() do
		if limb:IsA("Part") or limb:IsA("MeshPart") then
			limb.Locked = false
			limb.CollisionGroup = "Default"
		end
	end
	local current_camera = workspace.CurrentCamera
	local spawn_position = (current_camera.CFrame.Position - Vector3.new(0, 1.5, 0))
		+ (current_camera.CFrame.LookVector * 8)
	rig:MoveTo(spawn_position)
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	rig.PrimaryPart = hrp
end

return {
	from_user = function(id: number | string, rig_type: Enum.HumanoidRigType, parent: Instance?)
		if type(id) == "string" then
			id = players:GetUserIdFromNameAsync(id)
		end
		local hum_desc = players:GetHumanoidDescriptionFromUserIdAsync(id :: number)
		local rig_model = players:CreateHumanoidModelFromDescriptionAsync(hum_desc, rig_type)
		rig_model.Parent = parent
		fix_rig(rig_model)
	
		return rig_model
	end,
	from_base = function(type: "base" | "female", rig_type: Enum.HumanoidRigType, parent: Instance?)
		local rig_model =
			players:CreateHumanoidModelFromDescriptionAsync(type == "base" and base_hum_desc or fem_hum_desc, rig_type)
		rig_model.Parent = parent
		fix_rig(rig_model)
		return rig_model
	end,
}
