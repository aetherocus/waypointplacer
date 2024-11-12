-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local Place = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Delete = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Visualizer = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Play = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local currentwaypoint = Instance.new("IntValue")

local yes = true

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local Waypoints = Instance.new("Folder", workspace)
Waypoints.Name = "Waypoints"

local waypoints = workspace:FindFirstChild("Waypoints")

local function createwaypoints()
	local waypoint = Instance.new("Part", waypoints)
	waypoint.Shape = Enum.PartType.Ball
	waypoint.Material = Enum.Material.Neon
	waypoint.Size = Vector3.new(1,1,1)
	waypoint.Position = char.HumanoidRootPart.Position
	waypoint.Anchored = true
	waypoint.CanCollide = false
	waypoint.CanTouch = false
	waypoint.CanQuery = false
	waypoint.Transparency = 0.8
	waypoint.Name = "wp".. currentwaypoint.Value

	currentwaypoint.Value = currentwaypoint.Value+1

end

local function delete()
	for i, v in pairs(waypoints:GetChildren()) do
		v:Destroy()
	end
end

local function visaulizer()
	if yes then
		for i, v in pairs(waypoints:GetChildren()) do
			v.Transparency = 1
		end
		yes = false
	else
		for i, v in pairs(waypoints:GetChildren()) do
			v.Transparency = 0.8
		end
		yes = true
	end
end

local track = {}

local wps = workspace.Waypoints

wps.ChildAdded:Connect(function(child: Instance) 
	table.insert(track, child)
end)



wps.ChildRemoved:Connect(function(child: Instance) 
	for i, v in pairs(track) do
		table.remove(track, i)
	end
end)



table.sort(track, function(a, b)
	return tonumber(a.Name:match("%d+")) < tonumber(b.Name:match("%d+"))
end)

local wpIdx = 1
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local hum = char:WaitForChild("Humanoid")

local function moveToNextWaypoint()
	local path = game:GetService("PathfindingService"):CreatePath()
	path:ComputeAsync(char.HumanoidRootPart.Position, track[wpIdx].Position)


	local waypoints = path:GetWaypoints()

	for i, waypoint in pairs(waypoints) do
		if waypoint.Action == Enum.PathWaypointAction.Jump then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
		hum:MoveTo(waypoint.Position)
	end

end



hum.MoveToFinished:Connect(function()


	
	if wpIdx == #track then
		wpIdx = 1
	else
		wpIdx = wpIdx + 1
	end
	


	moveToNextWaypoint()



end)


--Properties:

ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(84, 84, 84)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0788571462, 0, 0.11304348, 0)
Frame.Size = UDim2.new(0.237714291, 0, 0.739130437, 0)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(1, 0, 0.0764705911, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Waypoint placer"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

UICorner.Parent = TextLabel

UICorner_2.Parent = Frame

UIListLayout.Parent = Frame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

Place.Name = "Place"
Place.Parent = Frame
Place.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Place.BorderColor3 = Color3.fromRGB(0, 0, 0)
Place.BorderSizePixel = 0
Place.Position = UDim2.new(0.0168269239, 0, 0.105882354, 0)
Place.Size = UDim2.new(0.9375, 0, 0.08529412, 0)
Place.Font = Enum.Font.SourceSans
Place.Text = "Place"
Place.TextColor3 = Color3.fromRGB(255, 255, 255)
Place.TextSize = 14.000
Place.MouseButton1Click:Connect(createwaypoints)

UICorner_3.Parent = Place

Delete.Name = "Delete"
Delete.Parent = Frame
Delete.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Delete.BorderColor3 = Color3.fromRGB(0, 0, 0)
Delete.BorderSizePixel = 0
Delete.Position = UDim2.new(0.0168269239, 0, 0.220588237, 0)
Delete.Size = UDim2.new(0.9375, 0, 0.08529412, 0)
Delete.Font = Enum.Font.SourceSans
Delete.Text = "Delete Waypoints"
Delete.TextColor3 = Color3.fromRGB(255, 255, 255)
Delete.TextSize = 14.000
Delete.MouseButton1Click:Connect(delete)

UICorner_4.Parent = Delete

Visualizer.Name = "Visualizer"
Visualizer.Parent = Frame
Visualizer.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Visualizer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Visualizer.BorderSizePixel = 0
Visualizer.Position = UDim2.new(0.0168269239, 0, 0.220588237, 0)
Visualizer.Size = UDim2.new(0.9375, 0, 0.08529412, 0)
Visualizer.Font = Enum.Font.SourceSans
Visualizer.Text = "Visualizer"
Visualizer.TextColor3 = Color3.fromRGB(255, 255, 255)
Visualizer.TextSize = 14.000
Visualizer.MouseButton1Click:Connect(visaulizer)

UICorner_5.Parent = Visualizer

Play.Name = "Play"
Play.Parent = Frame
Play.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Play.BorderColor3 = Color3.fromRGB(0, 0, 0)
Play.BorderSizePixel = 0
Play.Position = UDim2.new(0.0168269239, 0, 0.220588237, 0)
Play.Size = UDim2.new(0.9375, 0, 0.08529412, 0)
Play.Font = Enum.Font.SourceSans
Play.Text = "Play"
Play.TextColor3 = Color3.fromRGB(255, 255, 255)
Play.TextSize = 14.000
Play.MouseButton1Click:Connect(moveToNextWaypoint)


UICorner_6.Parent = Play

currentwaypoint.Parent = Frame

local UIS = game:GetService('UserInputService')
local frame = Frame
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)
