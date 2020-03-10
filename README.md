# Lenovo-G50-80-macOS

This repository provides OpenCore configuration files for Lenovo-G50-80. 

[![release](https://img.shields.io/badge/下载-release-blue.svg)](https://github.com/chiccheung/Lenovo-G50-80-macOS/releases) 
 

## 电脑配置

| 规格     | 详细信息 |
| -------- | ---------------------------------------- |
| 电脑型号 | Lenovo G50-80 |
| 处理器 | Intel i5-5200U |
| 内存插槽一 | Kingston 4GB DDR3 1600MHz |
| 内存插槽二 | Samsung  4GB DDR3 1600MHz |
| 硬盘插槽一 | KINGSTON 120GB SATA |
| 硬盘插槽二 | Western Digital 500GB SATA |
| 集成显卡 | Interl(R) HD Graphics 5500 Broadwell |
| 独立显卡 | AMD Radeon R5 M330 |
| 显示器   | 内建显示器 15.5 - 英寸 (1920 x 1080) |
| 声卡     | CONEXANT CX20752  |
| 网卡     | Qualcomm Atheros AR956x |


## 详情

<b>系统版本：macOS Catalina 10.15.3 (19D76)｜ Open Core 版本：0.5.7</b>

<b>正常工作项说明</b>

- 使用 acidanthera 推荐的轻量级编辑器[ProperTree](https://github.com/corpnewt/ProperTree)修改 config.plist 文件
- Qualcomm Atheros AR956x 在 macOS Catalina 下工作状况不理想，使用 COMFAST USB无线网卡
  - 参阅：[Wireless-USB-Adapter-Clover](https://github.com/chris1111/Wireless-USB-Adapter-Clover) 

<b>不正常工作项说明</b>

- 独立显卡
  - 已注入设备属性 `disable-external-gpu` 禁用此设备，减少电量消耗
- 读卡器
- Qualcomm Atheros AR956x 无线网卡 & 蓝牙
- SystemSerialNumber & MLB 请在 config.plst 相关条目下自行添加，以正常使用 App Store
  - 参阅：[使用OpenCore引导黑苹果](https://blog.xjn819.com/?p=543)
  - 工具：[macinfo](https://github.com/acidanthera/MacInfoPkg/releases)
  - 命令：`./macserial -m MacBookPro12,1`

## 资料

-  OpenCore
   - 参阅：[OpenCorePkg](https://github.com/acidanthera/OpenCorePkg)
   - 参阅：[使用OpenCore引导黑苹果](https://blog.xjn819.com/?p=543)

-  ACIP hotpatch 修补
   - 参阅：[OC-little](https://github.com/daliansky/OC-little)
   - 参阅：[电池 hotpatch](https://github.com/chiccheung/Lenovo-G50-80-macOS/blob/master/Files/SSDT-OCBAT0-LenovoG50-80.dsl)

-  Clover
   - 参阅：[Clover-EFI](https://github.com/chiccheung/Lenovo-G50-80-macOS/blob/master/Files/Clover-EFI.zip)
   - 说明：Clover引导文件没有进行深入测试

-  键盘触摸板
   - 驱动：[SmartTouchpad](https://github.com/chiccheung/Lenovo-G50-80-macOS/blob/master/Files/SmartTouchpad%20v4.7%20beta%205.zip)
   - 说明：VoodooPS2 无法使触摸板正常工作，详情 [issues#557](https://github.com/acidanthera/bugtracker/issues/557)，故使用 SmartTouchpad 来驱动键盘触摸板

## 许可证声明

- Copyright (c) 2016-2017, The HermitCrabs Lab
- Copyright (c) 2016-2019, Download-Fritz
- Copyright (c) 2017-2019, savvas
- Copyright (c) 2016-2019, vit9696
