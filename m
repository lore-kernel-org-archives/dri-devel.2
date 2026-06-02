Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE40BCD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAC710E331;
	Tue,  2 Jun 2026 21:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="BHMrXHkr";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B60B10E331
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=NyPSyRLUOFZ5pN/SoGqXQdqwGa+JGoFeCCOZJivTsn8=; b=BHMrXHkrVaEX4fAoOWSvgiF4om
 /u4wFEh0HbB21HLqcwBI2wNR0UQaqIVhsmYq6hGG4F9YMwwFAf14hXCsvvuq1TYGAhT3Omb0jrKKz
 XVCfVXbdPhkqFA6jBE8SF6t96CjwxGI6As7ZDHpha6GBKKGcYH8yTssbdFxYbLtt1fFsyrbe/n89Y
 2tJqoqQ0inusrDVXbJ5NrenuDVc6pAJUr8aN1jqyvX1caeVuAgXvUlR6pA+pkZ2UZpq41NqljO4e8
 WhPKFNdOMUNMyIsfKAB34adwmhRYiYfjaYwgr54UuajxtVRcsfFT6CDV/RAXmp/zL7gKKi+gXYXXS
 ZUkudMFg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>, Chaoyi Chen <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH 2/2] drm/rockchip: dsi: Add dphy_get_timing support for
 multiple PHY types
Date: Tue, 02 Jun 2026 23:02:13 +0200
Message-ID: <7091445.e8TTKsaY2g@phil>
In-Reply-To: <20260324085838.90-2-kernel@airkyi.com>
References: <20260324085838.90-1-kernel@airkyi.com>
 <20260324085838.90-2-kernel@airkyi.com>
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

Am Dienstag, 24. M=C3=A4rz 2026, 09:58:38 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Chaoyi Chen:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> Currently, there are generally two types of DPHY for Rockchip. One is
> the DPHY used by RK3288/RK3399, whose timing is described by Table A-3
> High-Speed Transition Times in the databook. The other is the DPHY used
> by PX30 and its successors. If its timing is still described using
> RK3288/RK3399, it may not perform correctly on some DSI panel.
>=20
> Add dphy_get_timing for different D-PHY types to adapt to timing
> differences.
>=20
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 45 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index d3bacfae174e..2d1c9e54ff85 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -247,6 +247,7 @@ enum {
>  	BIASEXTR_127_7,
>  };
> =20
> +struct dw_mipi_dsi_rockchip;
>  struct rockchip_dw_dsi_chip_data {
>  	u32 reg;
> =20
> @@ -262,6 +263,9 @@ struct rockchip_dw_dsi_chip_data {
>  	u32 lanecfg2_grf_reg;
>  	u32 lanecfg2;
> =20
> +	int (*dphy_get_timing)(struct dw_mipi_dsi_rockchip *dsi, unsigned int l=
ane_mbps,
> +			       struct dw_mipi_dsi_dphy_timing *timing);
> +
>  	int (*dphy_rx_init)(struct phy *phy);
>  	int (*dphy_rx_power_on)(struct phy *phy);
>  	int (*dphy_rx_power_off)(struct phy *phy);
> @@ -721,8 +725,9 @@ static struct hstt hstt_table[] =3D {
>  };
> =20
>  static int
> -dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> -			   struct dw_mipi_dsi_dphy_timing *timing)
> +dw_mipi_dsi_phy_rk3288_get_timing(struct dw_mipi_dsi_rockchip *dsi,
> +				  unsigned int lane_mbps,
> +				  struct dw_mipi_dsi_dphy_timing *timing)
>  {
>  	int i;
> =20
> @@ -738,6 +743,32 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned=
 int lane_mbps,
>  	return 0;
>  }
> =20
> +static const struct dw_mipi_dsi_dphy_timing dphy_timing_px30 =3D {
> +	.clk_lp2hs =3D 0x40,
> +	.clk_hs2lp =3D 0x40,
> +	.data_lp2hs =3D 0x10,
> +	.data_hs2lp =3D 0x14,
> +};

so just to make sure, the timing on the px30 (and later) variant is the
same for all lane speeds?

Please include that bit in the commit description

Thanks
Heiko


