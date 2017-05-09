@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 0cae693ee01e4c01ab656b983efed283 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_top_level_init_behav xil_defaultlib.tb_top_level_init -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
