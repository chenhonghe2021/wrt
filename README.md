# wrt
istoreos openwrt 相关


cleanup.sh 这个脚本链接指向的是一个远程文件。我可以帮您获取并运行这个脚本，但出于**安全考虑**，在执行任何来自互联网的脚本之前，**强烈建议**您先查看其内容，以确保它不会执行有害或意料之外的操作。

**安全警告：** 运行来自互联网的脚本时，您是在授予该脚本与您当前用户（通常是 `root`）相同的权限。

### 📋 步骤一：查看脚本内容 (推荐)

您可以使用 `curl` 命令将脚本内容打印到屏幕上进行检查，而不是直接执行它。

```bash
curl -sL https://raw.githubusercontent.com/chenhonghe2021/wrt/refs/heads/main/cleanup.sh
```

### 📋 步骤二：运行脚本

如果您确认脚本内容安全，并且您想在 iStoreOS 上运行它，可以使用以下命令：

```bash
sh -c "$(curl -sL https://raw.githubusercontent.com/chenhonghe2021/wrt/refs/heads/main/cleanup.sh)"
```

**说明：**

  * `curl -sL ...`：下载脚本内容，`-s` 静默模式，`-L` 跟随重定向。
  * `sh -c "..."`：使用 `/bin/sh`（OpenWrt/iStoreOS 的默认 Shell，通常是 BusyBox `ash`）来执行下载的内容，而不是使用 `bash`，以确保在精简系统上的最大兼容性。

-----

**请注意：** 如果您运行后遇到任何错误或觉得清理效果不佳，您可以参考我上面提供的 [iStoreOS/OpenWrt 空间清理脚本](#%E2%9C%A8-istoreosopenwrt-%E7%A9%BA%E9%97%B4%E6%B8%85%E7%90%86%E8%84%9A%E6%9C%AC) 的内容，它专注于标准的 OpenWrt 清理操作，具有很好的兼容性和安全性。

您是否已经查看了该链接脚本的内容，并确认要直接在您的 iStoreOS 上运行它？
