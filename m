Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594DDC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E9F10EE9F;
	Wed, 12 Aug 2026 07:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L3J5G3fm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE25010EE9F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:42:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 981EC41757;
 Wed, 12 Aug 2026 07:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522331F000E9;
 Wed, 12 Aug 2026 07:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786520555;
 bh=xd5mCe89e5Y8H6yWc6iTGVbR3Lp+fbUYjVSqB2fASeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L3J5G3fmrJebNsrzi3jKvHFTAKO6Upjs5FkSUkTMP+XlFKqHahOgr2nqWWxuRGkRt
 38F+a6hPGioyD7M/R5p5zYAgyxr7M/pQbOtYD+yh0QjnxG54nL+9hNl+pe5ReJirHX
 ZcUo0osuzplT5bIs8V0gBprwt071kG2uYf5YlLEqS7q97SIiNrX292reaLspAJpC0h
 XSntc2qSLC7QLTLHDoFtimT7Si4Z44egmGPOnkHaWbOmVFBV4WMcdyt8j0alTIZR4r
 tZQu0RXzLxXobunJaDkk00JQXAKjMWdgNwCWB5cJ8KNh228yzH4GkBLnKt42GhZ+I1
 rbz6idzkAFWFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812073002.328-4-kernel@airkyi.com>
References: <20260812073002.328-1-kernel@airkyi.com>
 <20260812073002.328-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:42:33 +0000
Message-Id: <20260812074235.522331F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete fix: Integer overflow in external D-PHY pixel clock c=
alculation
--

--- Patch [3]: [PATCH v4 3/3] drm/rockchip: dsi: Relax the lane rate margin=
 requirements ---
commit 6f9a68488ce9227bbef69a3b1f33676d60dad2a4
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Relax the lane rate margin requirements

This commit adjusts the DSI lane rate calculation to reduce the bandwidth
overhead from 25% to about 11%. It updates both the target_mbps calculation
and the parameter passed to phy_mipi_dphy_get_default_config().

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index ddb3a441787e6..c4de442675b79 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
[ ... ]
> @@ -589,8 +589,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	mpclk =3D DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
>  	if (mpclk) {
> -		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
> -		tmp =3D mpclk * (bpp / lanes) * 10 / 8;
> +		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
> +		tmp =3D DIV_ROUND_UP(mpclk * bpp * 10, lanes * 9);
>  		if (tmp < max_mbps)
>  			target_mbps =3D tmp;
>  		else
> @@ -600,7 +600,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	/* for external phy only a the mipi_dphy_config is necessary */
>  	if (dsi->phy) {
> -		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
> +		phy_mipi_dphy_get_default_config((u32)mode->clock * 1000 * 10 / 9,

[Severity: Medium]
Will this (u32) cast still cause an integer overflow for high pixel clocks?

If userspace requests a display mode with a pixel clock exceeding ~429.5 MHz
(e.g., 594 MHz for 4K@60Hz), the intermediate product in
dw_mipi_dsi_get_lane_mbps() will be:

((u32)594000 * 1000 * 10 =3D 5,940,000,000)

This overflows 32-bit unsigned arithmetic and wraps around to 1,645,032,704.

As a result, the PHY is incorrectly configured with ~182 MHz instead
of 660 MHz, leading to insufficient bandwidth and display failures.

Could we use a 64-bit cast like (u64) to fully prevent overflow during the
intermediate calculation here?

>  						 bpp, lanes,
>  						 &dsi->phy_opts.mipi_dphy);
>  		dsi->lane_mbps =3D target_mbps;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812073002.328-=
1-kernel@airkyi.com?part=3D3
