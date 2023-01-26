local lib = loadstring(syn.request({Url = "https://raw.githubusercontent.com/NlukrcR2qI/MN_Hub/main/lib.lua", Method = "GET", Headers = {["Content-Type"] = "application/json"}}).Body)()

if game.PlaceId == 4643697430 then else lib:Create_Noti("Script Error", "Not Connected To Sbr!!!") task.wait(9e9) end

local mainui = lib:CreateUI()

local sbrtab = mainui:Create_Tab("SBR")

shared.sbrdata = {
	toggle = false
}

sbrtab:Create_Toggle("Advanced Auto SBR", false, function(a)
	if a then
		shared.sbrdata.toggle = true

		lib:Create_Noti("Script Notify", "Auto SBR Enabled")

		coroutine.wrap(function()
			repeat task.wait() until not game.Workspace:FindFirstChild("Barrier")

			for i,v in ipairs(game:GetService("Workspace").Barriers:GetChildren()) do
				if not shared.sbrdata.toggle then break end
	
				firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
	
				task.wait()
	
				firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
	
				break
			end
	
			shared.sbrdata.childremovedconnect = game.Workspace.Barriers.ChildRemoved:Connect(function()
				if not shared.sbrdata.toggle then return end
	
				if #game:GetService("Workspace").Barriers:GetChildren() == 0 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1839.83, 414.666, 8988.37)
	
					task.wait(1)
	
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Finish, 1)
				
					task.wait()
				
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace").Finish, 0)

					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1428.225341796875, 402.1226501464844, 7879.00341796875)
				end
	
				for i,v in ipairs(game:GetService("Workspace").Barriers:GetChildren()) do
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
				
					task.wait()
				
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
				
					break
				end
			end)
		end)()
	else
		lib:Create_Noti("Script Notify", "Auto SBR Disabled")

		shared.sbrdata.childremovedconnect:Disconnect()

		shared.sbrdata.toggle = false
	end
end)

local num = 0
local function breakity(part)
    if part.Name == "Part" then
        num = num + 1
        part.Name = 'Part '..num
    end
end

for i,v in pairs(workspace.Map:GetChildren()) do
    if v:IsA("Part") then
        breakity(v)
    end
end

for i,v in pairs(game:GetService("Workspace").Barriers:GetChildren()) do
    v.Size = Vector3.new(0,0,0)
    v.Position = Vector3.new(0,-1000,0)
end

local TPBypass
TPBypass = hookfunction(getrawmetatable(game).__namecall,
    newcclosure(
        function(self, ...)
            local args = {...}

            if self.Name == "Returner" and args[1] == "idklolbrah2de"  then
                return "  ___XP DE KEY"
            end

            return TPBypass(self, ...)
        end
    )
)

local playertab = mainui:Create_Tab("Player")

shared.playerflydata = {
	speed = 0
}

playertab:Create_Slider("Fly Speed", 0, 0, 1000, function(a)
	shared.playerflydata.speed = a
end)

playertab:Create_Toggle("Fly", false, function(a)
	if a then
		local function fly(ey)
			local thing = Instance.new("BodyVelocity")
			thing.Name = ey
			thing.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			thing.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
			coroutine.wrap(function()
				while task.wait() do
					thing.Velocity = game.Players.LocalPlayer.Character.Humanoid.MoveDirection * shared.playerflydata.speed
				end
			end)()
		end

		local function remove(ey)
			for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
				if v.Name == ey then
					v:Destroy()
				end
			end

			local thing = Instance.new("BodyVelocity")
			thing.Name = "Stopper"
			thing.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			thing.Velocity = Vector3.new(0,0,0)
			thing.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

			coroutine.wrap(function()
				task.wait(0.01)
				thing:Destroy()
			end)()
		end

		shared.playerflydata.ibconnect = game.UserInputService.InputBegan:Connect(function(a)
			if a.KeyCode == Enum.KeyCode.W then
				fly("W")
			end

			if a.KeyCode == Enum.KeyCode.A then
				fly("A")
			end

			if a.KeyCode == Enum.KeyCode.S then
				fly("S")
			end

			if a.KeyCode == Enum.KeyCode.D then
				fly("D")
			end

			if a.KeyCode == Enum.KeyCode.Space then
				local thing = Instance.new("BodyVelocity")
				thing.Name = "YAxis"
				thing.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				thing.Velocity = Vector3.new(0,shared.playerflydata.speed,0)
				thing.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
			end
		end)

		shared.playerflydata.ieconnect = game.UserInputService.InputEnded:Connect(function(a)
			if a.KeyCode == Enum.KeyCode.W then
				remove("W")
			end

			if a.KeyCode == Enum.KeyCode.A then
				remove("A")
			end

			if a.KeyCode == Enum.KeyCode.S then
				remove("S")
			end

			if a.KeyCode == Enum.KeyCode.D then
				remove("D")
			end

			if a.KeyCode == Enum.KeyCode.Space then
				for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
					if v.Name == "YAxis" then
						v:Destroy()
					end
				end
			end
		end)
	else
		shared.playerflydata.ibconnect:Disconnect()
		shared.playerflydata.ieconnect:Disconnect()
	end
end)

playertab:Create_Seperator()

playertab:Create_Button("Tp To Beginning", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1414.9805908203125, 284.3507385253906, -906.2833862304688)
end)

playertab:Create_Button("Tp To Race Line", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1662.6883544921875, 295.6007385253906, -218.7051544189453)
end)

playertab:Create_Button("Tp To Desert (Beginning)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1669.106201171875, 294.3509826660156, 261.80352783203125)
end)

playertab:Create_Button("Tp To Desert (Middle Entrance 1)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2235.54736328125, 327.3511657714844, 728.9248046875)
end)

playertab:Create_Button("Tp To Desert (Middle Entrance 2)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.1004638671875, 327.20062255859375, 849.1799926757812)
end)

playertab:Create_Button("Tp To Desert (Middle Entrance 3)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1540.9508056640625, 323.2021179199219, 868.3640747070312)
end)

playertab:Create_Button("Tp To Desert (Middle Entrance 4)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1317.0469970703125, 322.3509216308594, 885.73779296875)
end)

playertab:Create_Button("Tp To Desert (Middle Entrance 5)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1051.685546875, 316.34698486328125, 934.20556640625)
end)

playertab:Create_Button("Tp To Desert (End 1/ Plains Start 1)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2359.629150390625, 340.3511657714844, 2871.98828125)
end)

playertab:Create_Button("Tp To Desert (End 2 / Plains Start 2)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1402.87109375, 262.3505859375, 2909.131591796875)
end)

playertab:Create_Button("Tp To The Plains (Middle Entrance 1)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1907.8109130859375, 291.3509216308594, 4598.84423828125)
end)

playertab:Create_Button("Tp To The Plains (Middle Entrance 2)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-796.1795654296875, 375.351806640625, 4616.87158203125)
end)

playertab:Create_Button("Tp To The Plains (End 1 / The Artic Start 1)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1168.8262939453125, 395.15887451171875, 5538.8173828125)
end)

playertab:Create_Button("Tp To The Plains (End 2 / The Artic Start 2)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-912.6465454101562, 398.9845886230469, 5462.0732421875)
end)

playertab:Create_Button("Tp To The Artic (Middle Right Turn)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-891.4859619140625, 430.3525085449219, 6247.12890625)
end)

playertab:Create_Button("Tp To The Artic (Middle Left Turn)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-714.7868041992188, 399.3516540527344, 6243.7998046875)
end)

playertab:Create_Button("Tp To The Artic (End)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1287.756591796875, 423.9065856933594, 7832.7431640625)
end)

playertab:Create_Button("Tp To The End", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1371.6236572265625, 413.35235595703125, 7979.58447265625)
end)

playertab:Create_Button("Tp To The End (Hiding Area)", function()
	workspace.Map["Part 1895"].Size = Vector3.new(618, 251, 415)
    workspace.Map["Part 1898"].Size = Vector3.new(0,0.1,0)

	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1428.225341796875, 402.1226501464844, 7879.00341796875)
end)

playertab:Create_Button("Tp To The Bridge (Start)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1457.9373779296875, 419.4114990234375, 8169.32958984375)
end)

playertab:Create_Button("Tp To The Bridge (End)", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1839.5252685546875, 414.863525390625, 8986.34765625)
end)

playertab:Create_Button("Tp To The Hand Of The Golden Statue", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1818.08740234375, 577.5335693359375, 9013.16796875)
end)

local horsetab = mainui:Create_Tab("Horse")

horsetab:Create_Button("Bring Horse", function()
	local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

	game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Seat:Sit(game.Players.LocalPlayer.Character.Humanoid)

	game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].HumanoidRootPart.CFrame = pos
end)

shared.synthetichorserunningdata = {
	["state"] = false,
	["run"] = false,
	["inputbeganconnect"] = nil,
	["inputendconnect"] = nil,
}

local mt = getrawmetatable(game)
local hook
hook =
    hookfunction(
    mt.__namecall,
    newcclosure(
        function(self, ...)
            local arguments = {...}
            local method = getnamecallmethod()
            if self.Name == "RemoteEvent" and arguments[1] == "Running" then
                if shared.synthetichorserunningdata.state then
                    return
                end
            end

			if self.Name == "RemoteEvent" and arguments[1] == "Stopping" then
                if shared.synthetichorserunningdata.state then
                    return
                end
            end
			
			if self.Name == "RemoteEvent" and arguments[1] == "Jump" then
                if shared.synthetichorserunningdata.state then
                    return
                end
            end

            return hook(self, unpack(arguments))
        end
    )
)

horsetab:Create_Toggle("Horse Stamina Bypass", false, function(a)
	if a then
		if not game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Seat:FindFirstChild("SeatWeld") then
			lib:Create_Noti("Script Error", "You're Not On A Horse!")

			return
		end

		local walk = false

		local back = false
	
		shared.synthetichorserunningdata.inputbeganconnect = game.UserInputService.InputBegan:Connect(function(a)
			if a.KeyCode == Enum.KeyCode.W then
				walk = true
			end

			if a.KeyCode == Enum.KeyCode.Space then
				game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid.JumpPower = 85
				game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
	
			if a.KeyCode == Enum.KeyCode.S then
				back = true
			end
		end)
	
		shared.synthetichorserunningdata.inputendconnect = game.UserInputService.InputEnded:Connect(function(a)
			if a.KeyCode == Enum.KeyCode.W then
				walk = false
			end
	
			if a.KeyCode == Enum.KeyCode.S then
				back = false
			end
		end)

		local clone = game:GetService("Players").LocalPlayer.PlayerGui.HorseGui.Speed:Clone()
		clone.Parent = game:GetService("Players").LocalPlayer.PlayerGui.HorseGui
		clone.Text = "Speed: "..math.floor(game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid.WalkSpeed)
		game:GetService("Players").LocalPlayer.PlayerGui.HorseGui:FindFirstChild("Speed").Visible = false
		game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			clone.Text = "Speed: "..math.floor(game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid.WalkSpeed)
		end)

		coroutine.wrap(function()
			while task.wait(0.02) do
				if math.floor(game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Speed.Value) >= 30 then
					game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].RemoteEvent:FireServer("Running", false)
		
					if not shared.synthetichorserunningdata.run then
						shared.synthetichorserunningdata.run = true
		
						shared.synthetichorserunningdata.state = true
					end

					if not shared.synthetichorserunningdata.state then
						shared.synthetichorserunningdata.inputbeganconnect:Disconnect()
						shared.synthetichorserunningdata.inputendconnect:Disconnect()
			
						shared.synthetichorserunningdata.state = false
	
						shared.synthetichorserunningdata.run = false

						break 
					end
				end

				if game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Seat:FindFirstChild("SeatWeld") then
					if walk == true then
						game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid.WalkSpeed += 1
					end
				
					if back == true then
						game.Workspace[game.Players.LocalPlayer.Name.."'s Horse"].Humanoid.WalkSpeed -= 1
					end
				else
					shared.synthetichorserunningdata.inputbeganconnect:Disconnect()
					shared.synthetichorserunningdata.inputendconnect:Disconnect()
		
					shared.synthetichorserunningdata.state = false

					shared.synthetichorserunningdata.run = false

					lib:Create_Noti("Script Notify", "Got Off Horse. Stopping Function...")
		
					break
				end
			end
		end)()
	else
		pcall(function()
			shared.synthetichorserunningdata.inputbeganconnect:Disconnect()
			shared.synthetichorserunningdata.inputendconnect:Disconnect()
	
			shared.synthetichorserunningdata.state = false
		end)
	end
end)

for i,v in pairs(getconnections(game.CoreGui.MN_LIB.MN_MFRM.container.bar.holder.positioner:FindFirstChild("tab").MouseButton1Click)) do
    v.Function()
end