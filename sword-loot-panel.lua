local monochromeSettings=true
local themeName="Green" local themeAccent=Color3.fromRGB(25,120,65) local themeTabAccent=Color3.fromRGB(16,78,42)  local applyTheme=function() end local p=game.Players.LocalPlayer 
_G.FarmOn=false
if _G.StopAutoRebirth then pcall(_G.StopAutoRebirth) end
if _G.CancelAutoReturn then pcall(_G.CancelAutoReturn) end
local old=p.PlayerGui:FindFirstChild("SwordPanel")
if old then old:Destroy() end
local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="SwordPanel"
g.ResetOnSpawn=false
local f=Instance.new("Frame",g)
f.Size=UDim2.fromOffset(290,485)
f.Position=UDim2.fromScale(.06,.22)
f.BackgroundColor3=Color3.fromRGB(0,0,0) f.BackgroundTransparency=.4 
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12) local menuBorder=Instance.new("UIStroke",f) menuBorder.Name="MenuBorder" menuBorder.Color=Color3.new(1,1,1) menuBorder.Thickness=1.5 menuBorder.Transparency=.15 
local function make(class,text,y,height)
 local o=Instance.new(class,f)
 o.Size=UDim2.fromOffset(266,height or 30)
 o.Position=UDim2.fromOffset(12,y)
 o.BackgroundColor3=themeAccent    
 o.TextColor3=Color3.fromRGB(255,255,255)
 o.TextSize=15
 o.BackgroundTransparency=0 o.Font=Enum.Font.GothamMedium
 o.Text=text if class=="TextBox" then o.BackgroundColor3=Color3.fromRGB(80,80,80) end 
 Instance.new("UICorner",o).CornerRadius=UDim.new(0,7)
 return o
end
local title=make("TextLabel","+1 SWORD LOOT" ,8,30)
title.BackgroundTransparency=1
title.Active=false title.Font=Enum.Font.GothamBold title.TextSize=19 
Instance.new("UIDragDetector",f)
local toggle=make("TextButton","OFF | start",44)
local mode=make("TextButton","Mode: Dungeon",80)
local stageLabel=make("TextLabel","Stage (1-36)",116) stageLabel.Size=UDim2.fromOffset(129,30) stageLabel.BackgroundTransparency=1 local stage=make("TextBox","22",116) stage.Size=UDim2.fromOffset(129,30) stage.Position=UDim2.fromOffset(149,116) stage.ClearTextOnFocus=false stage.PlaceholderText="1-36"
local bagLabel=make("TextLabel","Return at",152)
bagLabel.Size=UDim2.fromOffset(129,30)
bagLabel.BackgroundTransparency=1
local bagMinus=make("TextButton","-",152)
bagMinus.Size=UDim2.fromOffset(30,30)
bagMinus.Position=UDim2.fromOffset(149,152)
local bagEntry=make("TextBox","35",152) 
bagEntry.Size=UDim2.fromOffset(60,30)
bagEntry.Position=UDim2.fromOffset(184,152)
bagEntry.ClearTextOnFocus=false
bagEntry.PlaceholderText="1-35" 
local bagPlus=make("TextButton","+",152)
bagPlus.Size=UDim2.fromOffset(30,30)
bagPlus.Position=UDim2.fromOffset(248,152)
local reward=make("TextButton","Rewards: OFF",188)
 
local clicker=make("TextButton","Clicker: OFF",260)
local rejoinButton=make("TextButton","Auto rejoin: ON",296)
local configBox=make("TextBox","Default",332)
configBox.ClearTextOnFocus=false
configBox.PlaceholderText="Settings name"
local saveButton=make("TextButton","Save settings",368)
saveButton.Size=UDim2.fromOffset(129,30)
local loadButton=make("TextButton","Load settings",368)
loadButton.Size=UDim2.fromOffset(129,30)
loadButton.Position=UDim2.fromOffset(149,368)
local profilesButton=make("TextButton","Saved settings",404)
local status=make("TextLabel","Ready | lobby",440,30)
local cpsBox=make("TextBox","400",260)
clicker.Size=UDim2.fromOffset(200,30)
cpsBox.Size=UDim2.fromOffset(58,30)
cpsBox.Position=UDim2.fromOffset(220,260)
cpsBox.ClearTextOnFocus=false
cpsBox.PlaceholderText="CPS"
status.TextSize=12
status.TextWrapped=true
status.BackgroundTransparency=1
local list=Instance.new("ScrollingFrame",f)
list.Position=UDim2.fromOffset(12,146)
list.Size=UDim2.fromOffset(266,150)
list.CanvasSize=UDim2.fromOffset(0,36*28)
list.BackgroundColor3=Color3.fromRGB(10,10,10)
list.ScrollBarThickness=7
list.Visible=false
list.ZIndex=10
local switchParts={}
local function paintSwitch(button,enabled)
 local parts=switchParts[button]
 if not parts then return end
 button.Text=""
 parts.track.BackgroundColor3=enabled and Color3.fromRGB(35,170,85) or Color3.fromRGB(200,45,45)
 parts.knob.Position=UDim2.fromOffset(enabled and 32 or 3,3)
 parts.state.Text=enabled and "ON" or "OFF"
 parts.state.Position=UDim2.fromOffset(enabled and 2 or 26,0)
end
local function makeSwitch(button,name)
 button.Text=""
 button.BackgroundColor3=Color3.fromRGB(25,25,25) button.BackgroundTransparency=1 
 local label=Instance.new("TextLabel",button)
 label.BackgroundTransparency=1 label.BackgroundColor3=Color3.fromRGB(25,25,25)  Instance.new("UICorner",label).CornerRadius=UDim.new(0,7)  label.Text=name label.TextColor3=Color3.new(1,1,1)
 label.Font=Enum.Font.GothamMedium label.TextSize=15
 label.TextXAlignment=Enum.TextXAlignment.Center 
 label.Size=UDim2.new(1,-76,1,0) label.Position=UDim2.fromOffset(0,0) 
 local track=Instance.new("Frame",button)
 track.Size=UDim2.fromOffset(59,28) track.Position=UDim2.new(1,-67,.5,-14)
 Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
 local knob=Instance.new("Frame",track)
 knob.Size=UDim2.fromOffset(22,22) knob.BackgroundColor3=Color3.new(1,1,1)
 Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
 local state=Instance.new("TextLabel",track)
 state.BackgroundTransparency=1 state.Size=UDim2.fromOffset(31,28)
 state.Font=Enum.Font.GothamBold state.TextSize=10 state.TextColor3=Color3.new(1,1,1)
 switchParts[button]={track=track,knob=knob,state=state}
 paintSwitch(button,false)
end
makeSwitch(toggle,"Farm")
 
makeSwitch(clicker,"Autoclicker")
makeSwitch(reward,"Rewards") makeSwitch(rejoinButton,"Auto rejoin") paintSwitch(rejoinButton,true) 

bagMinus.BackgroundColor3=Color3.fromRGB(190,45,45) bagPlus.BackgroundColor3=Color3.fromRGB(25,120,65) local on=false  
local kind=1
local chosen=22 local bagLimit=35 
local rewards=false
 
local clicking,claiming=false,false
local input
local clickCps=400
local autoRejoin=true
local rejoining=false
local rejoinFailed=false
local saveLast=function() end
local connections={}
local version=0
local h,r
local function live(v)
 return g.Parent and version==v
end
local function say(t)
 if g.Parent then status.Text=t end
end
local function stopMove()
 if h and r and r.Parent then pcall(function() h:MoveTo(r.Position) end) end
end
local function setBag(value)
 bagLimit=math.clamp(math.floor(tonumber(value) or bagLimit),1,35) 
 bagEntry.Text=tostring(bagLimit)
 saveLast()
end
bagMinus.Activated:Connect(function() setBag(bagLimit-1) end)
bagPlus.Activated:Connect(function() setBag(bagLimit+1) end)
bagEntry.FocusLost:Connect(function() setBag(bagEntry.Text) end)
toggle.Activated:Connect(function()
 rejoinFailed=false
 on=not on
 paintSwitch(toggle,on) 
 toggle.BackgroundColor3=Color3.fromRGB(25,25,25) 
 if not on then stopMove() end
 saveLast()
end)
mode.Activated:Connect(function()
 on=false
 version=version+1
 stopMove()
 kind=3-kind
 mode.Text=kind==1 and "Mode: Dungeon" or "Mode: Training"
 paintSwitch(toggle,false) 
 say(kind==1 and "Start in lobby" or "Walks to training pad")
 saveLast()
end)
reward.Activated:Connect(function()
 rewards=not rewards
 paintSwitch(reward,rewards) 
 saveLast()
end)

stage.FocusLost:Connect(function() chosen=math.clamp(math.floor(tonumber(stage.Text) or chosen),1,36) stage.Text=tostring(chosen) saveLast() end)
local u=game:GetService("UserInputService")

clicker.Activated:Connect(function()
 clicking=not clicking
 paintSwitch(clicker,clicking) 
 saveLast()
end)
local function click(point)
 input=input or u:CreateVirtualInput()
 assert(input,"No input")
 input:SendMouseButton(point,Enum.UserInputType.MouseButton1,true)
 task.wait(.01)
 input:SendMouseButton(point,Enum.UserInputType.MouseButton1,false)
end
g.Destroying:Connect(function()
 saveLast()
 on=false
 version=version+1
 stopMove()
 for _,c in ipairs(connections) do c:Disconnect() end
end)
local function waitOn(v)
 local t=os.clock()
 while live(v) and not on do task.wait(.2) end
 return os.clock()-t
end
local function bag()
 local t=p.PlayerGui.MainGui.Main.BottomLeft.LootCapacity.Label.Text
 local a,z=t:match("(%d+)%s*/%s*(%d+)")
 assert(a and z,"Bag?")
 return tonumber(a),tonumber(z)
end
local function full()
 local a,z=bag()
 return z>0 and a>=math.min(z,bagLimit)
end
local function gate(n)
 if n==1 then return workspace.Map.Lobby.DungeonGate end
 return workspace.Map.Stages[tostring(n)].Build.StageEntrance
end
local function pos(e)
 if e:IsA("Model") then return e:GetBoundingBox().Position end
 return e.Position
end
local function fire(q,guard)
 assert(q and q:IsA("GuiButton"),"No button")
 assert(type(firesignal)=="function","No firesignal")
 local a=pcall(function() firesignal(q.Activated) end)
 task.wait(.2)
 if guard and not guard() then return end
 local b=pcall(function() firesignal(q.MouseButton1Click) end)
 assert(a or b,"Click failed")
end
local function walk(t,label,v,training)
 local deadline=os.clock()+90
 while live(v) and (training or not full()) do
  deadline=deadline+waitOn(v)
  if not live(v) then return end
  assert(h.Health>0 and r.Parent,"Defeated")
  say(label)
  local q=Vector3.new(t.X,r.Position.Y,t.Z)
  if (q-r.Position).Magnitude<3 then return end
  assert(os.clock()<deadline,"Move timeout")
  h:MoveTo(q)
  task.wait(.3)
 end
end
local function visible(o)
 while o do
  if o:IsA("GuiObject") and not o.Visible then return false end
  if o:IsA("ScreenGui") and not o.Enabled then return false end
  o=o.Parent
 end
 return true
end
local function ensureLobby(v)
 local root=p.PlayerGui:FindFirstChild("MainGui2")
 local top=root and root:FindFirstChild("Top")
 local box=top and top:FindFirstChild("ReturnTown")
 local button=box and box:FindFirstChild("ImageButton")
 if button and visible(button) then
  waitOn(v)
  if not live(v) then return end
  fire(button,function() return live(v) and on end)
  local deadline=os.clock()+20
  repeat
   if not live(v) then return end
   deadline=deadline+waitOn(v)
   assert(os.clock()<deadline,"Could not return to lobby")
   task.wait(.5)
  until not visible(button)
  task.wait(1)
 end
end
local function dungeon(v)
 ensureLobby(v)
 if not live(v) then return end
 local count=bag()
 assert(count==0,"Empty bag in lobby")
 while live(v) do
  waitOn(v)
  if not live(v) then return end
  local target=chosen
  h=p.Character:FindFirstChildOfClass("Humanoid")
  r=p.Character.HumanoidRootPart
  for n=1,36 do if n>chosen then break end
   if not live(v) or full() then break end
   local t=pos(gate(n))
   local d=Vector3.new(t.X-r.Position.X,0,t.Z-r.Position.Z)
   if d.Magnitude>0 then t=t+d.Unit*10 end
   walk(t,"Entering stage "..n,v)
   if not live(v) or full() then break end
   walk((pos(gate(n))+pos(gate(n+1)))/2,"Stage "..n.." middle",v)
   if not live(v) then return end
   stopMove()
   local deadline=os.clock()+1
   while live(v) and not full() do
    deadline=deadline+waitOn(v)
    if not live(v) then return end
    assert(h.Health>0,"Defeated")
    if n>chosen or n<chosen and os.clock()>=deadline then break end
    say("Farming "..n.." | Bag "..bag())
    task.wait(.3)
   end
  end
  waitOn(v)
  if not live(v) then return end
  stopMove()
  say("Returning")
  fire(p.PlayerGui.MainGui2.Top.ReturnTown.ImageButton,function() return live(v) and on end)
  local deadline=os.clock()+20
  while live(v) and bag()>0 do
   deadline=deadline+waitOn(v)
   assert(os.clock()<deadline,"Return failed")
   task.wait(.5)
  end
  task.wait(3)
 end
end
local function train(v)
 ensureLobby(v)
 while live(v) do
  waitOn(v)
  if not live(v) then return end
  h=p.Character:FindFirstChildOfClass("Humanoid")
  r=p.Character.HumanoidRootPart
  local training=Vector3.new(-80.40,154.23,345.39)
  local delta=r.Position-training
  if Vector3.new(delta.X,0,delta.Z).Magnitude>4 then
   walk(training,"Going to train",v,true)
   if not live(v) then return end
   stopMove()
  end
  say("Training")
  task.wait(1)
 end
end

local Http=game:GetService("HttpService")
local store={version=1,active="Default",profiles={}}
local file="SwordPanel-configs.json"
local function readStore(path)
 local ok,value=pcall(function() return Http:JSONDecode(readfile(path)) end)
 if ok and type(value)=="table" and type(value.profiles)=="table" then return value end
end
store=readStore(file) or readStore(file..".bak") or store
local function snapshot()
 return {mode=kind,stage=chosen,theme=themeName,bagLimit=bagLimit ,enabled=on,rewards=rewards, clicker=clicking,cps=clickCps,rejoin=autoRejoin,window={x=f.Position.X.Scale,ox=f.Position.X.Offset,y=f.Position.Y.Scale,oy=f.Position.Y.Offset}}
end
local function writeStore()
 local encoded=Http:JSONEncode(store)
 local previous=readStore(file)
 if previous then writefile(file..".bak",Http:JSONEncode(previous)) end
 writefile(file,encoded)
end
saveLast=function()
 if not g.Parent or rejoinFailed then return end
 local ok=pcall(function() store.last=snapshot() writeStore() end)
 if not ok then say("Config save failed") end
end
local function apply(data)
 assert(type(data)=="table","Config missing") applyTheme(data.theme) 
 rejoinFailed=false
 on=false
 version=version+1
 stopMove()
 kind=data.mode==2 and 2 or 1
 chosen=math.clamp(math.floor(tonumber(data.stage) or 22),1,36)
 bagLimit=math.clamp(math.floor(tonumber(data.bagLimit) or 35),1,35)  bagEntry.Text=tostring(bagLimit) rewards=data.rewards==true
  
 clicking=data.clicker==true
 clickCps=math.clamp(math.floor(tonumber(data.cps) or 10),1,400)
 autoRejoin=data.rejoin~=false
 local w=data.window
 if type(w)=="table" then
  f.Position=UDim2.new(tonumber(w.x) or .06,math.clamp(tonumber(w.ox) or 0,-1000,1000),tonumber(w.y) or .22,math.clamp(tonumber(w.oy) or 0,-1000,1000))
 end
 on=data.enabled==true
 paintSwitch(toggle,on) 
 toggle.BackgroundColor3=Color3.fromRGB(25,25,25) 
 mode.Text=kind==1 and "Mode: Dungeon" or "Mode: Training"
 stage.Text=tostring(chosen)
 paintSwitch(reward,rewards) 
   
 paintSwitch(clicker,clicking) 
 cpsBox.Text=tostring(clickCps)
 paintSwitch(rejoinButton,autoRejoin) 
end
local function profileName()
 local name=configBox.Text:match("^%s*(.-)%s*$"):sub(1,32)
 assert(name~="","Enter a config name")
 return name
end
saveButton.Activated:Connect(function()
 local ok,err=pcall(function()
  local name=profileName()
  store.profiles[name]=snapshot()
  store.active=name
  store.last=snapshot()
  writeStore()
  say("Saved "..name)
 end)
 if not ok then say(tostring(err)) end
end)
loadButton.Activated:Connect(function()
 local ok,err=pcall(function()
  local name=profileName()
  apply(assert(store.profiles[name],"Unknown settings"))
  store.active=name
  saveLast()
  say("Loaded "..name)
 end)
 if not ok then say(tostring(err)) end
end)
local profileList=Instance.new("ScrollingFrame",f)
profileList.Size=UDim2.fromOffset(266,140)
profileList.Position=UDim2.fromOffset(12,300)
profileList.ScrollBarThickness=7
profileList.Visible=false
profileList.ZIndex=15 profileList.BackgroundColor3=Color3.fromRGB(10,10,10) profileList.BackgroundTransparency=0 profileList.BorderSizePixel=0 profileList.ScrollBarImageColor3=Color3.new(1,1,1) Instance.new("UICorner",profileList).CornerRadius=UDim.new(0,7) 
profilesButton.Activated:Connect(function()
 profileList.Visible=not profileList.Visible
 if not profileList.Visible then return end
 for _,child in ipairs(profileList:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end 
 local names={}
 for name in pairs(store.profiles) do table.insert(names,name) end
 table.sort(names)
 profileList.CanvasSize=UDim2.fromOffset(0,#names*34 )
 for i,name in ipairs(names) do
  local o=Instance.new("TextButton",profileList)
  o.Size=UDim2.new(1,-10,0,30) 
  o.Position=UDim2.fromOffset(4,(i-1)*34) 
  o.Text=name
  o.TextSize=15
  o.BackgroundColor3=themeAccent     o.TextColor3=Color3.new(1,1,1) o.BackgroundTransparency=0 o.ZIndex=16 o.Font=Enum.Font.GothamMedium o.BorderSizePixel=0 Instance.new("UICorner",o).CornerRadius=UDim.new(0,7) 
  o.Activated:Connect(function()
   configBox.Text=name
   profileList.Visible=false
   say("Press Load settings")
  end)
 end
end)
local compactScale=Instance.new("UIScale",f)
compactScale.Scale=.8
f.Size=UDim2.fromOffset(290,300)
title.Size=UDim2.fromOffset(230,30)
local fold=make("TextButton","-",8,30)
fold.Size=UDim2.fromOffset(30,30)
fold.Position=UDim2.fromOffset(248,8)
fold.ZIndex=20 fold.BackgroundColor3=Color3.fromRGB(190,45,45) 
local function row(o,y) o.Position=UDim2.fromOffset(o.Position.X.Offset,y) end
row(toggle,80)
row(mode,116) row(stage,152) row(stageLabel,152)
for _,o in ipairs({bagLabel,bagMinus,bagEntry,bagPlus}) do row(o,188) end
row(reward,80) row(clicker,116) row(cpsBox,116) 
row(configBox,80) row(saveButton,116) row(loadButton,116) row(profilesButton,152)
row(rejoinButton,188) row(status,260)
list.Position=UDim2.fromOffset(12,116)
list.Size=UDim2.fromOffset(266,140)
profileList.Position=UDim2.fromOffset(12,80) 
local pages={
 {toggle,mode,stage,stageLabel,bagLabel,bagMinus,bagEntry,bagPlus},
 {reward,clicker,cpsBox} ,
 {configBox,saveButton,loadButton,profilesButton,rejoinButton}
}
local tabs={}
local pageHeight=230 local function selectTab(n) status.Visible=false pageHeight=n==2 and 158  or (n==3 and 266 or 230)  f.Size=UDim2.fromOffset(290,pageHeight)
 list.Visible=false profileList.Visible=false
 for i,controls in ipairs(pages) do
  for _,o in ipairs(controls) do o.Visible=i==n end
  tabs[i].BackgroundColor3=themeTabAccent   tabs[i].TextTransparency=i==n and 0 or .25  
 end
end
for i,name in ipairs({"FARM","EXTRAS","SETTINGS"} ) do
 local tab=make("TextButton",name,44)
 tab.Size=UDim2.fromOffset(84,30)
 tab.Position=UDim2.fromOffset(12+(i-1)*91,44)
 tabs[i]=tab
 tab.Activated:Connect(function() selectTab(i) end)
end
local themeButton=make("TextButton","Theme: Green",224)
table.insert(pages[3],themeButton)
local chromeThemes=true
local themeNames={"Green","Blue","Purple","Red","Orange","Yellow","Teal","Pink","White","Monochrome"}
local palettes={
 Green={Color3.fromRGB(5,20,12),Color3.fromRGB(25,120,65),Color3.fromRGB(75,220,125)},
 Blue={Color3.fromRGB(8,14,25),Color3.fromRGB(35,95,170),Color3.fromRGB(85,165,255)},
 Purple={Color3.fromRGB(20,10,28),Color3.fromRGB(115,65,165),Color3.fromRGB(180,120,245)},
 Red={Color3.fromRGB(28,8,8),Color3.fromRGB(160,40,40),Color3.fromRGB(255,90,90)},
 Orange={Color3.fromRGB(28,16,7),Color3.fromRGB(175,85,20),Color3.fromRGB(255,160,65)},
 Yellow={Color3.fromRGB(24,22,6),Color3.fromRGB(225,190,45),Color3.fromRGB(255,225,95)},
 Teal={Color3.fromRGB(5,23,23),Color3.fromRGB(20,125,125),Color3.fromRGB(65,225,215)},
 Pink={Color3.fromRGB(27,9,22),Color3.fromRGB(165,50,120),Color3.fromRGB(255,115,200)},
 White={Color3.fromRGB(18,18,18),Color3.fromRGB(220,220,220),Color3.fromRGB(255,255,255)},
 Monochrome={Color3.fromRGB(0,0,0),Color3.fromRGB(65,65,65),Color3.fromRGB(180,180,180)}
}

local themeExcluded={[bagMinus]=true,[bagPlus]=true,[fold]=true}
for _,tab in ipairs(tabs) do themeExcluded[tab]=true end
applyTheme=function(name)
 themeName=palettes[name] and name or "Green"
 local colors=palettes[themeName]
 themeAccent=colors[2] themeTabAccent=Color3.fromRGB(math.floor(themeAccent.R*255*.65),math.floor(themeAccent.G*255*.65),math.floor(themeAccent.B*255*.65)) 
 f.BackgroundColor3=colors[1] menuBorder.Color=colors[3] for _,tab in ipairs(tabs) do tab.BackgroundColor3=themeTabAccent  tab.TextColor3=Color3.new(1,1,1)  end 
 for _,o in ipairs(g:GetDescendants()) do
  if o:IsA("TextBox") then o.BackgroundColor3=Color3.fromRGB(80,80,80) 
  elseif o:IsA("TextButton") and not switchParts[o] and not themeExcluded[o] then
   o.BackgroundColor3=themeAccent o.TextColor3=(themeName=="White" or themeName=="Yellow") and Color3.new(0,0,0) or Color3.new(1,1,1)   
  end
 end
 themeButton.Text="Theme: "..themeName
end
themeButton.Activated:Connect(function()
 local index=table.find(themeNames,themeName) or 1
 applyTheme(themeNames[index%#themeNames+1])
 saveLast()
end)
applyTheme(themeName)

local switchWrappers={} 
for button,parts in pairs(switchParts) do
 local wrapper=Instance.new("Frame",f)
 wrapper.Name="SwitchRow"
 wrapper.BackgroundTransparency=1
 wrapper.Size=button.Size wrapper.Position=button.Position
 wrapper.Visible=button.Visible
 for _,child in ipairs(button:GetChildren()) do
  if child:IsA("TextLabel") then child.Parent=wrapper end
 end
 button.Parent=wrapper
 button.Size=UDim2.fromOffset(59,28)
 button.Position=UDim2.new(1,-67,.5,-14)
 parts.track.Position=UDim2.fromOffset(0,0)
 switchWrappers[button]=wrapper
end
for _,controls in ipairs(pages) do
 for i,control in ipairs(controls) do
  controls[i]=switchWrappers[control] or control
 end
end

selectTab(1)
local folded=false
local hidden={}
fold.Activated:Connect(function()
 folded=not folded
 if folded then
  list.Visible=false profileList.Visible=false
  for _,child in ipairs(f:GetChildren()) do
   if child:IsA("GuiObject") and child~=title and child~=fold then
    hidden[child]=child.Visible child.Visible=false
   end
  end
 else
  for child,visible in pairs(hidden) do
   if child.Parent then child.Visible=visible end
  end
  hidden={}
 end
 f.Size=UDim2.fromOffset(290,folded and 46 or pageHeight)
 fold.Text=folded and "+" or "-" fold.BackgroundColor3=folded and Color3.fromRGB(25,120,65) or Color3.fromRGB(190,45,45) 
end)

cpsBox.FocusLost:Connect(function()
 clickCps=math.clamp(math.floor(tonumber(cpsBox.Text) or 10),1,400)
 cpsBox.Text=tostring(clickCps)
 saveLast()
end)
configBox.Text=type(store.active)=="string" and store.active or "Default"
if type(store.last)=="table" then
 local ok=pcall(apply,store.last)
 if ok then say("Restored last settings") end
end
if not next(store.profiles) then store.profiles.Default=snapshot() end
local BOOT=[=[repeat task.wait(1) until game:IsLoaded() and game:GetService("Players").LocalPlayer
if game.PlaceId==93239606899307 then
local p=game:GetService("Players").LocalPlayer
local endTime=os.clock()+60
repeat task.wait(1) until p:FindFirstChild("PlayerGui") and p.PlayerGui:FindFirstChild("MainGui") and workspace:FindFirstChild("Map") or os.clock()>endTime
task.wait(3)
assert(loadstring(readfile("SwordPanel.lua")))()
end]=]
local queue=queue_on_teleport or queueonteleport
if type(queue)=="function" and _G.SwordPanelQueuedPlayer~=p then
 local ok=pcall(queue,BOOT)
 if ok then _G.SwordPanelQueuedPlayer=p else say("Relaunch hook failed") end
end
local Teleport=game:GetService("TeleportService")
local Gui=game:GetService("GuiService")
local function reconnect()
 if rejoining or not autoRejoin or not g.Parent then return end
 saveLast()
 rejoining=true
 rejoinFailed=false
 version=version+1
 stopMove()
 task.spawn(function()
  for attempt=1,6 do
   if not g.Parent or not autoRejoin then break end
   say("Rejoin attempt "..attempt.."/6")
   pcall(function() Teleport:Teleport(game.PlaceId,p) end)
   local deadline=os.clock()+math.min(attempt*5,30)
   while g.Parent and autoRejoin and os.clock()<deadline do task.wait(.5) end
  end
  rejoining=false
  if g.Parent and autoRejoin then
   rejoinFailed=true
   on=false
   paintSwitch(toggle,false) 
   say("Rejoin failed - reconnect manually")
  end
 end)
end
_G.SwordPanelRejoin=reconnect
local function errorMessage(message)
 if type(message)~="string" or message=="" then
  local ok,value=pcall(function() return Gui:GetErrorMessage() end)
  message=ok and value or ""
 end
 if message~="" then reconnect() end
end
local hooked,connection=pcall(function()
 return Gui.ErrorMessageChanged:Connect(errorMessage)
end)
if hooked then table.insert(connections,connection) end
rejoinButton.Activated:Connect(function()
 rejoinFailed=false
 autoRejoin=not autoRejoin
 paintSwitch(rejoinButton,autoRejoin) 
 saveLast()
 if autoRejoin then errorMessage("") end
end)
task.spawn(function()
 while g.Parent do
  task.wait(10)
  if g.Parent and not rejoining and not rejoinFailed then saveLast() end
 end
end)

task.spawn(function()
 while g.Parent do
  if on and not rejoining then
   local v=version
   local ok,err=pcall(function()
    if kind==1 then dungeon(v) else train(v) end 
   end)
   if live(v) and not ok then
    on=false
    version=version+1
    stopMove()
    paintSwitch(toggle,false) 
    say(tostring(err))
    saveLast()
   end
  end
  task.wait(.2)
 end
end)
task.spawn(function()
 while g.Parent do
  if rewards and not rejoining and not u:GetFocusedTextBox() then
   local ok,err=pcall(function()
    local frame=p.PlayerGui.MainGui:FindFirstChild("Playtime")
    assert(frame,"Open gifts")
    local q=frame.Bottom.ClaimAll
    local visible=frame.Visible
    frame.Visible=true
    claiming=true
    local success,message=pcall(function()
     task.wait(.25)
     if not rewards or not g.Parent then return end
     local point=q.AbsolutePosition+q.AbsoluteSize/2+Vector2.new(0,60)
     click(point)
     task.wait(.4)
    end)
    if frame.Parent then frame.Visible=visible end
    claiming=false
    assert(success,message)
   end)
   if not ok then paintSwitch(reward,rewards)  end
  end
  task.wait(20)
 end
end)

task.spawn(function()
 local credit,last=0,os.clock()
 while g.Parent do
  local now=os.clock()
  local elapsed=math.min(math.max(now-last,0),.05)
  last=now
  if clicking and not rejoining and not rejoinFailed then
   credit=math.min(20,credit+elapsed*clickCps)
   local count=math.floor(credit)
   if count>0 then
    credit=credit-count
    local ok,err=pcall(function()
     local event=game:GetService("ReplicatedStorage").Remotes.MainEvent
     for i=1,count do event:FireServer(220) end
    end)
    if ok then
     paintSwitch(clicker,clicking) 
    else
     clicking=false
     credit=0
     paintSwitch(clicker,clicking) 
     say(tostring(err))
     saveLast()
    end
   end
  else
   credit=0
  end
  task.wait()
 end
end)






