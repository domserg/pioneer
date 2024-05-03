import time
from pyb import UART

uart = UART(3, 9600, timeout_char=1000)
while True:
    uart.write("e")
    time.sleep_ms(1000)
    uart.write("hi")
    time.sleep_ms(1000)
