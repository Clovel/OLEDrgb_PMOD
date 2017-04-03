all:
	xc8 --chip=16F636 -m --opt=all -g SOFTWARE/Sources/main.c SOFTWARE/Sources/OLED_functions.c SOFTWARE/Sources/OLED_power_on.c
xav:
	xc8 --chip=16F636 -m --opt=all -g SOFTWARE/Sources/OLED_empty_xav.c

clean:
	rm -rf *.as *.cmf *.cof *.d *.hxl *.hex *.map *.p1 *.pre *.sdb *.sym *.lst *.rlf
	
clean_soft:
	rm -rf SOFTWARE/*.as SOFTWARE/*.cmf SOFTWARE/*.cof SOFTWARE/*.d SOFTWARE/*.hxl SOFTWARE/*.hex SOFTWARE/*.map SOFTWARE/*.p1 SOFTWARE/*.pre SOFTWARE/*.sdb SOFTWARE/*.sym SOFTWARE/*.rlf SOFTWARE/*.lst