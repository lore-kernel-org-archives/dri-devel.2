Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E24C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E5FB10ED5A;
	Tue, 14 Jul 2026 13:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vaa7jqYw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0305810ED5A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:43:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1001D601ED;
 Tue, 14 Jul 2026 13:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1101F000E9;
 Tue, 14 Jul 2026 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784036634;
 bh=/8BBFCby8zpZvXm8ZgPtUr5fAkL8w8J4AaTBkdkpBLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vaa7jqYwjxH7jgnVrXDsqOSYxfEdnoDKC8Od62lDJoJt3rowd6ghPLRjCoV3nnyGI
 xjEtab4im6+sj1zgDvgVoUsrrClqTItlsIdRvabj3cUp5RZmR9qhafTCaBfLiYJpTh
 Sbm8mrsl1JdRDbRn32ngk4D7HHPadeR68iMd/a1PyAIUwlWww1TxynJ7z0ogE2c8NQ
 fQG62TbACSpl4NtBvV/l3OCveNS9n/R2oVaI34mhBtni+xK5zYQhhUC0lXvKZWqDv3
 XfxUa4Eoq8g+XiANfNy4XantampTaBnF2LlP31+KkwoAuGZI1IzUXSVgdyQYE858ea
 uZq0ohgsvou8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes 2/2] drm/hisilicon/hibmc: Add a flag
 to indicate whether the OS-side driver has been loaded
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714132051.993356-3-shiyongbang@huawei.com>
References: <20260714132051.993356-1-shiyongbang@huawei.com>
 <20260714132051.993356-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:43:54 +0000
Message-Id: <20260714134354.8F1101F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Directly writing to the `HIBMC_ENABLE_FLAG` register clobbers the =
`GPIO_DATA_DIRECTION` I2C bits and creates a data race.
- [High] The disable flag is set too early in the teardown sequence, allowi=
ng the BMC to re-enable DP hardware while the OS driver is still active.
--

--- Patch [2]: [PATCH for drm-misc-fixes 2/2] drm/hisilicon/hibmc: Add a fl=
ag to indicate whether the OS-side driver has been loaded ---
commit bfee57e8491146f1282ee8dc01bf699cf1bf50ed
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver has =
been loaded

This patch adds a flag to indicate whether the OS-side driver has been
loaded to prevent the BMC from enabling DP if the driver is not loaded,
which could lead to system failure in handling interrupts.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index e5cca7b63b787..6436263a6c039 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

[ ... ]

> @@ -424,6 +424,16 @@ static int hibmc_load(struct drm_device *dev)
>  	return ret;
>  }
> =20
> +static inline void hibmc_set_enable_flag(struct hibmc_drm_private *priv)
> +{
> +	writel(HIBMC_ENABLE_STATE, priv->mmio + HIBMC_ENABLE_FLAG);
> +}
> +
> +static inline void hibmc_set_disable_flag(struct hibmc_drm_private *priv)
> +{
> +	writel(0, priv->mmio + HIBMC_ENABLE_FLAG);
> +}

[Severity: High]
Does this direct writel() overwrite the I2C bus state?

The HIBMC_ENABLE_FLAG offset is 0x802A4, which aliases the
GPIO_DATA_DIRECTION I2C register used by the driver's I2C bit-banging code.

Writing directly instead of using a read-modify-write clears the I2C
mask bits that might be currently active. Direct writing of 0 clears both
the enable bit and the I2C direction bits.

>  static int hibmc_pci_probe(struct pci_dev *pdev,
>  			   const struct pci_device_id *ent)
>  {

[ ... ]

> @@ -468,6 +478,8 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
> =20
>  	drm_client_setup(dev, NULL);
> =20
> +	hibmc_set_enable_flag(priv);
> +

[Severity: High]
Can this call to hibmc_set_enable_flag() race with I2C EDID reads?

Calling this immediately after drm_client_setup() means fbdev initialization
can asynchronously probe connectors and trigger I2C bit-banging.

Without locking between the I2C code's read-modify-write cycle and this
direct write, the I2C code might overwrite and clear the enable flag,
reverting the BMC driver status this patch intended to set.

>  	return 0;
> =20
>  err_unload:
> @@ -480,6 +492,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev =3D pci_get_drvdata(pdev);
> =20
> +	hibmc_set_disable_flag(to_hibmc_drm_private(dev));

[Severity: High]
Is it safe to clear the disable flag before userspace is locked out and the
hardware is quiesced?

By clearing the flag before calling drm_dev_unregister() and hibmc_unload(),
the BMC might attempt to take over the DP hardware or ignore interrupts
while the OS is still actively managing it. This could race with the shutdo=
wn
of the display hardware in hibmc_unload().

>  	drm_dev_unregister(dev);
>  	hibmc_unload(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714132051.9933=
56-1-shiyongbang@huawei.com?part=3D2
