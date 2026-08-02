Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50D5C5516F
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 00:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397E810E3A9;
	Sun,  2 Aug 2026 00:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ftzErIBO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381C010E3A9
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 00:34:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23BEF6057A;
 Sun,  2 Aug 2026 00:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48341F00AC4;
 Sun,  2 Aug 2026 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785630892;
 bh=BDksBAHXJlUKWoDV9Y/ePca01ZdN3WSGsdkOHh+qOsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ftzErIBOTMp15Arc2+Gjw41iypfXaLjLGqXM/ldQa5lBeaaZb02mcD6yTFOCYsom8
 B0EVu+9BWnwirlrpGFMFSuGthzx2/r+aQ1bV+vhLHNrcYRh3I2g3TmpT6S5i/2OFc5
 uA/FMpxaMAokQx1L4XGEn1kZpUdBKPSqU/np4ptApTTBl6LtUiEoP5ct5LwG0g5FMz
 Yo6C4KFNjnMKCLlPpC+4GBLq9oshwm6zlU077lWzam2ijAijqTbbsGAicfzCu3DrLi
 Bn2VpwyJ+nQxQ3Fh+aJtsXNAVATvp7beCmQSpzY9mztX/SByL6OHlH8VIMo/qXvzek
 pmUpQBANAmFhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/kmb: Handle DSI clock enable failures
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260802002512.486369-1-dbgh9129@gmail.com>
References: <20260802002512.486369-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 00:34:52 +0000
Message-Id: <20260802003452.A48341F00AC4@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel panic due to ERR_PTR dereference when kmb_dsi_init() fails.
- [High] Singleton dsi_host prevents re-registration on unbind/rebind.
- [High] Severe device reference and devres leaks involving the DSI platfor=
m device.
--

--- Patch [1]: [PATCH v1] drm/kmb: Handle DSI clock enable failures ---
commit 91e06039c775a24291e2b65a4018e13b758801ff
Author: Yuho Choi <dbgh9129@gmail.com>

drm/kmb: Handle DSI clock enable failures
   =20
Disable clocks that were enabled before a later DSI clock fails, and
track whether the complete DSI clock set is enabled so teardown does
not disable partially initialized clocks. Propagate kmb_dsi_clk_init()
failures through the display hardware initialization path instead of
continuing with a partially initialized DSI device.

> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 7c2eb1152fc2f..fef76d6781b43 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -61,6 +61,8 @@ static int kmb_initialize_clocks(struct kmb_drm_private=
 *kmb, struct device *dev
>  	drm_info(&kmb->drm, "system clk =3D %d Mhz", kmb->sys_clk_mhz);
> =20
>  	ret =3D  kmb_dsi_clk_init(kmb->kmb_dsi);
> +	if (ret)
> +		return ret;
> =20
>  	/* Set LCD clock to 200 Mhz */
>  	clk_set_rate(kmb->kmb_clk.clk_lcd, KMB_LCD_DEFAULT_CLK);

[ ... ]

> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
> index 59d0e856392fc..07dc4e324426d 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
> @@ -175,9 +175,14 @@ mipi_hs_freq_range[MIPI_DPHY_DEFAULT_BIT_RATES] =3D {
> =20
>  static void kmb_dsi_clk_disable(struct kmb_dsi *kmb_dsi)
>  {
> +	if (!kmb_dsi->dsi_clk_enabled)
> +		return;

[Severity: High]
This isn't a bug introduced by this patch, but will this cause a kernel
panic if kmb_dsi_init() fails?

Looking at kmb_probe(), if DSI initialization fails, it returns an
ERR_PTR which is stored in kmb->kmb_dsi:

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    ...
    kmb->kmb_dsi =3D kmb_dsi_init(dsi_pdev);
    if (IS_ERR(kmb->kmb_dsi)) {
        drm_err(&kmb->drm, "failed to initialize DSI\n");
        ret =3D PTR_ERR(kmb->kmb_dsi);
        goto err_free1;
    }

The error handler then jumps to err_free1:

err_free1:
    dev_set_drvdata(dev, NULL);
    kmb_dsi_host_unregister(kmb->kmb_dsi);
}

Then kmb_dsi_host_unregister() calls kmb_dsi_clk_disable() where
kmb_dsi is dereferenced. Can we add an IS_ERR_OR_NULL() check here,
or avoid calling unregister on the error pointer in the probe cleanup path?

[Severity: High]
This is a pre-existing issue, but does unbinding and rebinding the driver
permanently break the display?

Looking at kmb_dsi_host_bridge_init(), it registers a static global
dsi_host:

drivers/gpu/drm/kmb/kmb_dsi.c:kmb_dsi_host_bridge_init() {
    if (!dsi_host) {
        dsi_host =3D kzalloc_obj(*dsi_host);
        ...=20
        mipi_dsi_host_register(dsi_host);
    }
}

During unbind, kmb_dsi_host_unregister() unregisters the host, but the
static pointer is never cleared. When the driver is rebound,
kmb_dsi_host_bridge_init() sees dsi_host is not NULL and skips
registration, leaving the host unregistered and causing subsequent
operations to fail. Is there a missing reset of this global variable?

[Severity: High]
This is another pre-existing issue, but does kmb_probe() permanently leak
memory and device references if probe is deferred?

kmb_probe() looks up the DSI platform device and takes references without
releasing them on error or unbind paths:

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    dsi_pdev =3D of_find_device_by_node(dsi_node);
    ...
    ret =3D kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
}

Furthermore, it allocates managed resources against this foreign DSI
device:

drivers/gpu/drm/kmb/kmb_dsi.c:kmb_dsi_init() {
    struct device *dev =3D get_device(&pdev->dev);
    kmb_dsi =3D devm_kzalloc(dev, sizeof(*kmb_dsi), GFP_KERNEL);
    ...
}

Because the foreign DSI device is never unbound when the DRM driver defers
or fails, do these devres resources and device references permanently
leak on every probe deferral?

>  	clk_disable_unprepare(kmb_dsi->clk_mipi);
>  	clk_disable_unprepare(kmb_dsi->clk_mipi_ecfg);
>  	clk_disable_unprepare(kmb_dsi->clk_mipi_cfg);
> +
> +	kmb_dsi->dsi_clk_enabled =3D false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802002512.4863=
69-1-dbgh9129@gmail.com?part=3D1
