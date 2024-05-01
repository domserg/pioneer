import sensor, image, time, utime
from pyb import UART

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.skip_frames(time = 2000)

uart = UART(3)
uart.init(9600, bits=8, parity=None, stop=1, timeout_char=1000)

clock = time.clock()

while(True):
    clock.tick()
    clk = utime.ticks_ms()
    img = sensor.snapshot()
    print(img.get_histogram().get_statistics().l_mean())
    uart.writechar(img.get_histogram().get_statistics().l_mean())
    while (clk + 100 > utime.ticks_ms()):
        pass
