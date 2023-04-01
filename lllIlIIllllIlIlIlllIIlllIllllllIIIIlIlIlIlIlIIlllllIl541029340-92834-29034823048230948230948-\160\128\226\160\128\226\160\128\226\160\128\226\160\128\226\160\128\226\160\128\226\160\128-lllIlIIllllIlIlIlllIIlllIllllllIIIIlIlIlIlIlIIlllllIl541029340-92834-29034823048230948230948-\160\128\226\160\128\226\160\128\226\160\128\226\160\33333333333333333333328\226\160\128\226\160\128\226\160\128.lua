print("░██████╗░██████╗░██╗███████╗███████╗  ██╗░░░██╗░░███╗░░")
print("██╔════╝░██╔══██╗██║██╔════╝██╔════╝  ██║░░░██║░████║░░")
print("██║░░██╗░██████╔╝██║█████╗░░█████╗░░  ╚██╗░██╔╝██╔██║░░")
print("██║░░╚██╗██╔══██╗██║██╔══╝░░██╔══╝░░  ░╚████╔╝░╚═╝██║░░")
print("╚██████╔╝██║░░██║██║███████╗██║░░░░░  ░░╚██╔╝░░███████╗")
print("░╚═════╝░╚═╝░░╚═╝╚═╝╚══════╝╚═╝░░░░░  ░░░╚═╝░░░╚══════╝")
print("Commands: start, stop, bring, serverhop, leave, rejoin, goto, reset, fling, loopfling, wl")
print("-----------------------------------------------------------------------------------------")
print("discord.gg/TRShpFeqGK | grief#0002")

local Tick = tick();

local AltControllers = {
    "nanovisions",
    "Gx_hn",
    "bv7z",
    "LanceXEvans",
    "57WRLDWD",
    "AimWithTheGods",
    "michael588172",
    "xah202",
    "drawwithfriendruiner"
}

local p = game:GetService("Players").LocalPlayer
if not table.find(AltControllers, p.Name) then
    p:Kick("Not On Whitelist, Buy The Script. discord.gg/TRShpFeqGK")
end

local Whitelisted = {
   "nanovisions",
   "Gx_hn",
   "bv7z",
   "AceOfSpades12_4",
   "Likka0999",
   "That_emo1rat",
   "michael588172",
   "ANegun"
}

local Blacklisted = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10
}

local Prefix = getgenv().Configuration.PrefixForChats
local servahop = getgenv().Configuration.Serverhop

local Looping = false

local Notify = function(text, time)
	game:GetService("StarterGui"):SetCore(
		"SendNotification",
		{
			Title = "Grief v1.1",
			Text = text,
			Duration = time or 3
		}
	)
end

if not syn then
	Notify("Buy synapse to access all the features.\nTook : "..Tick.."seconds to load!", 5)
end

if game:GetService("ReplicatedStorage"):FindFirstChild("lIIl") then
    game:GetService("ReplicatedStorage"):FindFirstChild("lIIl"):Destroy()
end

if table.find(Blacklisted, game:GetService("Players").LocalPlayer.UserId) then
    game.Players.LocalPlayer:Kick("Blacklisted.")
else
	Notify("Check Console For Info", 10)
	Notify("discord.gg/TRShpFeqGK | grief#0002", 10)
	if not table.find(AltControllers, p.Name) then
        return
    else
        print("yep"
    end
end

local Testers = {
    "drawwithfriendruiner"
}

local billboardGuiProperties = {
    Name = "PlayerTag",
    Adornee = nil,
    Enabled = true,
    LightInfluence = 0,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    ResetOnSpawn = false,
    AlwaysOnTop = true,
    StudsOffset = Vector3.new(0, 2, 0),
    Size = UDim2.new(2, 0, 2, 0), 
}

local textLabelProperties = {
    Font = Enum.Font.SourceSansBold,
    TextScaled = true,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1
}

local function AddLabel(Player)
    local hasAltControllerTag = table.find(AltControllers, Player.Name)
    local hasTesterTag = table.find(Testers, Player.Name)
    local hasOwnerTag = (Player.Name == "nanovisions" or Player.Name == "bv7z")
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = Player.Character.Head
    textLabel.Name = "Tag"
    for key, value in pairs(textLabelProperties) do
        textLabel[key] = value
    end
    
    if hasAltControllerTag and not hasTesterTag and not hasOwnerTag then
        textLabel.Text = "Buyer"
        textLabel.TextColor3 = Color3.fromRGB(102, 51, 153)
    elseif hasTesterTag and not hasAltControllerTag and not hasOwnerTag then
        textLabel.Text = "Tester"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    elseif hasOwnerTag and not hasAltControllerTag and not hasTesterTag then
        textLabel.Text = "Owner"
        textLabel.TextColor3 = Color3.new(1, 1, 1)
    elseif hasAltControllerTag and hasOwnerTag then
        textLabel.Text = "Owner"
        textLabel.TextColor3 = Color3.new(1, 1, 1)
    end
    
    if hasAltControllerTag or hasTesterTag or isOwner then
        local billboardGui = Instance.new("BillboardGui")
        for key, value in pairs(billboardGuiProperties) do
            billboardGui[key] = value
        end
        billboardGui.Adornee = Player.Character.Head
        billboardGui.Parent = Player.Character.Head
        textLabel.Parent = billboardGui
    end
end

for i,v in next, game:GetService("Players"):GetPlayers() do
	AddLabel(v)
	v.CharacterAdded:Connect(function(c)
		c:WaitForChild("Humanoid")
		c:WaitForChild("HumanoidRootPart")
		AddLabel(v)
	end)
end

game:GetService("Players").PlayerAdded:Connect(function(Player)
	AddLabel(Player)
	Player.CharacterAdded:Connect(function(c)
		c:WaitForChild("Humanoid")
		c:WaitForChild("HumanoidRootPart")
		AddLabel(Player)
	end)
end)

local Toggle = true

local Whitelisted_OnlyForTheServer = {}

local players = {}

for i, player in pairs(game.Players:GetPlayers()) do
    if table.find(Whitelisted, player.Name) then
        table.insert(players, player.DisplayName)
    end
end

local players_string = ""

if #players > 0 then
    players_string = table.concat(players, ", ")
else
    players_string = "None"
end

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local rservice = game:GetService("RunService")

local function SkidFling(TargetPlayer, TTW, IgnoreIfSeated)
    local Character = LocalPlayer.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid.RootPart
    local OldPosition = RootPart.CFrame
    
    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle
    
    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end
    
    if Character and Humanoid and RootPart then
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        else
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        if THumanoid.Sit and IgnoreIfSeated == "Yes" then
            return
        elseif IgnoreIfSeated == "No" then
        end
        local function FPos(BasePart,Pos,Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            RootPart.Velocity = Vector3.new(9e8,9e8,9e8)
            RootPart.RotVelocity = Vector3.new(9e8,9e8,9e8)
        end
        local function SFBasePart(BasePart)
            local Time = tick()
            local Angle = 0
            
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 30 then
                        Angle = Angle + 0
                        FPos(BasePart,CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 5,CFrame.Angles(math.rad(Angle),0,0))
                        game:GetService("RunService").Heartbeat:wait()

                        FPos(BasePart,CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
                        game:GetService("RunService").Heartbeat:wait()

                        FPos(BasePart,CFrame.new(0,-1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,CFrame.Angles(math.rad(Angle),0,0))
                        game:GetService("RunService").Heartbeat:wait()
                        
                    else
                        FPos(BasePart,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-30),0,0))
                        game:GetService("RunService").Heartbeat:wait()

                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 1000 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or Humanoid.Health <= 0 or tick() > Time + TTW
        end
        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e9,9e9,9e9)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
        end
        BV:Destroy()
        for _,x in next, Character:GetDescendants() do
            if x:IsA("BasePart") then
                x.Velocity,x.RotVelocity = Vector3.new(),Vector3.new()
            end
        end
        Humanoid:ChangeState("GettingUp")
        workspace.CurrentCamera.CameraSubject = Humanoid
        RootPart.CFrame = OldPosition
    end
end

rservice.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit == true then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
        for _,z in next, LocalPlayer.Character:GetChildren() do if z:IsA'BasePart' then z.CanCollide = false end end
    end
end)

coroutine.resume(coroutine.create(function()
    while wait() do
        pcall(function()
            for _,z in pairs(Players:GetPlayers()) do
                if Toggle then
                    if z ~= LocalPlayer and not table.find(Whitelisted, z.Name) and not table.find(Whitelisted_OnlyForTheServer, z.Name) then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and z and z.Character and z.Character:FindFirstChildOfClass("Humanoid").Sit == false then
                            SkidFling(z, getgenv().Configuration.TimeToWait, "Yes")
                            wait()
                        end
                    end
                end
            end
        end)
    end
end))
coroutine.resume(coroutine.create(function()
    while wait() do
        for _,z in next, Players:GetPlayers() do
            if z~=LocalPlayer then
                if Toggle then
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().Chats[math.random(1, #getgenv().Chats)], "All")
                    wait(2.15)
                end
            end
        end
    end
end))

local function Refresh()
	if syn then
		local _ = nil
		local _1 = Instance.new("Model")
		local _2 = LocalPlayer.Character
		LocalPlayer.Character = _1
		LocalPlayer.Character = _2
		wait(Players.RespawnTime - .1)
		_ = LocalPlayer.Character.HumanoidRootPart.CFrame
		_2:Destroy()
		LocalPlayer.CharacterAdded:Wait()
		LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = _
	elseif not syn then
		return
	end
end

local function Serverhop()
    wait(140)
    local gameId = game.PlaceId
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", gameId))).data

    if #servers > 0 then
       game:GetService("StarterGui"):SetCore("SendNotification", {
         Title = "Notification";
         Text = "Serverhopping!";
         Duration = 20
       })
        
        wait(.5)
        
      local randomServer = servers[math.random(1, #servers)]
      game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, randomServer.id)
   end
end

if servahop == true then
    Serverhop()
end

for i,v in next, Players:GetPlayers() do
    if table.find(AltControllers, v.Name) then
        v.Chatted:Connect(function(Message)
            if Message == Prefix.."stop" then
                Toggle = false
                Looping = false
            elseif Message == Prefix.."start" then
                if not Toggle then
                    Toggle = true
                end
            elseif Message == Prefix.."bring" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            elseif Message == Prefix.."leave" then
                game:shutdown()
            elseif Message == Prefix.."rejoin" then
                game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
            elseif Message == Prefix.."reset" then
                LocalPlayer.Character:BreakJoints()
            elseif string.sub(string.lower(Message), 1, 7) == Prefix.."fling " then
                for _,x in next, Players:GetPlayers() do
                    if x.Name:lower():sub(1, #Message:sub(8)) == Message:sub(8):lower() or x.DisplayName:lower():sub(1, #Message:sub(8)) == Message:sub(8) then
                        SkidFling(x, 3, "No")
                    end
                end
            elseif string.sub(string.lower(Message), 1, 11) == Prefix.."loopfling " then
				if syn then
					if not Looping then
						Looping = true
					end
					while Looping do
						for _,x in next, Players:GetPlayers() do
							if x.Name:lower():sub(1, #Message:sub(12)) == Message:sub(12):lower() or x.DisplayName:lower():sub(1, #Message:sub(12)) == Message:sub(12) then
								SkidFling(x, getgenv().Configuration.TimeToWait, "No")
								task.wait()
							end
						end
					end
				elseif not syn then
					return Notify("Buy synapse to use this feature.", 5)
				end
            elseif Message == Prefix.."anchor" then
                LocalPlayer.Character.HumanoidRootPart.Anchored = true
            elseif Message == Prefix.."unanchor" then
                if LocalPlayer.Character.HumanoidRootPart.Anchored then
                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                end
            elseif string.sub(string.lower(Message), 1, 6) == Prefix.."goto " then
                for _,x in next, Players:GetPlayers() do
                    if x.Name:lower():sub(1, #Message:sub(7)) == Message:sub(7):lower() or x.DisplayName:lower():sub(1, #Message:sub(7)) == Message:sub(7) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
                    end
                end
            elseif Message == Prefix.."re" then
				if syn then
                	pcall(Refresh)
				else
					return Notify("Buy synapse to use this feature.", 5)
				end
            elseif string.sub(string.lower(Message), 1, 4) == Prefix.."wl " then
                for _,x in next, Players:GetPlayers() do
                    if x.Name:lower():sub(1, #Message:sub(5)) == Message:sub(5):lower() then
                        table.insert(Whitelisted_OnlyForTheServer, x.Name)
                    end
                end
            end
        end)
    end
end
