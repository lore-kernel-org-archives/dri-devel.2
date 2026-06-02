Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF1CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DCC10E0C4;
	Tue,  2 Jun 2026 20:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="eN/qgfbU";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599E910E104
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=gdnGze8I+ROg9ZF+rqMhgnzW1lOwo0q/HCgzLDR7Li4=; b=eN/qgfbUu5LYjEDPu3bQBRNWJT
 nDng4lbq0YaU0YNm1apXfmZav0rAq3YPs1VjngWgjaOflt6FwOPUkk44Rd/Zsypp9nBqmc0wS/Prd
 X1Tf2b/PdsGDQYgpeR0N9ZBVCNtiG7BDIXrsx/YwqX1IHKi+Q2o8ek3ifAIjCad9zQ+Srx3OIuSMO
 uHDnSDOXCbdorbcZ5lxxyhOlugDpfukBs7cZAvOhI90RbW/XjJWi6z8CiE+moIFU8ODTg+iuzaWiF
 6S25iu+JRMlbIPOepXrNn66zp3555eg7FLUP3d7reL/9n+NUxuf90bnQYmzjG9j0GqyFf5CehjG1m
 bIJ5dPmw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>, Chaoyi Chen <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
Date: Tue, 02 Jun 2026 22:59:38 +0200
Message-ID: <4888940.6M6d0yLqnL@phil>
In-Reply-To: <20260324085838.90-1-kernel@airkyi.com>
References: <20260324085838.90-1-kernel@airkyi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Dienstag, 24. M=C3=A4rz 2026, 09:58:37 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Chaoyi Chen:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> Different chips have varying support for the maximum bit rate per lane.
>=20
> Add calculation for the maximum per lane bit rate for various chip
> platforms, and relax the bandwidth margin requirements.
>=20
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 3547d91b25d3..d3bacfae174e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -268,6 +268,7 @@ struct rockchip_dw_dsi_chip_data {
> =20
>  	unsigned int flags;
>  	unsigned int max_data_lanes;
> +	unsigned long max_bit_rate_per_lane;
>  };
> =20
>  struct dw_mipi_dsi_rockchip {
> @@ -565,7 +566,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
>  	int bpp;
>  	unsigned long mpclk, tmp;
>  	unsigned int target_mbps =3D 1000;
> -	unsigned int max_mbps =3D dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
> +	unsigned int max_mbps;
>  	unsigned long best_freq =3D 0;
>  	unsigned long fvco_min, fvco_max, fin, fout;
>  	unsigned int min_prediv, max_prediv;
> @@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
>  	unsigned long _fbdiv, best_fbdiv;
>  	unsigned long min_delta =3D ULONG_MAX;
> =20
> +	max_mbps =3D dsi->cdata->max_bit_rate_per_lane;

I may be blind, but how do the values come together?
In the dppa_map table we have mbps values of 89 to 1500
(MHz)

While below the values set are
	.max_bit_rate_per_lane =3D 1500000000UL,
in Hz I guess

And I don't see the needed conversion somehow.


>  	dsi->format =3D format;
>  	bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
>  	if (bpp < 0) {
> @@ -584,8 +586,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	mpclk =3D DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
>  	if (mpclk) {
> -		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
> -		tmp =3D mpclk * (bpp / lanes) * 10 / 8;
> +		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
> +		tmp =3D mpclk * (bpp / lanes) * 10 / 9;

Please do this in a separate patch, especially as I would expect some
sort of explanation on why this is ok to do.

Thanks
Heiko

>  		if (tmp < max_mbps)
>  			target_mbps =3D tmp;
>  		else
> @@ -595,7 +597,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	/* for external phy only a the mipi_dphy_config is necessary */
>  	if (dsi->phy) {
> -		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
> +		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 9,
>  						 bpp, lanes,
>  						 &dsi->phy_opts.mipi_dphy);
>  		dsi->lane_mbps =3D target_mbps;
> @@ -1503,6 +1505,7 @@ static const struct rockchip_dw_dsi_chip_data px30_=
chip_data[] =3D {
>  						PX30_DSI_FORCETXSTOPMODE), 0),
> =20
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1515,6 +1518,7 @@ static const struct rockchip_dw_dsi_chip_data rk312=
8_chip_data[] =3D {
>  						RK3128_DSI_FORCERXMODE |
>  						RK3128_DSI_FORCETXSTOPMODE), 0),
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1527,6 +1531,7 @@ static const struct rockchip_dw_dsi_chip_data rk328=
8_chip_data[] =3D {
>  		.lcdsel_lit =3D FIELD_PREP_WM16_CONST(RK3288_DSI0_LCDC_SEL, 1),
> =20
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
>  	},
>  	{
>  		.reg =3D 0xff964000,
> @@ -1535,6 +1540,7 @@ static const struct rockchip_dw_dsi_chip_data rk328=
8_chip_data[] =3D {
>  		.lcdsel_lit =3D FIELD_PREP_WM16_CONST(RK3288_DSI1_LCDC_SEL, 1),
> =20
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1547,6 +1553,7 @@ static const struct rockchip_dw_dsi_chip_data rk336=
8_chip_data[] =3D {
>  						RK3368_DSI_FORCETXSTOPMODE |
>  						RK3368_DSI_FORCERXMODE), 0),
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1634,6 +1641,7 @@ static const struct rockchip_dw_dsi_chip_data rk339=
9_chip_data[] =3D {
> =20
>  		.flags =3D DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
>  	},
>  	{
>  		.reg =3D 0xff968000,
> @@ -1658,6 +1666,7 @@ static const struct rockchip_dw_dsi_chip_data rk339=
9_chip_data[] =3D {
> =20
>  		.flags =3D DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
> =20
>  		.dphy_rx_init =3D rk3399_dphy_tx1rx1_init,
>  		.dphy_rx_power_on =3D rk3399_dphy_tx1rx1_power_on,
> @@ -1674,6 +1683,7 @@ static const struct rockchip_dw_dsi_chip_data rk350=
6_chip_data[] =3D {
>  			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCERXMODE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCETXSTOPMODE, 0)),
>  		.max_data_lanes =3D 2,
> +		.max_bit_rate_per_lane =3D 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1687,6 +1697,7 @@ static const struct rockchip_dw_dsi_chip_data rk356=
8_chip_data[] =3D {
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI0_TURNDISABLE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1200000000UL,
>  	},
>  	{
>  		.reg =3D 0xfe070000,
> @@ -1696,6 +1707,7 @@ static const struct rockchip_dw_dsi_chip_data rk356=
8_chip_data[] =3D {
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI1_TURNDISABLE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1200000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1708,6 +1720,7 @@ static const struct rockchip_dw_dsi_chip_data rv112=
6_chip_data[] =3D {
>  			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCERXMODE, 0) |
>  			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
>  		.max_data_lanes =3D 4,
> +		.max_bit_rate_per_lane =3D 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
>=20




