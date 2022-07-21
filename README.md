[【开发板评测】Renesas RA6M4开发板之GPIO、IIC（模拟）](https://club.rt-thread.org/ask/article/36fe553196532ddd.html "【开发板评测】Renesas RA6M4开发板之GPIO、IIC（模拟）")
@[toc](【Renesas RA6M4开发板之I2C（模拟）驱动ssd1306 OLED屏幕】)

# 1.0 OLED

![在这里插入图片描述](https://img-blog.csdnimg.cn/32e9e77bb3ef44789afbac34848a3537.png)
**此图转载优信电子**

有机发光二极管（OrganicLight-Emitting Diode，OLED），又称为有机电激光显示、有机发光半导体（OrganicElectroluminesence Display，OLED），是指有机半导体材料和发光材料在电场驱动下，通过载流子注入和复合导致发光的现象。本篇通过0.96寸OLED包采用I2C软串口示例程序演示。
## 1.1产品特性:
OLED(Organic Light-Emitting Diode):有机发光二极管又称为有机电激光显示，OLED显示技术具有自发光的特性，采用非常薄的有机材料涂层和玻璃基板，当有电流通过时，这些有机材料就会发光，而且OLED显示屏幕可视角度大，功耗低。OLED由于同时具备自发光、不需背光源(只上电是不会亮的，驱动程序和接线正确才会点亮)、对比度高、厚度薄、视角广、反应速度快、可用于挠曲面板、使用温度范围广、结构及制程简单等优异之特性。最先接触的12864屏都是LCD的，需要背光，功耗较高，而OLED的功耗低，更加适合小系统;由于两者发光材料的不同，在不同的环境中，OLED的显示效果更佳。模块供电可以是3.3V也可以是5V,不需要修改模块电路，OLED屏具有多个控制指令，可以控制OLED的亮度、对比度、开关升压电路等指令。操作方便，功能丰富。可显示汉字、ASClI、图案等。同时为了方便应用在产品上，预留4个M3固定孔，方便用户固定在机壳上。

## 1.2产品参数:
1、高分辨率:128*64(和12864LCD相同分辨率，但该OLED屏的单位面积像素点多)
2、超广可视角度:大于160°
3、超低功耗:正常显示时0.06W
4、宽供电范围:直流3.3V-5V
5、工业级:工作温度范围-30℃~70℃
6、体积小:27mm*27mm*2mm
7、通信方式:l2C
8:、亮度、对比度可以通过程序指令控制
9:、使用寿命不少于16000小时
10、OLED屏幕内部驱动芯片:SSD1306

# 2. RT-theard配置
## 2.1 硬件需求
1、需要0.96寸I2C驱动的OLED屏幕进行动态显示，**SDA---p511(p50b);SCL---p512(p50c)**，公式首先将p去掉还有三位，以p511为例，最后转换的数字为 “(5x16x16)+(1x10)+1”算出来为 1291 转换为16进制为0x50b。注：在程序里的话需要将字符转为数字。

> 实现功能：
> OLED屏幕；画直线、矩形框、画圆、画光标、字体。
> 板载按键中断交互，LED3 1Hz频闪。

![在这里插入图片描述](https://img-blog.csdnimg.cn/e98f4dc903de40d6bbf76d0308954c0b.png)
*ssd1306屏幕地址看电阻接线情况为：0x3c（后面需要用到）*
2、RA6M4开发板
![在这里插入图片描述](https://img-blog.csdnimg.cn/4c5dcda23c6d4afaacb393dc46a7ae51.png)
3、USB下载线，ch340串口和附带6根母母线，**rx---p613;tx---p614**
![在这里插入图片描述](https://img-blog.csdnimg.cn/255886d2dc454620840a47d1039e62ba.png)



## 2.2 软件配置
Renesas RA6M4开发板环境配置参照：[【基于 RT-Thread Studio的CPK-RA6M4 开发板环境搭建】](https://blog.csdn.net/vor234/article/details/125634313)
1、新建项目RA6M4-IIC工程
![在这里插入图片描述](https://img-blog.csdnimg.cn/dae77e5a8cd6466da6a01eefdaaf6e97.png)
2、点击RT-theard Setting，在软件包下添加软件包，然后搜索ssd相关软件支持包，点击添加即可,然后出现对应包。
![在这里插入图片描述](https://img-blog.csdnimg.cn/e6dafce1a3c34ec596f1d06c9a3b03ed.png)
3、配置ssd306，右键选择配置项
![在这里插入图片描述](https://img-blog.csdnimg.cn/fa5bebed4b4a4893baa2477806162a0b.png)
4、在软件包中配置上述地址0x3c，开启示例
![在这里插入图片描述](https://img-blog.csdnimg.cn/9e3071dc2e9b44ac97ce0422710d3650.png)
5、在硬件中，启动I2C，设置端口

![在这里插入图片描述](https://img-blog.csdnimg.cn/4284b47fc59b496d91bfe65118b8a761.png)
6、全部保存刚刚的配置，更新当前配置文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/1242d9c0e5a4495c8c18a1d582ca5e09.png)
**保存完是灰色，没有保存是蓝色。**
# 3. 代码分析
1、刚刚加载软件包在packages文件夹下，示例代码为
*ssd1306_tests.c*

```cpp
/*
 * Copyright (c) 2020, RudyLo <luhuadong@163.com>
 *
 * SPDX-License-Identifier: MIT License
 *
 * Change Logs:
 * Date           Author       Notes
 * 2020-11-15     luhuadong    the first version
 */

#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

#include <string.h>
#include <stdio.h>
#include "ssd1306.h"
#include "ssd1306_tests.h"

void ssd1306_TestBorder()
{
    ssd1306_Fill(Black);

    uint32_t start = rt_tick_get();
    uint32_t end = start;
    uint8_t x = 0;
    uint8_t y = 0;
    do {
        ssd1306_DrawPixel(x, y, Black);

        if((y == 0) && (x < 127))
            x++;
        else if((x == 127) && (y < 63))
            y++;
        else if((y == 63) && (x > 0)) 
            x--;
        else
            y--;

        ssd1306_DrawPixel(x, y, White);
        ssd1306_UpdateScreen();
    
        rt_thread_mdelay(5);
        end = rt_tick_get();
    } while((end - start) < 8000);
   
    rt_thread_mdelay(1000);
}

void ssd1306_TestFonts()
{
    ssd1306_Fill(Black);
    ssd1306_SetCursor(2, 0);
    ssd1306_WriteString("Font 16x26", Font_16x26, White);
    ssd1306_SetCursor(2, 26);
    ssd1306_WriteString("Font 11x18", Font_11x18, White);
    ssd1306_SetCursor(2, 26+18);
    ssd1306_WriteString("Font 7x10", Font_7x10, White);
    ssd1306_SetCursor(2, 26+18+10);
    ssd1306_WriteString("Font 6x8", Font_6x8, White);
    ssd1306_UpdateScreen();
}

void ssd1306_TestFPS()
{
    ssd1306_Fill(White);
   
    uint32_t start = rt_tick_get();
    uint32_t end = start;
    int fps = 0;
    char message[] = "ABCDEFGHIJK";
   
    ssd1306_SetCursor(2,0);
    ssd1306_WriteString("Testing...", Font_11x18, Black);
   
    do {
        ssd1306_SetCursor(2, 18);
        ssd1306_WriteString(message, Font_11x18, Black);
        ssd1306_UpdateScreen();
       
        char ch = message[0];
        memmove(message, message+1, sizeof(message)-2);
        message[sizeof(message)-2] = ch;

        fps++;
        end = rt_tick_get();
    } while((end - start) < 5000);
   
    rt_thread_mdelay(1000);

    char buff[64];
    fps = (float)fps / ((end - start) / 1000.0);
    snprintf(buff, sizeof(buff), "~%d FPS", fps);
   
    ssd1306_Fill(White);
    ssd1306_SetCursor(2, 18);
    ssd1306_WriteString(buff, Font_11x18, Black);
    ssd1306_UpdateScreen();
}

void ssd1306_TestLine()
{
    ssd1306_Line(1,1,SSD1306_WIDTH - 1,SSD1306_HEIGHT - 1,White);
    ssd1306_Line(SSD1306_WIDTH - 1,1,1,SSD1306_HEIGHT - 1,White);
    ssd1306_UpdateScreen();
    return;
}

void ssd1306_TestRectangle()
{
    uint32_t delta;

    for(delta = 0; delta < 5; delta ++) 
    {
        ssd1306_DrawRectangle(1 + (5*delta),1 + (5*delta) ,SSD1306_WIDTH-1 - (5*delta),SSD1306_HEIGHT-1 - (5*delta),White);
    }
    ssd1306_UpdateScreen();
    return;
}

void ssd1306_TestCircle()
{
    uint32_t delta;

    for(delta = 0; delta < 5; delta ++) 
    {
        ssd1306_DrawCircle(20* delta+30, 30, 10, White);
    }
    ssd1306_UpdateScreen();
    return;
}

void ssd1306_TestArc()
{
    ssd1306_DrawArc(30, 30, 30, 20, 270, White);
    ssd1306_UpdateScreen();
    return;
}

void ssd1306_TestPolyline()
{
    SSD1306_VERTEX loc_vertex[] =
    {
        {35,40},
        {40,20},
        {45,28},
        {50,10},
        {45,16},
        {50,10},
        {53,16}
    };

    ssd1306_Polyline(loc_vertex,sizeof(loc_vertex)/sizeof(loc_vertex[0]),White);
    ssd1306_UpdateScreen();
    return;
}

void ssd1306_TestAll()
{
    ssd1306_Init();

    ssd1306_TestFPS();
    rt_thread_mdelay(3000);

    ssd1306_TestBorder();

    ssd1306_TestFonts();
    rt_thread_mdelay(3000);

    ssd1306_Fill(Black);
    ssd1306_TestRectangle();
    ssd1306_TestLine();
    rt_thread_mdelay(3000);

    ssd1306_Fill(Black);
    ssd1306_TestPolyline();
    rt_thread_mdelay(3000);

    ssd1306_Fill(Black);
    ssd1306_TestArc();
    rt_thread_mdelay(3000);

    ssd1306_Fill(Black);
    ssd1306_TestCircle();
    rt_thread_mdelay(3000);
}

#ifdef FINSH_USING_MSH
MSH_CMD_EXPORT(ssd1306_TestAll, test ssd1306 oled driver);
#endif

```

2、此库包含画直线（ssd1306_TestPolyline();）、矩形框（ssd1306_TestRectangle();）、画圆（ssd1306_TestCircle();）、画光标（ssd1306_TestArc();）、字体（ssd1306_TestFonts();）。调用时直接在串口CMD命令输入“ssd1306_TestAll”，即可查看对应切换。
![在这里插入图片描述](https://img-blog.csdnimg.cn/8cbbbc52e5d24f2e8b69c43a855771e0.png)
3、main.c文件在re_gen文件夹下，主程序围绕“hal_entry();”函数（在src文件夹）
*main.c*
```cpp
/* generated main source file - do not edit */
#include "hal_data.h"
            int main(void) {
              hal_entry();
              return 0;
            }

```
*hal_entry.c*
```cpp
/*
 * Copyright (c) 2006-2021, RT-Thread Development Team
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Change Logs:
 * Date           Author        Notes
 * 2021-10-10     Sherman       first version
 * 2021-11-03     Sherman       Add icu_sample
 */

#include <rtthread.h>
#include "hal_data.h"
#include <rtdevice.h>

#define LED3_PIN    BSP_IO_PORT_01_PIN_06
#define USER_INPUT  "P105"

void hal_entry(void)
{
    rt_kprintf("\nHello RT-Thread!\n");

    while (1)
    {
        rt_pin_write(LED3_PIN, PIN_HIGH);
        rt_thread_mdelay(500);
        rt_pin_write(LED3_PIN, PIN_LOW);
        rt_thread_mdelay(500);
    }
}

void irq_callback_test(void *args)
{
    rt_kprintf("\n IRQ00 triggered \n");
}

void icu_sample(void)
{
    /* init */
    rt_uint32_t pin = rt_pin_get(USER_INPUT);
    rt_kprintf("\n pin number : 0x%04X \n", pin);
    rt_err_t err = rt_pin_attach_irq(pin, PIN_IRQ_MODE_RISING, irq_callback_test, RT_NULL);
    if(RT_EOK != err)
    {
        rt_kprintf("\n attach irq failed. \n");
    }
    err = rt_pin_irq_enable(pin, PIN_IRQ_ENABLE);
    if(RT_EOK != err)
    {
        rt_kprintf("\n enable irq failed. \n");
    }
}
MSH_CMD_EXPORT(icu_sample, icu sample);

```
# 4. 下载验证
1、编译重构
![在这里插入图片描述](https://img-blog.csdnimg.cn/c9c7620361874f41841f31b0596318be.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/3229d590ec9845c6ba4b66f2c85d28ea.png)
编译成功

2、下载程序
![在这里插入图片描述](https://img-blog.csdnimg.cn/e2496e571acb49f09a85e51fe077d606.png)
下载成功


3、CMD串口调试

![在这里插入图片描述](https://img-blog.csdnimg.cn/181227ee2ed64ef2801477ece50cf41c.png)
然后板载复位
输入：ssd1306_TestAll，开始显示！🎉🎉🎉
![在这里插入图片描述](https://img-blog.csdnimg.cn/b2e61abb93bd4012bba5f24646296bd8.png)
效果如下
![请添加图片描述](https://img-blog.csdnimg.cn/c209e553376e4263b30b9f90571a6a2c.gif)
这样我们就可以天马行空啦!![请添加图片描述](https://img-blog.csdnimg.cn/92099d4d054b4b2cbd39b95719739a90.gif)

参考文献；
[【基于 RT-Thread Studio的CPK-RA6M4 开发板环境搭建】](https://blog.csdn.net/vor234/article/details/125634313)
