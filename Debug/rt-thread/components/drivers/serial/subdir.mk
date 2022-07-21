################################################################################
# �Զ����ɵ��ļ�����Ҫ�༭��
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../rt-thread/components/drivers/serial/serial_v2.c 

OBJS += \
./rt-thread/components/drivers/serial/serial_v2.o 

C_DEPS += \
./rt-thread/components/drivers/serial/serial_v2.d 


# Each subdirectory must supply rules for building sources it contributes
rt-thread/components/drivers/serial/%.o: ../rt-thread/components/drivers/serial/%.c
	arm-none-eabi-gcc -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\board\ports" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\board" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\libraries\HAL_Drivers\config" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\libraries\HAL_Drivers" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\packages\ssd1306-latest\inc" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra\arm\CMSIS_5\CMSIS\Core\Include" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra\fsp\inc\api" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra\fsp\inc\instances" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra\fsp\inc" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra_cfg\fsp_cfg\bsp" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra_cfg\fsp_cfg" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\ra_gen" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\drivers\include" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\finsh" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\libc\compilers\common" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\libc\compilers\newlib" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\libc\posix\io\poll" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\libc\posix\io\stdio" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\components\libc\posix\ipc" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\include" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\libcpu\arm\common" -I"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rt-thread\libcpu\arm\cortex-m4" -include"D:\RT-ThreadStudio\workspace\RA6M4-IIC\rtconfig_preinc.h" -std=gnu11 -mcpu=cortex-m33 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard -ffunction-sections -fdata-sections -Dgcc -O0 -gdwarf-2 -g -Wall -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"

