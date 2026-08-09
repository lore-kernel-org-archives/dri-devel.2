Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2931EC5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E81B89798;
	Sun,  9 Aug 2026 08:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YHohP8tQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA37489798
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E957541FD8;
 Sun,  9 Aug 2026 08:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC67A1F000E9;
 Sun,  9 Aug 2026 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786264883;
 bh=9nrrActF2t8Vhd0iVOAfMqMElJ+KQ8x6Jq8VFKA6V5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YHohP8tQCTbS6q8eKxZPLVNu94mQo2G6BbCrBOYqCebpO0O/3udo3DfOdnCK1zl+1
 fZ2VESHFBYTLfGkP46NO0v0zT8KcbHGeVuilKo6FDu4C9W/Grqpqr3ebiBd5U14rvs
 /OE6SqpekvzpTXvEdDQvs/hac8TmdsRraDtP35ilI3O9b8ezgpyAad6cpNbc8/T1+S
 y62F3r8jPvn+YHJlquKD/vZEWbM7jT3USQhqpims8qDM9lqVrFPn5yxuVTO/zSfMXj
 B5zt2GuNwxeSntCasixU8PmsZDe9BpDArzdBopMgp5QQB0QqEQqaBWc17iEmjLfkdw
 /cDyfznCElnxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for
 Exynos 7870 DSIM
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809-exynos-dsim-fixes-v4-1-ca67c51e61b7@disroot.org>
References: <20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org>
 <20260809-exynos-dsim-fixes-v4-1-ca67c51e61b7@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 08:41:23 +0000
Message-Id: <20260809084123.AC67A1F000E9@smtp.kernel.org>
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
- [High] Unchecked NULL pointer from `of_device_get_match_data()` leads to =
kernel panic in probe.
- [High] Hardware polling loop for lane stop states terminates prematurely =
and lacks a time-bound delay.
- [High] Macro `samsung_dsim_hw_is_exynos()` incorrectly evaluates to false=
 for `DSIM_TYPE_EXYNOS7870`.
--

--- Patch [1]: [PATCH v4 1/3] drm/bridge: samsung-dsim: enable MFLUSH_VS fo=
r Exynos 7870 DSIM ---
commit 6317440f4c2cdec241fc86381b097531928140af
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM

Commit a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display
FIFO on vsync pulse") intends to enable FIFO flushing at v-sync pulse by
not setting the active-low MFLUSH_VS bit. This commit enables the bit
for Exynos 7870 since it is active-high on this hardware.

Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos787=
0/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#=
L699 [1]

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e2fc69fc51b60..6260c091c3df8 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_d=
sim *dsi)
>  			reg |=3D DSIM_HBP_DISABLE_MODE;
>  		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
>  			reg |=3D DSIM_HSA_DISABLE_MODE;
> +
> +		/*
> +		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
> +		 * enabled as its active-high.
> +		 */
> +		if (dsi->plat_data->hw_type =3D=3D DSIM_TYPE_EXYNOS7870)
> +			reg |=3D DSIM_MFLUSH_VS;
>  	}
> =20
>  	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

[Severity: High]
This isn't a bug introduced by this patch, but since Exynos 7870 support is
being actively modified here, does the samsung_dsim_hw_is_exynos() macro ne=
ed
updating to include DSIM_TYPE_EXYNOS7870?

Currently, it evaluates to false for Exynos 7870 because the macro strictly
checks up to DSIM_TYPE_EXYNOS5433:

include/drm/bridge/samsung-dsim.h:
#define samsung_dsim_hw_is_exynos(hw) \
	((hw) >=3D DSIM_TYPE_EXYNOS3250 && (hw) <=3D DSIM_TYPE_EXYNOS5433)

This causes the driver to erroneously execute the i.MX early initialization
path in samsung_dsim_atomic_pre_enable() and incorrectly set the
DSIM_NON_CONTINUOUS_CLKLANE bit further down in samsung_dsim_init_link().

[ ... ]

> 	/* Check clock and data lane state are stop state */
> 	timeout =3D 100;
> 	do {
> 		if (timeout-- =3D=3D 0) {
> 			dev_err(dsi->dev, "waiting for bus lanes timed out\n");
> 			return -EFAULT;
> 		}
>=20
> 		if (driver_data->has_legacy_status_reg)
> 			reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
> 		else
> 			reg =3D samsung_dsim_read(dsi, DSIM_DPHY_STATUS_REG);
> 		if ((reg & DSIM_STOP_STATE_DAT(lanes_mask))
> 		    !=3D DSIM_STOP_STATE_DAT(lanes_mask))
> 			continue;
> 	} while (!(reg & (DSIM_STOP_STATE_CLK | DSIM_TX_READY_HS_CLK)));

[Severity: High]
This is a pre-existing issue, but can this hardware polling loop terminate
prematurely?

If the clock lane happens to be ready but the data lanes are not, the
continue statement jumps to the loop condition evaluation. The condition
evaluates to false, causing the loop to exit successfully instead of waiting
for the data lanes.

Also, should this loop include a time-bound delay (like ndelay) to prevent
premature aborts on faster processors?

[ ... ]

[Severity: High]
This is a pre-existing issue elsewhere in the file, but can we hit a NULL
pointer dereference in samsung_dsim_probe() if the driver is bound via sysf=
s?

If a platform device is manually created and the driver is bound via sysfs
(e.g., via "echo samsung-dsim > bind") without an associated device tree no=
de,
of_device_get_match_data() returns NULL:

samsung_dsim_probe() {
    ...
    dsi->plat_data =3D of_device_get_match_data(dev);
    dsi->driver_data =3D samsung_dsim_types[dsi->plat_data->hw_type];
    ...
}

Does this need a NULL check before dereferencing dsi->plat_data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-exynos-dsi=
m-fixes-v4-0-ca67c51e61b7@disroot.org?part=3D1
