-- ================================================================
--   ██╗   ██╗ ██████╗     ██╗  ██╗██╗   ██╗██████╗ 
--   ██║   ██║██╔════╝     ██║  ██║██║   ██║██╔══██╗
--   ██║   ██║██║  ███╗    ███████║██║   ██║██████╔╝
--   ██║   ██║██║   ██║    ██╔══██║██║   ██║██╔══██╗
--   ╚██████╔╝╚██████╔╝    ██║  ██║╚██████╔╝██████╔╝
--    ╚═════╝  ╚═════╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
-- ================================================================
--   วางใน StarterPlayerScripts (LocalScript)
-- ================================================================

-- ================================================================
--             ⚙️  CONFIG — แก้ตรงนี้ได้เลย!
-- ================================================================
local CONFIG = {

    -- [ ข้อมูลทั่วไป ]
    HUB_NAME    = "UG Hub",               -- ชื่อโปรแกรม
    VERSION     = "v6.2",                 -- เวอร์ชั่น
    AUTHOR      = "regretevator638",       -- ชื่อผู้สร้าง
    DISCORD     = "discord.gg/v6Qh69hqd", -- ลิงค์ Discord

    -- [ UI เริ่มต้น ]
    DEFAULT_THEME            = "Dark",    -- ธีม: Dark Neon Minimal Sad Sunset Matrix Sakura Cyberpunk Ocean Blood Gold
    DEFAULT_BG_TRANSPARENCY  = 0.4,       -- ความโปร่งใสพื้นหลัง (0=ทึบ, 1=ใส)
    DEFAULT_FPS_COLOR        = {r=80, g=255, b=120}, -- สีตัวอักษร FPS
    DEFAULT_CORNER_RADIUS    = 10,        -- ความโค้งมน (0-20)
    GLOW_ENABLED             = true,      -- เปิด/ปิด Glow รอบ UI
    AUTO_COLOR               = true,      -- เปลี่ยนสีตาม FPS อัตโนมัติ

    -- [ ขนาด UI เริ่มต้น ]
    MAIN_WIDTH  = 220,
    MAIN_HEIGHT = 110,

    -- [ ระบบแจ้งเตือน ]
    FPS_WARN         = 20,    -- แจ้งเตือนเมื่อ FPS ต่ำกว่านี้
    PING_WARN        = 150,   -- แจ้งเตือนเมื่อ Ping สูงกว่านี้ (ms)
    AUTO_REJOIN_FPS  = 0,     -- Auto Rejoin เมื่อ FPS ต่ำกว่านี้ (0 = ปิด)
    UPDATE_INTERVAL  = 0.5,   -- ความเร็วอ่านค่า (วินาที)

    -- [ Whitelist — ใครบ้างที่เข้าได้นอกจากตัวเอง ]
    WHITELIST = {
        -- "username1",
        -- "username2",
    },

    -- [ แสดง/ซ่อนข้อมูลแต่ละอัน ]
    SHOW = {
        FPS        = true,
        PING       = true,
        MEMORY     = true,
        SERVER_FPS = true,
        NETWORK    = true,
        PLAYERS    = true,
        TIME       = true,
        CLOCK      = true,
        HEALTH     = true,
        WALKSPEED  = true,
        GAMEMODE   = true,
        FRAMETIME  = true,
    },

    -- [ Watermark จางๆ กลาง UI ]
    WATERMARK_ENABLED      = true,
    WATERMARK_TRANSPARENCY = 0.82, -- 0=เห็นชัด, 1=ซ่อน

    -- [ สีธีม Login Screen ]
    LOGIN_GLOW_COLOR = {r=100, g=200, b=255},
    LOGIN_TITLE_COLOR = {r=100, g=200, b=255},

    -- [ ตำแหน่ง UI เริ่มต้น (0-1) ]
    START_POS_X = 0.02,
    START_POS_Y = 0.08,
}
-- ================================================================
--                 โค้ดหลัก — ไม่ต้องแตะ!
-- ================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function getDeviceDetail()
    local platform = UserInputService:GetPlatform()
    local vp = workspace.CurrentCamera.ViewportSize
    local w = math.max(vp.X, vp.Y)
    local h = math.min(vp.X, vp.Y)
    if platform == Enum.Platform.IOS then
        if w >= 1024 then
            if w >= 2048 and h >= 1536 then return "iPad Pro 12.9\" 📱"
            elseif w >= 2360 and h >= 1640 then return "iPad Pro 11\" 📱"
            elseif w >= 2160 and h >= 1620 then return "iPad 10th Gen 📱"
            elseif w >= 2266 and h >= 1488 then return "iPad Mini 6 📱"
            else return "iPad 📱" end
        else
            if w >= 2796 then return "iPhone 14/15 Pro Max 📱"
            elseif w >= 2556 then return "iPhone 14/15 Pro 📱"
            elseif w >= 2532 then return "iPhone 14/15 📱"
            elseif w >= 2778 then return "iPhone 13 Pro Max 📱"
            elseif w >= 2340 then return "iPhone 13 mini 📱"
            elseif w >= 1792 then return "iPhone XR/11 📱"
            elseif w >= 1334 then return "iPhone SE/8/7 📱"
            else return "iPhone 📱" end
        end
    elseif platform == Enum.Platform.Android then
        if w >= 2960 then return "Android (QHD+) 📱"
        elseif w >= 2400 then return "Android (FHD+) 📱"
        elseif w >= 1920 then return "Android (FHD) 📱"
        else return "Android 📱" end
    elseif platform == Enum.Platform.Windows then
        if w >= 3840 then return "Windows (4K) 💻"
        elseif w >= 2560 then return "Windows (2K) 💻"
        elseif w >= 1920 then return "Windows (FHD) 💻"
        else return "Windows 💻" end
    elseif platform == Enum.Platform.OSX then
        return w >= 2560 and "MacBook Pro/Air 🖥️" or "Mac 🖥️"
    elseif platform == Enum.Platform.XBoxOne then return "Xbox 🎮"
    else return "Unknown ❓" end
end

-- Settings (โหลดจาก CONFIG เป็นค่าเริ่มต้น)
local settings = {
    posX             = CONFIG.START_POS_X,
    posY             = CONFIG.START_POS_Y,
    width            = CONFIG.MAIN_WIDTH,
    height           = CONFIG.MAIN_HEIGHT,
    textColor        = {r=CONFIG.DEFAULT_FPS_COLOR.r, g=CONFIG.DEFAULT_FPS_COLOR.g, b=CONFIG.DEFAULT_FPS_COLOR.b},
    bgTransparency   = CONFIG.DEFAULT_BG_TRANSPARENCY,
    autoColor        = CONFIG.AUTO_COLOR,
    theme            = CONFIG.DEFAULT_THEME,
    minimized        = false,
    fpsWarnThreshold = CONFIG.FPS_WARN,
    pingWarnThreshold= CONFIG.PING_WARN,
    updateInterval   = CONFIG.UPDATE_INTERVAL,
    locked           = false,
    saves            = {},
    sessionStart     = os.time(),
    glowEnabled      = CONFIG.GLOW_ENABLED,
    autoRejoinFps    = CONFIG.AUTO_REJOIN_FPS,
    cornerRadius     = CONFIG.DEFAULT_CORNER_RADIUS,
    showFps          = CONFIG.SHOW.FPS,
    showPing         = CONFIG.SHOW.PING,
    showMem          = CONFIG.SHOW.MEMORY,
    showSrv          = CONFIG.SHOW.SERVER_FPS,
    showNet          = CONFIG.SHOW.NETWORK,
    showPlayers      = CONFIG.SHOW.PLAYERS,
    showTime         = CONFIG.SHOW.TIME,
    showClock        = CONFIG.SHOW.CLOCK,
    showHealth       = CONFIG.SHOW.HEALTH,
    showWalkspeed    = CONFIG.SHOW.WALKSPEED,
    showGameMode     = CONFIG.SHOW.GAMEMODE,
    showFrameTime    = CONFIG.SHOW.FRAMETIME,
}

local themes = {
    Dark      ={bg=Color3.fromRGB(10,10,10),    text=Color3.fromRGB(255,255,255), glow=Color3.fromRGB(100,100,100)},
    Neon      ={bg=Color3.fromRGB(0,0,30),      text=Color3.fromRGB(0,255,255),   glow=Color3.fromRGB(0,255,255)},
    Minimal   ={bg=Color3.fromRGB(240,240,240), text=Color3.fromRGB(20,20,20),    glow=Color3.fromRGB(200,200,200)},
    Sad       ={bg=Color3.fromRGB(30,30,60),    text=Color3.fromRGB(150,170,255), glow=Color3.fromRGB(100,120,255)},
    Sunset    ={bg=Color3.fromRGB(60,20,10),    text=Color3.fromRGB(255,160,80),  glow=Color3.fromRGB(255,100,0)},
    Matrix    ={bg=Color3.fromRGB(0,15,0),      text=Color3.fromRGB(0,255,70),    glow=Color3.fromRGB(0,200,0)},
    Sakura    ={bg=Color3.fromRGB(60,20,35),    text=Color3.fromRGB(255,180,200), glow=Color3.fromRGB(255,100,150)},
    Cyberpunk ={bg=Color3.fromRGB(10,0,30),     text=Color3.fromRGB(255,0,200),   glow=Color3.fromRGB(200,0,255)},
    Ocean     ={bg=Color3.fromRGB(0,20,40),     text=Color3.fromRGB(0,200,255),   glow=Color3.fromRGB(0,150,255)},
    Blood     ={bg=Color3.fromRGB(30,0,0),      text=Color3.fromRGB(255,50,50),   glow=Color3.fromRGB(200,0,0)},
    Gold      ={bg=Color3.fromRGB(30,25,0),     text=Color3.fromRGB(255,210,0),   glow=Color3.fromRGB(255,180,0)},
}

local notifHistory = {}
local function addNotif(msg, color)
    table.insert(notifHistory, {t=os.time(), msg=msg, color=color or Color3.fromRGB(255,255,255)})
    if #notifHistory > 50 then table.remove(notifHistory, 1) end
end

local function loadSettings()
    local saved = playerGui:GetAttribute("UGHub_Settings")
    if saved then
        local ok, decoded = pcall(function() return HttpService:JSONDecode(saved) end)
        if ok and decoded then
            for k,v in pairs(decoded) do settings[k]=v end
        end
    end
end
local function saveSettings()
    local ok, encoded = pcall(function() return HttpService:JSONEncode(settings) end)
    if ok then playerGui:SetAttribute("UGHub_Settings", encoded) end
end
loadSettings()
settings.sessionStart = os.time()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UGHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

task.spawn(function()
    while task.wait(5) do
        for _,gui in ipairs(playerGui:GetChildren()) do
            if gui.Name=="UGHub" and gui~=screenGui then gui:Destroy() end
        end
    end
end)

local function makeLabel(parent,pos,size,textSize,bold,zidx)
    local l=Instance.new("TextLabel")
    l.Position=pos; l.Size=size; l.BackgroundTransparency=1
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize=textSize or 14; l.TextColor3=Color3.fromRGB(255,255,255)
    l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=zidx or 1; l.Parent=parent
    return l
end

local function makeBtn(parent,pos,size,text,bg,zidx)
    local b=Instance.new("TextButton")
    b.Position=pos; b.Size=size; b.BackgroundColor3=bg or Color3.fromRGB(50,50,50)
    b.BorderSizePixel=0; b.Text=text; b.TextSize=12
    b.TextColor3=Color3.fromRGB(255,255,255); b.Font=Enum.Font.GothamBold
    b.ZIndex=zidx or 1; b.Active=true; b.Parent=parent
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    return b
end

local function tweenFrame(frame,props,t)
    TweenService:Create(frame,TweenInfo.new(t or 0.2,Enum.EasingStyle.Quad),props):Play()
end

local function addDrag(frame,onEnd)
    local dragging,dragStart,startPos=false,nil,nil
    frame.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            if not settings.locked then dragging=true; dragStart=inp.Position; startPos=frame.Position end
        end
    end)
    frame.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            dragging=false; if onEnd then onEnd() end
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local delta=inp.Position-dragStart; local vp=screenGui.AbsoluteSize
            frame.Position=UDim2.new(startPos.X.Scale+delta.X/vp.X,0,startPos.Y.Scale+delta.Y/vp.Y,0)
        end
    end)
end

local function addResizeHandle(frame,minW,minH,zidx,onResized)
    local handle=Instance.new("TextButton")
    handle.Size=UDim2.new(0,16,0,16); handle.Position=UDim2.new(1,-16,1,-16)
    handle.BackgroundColor3=Color3.fromRGB(100,100,100); handle.BackgroundTransparency=0.4
    handle.BorderSizePixel=0; handle.Text="◢"; handle.TextSize=11
    handle.TextColor3=Color3.fromRGB(200,200,200); handle.Font=Enum.Font.GothamBold
    handle.ZIndex=zidx or 5; handle.Active=true; handle.Parent=frame
    Instance.new("UICorner",handle).CornerRadius=UDim.new(0,4)
    local resizing,resizeStart,startSize=false,nil,nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            resizing=true; resizeStart=inp.Position
            startSize=Vector2.new(frame.AbsoluteSize.X,frame.AbsoluteSize.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if resizing and (inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch) then
            resizing=false; if onResized then onResized() end
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if resizing and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local delta=inp.Position-resizeStart
            frame.Size=UDim2.new(0,math.max(minW,startSize.X+delta.X),0,math.max(minH,startSize.Y+delta.Y))
        end
    end)
end

local function addGlow(frame,color)
    local glow=Instance.new("UIStroke")
    glow.Color=color or Color3.fromRGB(100,100,100); glow.Thickness=1.5; glow.Transparency=0.3
    glow.Parent=frame; return glow
end

local function addWatermark(parent, zidx)
    if not CONFIG.WATERMARK_ENABLED then return end
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,0,1,0); lbl.Position=UDim2.new(0,0,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=CONFIG.HUB_NAME
    lbl.Font=Enum.Font.GothamBold; lbl.TextSize=18
    lbl.TextColor3=Color3.fromRGB(255,255,255)
    lbl.TextTransparency=CONFIG.WATERMARK_TRANSPARENCY
    lbl.TextXAlignment=Enum.TextXAlignment.Center
    lbl.TextYAlignment=Enum.TextYAlignment.Center
    lbl.ZIndex=zidx or 1; lbl.Parent=parent
    return lbl
end

-- ===== LOGIN SCREEN =====
local loginGlowColor = Color3.fromRGB(CONFIG.LOGIN_GLOW_COLOR.r, CONFIG.LOGIN_GLOW_COLOR.g, CONFIG.LOGIN_GLOW_COLOR.b)
local loginTitleColor = Color3.fromRGB(CONFIG.LOGIN_TITLE_COLOR.r, CONFIG.LOGIN_TITLE_COLOR.g, CONFIG.LOGIN_TITLE_COLOR.b)

local loginFrame=Instance.new("Frame")
loginFrame.Size=UDim2.new(0,280,0,355)
loginFrame.Position=UDim2.new(0.5,-140,0.5,-177)
loginFrame.BackgroundColor3=Color3.fromRGB(12,12,12)
loginFrame.BackgroundTransparency=1
loginFrame.BorderSizePixel=0; loginFrame.ZIndex=50
loginFrame.Active=true; loginFrame.Parent=screenGui
Instance.new("UICorner",loginFrame).CornerRadius=UDim.new(0,14)
addGlow(loginFrame, loginGlowColor)
tweenFrame(loginFrame,{BackgroundTransparency=0.05},0.4)

local avatarFrame=Instance.new("Frame")
avatarFrame.Size=UDim2.new(0,70,0,70); avatarFrame.Position=UDim2.new(0.5,-35,0,12)
avatarFrame.BackgroundColor3=Color3.fromRGB(30,30,30); avatarFrame.BorderSizePixel=0
avatarFrame.ZIndex=51; avatarFrame.Parent=loginFrame
Instance.new("UICorner",avatarFrame).CornerRadius=UDim.new(1,0)

local avatarImg=Instance.new("ImageLabel")
avatarImg.Size=UDim2.new(1,0,1,0); avatarImg.BackgroundTransparency=1
avatarImg.Image="rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"
avatarImg.ZIndex=52; avatarImg.Parent=avatarFrame
Instance.new("UICorner",avatarImg).CornerRadius=UDim.new(1,0)

local logoLabel=Instance.new("TextLabel")
logoLabel.Size=UDim2.new(1,0,0,30); logoLabel.Position=UDim2.new(0,0,0,88)
logoLabel.BackgroundTransparency=1
logoLabel.Text="🎯 "..CONFIG.HUB_NAME
logoLabel.Font=Enum.Font.GothamBold; logoLabel.TextSize=24
logoLabel.TextColor3=loginTitleColor
logoLabel.TextXAlignment=Enum.TextXAlignment.Center
logoLabel.ZIndex=51; logoLabel.Parent=loginFrame

local subLabel=Instance.new("TextLabel")
subLabel.Size=UDim2.new(1,0,0,18); subLabel.Position=UDim2.new(0,0,0,120)
subLabel.BackgroundTransparency=1
subLabel.Text="FPS Monitor Ultimate "..CONFIG.VERSION
subLabel.Font=Enum.Font.Gotham; subLabel.TextSize=11
subLabel.TextColor3=Color3.fromRGB(150,150,150)
subLabel.TextXAlignment=Enum.TextXAlignment.Center
subLabel.ZIndex=51; subLabel.Parent=loginFrame

local deviceLabel=Instance.new("TextLabel")
deviceLabel.Size=UDim2.new(1,-20,0,18); deviceLabel.Position=UDim2.new(0,10,0,140)
deviceLabel.BackgroundTransparency=1; deviceLabel.Text="📱 "..getDeviceDetail()
deviceLabel.Font=Enum.Font.Gotham; deviceLabel.TextSize=11
deviceLabel.TextColor3=loginTitleColor
deviceLabel.TextXAlignment=Enum.TextXAlignment.Center
deviceLabel.ZIndex=51; deviceLabel.Parent=loginFrame

local divider=Instance.new("Frame")
divider.Size=UDim2.new(1,-40,0,1); divider.Position=UDim2.new(0,20,0,163)
divider.BackgroundColor3=Color3.fromRGB(50,50,50); divider.BorderSizePixel=0
divider.ZIndex=51; divider.Parent=loginFrame

local userLbl=Instance.new("TextLabel")
userLbl.Size=UDim2.new(1,-20,0,18); userLbl.Position=UDim2.new(0,10,0,172)
userLbl.BackgroundTransparency=1; userLbl.Text="Roblox Username"
userLbl.Font=Enum.Font.Gotham; userLbl.TextSize=11
userLbl.TextColor3=Color3.fromRGB(180,180,180)
userLbl.TextXAlignment=Enum.TextXAlignment.Left
userLbl.ZIndex=51; userLbl.Parent=loginFrame

local inputBox=Instance.new("TextBox")
inputBox.Size=UDim2.new(1,-20,0,36); inputBox.Position=UDim2.new(0,10,0,192)
inputBox.BackgroundColor3=Color3.fromRGB(30,30,30); inputBox.BorderSizePixel=0
inputBox.Text=player.Name; inputBox.Font=Enum.Font.Gotham; inputBox.TextSize=13
inputBox.TextColor3=Color3.fromRGB(255,255,255)
inputBox.PlaceholderText="ใส่ชื่อ Roblox ของคุณ..."
inputBox.PlaceholderColor3=Color3.fromRGB(100,100,100)
inputBox.ZIndex=52; inputBox.Active=true; inputBox.ClearTextOnFocus=false
inputBox.Parent=loginFrame
Instance.new("UICorner",inputBox).CornerRadius=UDim.new(0,8)

inputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local name=inputBox.Text
    if name~="" then
        local ok,userId=pcall(function() return Players:GetUserIdFromNameAsync(name) end)
        if ok and userId then
            avatarImg.Image="rbxthumb://type=AvatarHeadShot&id="..userId.."&w=150&h=150"
        end
    end
end)

local statusLabel=Instance.new("TextLabel")
statusLabel.Size=UDim2.new(1,-20,0,18); statusLabel.Position=UDim2.new(0,10,0,232)
statusLabel.BackgroundTransparency=1; statusLabel.Text=""
statusLabel.Font=Enum.Font.Gotham; statusLabel.TextSize=11
statusLabel.TextColor3=Color3.fromRGB(255,80,80)
statusLabel.TextXAlignment=Enum.TextXAlignment.Center
statusLabel.ZIndex=51; statusLabel.Parent=loginFrame

local loginBtn=makeBtn(loginFrame,UDim2.new(0,10,0,254),UDim2.new(1,-20,0,40),"🔐 เข้าใช้งาน",Color3.fromRGB(40,130,220),51)
loginBtn.TextSize=14

local divider2=Instance.new("Frame")
divider2.Size=UDim2.new(1,-40,0,1); divider2.Position=UDim2.new(0,20,0,300)
divider2.BackgroundColor3=Color3.fromRGB(50,50,50); divider2.BorderSizePixel=0
divider2.ZIndex=51; divider2.Parent=loginFrame

local creditLabel=Instance.new("TextLabel")
creditLabel.Size=UDim2.new(1,0,0,14); creditLabel.Position=UDim2.new(0,0,0,306)
creditLabel.BackgroundTransparency=1
creditLabel.Text=CONFIG.HUB_NAME.." "..CONFIG.VERSION.." | by "..CONFIG.AUTHOR
creditLabel.Font=Enum.Font.Gotham; creditLabel.TextSize=10
creditLabel.TextColor3=Color3.fromRGB(80,80,80)
creditLabel.TextXAlignment=Enum.TextXAlignment.Center
creditLabel.ZIndex=51; creditLabel.Parent=loginFrame

local discordLabel=Instance.new("TextLabel")
discordLabel.Size=UDim2.new(1,0,0,16); discordLabel.Position=UDim2.new(0,0,0,322)
discordLabel.BackgroundTransparency=1
discordLabel.Text="💬 "..CONFIG.DISCORD
discordLabel.Font=Enum.Font.GothamBold; discordLabel.TextSize=11
discordLabel.TextColor3=Color3.fromRGB(88,101,242)
discordLabel.TextXAlignment=Enum.TextXAlignment.Center
discordLabel.ZIndex=51; discordLabel.Parent=loginFrame

-- ===== MAIN UI =====
local mainUI=Instance.new("Frame")
mainUI.Size=UDim2.new(1,0,1,0); mainUI.BackgroundTransparency=1
mainUI.Visible=false; mainUI.ZIndex=1; mainUI.Parent=screenGui

local mainCorner=Instance.new("UICorner")
local mainFrame=Instance.new("Frame")
mainFrame.Size=UDim2.new(0,settings.width,0,settings.height)
mainFrame.Position=UDim2.new(settings.posX,0,settings.posY,0)
mainFrame.BackgroundColor3=Color3.fromRGB(0,0,0)
mainFrame.BackgroundTransparency=settings.bgTransparency
mainFrame.BorderSizePixel=0; mainFrame.ClipsDescendants=true
mainFrame.Active=true; mainFrame.Parent=mainUI
mainCorner.CornerRadius=UDim.new(0,settings.cornerRadius); mainCorner.Parent=mainFrame
local mainGlow=addGlow(mainFrame,Color3.fromRGB(80,255,120))
if not settings.glowEnabled then mainGlow.Transparency=1 end
addWatermark(mainFrame, 1)

local fpsLabel    =makeLabel(mainFrame,UDim2.new(0,8,0,3),  UDim2.new(0.5,-10,0,16),13,true,2)
local pingLabel   =makeLabel(mainFrame,UDim2.new(0,8,0,21), UDim2.new(0.5,-10,0,12),11,false,2)
local memLabel    =makeLabel(mainFrame,UDim2.new(0.5,2,0,3), UDim2.new(0.5,-36,0,12),11,false,2)
local srvLabel    =makeLabel(mainFrame,UDim2.new(0.5,2,0,17),UDim2.new(0.5,-36,0,11),10,false,2)
local netLabel    =makeLabel(mainFrame,UDim2.new(0,8,0,35), UDim2.new(0.5,-10,0,11),10,false,2)
local pcLabel     =makeLabel(mainFrame,UDim2.new(0.5,2,0,31),UDim2.new(0.5,-36,0,11),10,false,2)
local timeLabel   =makeLabel(mainFrame,UDim2.new(0,8,0,48), UDim2.new(0.55,0,0,11),10,false,2)
local clockLabel  =makeLabel(mainFrame,UDim2.new(0.5,2,0,48),UDim2.new(0.5,-8,0,11),10,false,2)
local healthLabel =makeLabel(mainFrame,UDim2.new(0,8,0,61), UDim2.new(0.5,-10,0,11),10,false,2)
local wsLabel     =makeLabel(mainFrame,UDim2.new(0.5,2,0,61),UDim2.new(0.5,-36,0,11),10,false,2)
local gmLabel     =makeLabel(mainFrame,UDim2.new(0,8,0,74), UDim2.new(0.5,-10,0,11),10,false,2)
local ftLabel     =makeLabel(mainFrame,UDim2.new(0.5,2,0,74),UDim2.new(0.5,-36,0,11),10,false,2)

fpsLabel.Text="FPS: --"; pingLabel.Text="Ping: --"
memLabel.Text="MEM: --"; srvLabel.Text="SRV: --"
netLabel.Text="Net: --"; pcLabel.Text="👥--"
timeLabel.Text="🕐 0m"; clockLabel.Text="🕰️ --:--"
healthLabel.Text="❤️ --"; wsLabel.Text="🏃 --"
gmLabel.Text="🎮 --"; ftLabel.Text="⏱ --ms"

local settingsBtn =makeBtn(mainFrame,UDim2.new(1,-76,0,2),UDim2.new(0,20,0,18),"⚙",Color3.fromRGB(60,60,60),3)
local minBtn      =makeBtn(mainFrame,UDim2.new(1,-52,0,2),UDim2.new(0,20,0,18),"–",Color3.fromRGB(60,60,60),3)
local shotBtn     =makeBtn(mainFrame,UDim2.new(1,-28,0,2),UDim2.new(0,20,0,18),"📷",Color3.fromRGB(60,60,60),3)
local lockQuickBtn=makeBtn(mainFrame,UDim2.new(1,-76,0,22),UDim2.new(0,20,0,14),
    settings.locked and "🔒" or "🔓",
    settings.locked and Color3.fromRGB(200,80,80) or Color3.fromRGB(60,60,60),3)
lockQuickBtn.TextSize=10
lockQuickBtn.MouseButton1Click:Connect(function()
    settings.locked=not settings.locked
    lockQuickBtn.Text=settings.locked and "🔒" or "🔓"
    lockQuickBtn.BackgroundColor3=settings.locked and Color3.fromRGB(200,80,80) or Color3.fromRGB(60,60,60)
    saveSettings()
end)
shotBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible=false; task.delay(3,function() mainFrame.Visible=true end)
end)

local graphFrame=Instance.new("Frame")
graphFrame.Size=UDim2.new(1,0,0,20); graphFrame.Position=UDim2.new(0,0,1,-40)
graphFrame.BackgroundColor3=Color3.fromRGB(15,15,15); graphFrame.BackgroundTransparency=0.5
graphFrame.BorderSizePixel=0; graphFrame.ZIndex=2; graphFrame.Active=true; graphFrame.Parent=mainFrame

local graphBars={}
for i=1,40 do
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(1/40,-1,0,0); bar.Position=UDim2.new((i-1)/40,0,1,0)
    bar.BackgroundColor3=Color3.fromRGB(80,255,120); bar.BorderSizePixel=0
    bar.AnchorPoint=Vector2.new(0,1); bar.ZIndex=3; bar.Parent=graphFrame
    graphBars[i]=bar
end

local pingGraphFrame=Instance.new("Frame")
pingGraphFrame.Size=UDim2.new(1,0,0,20); pingGraphFrame.Position=UDim2.new(0,0,1,-20)
pingGraphFrame.BackgroundColor3=Color3.fromRGB(10,10,30); pingGraphFrame.BackgroundTransparency=0.5
pingGraphFrame.BorderSizePixel=0; pingGraphFrame.ZIndex=2; pingGraphFrame.Active=true; pingGraphFrame.Parent=mainFrame

local pingGraphBars={}
for i=1,40 do
    local bar=Instance.new("Frame")
    bar.Size=UDim2.new(1/40,-1,0,0); bar.Position=UDim2.new((i-1)/40,0,1,0)
    bar.BackgroundColor3=Color3.fromRGB(100,180,255); bar.BorderSizePixel=0
    bar.AnchorPoint=Vector2.new(0,1); bar.ZIndex=3; bar.Parent=pingGraphFrame
    pingGraphBars[i]=bar
end

local fpsHistory,pingHistory,fpsLog={},{},{}
local function updateGraph(fps,ping)
    table.insert(fpsHistory,fps); table.insert(fpsLog,{t=os.time(),v=fps})
    table.insert(pingHistory,ping or 0)
    if #fpsHistory>40 then table.remove(fpsHistory,1) end
    if #pingHistory>40 then table.remove(pingHistory,1) end
    if #fpsLog>300 then table.remove(fpsLog,1) end
    for i,bar in ipairs(graphBars) do
        local val=fpsHistory[i] or 0
        bar.Size=UDim2.new(1/40,-1,math.clamp(val/60,0,1),0)
        bar.BackgroundColor3=val>=60 and Color3.fromRGB(80,255,120) or val>=30 and Color3.fromRGB(255,210,50) or Color3.fromRGB(255,70,70)
    end
    for i,bar in ipairs(pingGraphBars) do
        local val=pingHistory[i] or 0
        bar.Size=UDim2.new(1/40,-1,math.clamp(val/200,0,1),0)
        bar.BackgroundColor3=val<80 and Color3.fromRGB(80,255,120) or val<150 and Color3.fromRGB(255,210,50) or Color3.fromRGB(255,70,70)
    end
end

local rejoinBtn=makeBtn(mainFrame,UDim2.new(0,4,1,-18),UDim2.new(1,-8,0,16),"🔄 Rejoin",Color3.fromRGB(40,100,200),3)
rejoinBtn.TextSize=10
rejoinBtn.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId,player) end)

addResizeHandle(mainFrame,150,90,4,function() settings.width=mainFrame.AbsoluteSize.X; settings.height=mainFrame.AbsoluteSize.Y; saveSettings() end)
addDrag(mainFrame,function() settings.posX=mainFrame.Position.X.Scale; settings.posY=mainFrame.Position.Y.Scale; saveSettings() end)

local miniFrame=Instance.new("Frame")
miniFrame.Size=UDim2.new(0,72,0,22); miniFrame.Position=mainFrame.Position
miniFrame.BackgroundColor3=Color3.fromRGB(0,0,0); miniFrame.BackgroundTransparency=0.4
miniFrame.BorderSizePixel=0; miniFrame.Visible=false; miniFrame.ZIndex=10
miniFrame.Active=true; miniFrame.Parent=mainUI
Instance.new("UICorner",miniFrame).CornerRadius=UDim.new(0,8)
local miniFpsLabel=makeLabel(miniFrame,UDim2.new(0,0,0,0),UDim2.new(1,0,1,0),13,true,11)
miniFpsLabel.TextXAlignment=Enum.TextXAlignment.Center; miniFpsLabel.Text="FPS: --"
addDrag(miniFrame,function() mainFrame.Position=miniFrame.Position; settings.posX=miniFrame.Position.X.Scale; settings.posY=miniFrame.Position.Y.Scale; saveSettings() end)

local miniMode=false
local function setMiniMode(val)
    miniMode=val; miniFrame.Visible=val; mainFrame.Visible=not val
    if val then miniFrame.Position=mainFrame.Position end
end

local expanded=not settings.minimized
local function setExpanded(val)
    expanded=val; minBtn.Text=expanded and "–" or "+"
    local targetH=expanded and settings.height or 42
    tweenFrame(mainFrame,{Size=UDim2.new(0,settings.width,0,targetH)},0.2)
    graphFrame.Visible=expanded; pingGraphFrame.Visible=expanded; rejoinBtn.Visible=expanded
    settings.minimized=not expanded; saveSettings()
end
setExpanded(expanded)
minBtn.MouseButton1Click:Connect(function() setExpanded(not expanded) end)

UserInputService.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.F3 then
        if miniMode then setMiniMode(false) else mainFrame.Visible=not mainFrame.Visible end
    elseif inp.KeyCode==Enum.KeyCode.F4 then setMiniMode(not miniMode) end
end)

-- Settings Panel
local PANEL_W=240
local panel=Instance.new("Frame")
panel.Size=UDim2.new(0,PANEL_W,0,300); panel.Position=UDim2.new(0.5,-PANEL_W/2,0.5,-150)
panel.BackgroundColor3=Color3.fromRGB(18,18,18); panel.BackgroundTransparency=1
panel.BorderSizePixel=0; panel.Visible=false; panel.ZIndex=20
panel.ClipsDescendants=true; panel.Active=true; panel.Parent=mainUI
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,12)
local panelGlow=addGlow(panel,loginGlowColor)
addWatermark(panel, 20)

local function showPanel()
    panel.Visible=true; panel.BackgroundTransparency=1
    tweenFrame(panel,{BackgroundTransparency=0.05},0.2)
end
local function hidePanel()
    tweenFrame(panel,{BackgroundTransparency=1},0.15)
    task.delay(0.15,function() panel.Visible=false end)
end

local header=Instance.new("Frame")
header.Size=UDim2.new(1,0,0,36); header.BackgroundColor3=Color3.fromRGB(30,30,30)
header.BorderSizePixel=0; header.ZIndex=21; header.Active=true; header.Parent=panel
Instance.new("UICorner",header).CornerRadius=UDim.new(0,12)

local pTitle=makeLabel(header,UDim2.new(0,10,0,0),UDim2.new(1,-40,1,0),14,true,22)
pTitle.Text="⚙ "..CONFIG.HUB_NAME.." "..CONFIG.VERSION

local closeBtn=makeBtn(header,UDim2.new(1,-34,0,4),UDim2.new(0,28,0,28),"✕",Color3.fromRGB(200,60,60),22)
closeBtn.MouseButton1Click:Connect(function() hidePanel() end)
addDrag(panel,nil)
addResizeHandle(panel,200,260,22,function() saveSettings() end)

local tabBar=Instance.new("Frame")
tabBar.Size=UDim2.new(1,0,0,32); tabBar.Position=UDim2.new(0,0,0,36)
tabBar.BackgroundColor3=Color3.fromRGB(25,25,25)
tabBar.BorderSizePixel=0; tabBar.ZIndex=21; tabBar.Active=true; tabBar.Parent=panel

local tabNames={"🎨","⚙️","🎭","💾","👁️","👤","📊","🔔"}
local tabLabels={"Color","System","Theme","Saves","Toggle","Info","Log","Notif"}
local tabPages={}
local tabBtns={}

for i,icon in ipairs(tabNames) do
    local tb=makeBtn(tabBar,UDim2.new((i-1)/8,1,0,2),UDim2.new(1/8,-2,1,-4),icon,Color3.fromRGB(40,40,40),22)
    tb.TextSize=12; tabBtns[i]=tb
    local tl=makeLabel(tb,UDim2.new(0,0,0.5,2),UDim2.new(1,0,0,8),6,false,23)
    tl.Text=tabLabels[i]; tl.TextXAlignment=Enum.TextXAlignment.Center; tl.TextColor3=Color3.fromRGB(180,180,180)
    local page=Instance.new("Frame")
    page.Size=UDim2.new(1,0,1,-68); page.Position=UDim2.new(0,0,0,68)
    page.BackgroundTransparency=1; page.BorderSizePixel=0; page.ZIndex=21
    page.Visible=(i==1); page.ClipsDescendants=true; page.Active=true; page.Parent=panel
    tabPages[i]=page
end

local function switchTab(idx)
    for i,page in ipairs(tabPages) do
        page.Visible=(i==idx)
        tabBtns[i].BackgroundColor3=i==idx and Color3.fromRGB(60,180,100) or Color3.fromRGB(40,40,40)
    end
end
for i,tb in ipairs(tabBtns) do tb.MouseButton1Click:Connect(function() switchTab(i) end) end
switchTab(1)

local function createSlider(parent,labelText,yPos,minVal,maxVal,currentVal,step,zIdx,callback)
    local lbl=makeLabel(parent,UDim2.new(0,10,0,yPos),UDim2.new(1,-60,0,15),11,false,zIdx); lbl.Text=labelText
    local valLbl=makeLabel(parent,UDim2.new(1,-48,0,yPos),UDim2.new(0,40,0,15),11,true,zIdx)
    valLbl.Text=tostring(currentVal); valLbl.TextColor3=Color3.fromRGB(100,180,255); valLbl.TextXAlignment=Enum.TextXAlignment.Right
    local track=Instance.new("Frame")
    track.Size=UDim2.new(1,-20,0,5); track.Position=UDim2.new(0,10,0,yPos+17)
    track.BackgroundColor3=Color3.fromRGB(55,55,55); track.BorderSizePixel=0
    track.ZIndex=zIdx; track.Active=true; track.Parent=parent
    Instance.new("UICorner",track).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame")
    fill.Size=UDim2.new((currentVal-minVal)/(maxVal-minVal),0,1,0)
    fill.BackgroundColor3=Color3.fromRGB(100,180,255); fill.BorderSizePixel=0
    fill.ZIndex=zIdx+1; fill.Active=true; fill.Parent=track
    Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("TextButton")
    knob.Size=UDim2.new(0,14,0,14)
    knob.Position=UDim2.new((currentVal-minVal)/(maxVal-minVal),-7,0.5,-7)
    knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0
    knob.Text=""; knob.ZIndex=zIdx+2; knob.Active=true; knob.Parent=track
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local sliding=false
    knob.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then sliding=true end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then sliding=false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local rel=math.clamp((inp.Position.X-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
            local val=math.round((minVal+rel*(maxVal-minVal))/step)*step
            val=math.clamp(val,minVal,maxVal)
            local r=(val-minVal)/(maxVal-minVal)
            fill.Size=UDim2.new(r,0,1,0); knob.Position=UDim2.new(r,-7,0.5,-7)
            valLbl.Text=tostring(math.round(val*10)/10); callback(val)
        end
    end)
end

-- Tab 1: Color
local colorPage=tabPages[1]
local autoBtn
createSlider(colorPage,"🔴 Red",4,0,255,settings.textColor.r,1,22,function(v) settings.textColor.r=v; settings.autoColor=false; fpsLabel.TextColor3=Color3.fromRGB(settings.textColor.r,settings.textColor.g,settings.textColor.b); saveSettings() end)
createSlider(colorPage,"🟢 Green",44,0,255,settings.textColor.g,1,22,function(v) settings.textColor.g=v; settings.autoColor=false; fpsLabel.TextColor3=Color3.fromRGB(settings.textColor.r,settings.textColor.g,settings.textColor.b); saveSettings() end)
createSlider(colorPage,"🔵 Blue",84,0,255,settings.textColor.b,1,22,function(v) settings.textColor.b=v; settings.autoColor=false; fpsLabel.TextColor3=Color3.fromRGB(settings.textColor.r,settings.textColor.g,settings.textColor.b); saveSettings() end)
createSlider(colorPage,"⬜ BG Opacity",124,0,100,(1-settings.bgTransparency)*100,1,22,function(v) settings.bgTransparency=1-(v/100); mainFrame.BackgroundTransparency=settings.bgTransparency; saveSettings() end)
createSlider(colorPage,"🔵 Corner Radius",164,0,20,settings.cornerRadius,1,22,function(v) settings.cornerRadius=v; mainCorner.CornerRadius=UDim.new(0,v); saveSettings() end)
autoBtn=makeBtn(colorPage,UDim2.new(0,10,0,206),UDim2.new(0.48,0,0,24),"Auto Color: "..(settings.autoColor and "ON" or "OFF"),settings.autoColor and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80),22)
autoBtn.TextSize=10
autoBtn.MouseButton1Click:Connect(function()
    settings.autoColor=not settings.autoColor
    autoBtn.BackgroundColor3=settings.autoColor and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80)
    autoBtn.Text="Auto Color: "..(settings.autoColor and "ON" or "OFF"); saveSettings()
end)
local glowBtn=makeBtn(colorPage,UDim2.new(0.5,4,0,206),UDim2.new(0.5,-14,0,24),"✨ Glow: "..(settings.glowEnabled and "ON" or "OFF"),settings.glowEnabled and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80),22)
glowBtn.TextSize=10
glowBtn.MouseButton1Click:Connect(function()
    settings.glowEnabled=not settings.glowEnabled
    mainGlow.Transparency=settings.glowEnabled and 0.3 or 1
    glowBtn.BackgroundColor3=settings.glowEnabled and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80)
    glowBtn.Text="✨ Glow: "..(settings.glowEnabled and "ON" or "OFF"); saveSettings()
end)

-- Tab 2: System
local sysPage=tabPages[2]
createSlider(sysPage,"⚡ Update Speed (วิ)",4,0.1,2.0,settings.updateInterval,0.1,22,function(v) settings.updateInterval=v; saveSettings() end)
createSlider(sysPage,"⚠️ FPS Warn",44,5,60,settings.fpsWarnThreshold,1,22,function(v) settings.fpsWarnThreshold=v; saveSettings() end)
createSlider(sysPage,"📡 Ping Warn (ms)",84,50,500,settings.pingWarnThreshold,10,22,function(v) settings.pingWarnThreshold=v; saveSettings() end)
createSlider(sysPage,"🔄 Auto Rejoin FPS",124,0,30,settings.autoRejoinFps,1,22,function(v) settings.autoRejoinFps=v; saveSettings() end)
local lockBtn=makeBtn(sysPage,UDim2.new(0,10,0,168),UDim2.new(0.48,0,0,24),settings.locked and "🔒 Locked" or "🔓 Unlocked",settings.locked and Color3.fromRGB(200,80,80) or Color3.fromRGB(60,60,60),22)
lockBtn.TextSize=10
lockBtn.MouseButton1Click:Connect(function()
    settings.locked=not settings.locked
    lockBtn.Text=settings.locked and "🔒 Locked" or "🔓 Unlocked"
    lockBtn.BackgroundColor3=settings.locked and Color3.fromRGB(200,80,80) or Color3.fromRGB(60,60,60)
    lockQuickBtn.Text=settings.locked and "🔒" or "🔓"
    lockQuickBtn.BackgroundColor3=settings.locked and Color3.fromRGB(200,80,80) or Color3.fromRGB(60,60,60)
    saveSettings()
end)
local miniModeBtn=makeBtn(sysPage,UDim2.new(0.5,4,0,168),UDim2.new(0.5,-14,0,24),"📌 Mini (F4)",Color3.fromRGB(100,60,160),22)
miniModeBtn.TextSize=10; miniModeBtn.MouseButton1Click:Connect(function() setMiniMode(not miniMode) end)
local rejoinSysBtn=makeBtn(sysPage,UDim2.new(0,10,0,198),UDim2.new(1,-20,0,24),"🔄 Rejoin Game",Color3.fromRGB(40,100,200),22)
rejoinSysBtn.TextSize=10; rejoinSysBtn.MouseButton1Click:Connect(function() TeleportService:Teleport(game.PlaceId,player) end)

-- Tab 3: Theme
local themePage=tabPages[3]
local themeNames={"Dark","Neon","Minimal","Sad","Sunset","Matrix","Sakura","Cyberpunk","Ocean","Blood","Gold"}
local themeBtns={}
for i,name in ipairs(themeNames) do
    local col=(i-1)%2; local row=math.floor((i-1)/2)
    local tb=makeBtn(themePage,UDim2.new(col*0.5,col==0 and 8 or 4,0,4+row*28),UDim2.new(0.5,-12,0,22),name,settings.theme==name and Color3.fromRGB(60,180,100) or Color3.fromRGB(50,50,50),22)
    tb.TextSize=11; themeBtns[name]=tb
    tb.MouseButton1Click:Connect(function()
        settings.theme=name
        local t=themes[name]
        mainFrame.BackgroundColor3=t.bg; panel.BackgroundColor3=t.bg
        mainGlow.Color=t.glow; panelGlow.Color=t.glow
        for _,l in ipairs({fpsLabel,pingLabel,memLabel,srvLabel,netLabel,pcLabel,timeLabel,clockLabel,healthLabel,wsLabel,gmLabel,ftLabel,miniFpsLabel}) do l.TextColor3=t.text end
        for n,b in pairs(themeBtns) do b.BackgroundColor3=n==name and Color3.fromRGB(60,180,100) or Color3.fromRGB(50,50,50) end
        saveSettings()
    end)
end

-- Tab 4: Named Saves
local savesPage=tabPages[4]
local savesScroll=Instance.new("ScrollingFrame")
savesScroll.Size=UDim2.new(1,-8,1,-80); savesScroll.Position=UDim2.new(0,4,0,4)
savesScroll.BackgroundTransparency=1; savesScroll.BorderSizePixel=0
savesScroll.ScrollBarThickness=4; savesScroll.ZIndex=22; savesScroll.Active=true; savesScroll.Parent=savesPage
local savesLayout=Instance.new("UIListLayout"); savesLayout.SortOrder=Enum.SortOrder.LayoutOrder; savesLayout.Padding=UDim.new(0,3); savesLayout.Parent=savesScroll

local saveNameBox=Instance.new("TextBox")
saveNameBox.Size=UDim2.new(1,-76,0,26); saveNameBox.Position=UDim2.new(0,8,1,-62)
saveNameBox.BackgroundColor3=Color3.fromRGB(30,30,30); saveNameBox.BorderSizePixel=0
saveNameBox.Text=""; saveNameBox.Font=Enum.Font.Gotham; saveNameBox.TextSize=11
saveNameBox.TextColor3=Color3.fromRGB(255,255,255)
saveNameBox.PlaceholderText="ตั้งชื่อ Save..."; saveNameBox.PlaceholderColor3=Color3.fromRGB(100,100,100)
saveNameBox.ZIndex=22; saveNameBox.Active=true; saveNameBox.ClearTextOnFocus=false
saveNameBox.Parent=savesPage
Instance.new("UICorner",saveNameBox).CornerRadius=UDim.new(0,6)

local saveStatusLbl=makeLabel(savesPage,UDim2.new(0,8,1,-30),UDim2.new(1,-16,0,22),10,false,22)
saveStatusLbl.Text=""; saveStatusLbl.TextXAlignment=Enum.TextXAlignment.Center; saveStatusLbl.TextColor3=Color3.fromRGB(80,255,120)

local refreshSavesList
local doSaveBtn=makeBtn(savesPage,UDim2.new(1,-66,1,-62),UDim2.new(0,58,0,26),"💾 Save",Color3.fromRGB(40,130,60),22)
doSaveBtn.TextSize=10
doSaveBtn.MouseButton1Click:Connect(function()
    local name=saveNameBox.Text:gsub("%s+","")
    if name=="" then name="Save "..tostring(#settings.saves+1) end
    table.insert(settings.saves,{name=name,textColor={r=settings.textColor.r,g=settings.textColor.g,b=settings.textColor.b},bgTransparency=settings.bgTransparency,autoColor=settings.autoColor,theme=settings.theme,glowEnabled=settings.glowEnabled,cornerRadius=settings.cornerRadius})
    saveNameBox.Text=""; saveSettings(); refreshSavesList()
    saveStatusLbl.Text="✅ บันทึก '"..name.."' แล้ว!"; task.delay(2,function() saveStatusLbl.Text="" end)
end)

refreshSavesList=function()
    for _,c in ipairs(savesScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for i,sv in ipairs(settings.saves) do
        local row=Instance.new("Frame")
        row.Size=UDim2.new(1,0,0,30); row.BackgroundColor3=Color3.fromRGB(28,28,28)
        row.BackgroundTransparency=0.2; row.BorderSizePixel=0; row.ZIndex=22; row.LayoutOrder=i; row.Parent=savesScroll
        Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
        local nameLbl=makeLabel(row,UDim2.new(0,8,0,0),UDim2.new(1,-96,1,0),10,true,23)
        nameLbl.Text="📁 "..sv.name; nameLbl.TextColor3=Color3.fromRGB(200,220,255)
        local loadB=makeBtn(row,UDim2.new(1,-92,0,4),UDim2.new(0,40,0,22),"Load",Color3.fromRGB(40,100,200),23)
        loadB.TextSize=10
        loadB.MouseButton1Click:Connect(function()
            settings.textColor=sv.textColor; settings.bgTransparency=sv.bgTransparency
            settings.autoColor=sv.autoColor; settings.theme=sv.theme or "Dark"
            settings.glowEnabled=sv.glowEnabled~=nil and sv.glowEnabled or true
            settings.cornerRadius=sv.cornerRadius or 10
            mainFrame.BackgroundTransparency=settings.bgTransparency
            mainCorner.CornerRadius=UDim.new(0,settings.cornerRadius)
            local t=themes[settings.theme] or themes.Dark
            mainFrame.BackgroundColor3=t.bg; panel.BackgroundColor3=t.bg
            mainGlow.Color=t.glow; mainGlow.Transparency=settings.glowEnabled and 0.3 or 1
            fpsLabel.TextColor3=Color3.fromRGB(settings.textColor.r,settings.textColor.g,settings.textColor.b)
            autoBtn.Text="Auto Color: "..(settings.autoColor and "ON" or "OFF")
            autoBtn.BackgroundColor3=settings.autoColor and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80)
            glowBtn.Text="✨ Glow: "..(settings.glowEnabled and "ON" or "OFF")
            glowBtn.BackgroundColor3=settings.glowEnabled and Color3.fromRGB(60,180,100) or Color3.fromRGB(80,80,80)
            for n,b in pairs(themeBtns) do b.BackgroundColor3=n==settings.theme and Color3.fromRGB(60,180,100) or Color3.fromRGB(50,50,50) end
            saveSettings()
            saveStatusLbl.Text="✅ โหลด '"..sv.name.."' แล้ว!"; task.delay(2,function() saveStatusLbl.Text="" end)
        end)
        local delB=makeBtn(row,UDim2.new(1,-48,0,4),UDim2.new(0,40,0,22),"🗑️",Color3.fromRGB(150,40,40),23)
        delB.TextSize=10
        delB.MouseButton1Click:Connect(function()
            local n=sv.name; table.remove(settings.saves,i); saveSettings(); refreshSavesList()
            saveStatusLbl.Text="🗑️ ลบ '"..n.."' แล้ว"; task.delay(2,function() saveStatusLbl.Text="" end)
        end)
    end
    savesScroll.CanvasSize=UDim2.new(0,0,0,#settings.saves*33)
end
refreshSavesList()

-- Tab 5: Toggle
local togglePage=tabPages[5]
local toggleItems={{"showFps","FPS"},{"showPing","Ping"},{"showMem","Memory"},{"showSrv","Server FPS"},{"showNet","Network"},{"showPlayers","Players"},{"showTime","Session Time"},{"showClock","Clock"},{"showHealth","Health"},{"showWalkspeed","Walkspeed"},{"showGameMode","Game Mode"},{"showFrameTime","Frame Time"}}
for i,item in ipairs(toggleItems) do
    local key,name=item[1],item[2]
    local col=(i-1)%2; local row=math.floor((i-1)/2)
    local tb=makeBtn(togglePage,UDim2.new(col*0.5,col==0 and 8 or 4,0,4+row*28),UDim2.new(0.5,-12,0,22),(settings[key] and "✅ " or "❌ ")..name,settings[key] and Color3.fromRGB(40,100,40) or Color3.fromRGB(80,40,40),22)
    tb.TextSize=10
    tb.MouseButton1Click:Connect(function()
        settings[key]=not settings[key]
        tb.Text=(settings[key] and "✅ " or "❌ ")..name
        tb.BackgroundColor3=settings[key] and Color3.fromRGB(40,100,40) or Color3.fromRGB(80,40,40)
        saveSettings()
    end)
end

-- Tab 6: Info
local infoPage=tabPages[6]
local vp=workspace.CurrentCamera.ViewportSize
local infoData={
    {"👤 User", player.Name},{"📱 Device", getDeviceDetail()},
    {"📐 Resolution", math.round(vp.X).."x"..math.round(vp.Y)},
    {"🎮 Place", tostring(game.PlaceId)},{"📦 Version", tostring(game.PlaceVersion)},
    {"🌐 Server", game.JobId~="" and game.JobId:sub(1,8).."..." or "Studio"},
    {"👥 Players", tostring(#Players:GetPlayers()).."/"..tostring(game.Players.MaxPlayers)},
    {"⭐ VIP", game.VIPServerId~="" and "Yes ✅" or "No ❌"},
    {"💬 Discord", CONFIG.DISCORD},
    {"🔧 Hub", CONFIG.HUB_NAME.." "..CONFIG.VERSION},
}
for i,info in ipairs(infoData) do
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,-16,0,22); row.Position=UDim2.new(0,8,0,(i-1)*25)
    row.BackgroundColor3=Color3.fromRGB(30,30,30); row.BackgroundTransparency=0.3
    row.BorderSizePixel=0; row.ZIndex=22; row.Parent=infoPage
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,5)
    local kl=makeLabel(row,UDim2.new(0,6,0,0),UDim2.new(0.5,0,1,0),10,true,23); kl.Text=info[1]; kl.TextColor3=Color3.fromRGB(180,180,180)
    local vll=makeLabel(row,UDim2.new(0.5,0,0,0),UDim2.new(0.5,-6,1,0),10,false,23); vll.Text=info[2]; vll.TextXAlignment=Enum.TextXAlignment.Right
    vll.TextColor3=info[1]=="💬 Discord" and Color3.fromRGB(88,101,242) or Color3.fromRGB(100,200,255)
end

-- Tab 7: Log
local logPage=tabPages[7]
local logScroll=Instance.new("ScrollingFrame")
logScroll.Size=UDim2.new(1,-8,1,-60); logScroll.Position=UDim2.new(0,4,0,4)
logScroll.BackgroundTransparency=1; logScroll.BorderSizePixel=0
logScroll.ScrollBarThickness=4; logScroll.ZIndex=22; logScroll.Active=true; logScroll.Parent=logPage
Instance.new("UIListLayout",logScroll).SortOrder=Enum.SortOrder.LayoutOrder
local clearLogBtn=makeBtn(logPage,UDim2.new(0,8,1,-54),UDim2.new(0.5,-12,0,22),"🗑️ Clear",Color3.fromRGB(150,50,50),22)
clearLogBtn.TextSize=10
clearLogBtn.MouseButton1Click:Connect(function()
    for _,c in ipairs(logScroll:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    table.clear(fpsLog)
end)
local exportBtn=makeBtn(logPage,UDim2.new(0.5,4,1,-54),UDim2.new(0.5,-12,0,22),"📋 Export",Color3.fromRGB(60,100,160),22)
exportBtn.TextSize=10
local exportBox=Instance.new("TextBox")
exportBox.Size=UDim2.new(1,-16,0,24); exportBox.Position=UDim2.new(0,8,1,-28)
exportBox.BackgroundColor3=Color3.fromRGB(20,20,20); exportBox.BorderSizePixel=0
exportBox.Text="กด Export แล้วก็อปตรงนี้"; exportBox.Font=Enum.Font.Gotham; exportBox.TextSize=9
exportBox.TextColor3=Color3.fromRGB(180,180,180); exportBox.ZIndex=22; exportBox.Active=true
exportBox.ClearTextOnFocus=false; exportBox.Parent=logPage
Instance.new("UICorner",exportBox).CornerRadius=UDim.new(0,4)
exportBtn.MouseButton1Click:Connect(function()
    local lines={}
    for _,entry in ipairs(fpsLog) do table.insert(lines, os.date("%H:%M:%S",entry.t)..": "..entry.v.." FPS") end
    exportBox.Text=table.concat(lines,", ")
end)
local function updateLogDisplay()
    for _,c in ipairs(logScroll:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    local count=0
    for i=#fpsLog,math.max(1,#fpsLog-29),-1 do
        local entry=fpsLog[i]
        local lbl=Instance.new("TextLabel")
        lbl.Size=UDim2.new(1,0,0,16); lbl.BackgroundTransparency=count%2==0 and 0.8 or 1
        lbl.BackgroundColor3=Color3.fromRGB(30,30,30); lbl.Font=Enum.Font.Gotham; lbl.TextSize=10
        lbl.Text=os.date("%H:%M:%S",entry.t).." → FPS: "..entry.v
        lbl.TextColor3=entry.v>=60 and Color3.fromRGB(80,255,120) or entry.v>=30 and Color3.fromRGB(255,210,50) or Color3.fromRGB(255,70,70)
        lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=23; lbl.LayoutOrder=count; lbl.Parent=logScroll
        count+=1
    end
    logScroll.CanvasSize=UDim2.new(0,0,0,count*16)
end

-- Tab 8: Notif
local notifPage=tabPages[8]
local notifScroll=Instance.new("ScrollingFrame")
notifScroll.Size=UDim2.new(1,-8,1,-36); notifScroll.Position=UDim2.new(0,4,0,4)
notifScroll.BackgroundTransparency=1; notifScroll.BorderSizePixel=0
notifScroll.ScrollBarThickness=4; notifScroll.ZIndex=22; notifScroll.Active=true; notifScroll.Parent=notifPage
Instance.new("UIListLayout",notifScroll).SortOrder=Enum.SortOrder.LayoutOrder
local clearNotifBtn=makeBtn(notifPage,UDim2.new(0,8,1,-30),UDim2.new(1,-16,0,22),"🗑️ Clear Notifications",Color3.fromRGB(150,50,50),22)
clearNotifBtn.TextSize=10
clearNotifBtn.MouseButton1Click:Connect(function()
    for _,c in ipairs(notifScroll:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    table.clear(notifHistory)
end)
local function updateNotifDisplay()
    for _,c in ipairs(notifScroll:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    local count=0
    for i=#notifHistory,math.max(1,#notifHistory-29),-1 do
        local entry=notifHistory[i]
        local lbl=Instance.new("TextLabel")
        lbl.Size=UDim2.new(1,0,0,16); lbl.BackgroundTransparency=count%2==0 and 0.8 or 1
        lbl.BackgroundColor3=Color3.fromRGB(30,30,30); lbl.Font=Enum.Font.Gotham; lbl.TextSize=9
        lbl.Text=os.date("%H:%M:%S",entry.t).." "..entry.msg
        lbl.TextColor3=entry.color; lbl.TextXAlignment=Enum.TextXAlignment.Left
        lbl.ZIndex=23; lbl.LayoutOrder=count; lbl.Parent=notifScroll
        count+=1
    end
    notifScroll.CanvasSize=UDim2.new(0,0,0,count*16)
end

settingsBtn.MouseButton1Click:Connect(function() if panel.Visible then hidePanel() else showPanel() end end)
tabBtns[7].MouseButton1Click:Connect(function() updateLogDisplay() end)
tabBtns[8].MouseButton1Click:Connect(function() updateNotifDisplay() end)
tabBtns[4].MouseButton1Click:Connect(function() refreshSavesList() end)

-- Warning
local warnFrame=Instance.new("Frame")
warnFrame.Size=UDim2.new(0,220,0,32); warnFrame.Position=UDim2.new(0.5,-110,0,52)
warnFrame.BackgroundColor3=Color3.fromRGB(200,50,50); warnFrame.BackgroundTransparency=0.2
warnFrame.BorderSizePixel=0; warnFrame.Visible=false; warnFrame.ZIndex=30
warnFrame.Active=true; warnFrame.Parent=mainUI
Instance.new("UICorner",warnFrame).CornerRadius=UDim.new(0,8)
local warnLabel=makeLabel(warnFrame,UDim2.new(0,0,0,0),UDim2.new(1,0,1,0),11,true,31)
warnLabel.Text="⚠️"; warnLabel.TextColor3=Color3.fromRGB(255,255,255); warnLabel.TextXAlignment=Enum.TextXAlignment.Center

local pingWarnFrame=Instance.new("Frame")
pingWarnFrame.Size=UDim2.new(0,220,0,32); pingWarnFrame.Position=UDim2.new(0.5,-110,0,88)
pingWarnFrame.BackgroundColor3=Color3.fromRGB(200,120,0); pingWarnFrame.BackgroundTransparency=0.2
pingWarnFrame.BorderSizePixel=0; pingWarnFrame.Visible=false; pingWarnFrame.ZIndex=30
pingWarnFrame.Active=true; pingWarnFrame.Parent=mainUI
Instance.new("UICorner",pingWarnFrame).CornerRadius=UDim.new(0,8)
local pingWarnLabel=makeLabel(pingWarnFrame,UDim2.new(0,0,0,0),UDim2.new(1,0,1,0),11,true,31)
pingWarnLabel.Text="⚠️ Ping สูง!"; pingWarnLabel.TextColor3=Color3.fromRGB(255,255,255); pingWarnLabel.TextXAlignment=Enum.TextXAlignment.Center

local warnCooldown,pingWarnCooldown=false,false
local function showWarning(msg,color)
    if warnCooldown then return end
    warnCooldown=true; warnLabel.Text=msg; warnFrame.Visible=true
    addNotif(msg, color or Color3.fromRGB(255,100,100))
    task.delay(3,function() warnFrame.Visible=false; task.delay(5,function() warnCooldown=false end) end)
end
local function showPingWarning(ping)
    if pingWarnCooldown then return end
    pingWarnCooldown=true
    local msg="⚠️ Ping สูง! ("..ping.."ms)"
    pingWarnLabel.Text=msg; pingWarnFrame.Visible=true
    addNotif(msg, Color3.fromRGB(255,180,50))
    task.delay(3,function() pingWarnFrame.Visible=false; task.delay(10,function() pingWarnCooldown=false end) end)
end

-- Login
local function checkLogin(username)
    username=username:gsub("%s+","")
    if username=="" then return false,"⚠️ กรุณาใส่ชื่อก่อน" end
    for _,w in ipairs(CONFIG.WHITELIST) do
        if username:lower()==w:lower() then return true,"✅ เข้าใช้งานสำเร็จ!" end
    end
    local ok,userId=pcall(function() return Players:GetUserIdFromNameAsync(username) end)
    if not ok then return false,"❌ ไม่พบ Username นี้ใน Roblox" end
    if userId~=player.UserId then return false,"❌ Username ไม่ตรงกับบัญชีที่ใช้อยู่" end
    return true,"✅ ยืนยันตัวตนสำเร็จ!"
end

loginBtn.MouseButton1Click:Connect(function()
    statusLabel.Text="🔄 กำลังตรวจสอบ..."; statusLabel.TextColor3=Color3.fromRGB(255,210,50); loginBtn.Active=false
    task.spawn(function()
        local success,msg=checkLogin(inputBox.Text); statusLabel.Text=msg
        if success then
            statusLabel.TextColor3=Color3.fromRGB(80,255,120)
            tweenFrame(loginFrame,{BackgroundTransparency=1},0.3)
            task.delay(0.3,function() loginFrame.Visible=false; mainUI.Visible=true end)
        else
            statusLabel.TextColor3=Color3.fromRGB(255,80,80)
            tweenFrame(loginFrame,{BackgroundColor3=Color3.fromRGB(40,10,10)},0.1)
            task.delay(0.4,function() tweenFrame(loginFrame,{BackgroundColor3=Color3.fromRGB(12,12,12)},0.2); loginBtn.Active=true end)
        end
    end)
end)

-- FPS Loop
local frameCount,elapsed,lastFrameTime=0,0,0
local autoRejoinCooldown=false

RunService.RenderStepped:Connect(function(dt)
    lastFrameTime=dt*1000; frameCount+=1; elapsed+=dt
    if elapsed>=settings.updateInterval then
        local fps=math.round(frameCount/elapsed)
        frameCount=0; elapsed=0
        local currentPing=0

        local fpsColor
        if settings.autoColor then
            fpsColor=fps>=60 and Color3.fromRGB(80,255,120) or fps>=30 and Color3.fromRGB(255,210,50) or Color3.fromRGB(255,70,70)
        else
            fpsColor=Color3.fromRGB(settings.textColor.r,settings.textColor.g,settings.textColor.b)
        end

        if settings.showFps then fpsLabel.TextColor3=fpsColor; fpsLabel.Text="FPS: "..fps; fpsLabel.Visible=true else fpsLabel.Visible=false end
        miniFpsLabel.TextColor3=fpsColor; miniFpsLabel.Text="FPS: "..fps
        if settings.glowEnabled then mainGlow.Color=fpsColor end

        local ok1,ping=pcall(function() return math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        if ok1 then
            currentPing=ping
            if settings.showPing then
                pingLabel.TextColor3=ping<80 and Color3.fromRGB(80,255,120) or ping<150 and Color3.fromRGB(255,210,50) or Color3.fromRGB(255,70,70)
                pingLabel.Text="Ping: "..ping.."ms"; pingLabel.Visible=true
            else pingLabel.Visible=false end
            if ping>settings.pingWarnThreshold then showPingWarning(ping) end
        end

        local ok2,mem=pcall(function() return math.round(Stats:GetTotalMemoryUsageMb()) end)
        if settings.showMem then memLabel.Text=ok2 and "MEM: "..mem.."MB" or "MEM: --"; memLabel.Visible=true else memLabel.Visible=false end

        local ok3,srvFps=pcall(function() return math.round(Stats.Network.ServerStatsItem["Server FPS"]:GetValue()) end)
        if settings.showSrv then srvLabel.Text=ok3 and "SRV: "..srvFps.."fps" or "SRV: --"; srvLabel.Visible=true else srvLabel.Visible=false end

        local ok4,netIn=pcall(function() return math.round(Stats.Network.ServerStatsItem["Data Receive KB/s"]:GetValue()) end)
        if settings.showNet then netLabel.Text=ok4 and "Net: "..netIn.."KB/s" or "Net: --"; netLabel.Visible=true else netLabel.Visible=false end

        if settings.showPlayers then pcLabel.Text="👥 "..#Players:GetPlayers(); pcLabel.Visible=true else pcLabel.Visible=false end

        local secs=os.time()-settings.sessionStart
        local mins=math.floor(secs/60); local hrs=math.floor(mins/60)
        if settings.showTime then
            timeLabel.Text=hrs>0 and "🕐 "..hrs.."h "..mins%60 .."m" or "🕐 "..mins.."m "..secs%60 .."s"
            timeLabel.Visible=true
        else timeLabel.Visible=false end

        if settings.showClock then clockLabel.Text="🕰️ "..os.date("%H:%M"); clockLabel.Visible=true else clockLabel.Visible=false end

        local char=player.Character
        if char then
            local hum=char:FindFirstChildOfClass("Humanoid")
            if hum then
                if settings.showHealth then healthLabel.Text="❤️ "..math.round(hum.Health).."/"..math.round(hum.MaxHealth); healthLabel.Visible=true else healthLabel.Visible=false end
                if settings.showWalkspeed then wsLabel.Text="🏃 "..math.round(hum.WalkSpeed); wsLabel.Visible=true else wsLabel.Visible=false end
                if settings.showGameMode then gmLabel.Text=hum.Health>0 and "🎮 Playing" or "👁️ Spectating"; gmLabel.Visible=true else gmLabel.Visible=false end
            end
        end

        if settings.showFrameTime then ftLabel.Text="⏱ "..math.round(lastFrameTime*10)/10 .."ms"; ftLabel.Visible=true else ftLabel.Visible=false end

        updateGraph(fps, currentPing)
        if fps<settings.fpsWarnThreshold then showWarning("⚠️ FPS ต่ำมาก! ("..fps..")", Color3.fromRGB(255,80,80)) end

        if settings.autoRejoinFps>0 and fps<settings.autoRejoinFps and not autoRejoinCooldown then
            autoRejoinCooldown=true
            showWarning("🔄 Auto Rejoin ใน 5 วิ...", Color3.fromRGB(255,150,50))
            task.delay(5,function() TeleportService:Teleport(game.PlaceId,player) end)
        end
    end
end)
