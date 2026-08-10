Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D187C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B895410E5F5;
	Mon, 10 Aug 2026 03:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JVEgfhZj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF56610E5F5
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66DDA42BB8;
 Mon, 10 Aug 2026 03:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297691F000E9;
 Mon, 10 Aug 2026 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786334027;
 bh=vTGUT2vq5aLXBzkFf9c5BvQ/GXTXPRjiBUlV2WlbSBk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JVEgfhZj1Mm4IUl6wDenOafg6fe4q+IJjV0OVF6u47os52kFjUWPkpxAUq1CLYvbr
 +8bbooD6rE0yUv4TVJkXLyn+HzqD6zOKJVa7C0OfzilSS2vYTb6veF16Dnne/6P3Mt
 o+vbwq2y7AWP1/rD+HOl0yYaSIGQjb7vCZngqKbRKLA2zmKPF8+x3hmUQBMdIfrNM1
 TluRWKIAzDTTUcY2b4TnGEH6Ib2o2iEkGQNQKeRcsiSyrgV6frmxYZR0cBA4fMmKhj
 E58UblRAqt6hlLKBxYcLOqULRMeba/pgbPrwTKDrmu84p28Prl9lpq807AuZS5aqi1
 PlrkzwuV/OpUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810034139.148-4-kernel@airkyi.com>
References: <20260810034139.148-1-kernel@airkyi.com>
 <20260810034139.148-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 03:53:46 +0000
Message-Id: <20260810035347.297691F000E9@smtp.kernel.org>
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

New issues:
- [High] Integer division truncation in bandwidth calculation causes DSI li=
nk underflow when combined with the newly reduced margin.

Pre-existing issues:
- [High] 32-bit signed integer overflow in PHY pixel clock calculation for =
displays with high pixel clocks (> 214.7 MHz).
- [High] Unsigned long overflow on 32-bit platforms within the core PHY con=
figuration calculation.
--

--- Patch [3]: [PATCH v3 3/3] drm/rockchip: dsi: Relax the lane rate margin=
 requirements ---
commit 93b5a610ac5007bdda923b4d779bc2ab6fd40792
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Relax the lane rate margin requirements

The commit reduces the DSI lane rate margin from 25% to about 11% to
accommodate platforms limited to 1Gbps lane rates. It updates the lane rate
calculation in dw_mipi_dsi_get_lane_mbps() and adjusts the PHY configuration
parameter accordingly.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 557708bc4faa4..bb2b35571af73 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -589,8 +589,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	mpclk =3D DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
>  	if (mpclk) {
> -		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
> -		tmp =3D mpclk * (bpp / lanes) * 10 / 8;
> +		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
> +		tmp =3D mpclk * (bpp / lanes) * 10 / 9;

[Severity: High]
Does the integer division (bpp / lanes) cause a truncation that leads to DSI
link underflow with this new reduced margin?

For example, with a panel using RGB666 (18 bpp) over 4 lanes, (18 / 4)
evaluates to 4 instead of 4.5.

With the old margin (10 / 8), the multiplier was 4 * 1.25 =3D 5.0, which sa=
fely
exceeded the 4.5 raw multiplier requirement.

With the new margin (10 / 9), the allocated bandwidth calculation becomes
4 * 10 / 9 =3D 4.44. Since 4.44 is strictly less than 4.5, the configured l=
ane
rate provides less bandwidth than the raw pixel payload requires, which cou=
ld
lead to FIFO underflows.

[ ... ]

> @@ -600,7 +600,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	/* for external phy only a the mipi_dphy_config is necessary */
>  	if (dsi->phy) {
> -		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
> +		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 9,

[Severity: High]
This isn't a bug introduced by this patch, but does mode->clock * 1000 * 10
silently overflow 32-bit signed integers for high pixel clocks?

Because mode->clock is a signed 32-bit integer (representing kHz) and the
literals are also 32-bit signed ints, the intermediate product overflows
INT_MAX (2,147,483,647) for any pixel clock exceeding ~214.7 MHz. The result
would wrap to a negative value.

[Severity: High]
This is a pre-existing issue, but does passing this margined pixel clock
to phy_mipi_dphy_get_default_config() overflow on 32-bit platforms?

When the inflated pixel clock reaches phy_mipi_dphy_calc_config() in
drivers/phy/phy-core-mipi-dphy.c, it computes:

    hs_clk_rate =3D pixel_clock * bpp;

On 32-bit architectures, pixel_clock is a 32-bit unsigned long. If
mode->clock is roughly 165 MHz, pixel_clock becomes
165,000 * 1000 * 10 / 9 =3D 183,333,333. Multiplying by bpp (e.g., 24) gives
4,400,000,000, which silently overflows the 32-bit ULONG_MAX before the
result is assigned to the 64-bit hs_clk_rate.

>  						 bpp, lanes,
>  						 &dsi->phy_opts.mipi_dphy);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810034139.148-=
1-kernel@airkyi.com?part=3D3
