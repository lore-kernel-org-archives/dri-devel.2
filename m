Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE1606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ahc8+q4f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8C510E244;
	Sun, 25 Oct 2026 14:38:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6156510E244
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 14:38:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAD1E43914;
 Sun, 25 Oct 2026 14:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C2C1F01825;
 Sun, 25 Oct 2026 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792939130;
 bh=gQq9ercy7WpejexTUf9xdDgd8HWYxGM+rf5OLyBX04c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ahc8+q4fNlyoviwTQ18Z1FSVFTE8xV1duWzCIMzZziAAwlWcShXcVeXwEXOPOuN4I
 m0PANEh0HzyCw3uHcgR+ak35HnyhbUGufVv9fVmfvs8Zt8RLCijq+aqbR9+QG+p+5G
 W3vlOmR4D3wj9E7yBokHGZ2w8I5J7YGlhsYOxlBSAHgu//8Gmxe9it235Td5ObG9Ai
 UzX1E6iIOGTnfLanWJBzMXWyfuwyPYEdwLv89KWArDHWdlY5LquWZl9AsA11DYMi2X
 ZI/RTmF2oPbegDPxNlMAvd0Qs5hBnKrJQAQl3n7/+DFuOg8uFhpzpi1DCmSv21d4CZ
 9HJEa+gccsqfg==
Message-ID: <sashiko-outbox-184251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: use the lane rate for lbcc
 when lanes run faster
To: "Romain TISSERAND" <romain.tisserand@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261025142639.3454322-1-romain.tisserand@gmail.com>
References: <20261025142639.3454322-1-romain.tisserand@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 14:38:50 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/bridge: dw-mipi-dsi: wrong lane count in dw_mipi_dsi_get_hco=
mponent_lbcc()
- [Medium] drm/bridge: dw-mipi-dsi: 1/8 margin check in dw_mipi_dsi_get_hco=
mponent_lbcc()
--

commit 6499adefdc008cafd18dfe3208439c2abd0174aa
Author: Romain TISSERAND <romain.tisserand@gmail.com>

drm/bridge: dw-mipi-dsi: use the lane rate for lbcc when lanes run faster

This commit updates dw_mipi_dsi_get_hcomponent_lbcc() to calculate horizont=
al
timing values from the DSI lane rate rather than the pixel clock whenever t=
he
lane rate exceeds the pixel bandwidth by more than 1/8, fixing DPI payload
FIFO overflows on glues such as Rockchip that run the lanes faster in
non-burst video modes.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 22d1b8cbe1d57..b026b602abc0f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -781,19 +781,28 @@ static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct d=
w_mipi_dsi *dsi,
>  					   u32 hcomponent)
>  {
>  	u32 frac, lbcc, minimum_lbcc;
> +	u64 pixel_kbps;
>  	int bpp;
> =20
> -	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +	bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> +	if (bpp < 0) {
> +		dev_err(dsi->dev, "failed to get bpp\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Use the lane rate when it is above the pixel bandwidth (burst, or
> +	 * glues adding margin in all modes); the 1/8 slack ignores lane_mbps
> +	 * being rounded up to the next MHz. Otherwise the pixel clock is more
> +	 * precise.
> +	 */
> +	pixel_kbps =3D div_u64((u64)mode->clock * bpp, dsi->lanes);
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ||
> +	    (u64)dsi->lane_mbps * MSEC_PER_SEC > pixel_kbps + pixel_kbps / 8) {

[Severity: Medium]
Can the 1/8 margin check miss panels where the lane rate runs faster than t=
he
pixel bandwidth by less than 12.5%?

In drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c,
dw_mipi_dsi_get_lane_mbps() computes the default lane rate using integer
division for (bpp / lanes):

	mpclk =3D DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
	if (mpclk) {
		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
		tmp =3D mpclk * (bpp / lanes) * 10 / 8;

For a 4-lane non-burst panel using MIPI_DSI_FMT_RGB666_PACKED (bpp =3D 18),
(bpp / lanes) truncates from 4.5 to 4, giving a lane rate of 5 * mpclk Mbps.
That is only 11.1% (1/9) above the 4.5 * mode->clock pixel bandwidth, rather
than 25%.

For any pixel clock >=3D 16 MHz on such a panel (or when a panel's requested
hs_rate or max_mbps clamp puts dsi->lane_mbps between +1 MHz and +12.5% abo=
ve
pixel_kbps), (u64)dsi->lane_mbps * MSEC_PER_SEC > pixel_kbps + pixel_kbps /=
 8
evaluates to false. Wouldn't that fall back to the pixel-clock formula and
program DSI_VID_HLINE_TIME, DSI_VID_HSA_TIME, and DSI_VID_HBP_TIME shorter
than the DPI line period, triggering the same DPI payload FIFO overflow?

If the slack is only meant to ignore lane_mbps being rounded up to the next
MHz, should the check compare dsi->lane_mbps against
DIV_ROUND_UP_ULL(pixel_kbps, MSEC_PER_SEC) instead of adding pixel_kbps / 8?

>  		/* lbcc based on lane_mbps */
>  		lbcc =3D hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
>  	} else {
>  		/* lbcc based on pixel clock rate */
> -		bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> -		if (bpp < 0) {
> -			dev_err(dsi->dev, "failed to get bpp\n");
> -			return 0;
> -		}
> -
>  		lbcc =3D div_u64((u64)hcomponent * mode->clock * bpp, dsi->lanes * 8);

[Severity: Medium]
Should pixel_kbps and the pixel-clock lbcc calculation divide by
dw_mipi_dsi_get_lanes(dsi) instead of dsi->lanes to handle dual-DSI panels?

In dw_mipi_dsi_bridge_atomic_pre_enable() -> dw_mipi_dsi_mode_set(),
dsi->lane_mbps is obtained by passing the combined master and slave lane
count from dw_mipi_dsi_get_lanes(dsi) along with the full-panel
adjusted_mode:

	u32 lanes =3D dw_mipi_dsi_get_lanes(dsi);

	clk_prepare_enable(dsi->pclk);

	ret =3D phy_ops->get_lane_mbps(priv_data, adjusted_mode, dsi->mode_flags,
				     lanes, dsi->format, &dsi->lane_mbps);

When a dual-DSI panel is attached in non-burst video mode via
dw_mipi_dsi_set_slave() (such as innolux,p097pfg on rk3399-gru-scarlet with
4 + 4 lanes), dsi->lane_mbps is the per-lane rate across all 8 lanes, where=
as
dividing mode->clock * bpp by dsi->lanes (4) makes pixel_kbps twice the
actual per-lane pixel bandwidth.

Because pixel_kbps is doubled, the condition
(u64)dsi->lane_mbps * MSEC_PER_SEC > pixel_kbps + pixel_kbps / 8 evaluates =
to
false, and the else branch then also divides by dsi->lanes (4) instead of
dw_mipi_dsi_get_lanes(dsi) (8), programming DSI_VID_HLINE_TIME,
DSI_VID_HSA_TIME, and DSI_VID_HBP_TIME for twice the per-lane pixel bandwid=
th
rather than the actual lane rate.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025142639.3454=
322-1-romain.tisserand@gmail.com?part=3D1
