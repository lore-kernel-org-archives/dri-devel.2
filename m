Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91477C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBB310E0A9;
	Tue, 21 Jul 2026 13:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N2LBTaDv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCDF10E0A9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:06:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E3B541B31;
 Tue, 21 Jul 2026 13:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D821F000E9;
 Tue, 21 Jul 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784639173;
 bh=N0luUbbWixu1B0H865xxVLvACliLCXHFGro+ERiVkrc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N2LBTaDvSQ+FUUN8MTNyQnQ7ZH3COvqfgJ8ybfO0Ewlo64FNTO4owniOF1sDFvTqM
 tB2RlWiJnYTfuhf4YTmQBmWIvVy098Si3BV22p1mdke2PnNiaaxhmKf7Pf95lMI4z0
 +o1Vv1tVlDWXwe6TusoyOTpGDag6QUVuT6JgPIhxgxPCjtjTXCFCLkZrKjJsRkajnJ
 sAdaPfx6teSTvZp2WZ6ujpD/mxw0qf4cx45KNmLM+crIIWZ0W+QkQdxffR6ESIixHJ
 P4palt+MUUgzxBAscehm2JSd5NzY63jrF+x3WWXmbJJgw+59Blq9ZEw4f8L0L8f9ov
 vNm76NezOk8eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v2 2/2] drm/hisilicon/hibmc: Add a
 flag to indicate whether the OS-side driver has been loaded
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721124324.1885856-3-shiyongbang@huawei.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:06:12 +0000
Message-Id: <20260721130613.16D821F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unlocked read-modify-write of the shared HIBMC_ENABLE_FLAG/GPIO_DA=
TA_DIRECTION register causes a data race, leading to I2C corruption or stat=
e loss.
- [High] Improper hardware enable/disable sequencing exposes uninitialized =
hardware to userspace and causes atomic shutdown timeouts.
- [Medium] HIBMC_ENABLE_FLAG is not cleared during early hardware initializ=
ation, limiting the fix's effectiveness on kexec or warm reboots.

Pre-existing issues:
- [High] The DRM poll worker can access unmapped MMIO memory after device r=
emoval due to inverted devm/drmm lifetimes.
--

--- Patch [2]: [PATCH for drm-misc-fixes v2 2/2] drm/hisilicon/hibmc: Add a=
 flag to indicate whether the OS-side driver has been loaded ---
commit 922d7ef6815cd065c3b6a7899d595e2a03634bf4
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has =
been loaded

This commit adds a hardware flag to indicate when the OS driver is loaded,
preventing the BMC from enabling DP prematurely. This aims to fix issues
with spurious unhandled interrupts during driver initialization.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index e5cca7b63b787..53c02f8b88413 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

[ ... ]

> @@ -424,6 +424,24 @@ static int hibmc_load(struct drm_device *dev)
>  	return ret;
>  }
> =20
> +static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
> +{
> +	u32 value;
> +
> +	value =3D readl(priv->mmio + HIBMC_ENABLE_FLAG);
> +	value |=3D HIBMC_ENABLE_STATE;
> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
> +}
> +
> +static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
> +{
> +	u32 value;
> +
> +	value =3D readl(priv->mmio + HIBMC_ENABLE_FLAG);
> +	value &=3D ~HIBMC_ENABLE_STATE;
> +	writel(value, priv->mmio + HIBMC_ENABLE_FLAG);
> +}

[Severity: High]
Could this read-modify-write sequence race with concurrent I2C operations?

The register HIBMC_ENABLE_FLAG (0x802A4) shares the exact same physical
address as GPIO_DATA_DIRECTION. The existing I2C bit-banging code also
performs unlocked RMWs on this register:

hibmc_drm_i2c.c:hibmc_set_i2c_signal() {
    u32 tmp_dir =3D readl(priv->mmio + GPIO_DATA_DIRECTION);
    ...
    tmp_dir &=3D ~mask;
    writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
}

Since this flag is modified during probe while userspace might concurrently
issue ioctls that trigger I2C bit-banging operations, does this need a
spinlock to prevent data corruption of either the I2C direction bits or the
enable state?

[Severity: Medium]
Does this hardware flag need to be explicitly cleared during early hardware
initialization?

If the kernel panics or reboots via kexec without a cold hardware reset,
HIBMC_ENABLE_FLAG remains set from the previous boot. On the subsequent boo=
t,
the BMC might incorrectly assume the OS driver is already loaded and fire DP
interrupts before the driver has initialized its interrupt handlers, causing
the exact "irq xx: nobody cared" bug this patch attempts to fix.

Would it be safer to clear it early in hibmc_hw_init()?

> @@ -466,6 +484,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  		goto err_unload;
>  	}
> =20
> +	hibmc_set_enable_flag(priv);
> +
>  	drm_client_setup(dev, NULL);
> =20
>  	return 0;

[Severity: High]
Is it safe to set this hardware enable flag after the DRM device is already
registered?

Because drm_dev_register() is called earlier in this function, the device is
already exposed to userspace. A user could interact with the device before
the BMC is instructed to enable DP.

Should hibmc_set_enable_flag() be called before drm_dev_register()?

> @@ -480,6 +500,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> =20
> +	hibmc_set_disable_flag(to_hibmc_drm_private(dev));
>  	drm_dev_unregister(dev);
>  	hibmc_unload(dev);
>  }

[Severity: High]
Could disabling the hardware flag here cause the subsequent atomic shutdown
to hang?

This calls hibmc_set_disable_flag() before drm_dev_unregister() and before
hibmc_unload() invokes drm_atomic_helper_shutdown(). If the hardware is
forcefully disabled while the DRM display pipeline is actively driving it,
can it lead to I2C/AUX timeouts or hanging commits during shutdown?

[Severity: High]
This is a pre-existing issue, but can the DRM poll worker access unmapped
MMIO memory after device removal here?

The MMIO region priv->mmio is mapped using devm_ioremap(), which binds
its lifetime to the PCI device. However, the output poll worker is
initialized via drmm_kms_helper_poll_init(), binding its lifetime to
the drm_device refcount.

If a userspace process holds the DRM device file open during a device
unbind or hot-unplug, hibmc_pci_remove() will complete and devres will
unmap the MMIO region. Because the drm_device is still alive, the poll
worker remains active and its next execution will access the unmapped
memory.

Should the poll worker be explicitly stopped in hibmc_unload()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721124324.1885=
856-1-shiyongbang@huawei.com?part=3D2
