Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6968CCD4846
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 01:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951BA10E95B;
	Tue, 12 May 2026 01:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="le7N28Lo";
	dkim-atps=neutral
X-Greylist: delayed 419 seconds by postgrey-1.36 at gabe;
 Tue, 12 May 2026 01:18:00 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1138410E23A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1778548674;
 bh=RI1LKPQBSFQGNx/RTpgPitop3o0KUtZZu7uLCufWIB0=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=le7N28LomoiqvO1r2pJ88gmljx4S0upie37iZLQwD6zVRZCDT15vw/8v9DnxnAdAh
 lDF89yriuKhmz1H5okE6VPcQF0bvPOpxp2+t/lMMUlZ5QMzl8+ehYxP/B6q3fa9Ycs
 WNLU6531kiSju1jlcbN//ct8YiiX7ZuPeFgfO1dg=
X-QQ-mid: zesmtpgz6t1778548076ta5496fac
X-QQ-Originating-IP: VqDSdyIt6ayYF87ktnGO0QYcuHE+i5xXTIoANh/OHyk=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 12 May 2026 09:07:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 628164798136935440
EX-QQ-RecipientCnt: 14
Message-ID: <90EB6258578AF9E7+a9f8705d-48dc-4a3f-809a-fef9c8a5674e@airkyi.com>
Date: Tue, 12 May 2026 09:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Chaoyi Chen <kernel@airkyi.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260324085838.90-1-kernel@airkyi.com>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20260324085838.90-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3ZkD08p3wd5x3ZjS4Yr68SjtmYyiTJKPx49MnpV9/fFhGprB1CZ5HqJ
 Fu2H+Y3HuRyD7ZBwCl28fwy6lR7i4YSzWu1+/c67rHcTONAOz8xcAKYVgLkwK+73WH5PdLc
 So7mFesRaUJSOLXO+FCWHMUfTGVkFAE0UgHbcmOFre/VRa5QA2BxUJqyDozkYaGvHdNWeat
 sE3/fyLsIvEbViz/KAUQOlziVTYR7tmgZIEBdgQ4Mh/LVppCXOycDrqcb4yEB02NfVBWF5M
 4S3fiYPepdzRqYHIb0OaIMPTe2JTJjf79hlGShJLYAEjKHP8w+Uo03kcVd0CMEQ4QCKvlmm
 +mlGqaSpf8nKiLCNUZ+DMiSPV8p2PMTh76snBkn5plt4TYKH8RZNWouUSfR18HLqrKautZd
 ascwlHasF3Zmf9IHdZCik4v64HJZKnNm3L26hp+8wnxH7U4OUdcEIOzgdxf8VxWof3zMoGZ
 zN+rOqtVCtsg3JGfX3sLS0qpt1RQ2JHEuYrYfD4lEjgqPVY1A2Ft5nk4PYYhJiOrUEmzuG5
 OPQ1Q/eKNm5sTpBiWOQkLme8GGLrpUO9pbv6hAzt2xrBqtYCxLEMOD4GL9XeA9IPq5doUpE
 Vaj18ECqaunKwDFKNiFYFpjETziGKMyPmbvod2zzMuRLBR/nn7b2JJfX/SU1z1r3YR5K/K2
 MnW53Pb945lUjgvPYFVIe8Se29yncTTCPNBXZwHfvUfFqcQ0xMYR4C0GtItgDbRkJrAR/9B
 bjFsDQJFqApSaRd+NzlAG/QkztPdCLV81WV1KHlwc7X6zlqWNqJRDKd72PNMQ6lt3g+dbnn
 6K5hv7WA+Ctu2Gd9z0quW2ga/wg3zfU9yB+HRNFfVp8mdkjF+3mMwkmYe20GiW6xl6K4t2k
 V1Y0eJYyQ1EjbHKe/0yRN3C8TtyxfR2jp5xuPNfjer7RK0hz5Bk2iGks48+jAVZgQxG55xG
 NrEPIyulgmrp1fhCOyD+yT5YAWaygiqGyQJmSME2EaTxOm98Z3lkkx6jcfZ/imGOnQQDztW
 JAoaJIRzZ4VnYqv8Yy
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

Hi,

On 3/24/2026 4:58 PM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Different chips have varying support for the maximum bit rate per lane.
> 
> Add calculation for the maximum per lane bit rate for various chip
> platforms, and relax the bandwidth margin requirements.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 3547d91b25d3..d3bacfae174e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -268,6 +268,7 @@ struct rockchip_dw_dsi_chip_data {
>  
>  	unsigned int flags;
>  	unsigned int max_data_lanes;
> +	unsigned long max_bit_rate_per_lane;
>  };
>  
>  struct dw_mipi_dsi_rockchip {
> @@ -565,7 +566,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>  	int bpp;
>  	unsigned long mpclk, tmp;
>  	unsigned int target_mbps = 1000;
> -	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
> +	unsigned int max_mbps;
>  	unsigned long best_freq = 0;
>  	unsigned long fvco_min, fvco_max, fin, fout;
>  	unsigned int min_prediv, max_prediv;
> @@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>  	unsigned long _fbdiv, best_fbdiv;
>  	unsigned long min_delta = ULONG_MAX;
>  
> +	max_mbps = dsi->cdata->max_bit_rate_per_lane;
>  	dsi->format = format;
>  	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>  	if (bpp < 0) {
> @@ -584,8 +586,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>  
>  	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
>  	if (mpclk) {
> -		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
> -		tmp = mpclk * (bpp / lanes) * 10 / 8;
> +		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
> +		tmp = mpclk * (bpp / lanes) * 10 / 9;
>  		if (tmp < max_mbps)
>  			target_mbps = tmp;
>  		else
> @@ -595,7 +597,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>  
>  	/* for external phy only a the mipi_dphy_config is necessary */
>  	if (dsi->phy) {
> -		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
> +		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 9,
>  						 bpp, lanes,
>  						 &dsi->phy_opts.mipi_dphy);
>  		dsi->lane_mbps = target_mbps;
> @@ -1503,6 +1505,7 @@ static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
>  						PX30_DSI_FORCETXSTOPMODE), 0),
>  
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1515,6 +1518,7 @@ static const struct rockchip_dw_dsi_chip_data rk3128_chip_data[] = {
>  						RK3128_DSI_FORCERXMODE |
>  						RK3128_DSI_FORCETXSTOPMODE), 0),
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1527,6 +1531,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
>  		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI0_LCDC_SEL, 1),
>  
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  	},
>  	{
>  		.reg = 0xff964000,
> @@ -1535,6 +1540,7 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
>  		.lcdsel_lit = FIELD_PREP_WM16_CONST(RK3288_DSI1_LCDC_SEL, 1),
>  
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1547,6 +1553,7 @@ static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
>  						RK3368_DSI_FORCETXSTOPMODE |
>  						RK3368_DSI_FORCERXMODE), 0),
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1634,6 +1641,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
>  
>  		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  	},
>  	{
>  		.reg = 0xff968000,
> @@ -1658,6 +1666,7 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
>  
>  		.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  
>  		.dphy_rx_init = rk3399_dphy_tx1rx1_init,
>  		.dphy_rx_power_on = rk3399_dphy_tx1rx1_power_on,
> @@ -1674,6 +1683,7 @@ static const struct rockchip_dw_dsi_chip_data rk3506_chip_data[] = {
>  			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCERXMODE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3506_DSI_FORCETXSTOPMODE, 0)),
>  		.max_data_lanes = 2,
> +		.max_bit_rate_per_lane = 1500000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1687,6 +1697,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI0_TURNDISABLE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI0_FORCERXMODE, 0)),
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1200000000UL,
>  	},
>  	{
>  		.reg = 0xfe070000,
> @@ -1696,6 +1707,7 @@ static const struct rockchip_dw_dsi_chip_data rk3568_chip_data[] = {
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI1_TURNDISABLE, 0) |
>  			     FIELD_PREP_WM16_CONST(RK3568_DSI1_FORCERXMODE, 0)),
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1200000000UL,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1708,6 +1720,7 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
>  			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCERXMODE, 0) |
>  			     FIELD_PREP_WM16_CONST(RV1126_DSI_FORCETXSTOPMODE, 0)),
>  		.max_data_lanes = 4,
> +		.max_bit_rate_per_lane = 1000000000UL,
>  	},
>  	{ /* sentinel */ }
>  };

Gentle ping about this.

Thanks!

-- 
Best, 
Chaoyi


