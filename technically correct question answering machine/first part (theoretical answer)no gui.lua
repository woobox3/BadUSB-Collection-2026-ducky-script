-- this is a theoretical part without any gui so use it only if you really dont want gui!! the other part is with a gui so thats more chill ykyky :3

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- config
local ACTIVATION_PART = workspace:WaitForChild("Part") -- you need a part named part for this to work (it doesnt have to be named part just change the "part" to whatever the model is named
local chatbotActive = false

-- keyword responses mainly come after this part
local responses = {
    -- hello
    ["hello"] = "Hey there! How can I help you today?",
    ["hi"] = "Hi! What's up?",
    ["hey"] = "Hey! 👋 What do you need?",
    ["goodbye"] = "See you later! Take care!",
    ["bye"] = "Catch you soon!",
    
    -- how are ya m8
    ["how are you"] = "I'm doing great, thanks for asking! How about you?",
    ["how r u"] = "I'm good! How are you doing?",
    ["what's up"] = "Not much, just here to chat with you!",
    ["whats up"] = "Not much, just here to chat with you!",
    
    -- help n questions
    ["help"] = "I'm here to help! What do you need assistance with?",
    ["can you help"] = "Of course! Tell me what you need help with.",
    ["what can you do"] = "I can chat with you and answer questions! Just ask me anything.",
    ["how do i"] = "I'd be happy to help! Be more specific about what you need.",
    
    -- time n date
    ["what time is it"] = "I'm not great with time, but you can check your device!",
    ["what's the time"] = "Check your clock! ⏰",
    ["what day is it"] = "I wish I could tell you, but I lose track of time!",
    
    -- feelin
    ["i'm sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["im sad"] = "Aw, I'm sorry you're feeling down. Things will get better! 💙",
    ["i'm happy"] = "That's awesome! Keep smiling! 😊",
    ["im happy"] = "That's awesome! Keep smiling! 😊",
    ["i'm tired"] = "You should get some rest! Take care of yourself.",
    ["im tired"] = "You should get some rest! Take care of yourself.",
    ["i'm bored"] = "Why don't you play some games or chat with friends?",
    ["im bored"] = "Why don't you play some games or chat with friends?",
    
    -- question
    ["what's your name"] = "I'm a chatbot! You can name me whatever you like!",
    ["whats your name"] = "I'm a chatbot! You can name me whatever you like!",
    ["are you real"] = "I'm code in Roblox! Real enough to chat with you! 😄",
    ["do you like games"] = "Absolutely! That's why I'm here in Roblox!",
    ["tell me a joke"] = "Why did the programmer quit his job? Because he didn't get arrays! 😄",
    
    -- politness n such
    ["thank you"] = "You're welcome! Always happy to help!",
    ["thanks"] = "No problem! Happy to assist!",
    ["please"] = "Of course! What do you need?",
    
    -- yuh nuh
    ["yes"] = "Great! What else?",
    ["no"] = "Understood! Anything else I can help with?",
    ["ok"] = "Awesome! Let me know if you need anything!",
    ["okay"] = "Awesome! Let me know if you need anything!",
    
    -- info
    ["what is roblox"] = "Roblox is an amazing gaming platform where you can create and play games!",
    ["how does this work"] = "Press the Part, say something, then type in chat and I'll respond!",
    ["explain"] = "I respond to keywords! Try asking me common questions!",
}


local function findKeyword(message)
    local lowerMessage = string.lower(message)
    
    
    for keyword, response in pairs(responses) do
        if lowerMessage == keyword then
            return response
        end
    end
    
    
    for keyword, response in pairs(responses) do
        if string.find(lowerMessage, keyword) then
            return response
        end
    end
    
    
    return "I'm not sure about that, but it sounds interesting! Can you tell me more?"
end


local function displayResponse(response)
    print("[Chatbot]: " .. response)
    
end


ACTIVATION_PART.MouseClick:Connect(function(player)
    if player.UserId == Players:FindFirstChild(Players.LocalPlayer.Name).UserId or game:GetService("RunService"):IsServer() then
        chatbotActive = not chatbotActive
        if chatbotActive then
            print("✅ Chatbot activated! Type in chat now.")
            displayResponse("Chatbot is now active! Ask me anything!")
        else
            print("❌ Chatbot deactivated.")
            displayResponse("Chatbot is now inactive.")
        end
    end
end)

-- listens message from chat bro
Players.LocalPlayer.Chatted:Connect(function(message)
    if chatbotActive then
        local response = findKeyword(message)
        displayResponse(response)
    end
end)

-- alternative
local Chat = game:GetService("Chat")
local generalChannel = Chat:GetGeneralChannel()

generalChannel.NewMessage:Connect(function(message)
    if chatbotActive and message.FromSpeaker ~= "Chatbot" then
        local response = findKeyword(message.Message)
        -- Send response through chat
        Chat:Chat(ACTIVATION_PART, response, "All")
        print("[Chatbot]: " .. response)
    end
end)

print("✅ Chatbot script loaded! Click the Part to activate.")
