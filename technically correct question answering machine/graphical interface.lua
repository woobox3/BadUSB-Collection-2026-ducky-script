##### Place this script in StarterPlayer > StarterCharacterScripts or StarterPlayer > StarterPlayerScripts (dont paste this part of the code into there!!)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- config
local ACTIVATION_PART = workspace:WaitForChild("Part")
local chatbotActive = false
local guiVisible = false

-- keyworh
local responses = {
    -- greets
    ["hello"] = "Hey there! How can I help you today?",
    ["hi"] = "Hi! What's up?",
    ["hey"] = "Hey! 👋 What do you need?",
    ["goodbye"] = "See you later! Take care!",
    ["bye"] = "Catch you soon!",
    
    -- beets
    ["how are you"] = "I'm doing great, thanks for asking! How about you?",
    ["how r u"] = "I'm good! How are you doing?",
    ["what's up"] = "Not much, just here to chat with you!",
    ["whats up"] = "Not much, just here to chat with you!",
    
    -- intergalatic space ship
    ["help"] = "I'm here to help! What do you need assistance with?",
    ["can you help"] = "Of course! Tell me what you need help with.",
    ["what can you do"] = "I can chat with you and answer questions! Just ask me anything.",
    ["how do i"] = "I'd be happy to help! Be more specific about what you need.",
    
    -- yes that is an The Office refrence
    ["what time is it"] = "I'm not great with time, but you can check your device!",
    ["what's the time"] = "Check your clock! ⏰",
    ["what day is it"] = "I wish I could tell you, but I lose track of time!",
    
    -- moods n such
    ["i'm sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["im sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["i'm happy"] = "That's awesome! Keep smiling! 😊",
    ["im happy"] = "That's awesome! Keep smiling! 😊",
    ["i'm tired"] = "You should get some rest! Take care of yourself.",
    ["im tired"] = "You should get some rest! Take care of yourself.",
    ["i'm bored"] = "Why don't you play some games or chat with friends?",
    ["im bored"] = "Why don't you play some games or chat with friends?",
    
    -- qa
    ["what's your name"] = "I'm a chatbot! You can name me whatever you like!",
    ["whats your name"] = "I'm a chatbot! You can name me whatever you like!",
    ["are you real"] = "I'm code in Roblox! Real enough to chat with you! 😄",
    ["do you like games"] = "Absolutely! That's why I'm here in Roblox!",
    ["tell me a joke"] = "Why did the programmer quit his job? Because he didn't get arrays! 😄",
    
    -- tp
    ["thank you"] = "You're welcome! Always happy to help!",
    ["thanks"] = "No problem! Happy to assist!",
    ["please"] = "Of course! What do you need?",
    
    -- Aaffr
    ["yes"] = "Great! What else?",
    ["no"] = "Understood! Anything else I can help with?",
    ["ok"] = "Awesome! Let me know if you need anything!",
    ["okay"] = "Awesome! Let me know if you need anything!",
    
    -- inf
    ["what is roblox"] = "Roblox is an amazing gaming platform where you can create and play games!",
    ["how does this work"] = "Press the Part, say something, then type in chat and I'll respond!",
    ["explain"] = "I respond to keywords! Try asking me common questions!",
}

-- graphical interface part
local function createChatbotGUI()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- main frm
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChatbotGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- main chat frame
    local chatFrame = Instance.new("Frame")
    chatFrame.Name = "ChatFrame"
    chatFrame.Size = UDim2.new(0, 400, 0, 500)
    chatFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    chatFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    chatFrame.BorderSizePixel = 0
    chatFrame.Visible = false
    chatFrame.Parent = screenGui
    
    -- add radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = chatFrame
    
    -- title br
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = chatFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.Text = "🤖 Chatbot Assistant"
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -45, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "X"
    closeButton.BorderSizePixel = 0
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    -- chat displ
    local chatDisplay = Instance.new("ScrollingFrame")
    chatDisplay.Name = "ChatDisplay"
    chatDisplay.Size = UDim2.new(1, -20, 1, -120)
    chatDisplay.Position = UDim2.new(0, 10, 0, 60)
    chatDisplay.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    chatDisplay.BorderSizePixel = 0
    chatDisplay.ScrollBarThickness = 8
    chatDisplay.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 215)
    chatDisplay.CanvasSize = UDim2.new(0, 0, 0, 0)
    chatDisplay.Parent = chatFrame
    
    local displayCorner = Instance.new("UICorner")
    displayCorner.CornerRadius = UDim.new(0, 8)
    displayCorner.Parent = chatDisplay
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = chatDisplay
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- inpt
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.new(1, -20, 0, 50)
    inputFrame.Position = UDim2.new(0, 10, 1, -60)
    inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = chatFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame
    
    -- Txt
    local textInput = Instance.new("TextBox")
    textInput.Name = "TextInput"
    textInput.Size = UDim2.new(1, -50, 1, 0)
    textInput.Position = UDim2.new(0, 5, 0, 0)
    textInput.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    textInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    textInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textInput.PlaceholderText = "Type a message..."
    textInput.TextSize = 14
    textInput.Font = Enum.Font.Gotham
    textInput.BorderSizePixel = 0
    textInput.Parent = inputFrame
    
    local inputTextCorner = Instance.new("UICorner")
    inputTextCorner.CornerRadius = UDim.new(0, 6)
    inputTextCorner.Parent = textInput
    
    -- Send Button
    local sendButton = Instance.new("TextButton")
    sendButton.Name = "SendButton"
    sendButton.Size = UDim2.new(0, 40, 1, 0)
    sendButton.Position = UDim2.new(1, -45, 0, 0)
    sendButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sendButton.TextSize = 16
    sendButton.Font = Enum.Font.GothamBold
    sendButton.Text = "➤"
    sendButton.BorderSizePixel = 0
    sendButton.Parent = inputFrame
    
    local sendCorner = Instance.new("UICorner")
    sendCorner.CornerRadius = UDim.new(0, 6)
    sendCorner.Parent = sendButton
    
    -- function to add mssgs to chat
    local function addMessageToChat(sender, message, isBot)
        local messageContainer = Instance.new("Frame")
        messageContainer.Name = "MessageContainer"
        messageContainer.Size = UDim2.new(1, -10, 0, 0)
        messageContainer.BackgroundTransparency = 1
        messageContainer.BorderSizePixel = 0
        messageContainer.Parent = chatDisplay
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Name = "MessageLabel"
        messageLabel.Size = UDim2.new(1, -10, 0, 0)
        messageLabel.BackgroundColor3 = isBot and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 60, 60)
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        messageLabel.TextSize = 13
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.Text = (isBot and "🤖 Bot: " or "👤 You: ") .. message
        messageLabel.TextWrapped = true
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.BorderSizePixel = 0
        messageLabel.Padding = UDim.new(0, 10)
        messageLabel.Parent = messageContainer
        
        local msgCorner = Instance.new("UICorner")
        msgCorner.CornerRadius = UDim.new(0, 8)
        msgCorner.Parent = messageLabel
        
        -- resize according to screen
        local textSize = game:GetService("TextService"):GetTextSize(messageLabel.Text, messageLabel.TextSize, messageLabel.Font, Vector2.new(messageLabel.AbsoluteSize.X - 20, math.huge))
        messageContainer.Size = UDim2.new(1, -10, 0, textSize.Y + 20)
        messageLabel.Size = UDim2.new(1, -10, 1, 0)
        
        chatDisplay.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
        chatDisplay.CanvasPosition = Vector2.new(0, listLayout.AbsoluteContentSize.Y)
    end
    
    -- function
    local function findKeyword(message)
        local lowerMessage = string.lower(message)
        
        for keyword, response in pairs(responses) do
            if string.find(lowerMessage, keyword) then
                return response
            end
        end
        
        return "I'm not sure about that, but it sounds interesting! Can you tell me more?"
    end
    
    -- button 
    local function sendMessage()
        local userMessage = textInput.Text:gsub("^%s+|%s+$", "")
        
        if userMessage ~= "" then
            addMessageToChat("You", userMessage, false)
            textInput.Text = ""
            
            -- bot respns
            local botResponse = findKeyword(userMessage)
            task.wait(0.5) -- Simulate typing delay
            addMessageToChat("Chatbot", botResponse, true)
        end
    end
    
    sendButton.MouseButton1Click:Connect(sendMessage)
    textInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            sendMessage()
        end
    end)
    
    -- close button func
    closeButton.MouseButton1Click:Connect(function()
        chatFrame.Visible = false
        guiVisible = false
    end)
    
    return chatFrame
end

-- refrence to gui
local chatGui = nil

-- clic dectetion
ACTIVATION_PART.MouseClick:Connect(function(player)
    if player == Players.LocalPlayer then
        chatbotActive = not chatbotActive
        
        if chatbotActive then
            print("✅ Chatbot activated!")
            
            if not chatGui then
                chatGui = createChatbotGUI()
            end
            
            guiVisible = true
            chatGui.Visible = true
        else
            print("❌ Chatbot deactivated.")
            if chatGui then
                chatGui.Visible = false
            end
            guiVisible = false
        end
    end
end)

print("✅ Chatbot GUI script loaded! Click the Part to open the GUI.")
