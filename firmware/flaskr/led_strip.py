import pigpio
import time
from concurrent.futures import ThreadPoolExecutor, CancelledError
from threading import Event
from easing_functions import *

pin = 18

pi = pigpio.pi()

executor = ThreadPoolExecutor(max_workers=1)
current_animation = None
exit = None

max_duty_cycle = 1000000
def update_brightness(percent):
    global current_animation
    global exit

    if current_animation is not None:
        print("cancel", current_animation)
        exit.set()
    current_brightness = current_animation.result(1) if current_animation is not None else max_duty_cycle
    
    # output is inverted, so high duty cycle is actually darker ...
    target_brightness = int(max_duty_cycle - max_duty_cycle * percent / 100)

    exit = Event()
    current_animation = executor.submit(brightness_animation_task, current_brightness, target_brightness, exit)


def brightness_animation_task(initial_brightness, target_brightness, exit):
    step_count = 100
    brightness = initial_brightness
    easing = QuadEaseInOut(start=initial_brightness, end = target_brightness, duration = step_count)
    step = 0
    while not exit.is_set() and step <= step_count:
        brightness = int(easing.ease(step))
        print(brightness)
        pi.hardware_PWM(pin, 4000, brightness)
        step = step + 1
        exit.wait(0.01)
    return brightness
