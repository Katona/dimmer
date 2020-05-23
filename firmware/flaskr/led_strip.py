import pigpio

pin = 18

pi = pigpio.pi()

max_duty_cicle = 1000000
def update_brightness(percent):
    # output is inverted, so high duty cicle is actually darker ...
    brightness_value = max_duty_cicle - max_duty_cicle * percent / 100
    pi.hardware_PWM(pin, 20000, 80000)
