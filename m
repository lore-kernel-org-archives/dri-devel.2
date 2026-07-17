Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B08C44522
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DA710E43E;
	Fri, 17 Jul 2026 12:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oa+kvuRy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3296B10E43E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:16:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB004400AE;
 Fri, 17 Jul 2026 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABD01F000E9;
 Fri, 17 Jul 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784290599;
 bh=0CftLDCVFEwpWJdAXq3mFHKdS0h8TSzDqMCvz+NyiHo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oa+kvuRyaEfRLcOvGMNpgLKc8v42jwajiu7LI7sMASnrteJviC465KDtlDx9xVSFo
 //O2XRetcw+aZtWPAmAvToG4cLvtnMeuiWOtdWQJNxjbQxIXAvitJ6N993YqGqwRNc
 fuWtyZWk3I6D0dDdjNL2yuK+5sjmIXvArjKzdPCw5tZVhjBiSAMjrDtVI+f6bpra7S
 zxRZjxUeQQVrjJpHsYKGqcfnbBhCZbkYYDUhF+Gpq2I5tk8UJQ+RTQ/5LveFTHV4kk
 EsrcsC90dQTHJRbV2XZc6BunoAkNi9Voz5Z+dh59j7fvZ3SSvFdsSE1XRW5F2jTP6p
 jrS2EoMKHBDFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support
To: "Rok Markovic" <rok@kanardia.eu>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260717120005.2087386-4-rok@kanardia.eu>
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-4-rok@kanardia.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 12:16:39 +0000
Message-Id: <20260717121639.7ABD01F000E9@smtp.kernel.org>
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
- [High] Unbalanced phy_power_off() in disable path permanently corrupts PH=
Y state after a transient enable error.
- [Low] Silently ignored regmap_write() error in rk3568_lvds_grf_config().
--

--- Patch [3]: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support ---
commit 42ee5aa3ee6adfe018b6f3294b12a2e7ab2076e3
Author: Rok Markovic <rok@kanardia.eu>
Date:   Fri Jul 17 12:00:04 2026 +0000

    drm/rockchip: lvds: add RK3568 support

This commit adds support for the RK3568 LVDS transmitter to the rockchip_lv=
ds
driver. It configures the MIPI DSI0 D-PHY in PHY_MODE_LVDS and powers the
D-PHY from the encoder enable path instead of probe.

Link: https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail=
.com/

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/r=
ockchip/rockchip_lvds.c
> index 150299c12298a..cc56ca2580a66 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
[ ... ]
> @@ -435,6 +435,133 @@ static void px30_lvds_encoder_disable(struct drm_en=
coder *encoder)
> +static int rk3568_lvds_grf_config(struct drm_encoder *encoder,
> +				  struct drm_display_mode *mode)
> +{
[ ... ]
> +	/*
> +	 * The LVDS block has its own dclk inversion select, separate from the
> +	 * VOP's pin polarity. Both have to agree with what the panel samples o=
n.
> +	 */
> +	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
> +		     RK3568_LVDS0_DCLK_INV_SEL(negedge));
> +

[Severity: Low]
Does this code silently ignore a potential error from regmap_write()?

If this first regmap_write() to RK3568_GRF_VO_CON2 fails, the DCLK inversion
configuration is not applied, but the function proceeds and only returns the
result of the second regmap_write() below.

> +	/* Set format */
> +	return regmap_write(lvds->grf, RK3568_GRF_VO_CON0,
> +			    RK3568_LVDS0_SELECT(lvds->format) |
> +			    RK3568_LVDS0_MSBSEL(1));
> +}
> +
> +static void rk3568_lvds_encoder_enable(struct drm_encoder *encoder)
> +{
[ ... ]
> +	ret =3D rk3568_lvds_poweron(lvds);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	ret =3D rk3568_lvds_grf_config(encoder, mode);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to configure LVDS: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	/*
> +	 * Only now bring the D-PHY up. phy_power_on() runs the whole
> +	 * inno_dsidphy_lvds_mode_enable() sequence - PLL and bandgap power-on,
[ ... ]
> +	ret =3D phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to set phy mode: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +

[Severity: High]
Can an early return here lead to an unbalanced phy_power_off() later?

If rk3568_lvds_encoder_enable() encounters an error and returns early before
calling phy_power_on(), the DRM core still treats the encoder as active sin=
ce
the enable callback returns void.

When the display pipeline is subsequently disabled, the DRM core unconditio=
nally
calls rk3568_lvds_encoder_disable(), which does this:

static void rk3568_lvds_encoder_disable(...)
{
    ...
    phy_power_off(lvds->dphy);
    ...
}

This would decrement the PHY's power_count from 0 to -1. Future calls to
phy_power_on() will see a negative count, skip the actual hardware power-on
routine, and just increment the counter to 0, which leaves the PHY permanen=
tly
broken until reboot.

> +	ret =3D phy_power_on(lvds->dphy);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to power on phy: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	drm_panel_enable(lvds->panel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717120005.2087=
386-1-rok@kanardia.eu?part=3D3
