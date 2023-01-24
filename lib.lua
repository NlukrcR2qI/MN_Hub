for i,v in pairs(game.CoreGui:GetChildren()) do 
    if v.Name == "MN_LIB" then
        v:Destroy()
    end
end

local ui = game:GetObjects("rbxassetid://12052626774")[1].MN_LIB
local parts = game:GetObjects("rbxassetid://12052626774")[1].elements

game:GetObjects("rbxassetid://12052626774")[1].MN_Noti.Parent = game.CoreGui

local MN_LIB = {}

local customicons = {
	button = "https://raw.githubusercontent.com/NlukrcR2qI/MN_Hub/main/Assets/Icon_Button.png",
	dropdown = "https://raw.githubusercontent.com/NlukrcR2qI/MN_Hub/main/Assets/Icon_Drop.png"
}

if not isfolder("MN_Files") then makefolder("MN_Files") end
if not isfolder("MN_Files/Assets") then makefolder("MN_Files/Assets") end

for i,v in pairs(customicons) do
	if not isfile("MN_Files/Assets/"..i..".png") then
		writefile("MN_Files/Assets/"..i..".png", game:HttpGet(v))
	end
end

local function GrabIcon(id)
	if isfile("MN_Files/Assets/"..id..".png") then
		return getsynasset("MN_Files/Assets/"..id..".png")
	else
		return ""
	end
end

function MN_LIB:Create_Noti(main, desc)
    coroutine.wrap(function()
        local element = parts.noti:Clone()
        element.contain.desc_text.Visible = false
        element.contain.main_text.Visible = false
        element.contain.desc_text.Text = desc
        element.contain.main_text.Text = main
        element.Parent = game.CoreGui.MN_Noti.contain
        game:GetService("TweenService"):Create(element.anim, TweenInfo.new(0.5), {Size = UDim2.new(0, 200,1, 0)}):Play()
        task.wait(0.1)
        game:GetService("TweenService"):Create(element, TweenInfo.new(0.5), {Size = UDim2.new(0, 200,0, 64)}):Play()
        task.wait(0.6)
        element.contain.desc_text.Visible = true
        element.contain.main_text.Visible = true
        element.anim:Destroy()
        game:GetService("TweenService"):Create(element.contain.line, TweenInfo.new(0.5), {Size = UDim2.new(0, 8,1, -10)}):Play()
        task.wait(3)
        game:GetService("TweenService"):Create(element, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        for i,v in pairs(element:GetDescendants()) do
            if v:IsA("Frame") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
            end
            if v:IsA("TextLabel") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
            end
        end
        task.wait(0.5)
        element:Destroy()
    end)()
end

function MN_LIB:CreateUI()
	local drag_time = 0.3
	local origpos
	local guipos
	local down = false

	ui.MN_MFRM.draghb.MouseButton1Down:Connect(function()
		local mousepos = game:GetService("UserInputService"):GetMouseLocation()
		origpos = mousepos
		guipos = ui.MN_MFRM.draghb.Parent.Position
		down = true
		shared.noopen = true
	end)

	game:GetService("UserInputService").InputEnded:Connect(function(a)
		if a.UserInputType == Enum.UserInputType.MouseButton1 then
			down = false
			shared.noopen = false
		end
	end)

	game.Players.LocalPlayer:GetMouse().Move:Connect(function()
		if down == true then
			local mousepos = game:GetService("UserInputService"):GetMouseLocation()
			local sumpos = mousepos - origpos
			game:GetService("TweenService"):Create(ui.MN_MFRM.draghb.Parent, TweenInfo.new(drag_time, Enum.EasingStyle.Quint), {Position = UDim2.new(guipos.X.Scale, guipos.X.Offset + sumpos.X, guipos.Y.Scale, guipos.Y.Offset + sumpos.Y)}):Play()
		end
	end)

	local mainframe = ui.MN_MFRM

	shared.noopen = false

	ui.MN_MFRM.container.bar.Size = UDim2.new(0, 332,0, 10)

	ui.MN_MFRM.container.bar.holder.BackgroundTransparency = 0

	mainframe.Size = UDim2.new(0, 362,0, 34)

	ui.MN_MFRM.container.bar.Parent.Parent.grad.Visible = false
	
	ui.MN_MFRM.container.bar.holder.positioner.Visible = false
	
	for i,v in pairs(ui.MN_MFRM.container.bar.Parent.tcontain:GetChildren()) do
		if v:IsA("Frame") then
			v.Visible = false
		end
	end

	ui.MN_MFRM.container.bar.MouseEnter:Connect(function()
		if shared.noopen == false then
			if mainframe.Size == UDim2.new(0, 362,0, 411) then
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 332,0, 28), BackgroundColor3 = Color3.fromRGB(76, 80, 97)}):Play()
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
			else
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(76, 80, 97)}):Play()
			end
		end
	end)

	ui.MN_MFRM.container.bar.MouseLeave:Connect(function()
		if shared.noopen == false then
			if mainframe.Size == UDim2.new(0, 362,0, 411) then
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 332,0, 10), BackgroundColor3 = Color3.fromRGB(62, 65, 79)}):Play()
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			else
				game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(62, 65, 79)}):Play()
			end
		end
	end)

	ui.MN_MFRM.container.bar.MouseButton1Click:Connect(function()
		if mainframe.Size == UDim2.new(0, 362,0, 411) then
			game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 332,0, 10)}):Play()
			
			game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
			
			game:GetService("TweenService"):Create(mainframe, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 362,0, 34)}):Play()
			
			ui.MN_MFRM.container.bar.Parent.Parent.grad.Visible = false
			
			task.wait(0.3)

			ui.MN_MFRM.container.bar.holder.positioner.Visible = false
			
			for i,v in pairs(ui.MN_MFRM.container.bar.Parent.tcontain:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end
		elseif mainframe.Size == UDim2.new(0, 362,0, 34) then
			game:GetService("TweenService"):Create(mainframe, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 362,0, 411)}):Play()
			
			game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(62, 65, 79)}):Play()
			
			game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 332,0, 28), BackgroundColor3 = Color3.fromRGB(76, 80, 97)}):Play()
			
			game:GetService("TweenService"):Create(ui.MN_MFRM.container.bar.holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()

			ui.MN_MFRM.container.bar.Parent.Parent.grad.Visible = true

			ui.MN_MFRM.container.bar.holder.positioner.Visible = true

			for i,v in pairs(ui.MN_MFRM.container.bar.Parent.tcontain:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = true
				end
			end
		end
	end)

	syn.protect_gui(ui)

	ui.Parent = game.CoreGui

	local tabtable = {}

	function tabtable:Create_Tab(name)
		local element2 = parts.tabframe:Clone()
		element2.Parent = ui.MN_MFRM.container.tcontain

		local element1 = parts.tab:Clone()
		element1.Size = UDim2.new(0, 1000,0, 15)
		element1.Text = name
		element1.Parent = ui.MN_MFRM.container.bar.holder.positioner
		element1.Size = UDim2.new(0, element1.TextBounds.X,0, 15)
		element1.MouseButton1Click:Connect(function()
			for i,v in pairs(ui.MN_MFRM.container.tcontain:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end

			for i,v in pairs(ui.MN_MFRM.container.bar.holder.positioner:GetChildren()) do
				if v:IsA("TextButton") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(111, 117, 141)}):Play()
				end
			end

			for i,v in pairs(element2:GetDescendants()) do
				if v:IsA("Frame") then
					v.BackgroundTransparency = 1
				end
				if v:IsA("TextButton") then
					v.BackgroundTransparency = 1
					v.TextTransparency = 1
				end
				if v:IsA("TextLabel") then
					v.BackgroundTransparency = 1
					v.TextTransparency = 1
				end
				if v:IsA("ImageLabel") then
					v.ImageTransparency = 1
				end
			end

			element2.Visible = true

			for i,v in pairs(element2:GetDescendants()) do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
				end
				if v:IsA("TextButton") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
				end
				if v:IsA("TextLabel") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
				end
				if v:IsA("ImageLabel") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
				end
			end

			game:GetService("TweenService"):Create(element1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(143, 151, 182)}):Play()
		end)

		local elementstable = {}

		function elementstable:Create_Button(name, func)
			local button = parts.button:Clone()
			button.func.ImageLabel.Image = GrabIcon("button")
			button.func.ImageLabel.ImageColor3 = Color3.fromRGB(112, 117, 143)
			button.title.Text = name
			button.func.ImageLabel.Size = UDim2.new(0, 17,0, 17)
			button.func.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 92, 112)}):Play()
				game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(120, 126, 153)}):Play()
			end)
			button.func.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 84, 102)}):Play()
				game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 92, 112)}):Play()
				game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(112, 117, 143)}):Play()
			end)
			button.func.MouseButton1Down:Connect(function()
				game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(107, 113, 136)}):Play()
				game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(131, 138, 167)}):Play()
			end)
			button.func.MouseButton1Up:Connect(function()
				game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.07), {BackgroundColor3 = Color3.fromRGB(88, 92, 112)}):Play()
				game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.07), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.07), {ImageColor3 = Color3.fromRGB(120, 126, 153)}):Play()

				func()
			end)
			button.Parent = element2
		end

		function elementstable:Create_Toggle(name, state, func)
			local element = parts.toggle:Clone()
			element.title.Text = name
			local on = false
			if state then
				on = true

				game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(119, 126, 152)}):Play()
				game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(112, 118, 143)}):Play()

				func(on)
			end
			element.func.MouseEnter:Connect(function()
				if on == true then return end
				game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 105, 127)}):Play()
				game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 105, 127)}):Play()
			end)
			element.func.MouseLeave:Connect(function()
				if on == true then return end
				game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
				game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
			end)
			element.func.MouseButton1Up:Connect(function()
				on = not on

				func(on)

				if on then
					game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(119, 126, 152)}):Play()
					game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(112, 118, 143)}):Play()
				else
					game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
					game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
				end
			end)
			element.Parent = element2
		end

		function elementstable:Create_TextBox(name, func)
			local element = parts.textbox:Clone()
			local focuseded = false
			element.title.Text = name
			element.TextBox.MouseEnter:Connect(function()
				if focuseded == true then return end
				game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 92, 112)}):Play()
			end)
			element.TextBox.MouseLeave:Connect(function()
				if focuseded == true then return end
				game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
				game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 84, 102)}):Play()
			end)
			element.TextBox.Focused:Connect(function()
				focuseded = true
				game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(109, 115, 139)}):Play()
				game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
			end)
			element.TextBox.FocusLost:Connect(function()
				focuseded = false
				func(element.TextBox.Text)
				game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(90, 95, 115)}):Play()
				game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 84, 102)}):Play()
			end)
			element.Parent = element2
		end

		function elementstable:Create_Seperator()
			local element = parts.separator:Clone()
			element.BackgroundColor3 = Color3.fromRGB(54, 56, 68)
			element.Parent = element2
		end

		function elementstable:Create_Slider(name, min, max, callback)
			local element = parts.slider:Clone()
			element.title.Text = name

			local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)

			local output = math.floor((max - min) * per + min)

			game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.15), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()

			element.func.bac.num.Text = tostring(output)

			callback(output)

			element.func.MouseButton1Down:Connect(function()
				local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)

				local output = math.floor((max - min) * per + min)

				game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.15), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()
	
				element.func.bac.num.Text = tostring(output)
	
				callback(output)

				temp = game.Players.LocalPlayer:GetMouse().Move:Connect(function()
					local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)

					local output = math.floor((max - min) * per + min)

					game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.2), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()
		
					element.func.bac.num.Text = tostring(output)
		
					callback(output)
				end)

				othertmp = game:GetService("UserInputService").InputEnded:Connect(function(a)
					if a.UserInputType == Enum.UserInputType.MouseButton1 then
						temp:Disconnect()
						othertmp:Disconnect()
					end
				end)
			end)
			element.Parent = element2
		end

		function elementstable:Create_Dropdown(name, size)
			local dropdownelement = parts.dropdown:Clone()
			dropdownelement.func.ImageLabel.Image = GrabIcon("dropdown")
			dropdownelement.func.ImageLabel.Rotation = 90
			dropdownelement.title.Text = name
			dropdownelement.func.ImageLabel.ImageColor3 = Color3.fromRGB(120, 126, 153)
			dropdownelement.func.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(dropdownelement.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(139, 146, 177)}):Play()
			end)
			dropdownelement.func.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(dropdownelement.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 92, 112)}):Play()
				game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(112, 117, 143)}):Play()
			end)
			dropdownelement.func.MouseButton1Down:Connect(function()
				game:GetService("TweenService"):Create(dropdownelement.func, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(107, 113, 136)}):Play()
				game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(131, 138, 167)}):Play()
			end)
			dropdownelement.func.MouseButton1Up:Connect(function()
				game:GetService("TweenService"):Create(dropdownelement.func, TweenInfo.new(0.07), {BackgroundColor3 = Color3.fromRGB(98, 103, 125)}):Play()
				game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.07), {ImageColor3 = Color3.fromRGB(139, 146, 177)}):Play()

				if dropdownelement.Size == UDim2.new(0, 332,0, 35) then
					game:GetService("TweenService"):Create(dropdownelement, TweenInfo.new(0.2), {Size = UDim2.new(0, 332,0, size)}):Play()
					game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.2), {Rotation = 0}):Play()

					dropdownelement.contain.seporator.BackgroundTransparency = 1

					dropdownelement.contain.Visible = true
					dropdownelement.cover.Visible = true
				elseif dropdownelement.Size == UDim2.new(0, 332,0, size) then
					game:GetService("TweenService"):Create(dropdownelement, TweenInfo.new(0.2), {Size = UDim2.new(0, 332,0, 35)}):Play()
					game:GetService("TweenService"):Create(dropdownelement.func.ImageLabel, TweenInfo.new(0.2), {Rotation = 90}):Play()

					task.wait(0.15)

					dropdownelement.contain.Visible = false
					dropdownelement.cover.Visible = false
				end
			end)
			dropdownelement.Parent = element2

			local dropelements = {}

			function dropelements:Create_Button(name, func)
				local button = parts.dropdown_elements.button:Clone()
				button.func.ImageLabel.Image = GrabIcon("button")
				button.func.ImageLabel.ImageColor3 = Color3.fromRGB(64, 70, 84)
				button.title.Text = name
				button.func.ImageLabel.Size = UDim2.new(0, 17,0, 17)
				button.func.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(58, 63, 77)}):Play()
					game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(89, 93, 113)}):Play()
					game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(89, 93, 113)}):Play()
				end)
				button.func.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(47, 51, 62)}):Play()
					game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
					game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(64, 70, 84)}):Play()
				end)
				button.func.MouseButton1Down:Connect(function()
					game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 76, 93)}):Play()
					game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(99, 104, 126)}):Play()
					game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(99, 104, 126)}):Play()
				end)
				button.func.MouseButton1Up:Connect(function()
					game:GetService("TweenService"):Create(button.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(58, 63, 77)}):Play()
					game:GetService("TweenService"):Create(button.func, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(89, 93, 113)}):Play()
					game:GetService("TweenService"):Create(button.func.ImageLabel, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(89, 93, 113)}):Play()
	
					func()
				end)
				button.Parent = dropdownelement.contain
			end

			function dropelements:Create_Toggle(name, state, func)
				local element = parts.dropdown_elements.toggle:Clone()
				element.title.Text = name
				local on = false
				if state then
					on = true
	
					game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(95, 106, 126)}):Play()
					game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(95, 106, 126)}):Play()
	
					func(on)
				end
				element.func.MouseEnter:Connect(function()
					if on == true then return end
					game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(78, 86, 103)}):Play()
					game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(78, 86, 103)}):Play()
				end)
				element.func.MouseLeave:Connect(function()
					if on == true then return end
					game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
					game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
				end)
				element.func.MouseButton1Up:Connect(function()
					on = not on
	
					func(on)
	
					if on then
						game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(95, 106, 126)}):Play()
						game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(95, 106, 126)}):Play()
					else
						game:GetService("TweenService"):Create(element.func.line, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
						game:GetService("TweenService"):Create(element.func.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
					end
				end)
				element.Parent = dropdownelement.contain
			end

			function dropelements:Create_TextBox(name, func)
				local element = parts.dropdown_elements.textbox:Clone()
				local focuseded = false
				element.title.Text = name
				element.TextBox.MouseEnter:Connect(function()
					if focuseded == true then return end
					game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(70, 77, 93)}):Play()
					game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(56, 61, 74)}):Play()
				end)
				element.TextBox.MouseLeave:Connect(function()
					if focuseded == true then return end
					game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
					game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(47, 51, 62)}):Play()
				end)
				element.TextBox.Focused:Connect(function()
					focuseded = true
					game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(78, 86, 103)}):Play()
					game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(67, 73, 88)}):Play()
				end)
				element.TextBox.FocusLost:Connect(function()
					focuseded = false
					func(element.TextBox.Text)
					game:GetService("TweenService"):Create(element.TextBox.out, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(64, 70, 84)}):Play()
					game:GetService("TweenService"):Create(element.TextBox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(47, 51, 62)}):Play()
				end)
				element.Parent = dropdownelement.contain
			end

			function dropelements:Create_Slider(name, min, max, callback)
				local element = parts.dropdown_elements.slider:Clone()
				element.title.Text = name
	
				local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)
	
				local output = math.floor((max - min) * per + min)
	
				game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.15), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()
	
				element.func.bac.num.Text = tostring(output)
	
				callback(output)
	
				element.func.MouseButton1Down:Connect(function()
					local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)
	
					local output = math.floor((max - min) * per + min)
	
					game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.15), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()
		
					element.func.bac.num.Text = tostring(output)
		
					callback(output)
	
					temp = game.Players.LocalPlayer:GetMouse().Move:Connect(function()
						local per = math.clamp((game:GetService("UserInputService"):GetMouseLocation().X - element.func.bac.AbsolutePosition.X) / element.func.bac.AbsoluteSize.X, 0, 1)
	
						local output = math.floor((max - min) * per + min)
	
						game:GetService("TweenService"):Create(element.func.bac.over, TweenInfo.new(0.2), {Size = UDim2.new(per, element.func.bac.over.Size.X.Offset, element.func.bac.over.Size.Y.Scale, element.func.bac.over.Size.Y.Offset)}):Play()
			
						element.func.bac.num.Text = tostring(output)
			
						callback(output)
					end)
	
					othertmp = game:GetService("UserInputService").InputEnded:Connect(function(a)
						if a.UserInputType == Enum.UserInputType.MouseButton1 then
							temp:Disconnect()
							othertmp:Disconnect()
						end
					end)
				end)
				element.Parent = dropdownelement.contain
			end

			return dropelements
		end

		return elementstable
	end

	return tabtable
end

return MN_LIB
