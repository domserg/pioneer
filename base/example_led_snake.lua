-- количество светодиодов на основной плате пионера(4) + на модуле LED (25), если нужно управлять всеми 29 светодиодами, то измените ledNumber на 29
local ledNumber = 29
-- создание порта управления светодиодами
local leds = Ledbar.new(ledNumber)

local currentLed = 0

local function snake()
    -- для светодиода №0-28 установить яркость в пределах от 0 до 1 для цветовых компонент R, G, B
    leds:set(currentLed, 0.1, 0.1, 0.1)
    currentLed = currentLed + 1
    -- если достигли последнего светодиода
    if (currentLed == ledNumber) then
        currentLed = 0
        -- выключить все светодиоды
        for i=0, ledNumber, 1 do
            leds:set(i, 0, 0, 0)
        end
    end
end

-- Обязательная функция обработки событий
function callback(event)
end

-- Создание таймера, каждую секунду запускающего функцию snake
timerRandomLED = Timer.new(1, function () snake() end)

-- Запуск созданного таймера
timerRandomLED:start()
