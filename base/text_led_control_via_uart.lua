-- инициализируем Uart интерфейс
local uartNum = 4 -- номер Uart интерфейса (USART4)
local baudRate = 9600 -- скорость передачи данных
local stopBits = 1
local parity = Uart.PARITY_NONE
local uart = Uart.new(uartNum, baudRate, parity, stopBits)

-- количество светодиодов на основной плате пионера(4) + на модуле LED (25), если нужно управлять 29 светодиодами, измените ledNumber на 29
local ledNumber = 4
-- создание порта управления светодиодами
local leds = Ledbar.new(ledNumber)

function getData() -- функция приёма байта данных
    buf = uart:read(uart:bytesToRead())
    if (buf:len() == 0) then return 0 end
    return buf
end

local takerFunction = function () -- функция для периодического чтения данных из UART
    local b = getData()
    if (b=="hi") then
        -- включить все светодиоды белым
        for i=0, ledNumber, 1 do
            leds:set(i, 1, 1, 1)
        end
    elseif (b=="e") then
        -- включить все светодиоды зеленым
        for i=0, ledNumber, 1 do
            leds:set(i, 0, 1, 0)
        end
    else
        -- выключить все светодиоды 
        for i=0, ledNumber, 1 do
            leds:set(i, 0, 0, 0)
        end
    end
end

local interval = 0.1
getMeasureTimer = Timer.new(interval, takerFunction) -- таймер для создания фото
getMeasureTimer:start()

-- определяем функцию анализа возникающих событий в системе
function callback(event)
end
