local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local ACTIVATION_PART = workspace:WaitForChild("Part")
local chatbotActive = false
local guiVisible = false

-- MASSIVE Keyword responses dictionary (100+ keywords!)
local responses = {
    -- ===== GREETINGS =====
    ["hello"] = "Hey there! How can I help you today? 👋",
    ["hi"] = "Hi! What's up?",
    ["hey"] = "Hey! 👋 What do you need?",
    ["yo"] = "Yo! What's good?",
    ["what's good"] = "Just chilling! How about you?",
    ["whats good"] = "Just chilling! How about you?",
    ["goodbye"] = "See you later! Take care! 👋",
    ["bye"] = "Catch you soon!",
    ["see you"] = "Later! 😎",
    ["peace"] = "Peace out! ✌️",
    ["adios"] = "Adios, amigo!",
    
    -- ===== HOW ARE YOU / FEELINGS =====
    ["how are you"] = "I'm doing great, thanks for asking! How about you?",
    ["how r u"] = "I'm good! How are you doing?",
    ["how are you doing"] = "Living the dream! What about you?",
    ["what's up"] = "Not much, just here to chat with you!",
    ["whats up"] = "Not much, just here to chat with you!",
    ["how you doing"] = "Pretty solid! Let's chat!",
    ["howdy"] = "Howdy partner! 🤠",
    
    -- ===== MOOD & FEELINGS =====
    ["i'm sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["im sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["i'm happy"] = "That's awesome! Keep smiling! 😊",
    ["im happy"] = "That's awesome! Keep smiling! 😊",
    ["i'm tired"] = "You should get some rest! Take care of yourself. 😴",
    ["im tired"] = "You should get some rest! Take care of yourself. 😴",
    ["i'm bored"] = "Why don't you play some games or chat with friends?",
    ["im bored"] = "Why don't you play some games or chat with friends?",
    ["i'm stressed"] = "Take a deep breath! Everything will be okay. 🧘",
    ["im stressed"] = "Take a deep breath! Everything will be okay. 🧘",
    ["i'm angry"] = "That's understandable. Try to calm down and talk about it!",
    ["im angry"] = "That's understandable. Try to calm down and talk about it!",
    ["i'm excited"] = "That's the spirit! Let's go! 🚀",
    ["im excited"] = "That's the spirit! Let's go! 🚀",
    ["i'm sick"] = "Oh no! Get well soon! Feel better! 💊",
    ["im sick"] = "Oh no! Get well soon! Feel better! 💊",
    
    -- ===== MODERN SLANG =====
    ["bet"] = "Bet! I got you! 💯",
    ["no cap"] = "For real! No lie! 🔥",
    ["cap"] = "That's a lie! Come on! 😂",
    ["sus"] = "Yeah, that does seem suspicious! 🤔",
    ["slay"] = "You're absolutely slaying it! 👑",
    ["fire"] = "Yeah, that's fire! 🔥",
    ["bussin"] = "That's bussin'! So good! 🔥",
    ["rizz"] = "You got that rizz! 😎",
    ["drip"] = "Your drip is immaculate! 👕✨",
    ["vibe"] = "I feel the vibe! Let's go with it!",
    ["vibes"] = "Good vibes only! ✨",
    ["lowkey"] = "Yeah, I lowkey agree with that!",
    ["highkey"] = "Yeah, I highkey love this! 💯",
    ["goat"] = "You're the GOAT! Greatest of all time! 🐐",
    ["w"] = "That's a W! Big win! 🎉",
    ["l"] = "That's an L! Better luck next time! 😅",
    ["dub"] = "Dub! Let's get that W! 💪",
    ["flex"] = "Stop flexing! We get it, you're cool! 😎",
    ["ghosted"] = "Oof, you got ghosted? That's rough! 👻",
    ["salty"] = "Don't be so salty! It's just a game!",
    ["cringe"] = "Yeah, that's pretty cringe not gonna lie!",
    ["based"] = "That's based! I respect it!",
    ["fam"] = "Yo fam! What's happening?",
    ["snatched"] = "You look snatched today! 💅",
    ["main character energy"] = "You got that main character energy! 🌟",
    ["hits different"] = "Yeah, that really hits different! 🎵",
    ["slaps"] = "That song slaps! 🎶",
    ["deadass"] = "Deadass? That's crazy!",
    ["dank"] = "That's dank! 😂",
    ["yeet"] = "YEET! Let's go! 🚀",
    ["stan"] = "I stan! You're amazing!",
    
    -- ===== HELP & QUESTIONS =====
    ["help"] = "I'm here to help! What do you need assistance with?",
    ["can you help"] = "Of course! Tell me what you need help with.",
    ["i need help"] = "No problem! What's the issue?",
    ["what can you do"] = "I can chat with you and answer questions! Just ask me anything.",
    ["how do i"] = "I'd be happy to help! Be more specific about what you need.",
    ["how to"] = "Tell me more and I'll guide you through it!",
    ["explain"] = "I respond to keywords! Try asking me common questions!",
    ["what is this"] = "It's a chatbot! Here to answer your questions! 🤖",
    ["confused"] = "Don't worry! Ask me anything and I'll try to help!",
    
    -- ===== TIME & DATE =====
    ["what time is it"] = "I'm not great with time, but you can check your device! ⏰",
    ["what's the time"] = "Check your clock! ⏰",
    ["what day is it"] = "I wish I could tell you, but I lose track of time!",
    ["time"] = "Time flies when you're having fun!",
    
    -- ===== RANDOM QUESTIONS =====
    ["what's your name"] = "I'm a chatbot! You can name me whatever you like! 🤖",
    ["whats your name"] = "I'm a chatbot! You can name me whatever you like! 🤖",
    ["your name"] = "I'm Bot! Nice to meet you!",
    ["are you real"] = "I'm code in Roblox! Real enough to chat with you! 😄",
    ["are you ai"] = "Technically I'm AI! But a pretty chill one! 😎",
    ["do you like games"] = "Absolutely! That's why I'm here in Roblox! 🎮",
    ["favorite game"] = "I love all games on Roblox! They're all awesome!",
    ["tell me a joke"] = "Why did the programmer quit his job? Because he didn't get arrays! 😄",
    ["joke"] = "What do you call a fake noodle? An impasta! 🍝😂",
    ["make me laugh"] = "Why did the scarecrow win an award? Because he was outstanding in his field! 😂",
    
    -- ===== THANKS & POLITENESS =====
    ["thank you"] = "You're welcome! Always happy to help! 😊",
    ["thanks"] = "No problem! Happy to assist!",
    ["thx"] = "No problem at all! 👍",
    ["ty"] = "You're welcome! 😊",
    ["please"] = "Of course! What do you need?",
    ["sorry"] = "No worries! We all make mistakes!",
    ["i'm sorry"] = "No problem! Don't worry about it!",
    
    -- ===== AFFIRMATIONS =====
    ["yes"] = "Great! What else?",
    ["yeah"] = "Awesome! Let me know what you need!",
    ["yep"] = "Perfect! Anything else?",
    ["no"] = "Understood! Anything else I can help with?",
    ["nope"] = "Got it! Let me know if you change your mind!",
    ["ok"] = "Awesome! Let me know if you need anything!",
    ["okay"] = "Awesome! Let me know if you need anything!",
    ["kk"] = "Kk! Ready when you are! 👍",
    ["sure"] = "Sure thing! What's up?",
    ["cool"] = "Cool! That's awesome!",
    
    -- ===== INFORMATION =====
    ["what is roblox"] = "Roblox is an amazing gaming platform where you can create and play games! 🎮",
    ["how does this work"] = "Click the Part, open the GUI, and type in chat! I'll respond to keywords!",
    ["how to use"] = "Type messages and I'll respond based on keywords! It's that simple!",
    ["what is this"] = "This is an AI chatbot! Here to chat and answer questions!",
    ["what is ai"] = "AI is Artificial Intelligence - I'm a computer program that talks with you!",
    ["how do i play"] = "Just explore and interact with the world!",
    ["can you teach me"] = "I can try! What do you want to learn about?",
    ["teach"] = "I'd love to help teach you! What's the topic?",
    
    -- ===== INTERNET CULTURE =====
    ["lol"] = "Haha! That's funny! 😂",
    ["lmao"] = "LMAO! That's hilarious! 🤣",
    ["omg"] = "OMG! That's crazy! 😲",
    ["wtf"] = "Wow, that's wild! 😅",
    ["bruh"] = "Bruh! That's crazy! 😂",
    ["meme"] = "Memes are the best! 😂",
    ["tiktok"] = "TikTok is wild! 📱",
    ["reddit"] = "Reddit is hilarious! 🤓",
    ["twitter"] = "Twitter has all the drama! 😂",
    ["discord"] = "Discord is great for hanging out! 💬",
    ["twitch"] = "Twitch streamers are awesome! 📺",
    ["youtube"] = "YouTube has everything! 📹",
    ["gaming"] = "Gaming is life! Let's play something! 🎮",
    ["poggers"] = "POGGERS! That's epic! 🎉",
    ["pogchamp"] = "PogChamp! That was insane! 🎮",
    ["raid"] = "Raiding is fun! Let's go! ⚔️",
    ["sus among us"] = "Amogus! 😂",
    ["among us"] = "Sus! That game was wild! 👀",
    
    -- ===== FOOD & PIZZA =====
    ["do you like pizza"] = "Who doesn't like pizza? It's the best! 🍕",
    ["pizza"] = "Pizza is amazing! 🍕",
    ["food"] = "Food is life! What are you eating? 🍔",
    ["hungry"] = "Get yourself a snack! You deserve it! 🍕",
    ["i'm hungry"] = "Go grab something to eat! 🍕",
    ["im hungry"] = "Go grab something to eat! 🍕",
    ["burgers"] = "Burgers hit different! 🍔",
    ["tacos"] = "Tacos are fire! 🌮",
    
    -- ===== LOVE & RELATIONSHIPS =====
    ["what is love"] = "Love is what makes the world go 'round! ❤️",
    ["love"] = "That's sweet! Spread the love! ❤️",
    ["i like someone"] = "Aww, that's cute! Go tell them! 💕",
    ["crush"] = "You got a crush? Shoot your shot! 💘",
    
    -- ===== PHILOSOPHY & LIFE =====
    ["what is the meaning of life"] = "To have fun and enjoy the game! 🎮",
    ["why am i here"] = "To have a great time! Let's chat!",
    ["life"] = "Life is what you make of it! Enjoy it! 🌈",
    ["happiness"] = "Happiness is all around you! Look for it! ✨",
    
    -- ===== GAMING TERMS =====
    ["noob"] = "Everyone's a noob at first! You'll get better! 💪",
    ["pro"] = "You're such a pro! Amazing! 🎯",
    ["lag"] = "Ugh, lag is the worst! 😤",
    ["gg"] = "GG! Good game! Well played! 🎮",
    ["clutch"] = "What a clutch play! Epic! 🔥",
    ["respawn"] = "Time to respawn and try again! 💪",
    ["level up"] = "Keep grinding and you'll level up! 📈",
    ["boss"] = "That boss is tough! You got this! 💪",
    ["quest"] = "Quests are fun! Keep exploring! 🗺️",
    ["achievement"] = "You unlocked an achievement! 🎉",
    
    -- ===== POSITIVE VIBES =====
    ["awesome"] = "You're awesome! Keep being amazing! 💯",
    ["amazing"] = "That's amazing! You're crushing it! 🔥",
    ["great"] = "That's great! Keep it up! 👍",
    ["best"] = "You're the best! Never forget that! 👑",
    ["good"] = "Good vibes only! ✨",
    ["nice"] = "That's nice! I like it! 😊",
    ["love it"] = "That's awesome! Glad you love it! ❤️",
    ["perfect"] = "Perfect! That's exactly right! ✨",
    ["beautiful"] = "That's beautiful! Really nice! 🌟",
    ["cute"] = "That's so cute! Adorable! 🥰",
    
    -- ===== NEGATIVE RESPONSES =====
    ["hate"] = "Oh no! What happened? Talk to me!",
    ["bad"] = "Don't worry! Every day is a new chance! 💪",
    ["worst"] = "It's not the worst! Things will get better!",
    ["fail"] = "Failures are just learning opportunities! 💡",
    ["broke"] = "Oof, that's rough! You'll recover! 💪",
    ["lost"] = "Don't worry! You'll find your way! 🧭",
    ["stuck"] = "You're not stuck! There's always a way forward! 💪",
    
    -- ===== RANDOM FUN =====
    ["do you believe in magic"] = "Of course! Roblox is full of magic! ✨",
    ["what is your secret"] = "My secret is to always be friendly! 😊",
    ["can you dance"] = "I can't dance, but I can cheer you on! 💃",
    ["can you sing"] = "Not really, but I can appreciate your voice! 🎵",
    ["can you fly"] = "I'm grounded! You fly though! 🚀",
    ["what's your favorite color"] = "I like all colors equally! They're all beautiful! 🌈",
    ["do you dream"] = "I dream of chatting with awesome people like you! 💭",
    ["do you sleep"] = "I'm always awake to chat with you! 🤖",
    ["favorite movie"] = "I love all movies! What's yours? 🎬",
    ["favorite book"] = "Books are great! What are you reading? 📚",
    ["favorite song"] = "Music is amazing! What do you listen to? 🎵",
    
    -- ===== GREETINGS VARIATIONS =====
    ["good morning"] = "Good morning! Let's make it a great day! 🌅",
    ["good afternoon"] = "Good afternoon! How's your day going? ☀️",
    ["good evening"] = "Good evening! Time to relax! 🌙",
    ["good night"] = "Good night! Sleep well! 😴💤",
    ["sweet dreams"] = "Sweet dreams! Sleep tight! 💤✨",
    ["wake up"] = "Rise and shine! Time for action! 🌅",
}

-- Create GUI
local function createChatbotGUI()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Main Frame
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChatbotGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Main Chat Window
    local chatFrame = Instance.new("Frame")
    chatFrame.Name = "ChatFrame"
    chatFrame.Size = UDim2.new(0, 450, 0, 550)
    chatFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    chatFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    chatFrame.BorderSizePixel = 0
    chatFrame.Visible = false
    chatFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = chatFrame
    
    -- Shadow effect
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 0, 1, 0)
    shadow.Position = UDim2.new(0, 2, 0, 2)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BorderSizePixel = 0
    shadow.ZIndex = 0
    shadow.Parent = chatFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadow
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 55)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 2
    titleBar.Parent = chatFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Gradient effect on title
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 180))
    }
    titleGradient.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, -60, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 20
    titleText.Font = Enum.Font.GothamBold
    titleText.Text = "🤖 AI Chatbot Assistant"
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.ZIndex = 3
    titleText.Parent = titleBar
    
    -- Status indicator
    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.Size = UDim2.new(0, 12, 0, 12)
    statusDot.Position = UDim2.new(1, -28, 0.5, -6)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 3
    statusDot.Parent = titleBar
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = statusDot
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -48, 0, 7)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 22
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "✕"
    closeButton.BorderSizePixel = 0
    closeButton.ZIndex = 3
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseEnter:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
    end)
    
    closeButton.MouseLeave:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    end)
    
    -- Chat Display Area (ScrollingFrame)
    local chatDisplay = Instance.new("ScrollingFrame")
    chatDisplay.Name = "ChatDisplay"
    chatDisplay.Size = UDim2.new(1, -20, 1, -130)
    chatDisplay.Position = UDim2.new(0, 10, 0, 65)
    chatDisplay.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    chatDisplay.BorderSizePixel = 0
    chatDisplay.ScrollBarThickness = 8
    chatDisplay.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 215)
    chatDisplay.CanvasSize = UDim2.new(0, 0, 0, 0)
    chatDisplay.ZIndex = 2
    chatDisplay.Parent = chatFrame
    
    local displayCorner = Instance.new("UICorner")
    displayCorner.CornerRadius = UDim.new(0, 8)
    displayCorner.Parent = chatDisplay
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = chatDisplay
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Input Frame
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "InputFrame"
    inputFrame.Size = UDim2.new(1, -20, 0, 55)
    inputFrame.Position = UDim2.new(0, 10, 1, -65)
    inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    inputFrame.BorderSizePixel = 0
    inputFrame.ZIndex = 2
    inputFrame.Parent = chatFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame
    
    -- Text Input Box
    local textInput = Instance.new("TextBox")
    textInput.Name = "TextInput"
    textInput.Size = UDim2.new(1, -60, 1, -10)
    textInput.Position = UDim2.new(0, 8, 0, 5)
    textInput.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    textInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    textInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textInput.PlaceholderText = "Type your message..."
    textInput.TextSize = 14
    textInput.Font = Enum.Font.Gotham
    textInput.BorderSizePixel = 0
    textInput.ZIndex = 2
    textInput.Parent = inputFrame
    
    local inputTextCorner = Instance.new("UICorner")
    inputTextCorner.CornerRadius = UDim.new(0, 6)
    inputTextCorner.Parent = textInput
    
    -- Send Button
    local sendButton = Instance.new("TextButton")
    sendButton.Name = "SendButton"
    sendButton.Size = UDim2.new(0, 48, 1, -10)
    sendButton.Position = UDim2.new(1, -56, 0, 5)
    sendButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sendButton.TextSize = 18
    sendButton.Font = Enum.Font.GothamBold
    sendButton.Text = "➤"
    sendButton.BorderSizePixel = 0
    sendButton.ZIndex = 2
    sendButton.Parent = inputFrame
    
    local sendCorner = Instance.new("UICorner")
    sendCorner.CornerRadius = UDim.new(0, 6)
    sendCorner.Parent = sendButton
    
    sendButton.MouseEnter:Connect(function()
        sendButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end)
    
    sendButton.MouseLeave:Connect(function()
        sendButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    end)
    
    -- Function to add message to chat
    local function addMessageToChat(sender, message, isBot)
        local messageContainer = Instance.new("Frame")
        messageContainer.Name = "MessageContainer"
        messageContainer.Size = UDim2.new(1, -10, 0, 0)
        messageContainer.BackgroundTransparency = 1
        messageContainer.BorderSizePixel = 0
        messageContainer.ZIndex = 2
        messageContainer.Parent = chatDisplay
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Name = "MessageLabel"
        messageLabel.Size = UDim2.new(1, -10, 0, 0)
        messageLabel.BackgroundColor3 = isBot and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 100, 150)
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        messageLabel.TextSize = 13
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.Text = (isBot and "🤖 Bot: " or "👤 You: ") .. message
        messageLabel.TextWrapped = true
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.BorderSizePixel = 0
        messageLabel.ZIndex = 2
        messageLabel.Parent = messageContainer
        
        local msgPadding = Instance.new("UIPadding")
        msgPadding.PaddingLeft = UDim.new(0, 10)
        msgPadding.PaddingRight = UDim.new(0, 10)
        msgPadding.PaddingTop = UDim.new(0, 8)
        msgPadding.PaddingBottom = UDim.new(0, 8)
        msgPadding.Parent = messageLabel
        
        local msgCorner = Instance.new("UICorner")
        msgCorner.CornerRadius = UDim.new(0, 10)
        msgCorner.Parent = messageLabel
        
        -- Resize container based on text
        local textSize = game:GetService("TextService"):GetTextSize(messageLabel.Text, messageLabel.TextSize, messageLabel.Font, Vector2.new(messageLabel.AbsoluteSize.X - 30, math.huge))
        messageContainer.Size = UDim2.new(1, -10, 0, math.max(textSize.Y + 20, 35))
        messageLabel.Size = UDim2.new(1, 0, 1, 0)
        
        chatDisplay.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        chatDisplay.CanvasPosition = Vector2.new(0, listLayout.AbsoluteContentSize.Y)
    end
    
    -- Function to find matching keyword
    local function findKeyword(message)
        local lowerMessage = string.lower(message)
        
        -- Check for exact matches first
        for keyword, response in pairs(responses) do
            if lowerMessage == keyword then
                return response
            end
        end
        
        -- Check for partial matches
        for keyword, response in pairs(responses) do
            if string.find(lowerMessage, keyword) then
                return response
            end
        end
        
        -- Default random responses
        local defaultResponses = {
            "That's interesting! Tell me more! 🤔",
            "I'm not sure about that, but it sounds cool! 😊",
            "Hmm, that's new to me! Explain? 🤷",
            "I don't have a response for that, but I'm learning! 📚",
            "That's beyond my knowledge, but I'm always learning! 🚀",
            "Interesting point! What else? 💭",
            "I'm still learning about that! 🤖",
            "That's wild! Never heard that before! 😲",
        }
        
        return defaultResponses[math.random(1, #defaultResponses)]
    end
    
    -- Send button functionality
    local function sendMessage()
        local userMessage = textInput.Text:gsub("^%s+|%s+$", "")
        
        if userMessage ~= "" then
            addMessageToChat("You", userMessage, false)
            textInput.Text = ""
            
            -- Get bot response
            local botResponse = findKeyword(userMessage)
            task.wait(0.3) -- Simulate typing delay
            addMessageToChat("Chatbot", botResponse, true)
        end
    end
    
    sendButton.MouseButton1Click:Connect(sendMessage)
    textInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            sendMessage()
        end
    end)
    
    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        chatFrame.Visible = false
        guiVisible = false
    end)
    
    return chatFrame
end

-- Reference to GUI
local chatGui = nil

-- Click detection for the part
ACTIVATION_PART.MouseClick:Connect(function(player)
    if player == Players.LocalPlayer then
        chatbotActive = not chatbotActive
        
        if chatbotActive then
            print("✅ Chatbot activated! GUI opened!")
            
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

print("✅ Extended Chatbot GUI script loaded! Click the Part to open.")
print("📚 The chatbot now has 150+ keywords including modern slang and internet culture!")
