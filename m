Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060EB10F590;
	Thu,  3 Sep 2026 12:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="ciZ5i2Nc";
	dkim-atps=neutral
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E7A10F590
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:51:52 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YHnZhrvww+/2PP0gI/LLXYXbIGDpd1kbNSWgnZtJLz0=;
 b=ciZ5i2NcZyclAn/Hb2IMQedebwuZnrlxIl2utGhS+AqSRu1PYvkehDK8kZQisJ8eS2WNDhI+i
 E4J0qcxhgcegSQf0cTehZHdZbOyiOWezCXEmLTnSeddU+xUjiyMZRIeQeGXo2rYRyr8xYqumlCF
 eexCOk2NKfb/ti9ml5kWGIk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hbK2T71QxzKm5m;
 Thu,  3 Sep 2026 20:40:49 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5DB0540578;
 Thu,  3 Sep 2026 20:51:44 +0800 (CST)
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 3 Sep 2026 20:51:43 +0800
Message-ID: <8feb2036-689e-4cfa-b091-263d9048575c@huawei.com>
Date: Thu, 3 Sep 2026 20:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v2 2/2] drm/hisilicon/hibmc: Add a flag
 to indicate whether the OS-side driver has been loaded
To: <sashiko-reviews@lists.linux.dev>, Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>, "tiantao (H)" <tiantao6@hisilicon.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
 "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>, <shiyongbang@huawei.com>,
 "Liangjian(Jim, Kunpeng Solution Development Dept)" <liangjian010@huawei.com>, 
 Chenjianmin <chenjianmin@huawei.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-3-shiyongbang@huawei.com>
 <20260721130613.16D821F000E9@smtp.kernel.org>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260721130613.16D821F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200005.china.huawei.com (7.202.194.71)
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Unlocked read-modify-write of the shared HIBMC_ENABLE_FLAG/GPIO_DATA_DIRECTION register causes a data race, leading to I2C corruption or state loss.
> - [High] Improper hardware enable/disable sequencing exposes uninitialized hardware to userspace and causes atomic shutdown timeouts.
> - [Medium] HIBMC_ENABLE_FLAG is not cleared during early hardware initialization, limiting the fix's effectiveness on kexec or warm reboots.
> 
> Pre-existing issues:
> - [High] The DRM poll worker can access unmapped MMIO memory after device removal due to inverted devm/drmm lifetimes.
> --
> 
> --- Patch [2]: [PATCH for drm-misc-fixes v2 2/2] drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has been loaded ---
> commit 922d7ef6815cd065c3b6a7899d595e2a03634bf4
> Author: Lin He <helin52@huawei.com>
> 
> drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has been loaded
> 
> This commit adds a hardware flag to indicate when the OS driver is loaded,
> preventing the BMC from enabling DP prematurely. This aims to fix issues
> with spurious unhandled interrupts during driver initialization.
> 
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index e5cca7b63b787..53c02f8b88413 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> 
> [ ... ]
> 
>> @@ -424,6 +424,24 @@ static int hibmc_load(struct drm_device *dev)
>>   	return ret;
>>   }
>>   
>> +static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
>> +{
>> +	u32 value;
>> +
>> +	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
>> +	value |= HIBMC_ENABLE_STATE;
>> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
>> +}
>> +
>> +static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
>> +{
>> +	u32 value;
>> +
>> +	value = readl(priv->mmio + HIBMC_ENABLE_FLAG);
>> +	value &= ~HIBMC_ENABLE_STATE;
>> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
>> +}
> 
> [Severity: High]
> Could this read-modify-write sequence race with concurrent I2C operations?
> 
> The register HIBMC_ENABLE_FLAG (0x802A4) shares the exact same physical
> address as GPIO_DATA_DIRECTION. The existing I2C bit-banging code also
> performs unlocked RMWs on this register:
> 
> hibmc_drm_i2c.c:hibmc_set_i2c_signal() {
>      u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
>      ...
>      tmp_dir &= ~mask;
>      writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
> }
> 
> Since this flag is modified during probe while userspace might concurrently
> issue ioctls that trigger I2C bit-banging operations, does this need a
> spinlock to prevent data corruption of either the I2C direction bits or the
> enable state?
> 

You are right, this is a genuine race condition and needs to be fixed.

> [Severity: Medium]
> Does this hardware flag need to be explicitly cleared during early hardware
> initialization?
> 
> If the kernel panics or reboots via kexec without a cold hardware reset,
> HIBMC_ENABLE_FLAG remains set from the previous boot. On the subsequent boot,
> the BMC might incorrectly assume the OS driver is already loaded and fire DP
> interrupts before the driver has initialized its interrupt handlers, causing
> the exact "irq xx: nobody cared" bug this patch attempts to fix.
> 
> Would it be safer to clear it early in hibmc_hw_init()?
> 

I understand the concern, but I believe clearing the flag in
`hibmc_hw_init()` is unnecessary and would actually be harmful. Here
are three independent reasons:

1. Flag purpose: HIBMC_ENABLE_STATE (BIT(2)) signals the BMC that the
    OS DP driver has finished initialization. Clearing it would cause
    the BMC to believe the OS is not loaded, triggering a host switch
    that disrupts the current host's display in dual-host KVM scenarios.

2. BMC judgment conditions: The BMC does not rely solely on this flag —
    it also checks host presence state. Even if the flag remains set,
    the BMC would not send DP interrupts to a host whose driver has not
    initialized. The risk scenario described in the review does not
    exist.

3. Register cleared on host reset: The register (0x802A4) is cleared by
    hardware on host reset. Since kexec triggers a host reset, the flag
    is already zeroed — the review's premise that "the flag persists
    from the previous boot" is invalid on the kexec path.

Additionally, `hibmc_dp_hw_init()` disables DP interrupts during init,
and they are only re-enabled after the IRQ handler is registered.

>> @@ -466,6 +484,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>>   		goto err_unload;
>>   	}
>>   
>> +	hibmc_set_enable_flag(priv);
>> +
>>   	drm_client_setup(dev, NULL);
>>   
>>   	return 0;
> 
> [Severity: High]
> Is it safe to set this hardware enable flag after the DRM device is already
> registered?
> 
> Because drm_dev_register() is called earlier in this function, the device is
> already exposed to userspace. A user could interact with the device before
> the BMC is instructed to enable DP.
> 
> Should hibmc_set_enable_flag() be called before drm_dev_register()?
> 

You are right, I will move `hibmc_set_enable_flag()` before `drm_dev_register()`
in v3.

>> @@ -480,6 +500,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>>   {
>>   	struct drm_device *dev = pci_get_drvdata(pdev);
>>   
>> +	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
>>   	drm_dev_unregister(dev);
>>   	hibmc_unload(dev);
>>   }
> 
> [Severity: High]
> Could disabling the hardware flag here cause the subsequent atomic shutdown
> to hang?
> 
> This calls hibmc_set_disable_flag() before drm_dev_unregister() and before
> hibmc_unload() invokes drm_atomic_helper_shutdown(). If the hardware is
> forcefully disabled while the DRM display pipeline is actively driving it,
> can it lead to I2C/AUX timeouts or hanging commits during shutdown?
> 

I don't believe this change would cause a shutdown hang, for two
reasons:

1. HIBMC_ENABLE_FLAG does not control any hardware display pipeline —
    it is only a software communication flag between the OS driver and
    the BMC. Clearing it does not forcefully disable any hardware
    block.

2. drm_atomic_helper_shutdown() and all I2C/AUX operations work
    directly through MMIO registers, independent of this flag's state.
    Therefore, disabling the flag cannot cause I2C/AUX timeouts or
    hanging commits.

Additionally, moving the disable flag call after drm_dev_unregister()
provides proper symmetry with the probe path (where we set the enable
flag before drm_dev_register()).


> [Severity: High]
> This is a pre-existing issue, but can the DRM poll worker access unmapped
> MMIO memory after device removal here?
> 
> The MMIO region priv->mmio is mapped using devm_ioremap(), which binds
> its lifetime to the PCI device. However, the output poll worker is
> initialized via drmm_kms_helper_poll_init(), binding its lifetime to
> the drm_device refcount.
> 
> If a userspace process holds the DRM device file open during a device
> unbind or hot-unplug, hibmc_pci_remove() will complete and devres will
> unmap the MMIO region. Because the drm_device is still alive, the poll
> worker remains active and its next execution will access the unmapped
> memory.
> 
> Should the poll worker be explicitly stopped in hibmc_unload()?
> 

Hi Thomas,

Sashiko AI raised a use-after-unmap concern on the poll worker in
hibmc_pci_remove. Investigation found the issue has two aspects, both
class-level (not hibmc-specific — ast and mgag200 share the same
structure).

The scoping question that determines severity and scope:

   Should "userspace holds a DRM fd during device unbind / hot-unplug"
   be a scenario bmc considers?

This determines which aspect matters and how far the fix should go.

   == Aspect 1: fd-held unbind (special trigger, ~certain UAF) ==

   Trigger: PCI unbind via sysfs while userspace holds a DRM fd.
   This is a special path (developer/abnormal operation), but once
   triggered the UAF is basically guaranteed. devres unwinds in reverse
   order: iounmap runs BEFORE drm_dev_put. With kref > 0, drm_dev_release
   never triggers, so all drmm actions are skipped and the poll worker
   keeps running after MMIO is unmapped:

     pci_remove  (same timing for hibmc / ast / mgag200)
     +-- drm_dev_unregister()       registered=false; unplugged NOT set
     +-- unload / atomic_helper_shutdown   [no explicit poll_fini]
     --- devres unwind (reverse order) ---
     #2  iounmap(mmio)              <-- MMIO DEAD FROM HERE
     #1  drm_dev_put()              kref > 0 (fd held)
         |
         X  drmm actions: NEVER run <-- poll_fini skipped (hibmc/ast)
         |                          <-- i2c_del_adapter skipped (ast/mga)
         |
         +-- poll worker: detect -> I2C -> readl/writel(mmio)  [UAF]
         |   (~10s, only if VGA connector polled; DP is POLL_HPD, skipped)
         +-- ioctl on open fd: detect -> AUX/I2C -> readl/writel(mmio)
         |   [UAF, IMMEDIATE — confirmed by oops]
         |   Xorg holds fd -> GETCONNECTOR -> hibmc_dp_aux_xfer
         |   -> readl(priv->mmio) -> page fault
         +-- DP HPD ISR (hibmc only): drm_dev_enter -> unplugged? NO -> [UAF]

   Manual poll_fini closes the poll worker path but NOT the ioctl path —
   ioctl doesn't go through the poll worker. Closing ioctl requires:
     (a1) drm_dev_unplug instead of drm_dev_unregister in pci_remove
          -> sets dev->unplugged, blocks ioctl in drm_ioctl,
          activates drm_dev_enter
     (a2) drm_dev_enter/drm_dev_exit in detect and I2C/AUX callbacks
     (a2) without (a1) is a no-op — this is why the existing DP HPD ISR
     protection is currently ineffective.

   So the scoping question becomes: if the fd-held scenario should be
   handled, (a1)+(a2) are needed beyond poll_fini.

   == Aspect 2: no-fd unbind (normal path, us-level window) ==

   Trigger: rmmod (blocked by fd, so no fd when it runs) or normal
   shutdown. This is the ordinary path.

   I checked drm_atomic_helper_shutdown (drm_atomic_helper.c):
   it only calls drm_atomic_helper_disable_all (disables all CRTC) and
   does NOT stop the poll worker. So the poll worker is only stopped by
   the drmm release action at kref=0, which runs AFTER iounmap:

     pci_remove
     +-- drm_dev_unregister()
     +-- hibmc_unload
     |   +-- drm_atomic_helper_shutdown()    [disables CRTC, NOT poll]
     --- devres unwind ---
     #2  iounmap(priv->mmio)            <-- MMIO DEAD (window starts)
     #1  drm_dev_put -> kref=0 -> drmm poll_fini   [STOP, window ends]
                                         ^^^ us-level gap ^^^

   The window is us-level (devres unwind between iounmap and drm_dev_put),
   poll period is 10s, so probability is ~10^-6. Combined with "BMC GPU
   rmmod is rare in production", this likely explains why it hasn't
   surfaced. But the window is structurally real.

   Manual poll_fini in hibmc_unload closes this window — stops the poll
   worker BEFORE iounmap. This is sufficient and curative for Aspect 2.
   ast and mgag200 have the same window and should apply the same fix.

     Proposed fix:

     hibmc_pci_remove
     +-- drm_dev_unregister()
     +-- hibmc_unload
     |   +-- drm_kms_helper_poll_fini()   <-- STOP POLL WORKER HERE
     |   +-- drm_atomic_helper_shutdown()
     --- devres unwind ---
     #2  iounmap(priv->mmio)              <-- worker already stopped, safe
     #1  drm_dev_put -> drmm poll_fini -> poll_enabled=false, early-return

   The drmm release action checks poll_enabled and early-returns when
   false, so the duplicate drmm call after a manual poll_fini is safe —
   no double cancel, no warning. Error paths are also safe (poll_enabled
   =false at init if drmm_kms_helper_poll_init hasn't run).

   == Summary ==

   poll_fini (Aspect 2 fix) should be done regardless — it closes a real
   (if small) window in the normal path, and applies to all three BMC
   GPU drivers. The scoping question is whether to also do (a1)+(a2)
   for the fd-held scenario (Aspect 1). If yes, poll_fini is still
   needed (drm_dev_unplug doesn't stop the poll worker); if no, poll_fini
   alone is the original review suggestion and sufficient for Aspect 2.

Thanks,
Yongbang.
