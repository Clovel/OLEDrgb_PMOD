all:
	xc8 --chip=16F636 -m --opt=all -g SOFTWARE/Sources/main.c SOFTWARE/Sources/OLED_functions.c SOFTWARE/Sources/OLED_power_on.c

clean:
	rm -rf *.as *.cmf *.cof *.d *.hxl *.hex *.map *.p1 *.pre *.sdb *.sym *.lst *.rlf
	