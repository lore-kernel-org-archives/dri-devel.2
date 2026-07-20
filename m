Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D2C44512
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 01:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2A410E07B;
	Mon, 20 Jul 2026 01:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fGaSFrmt";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 20 Jul 2026 01:59:18 UTC
Received: from mail-m103131191208.xmail.ntesmail.com
 (mail-m103131191208.xmail.ntesmail.com [103.131.191.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3309810E07B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:59:17 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 46c36dd28;
 Mon, 20 Jul 2026 09:54:10 +0800 (GMT+08:00)
Message-ID: <9219738d-c3f2-4034-b88f-84335f77fbad@rock-chips.com>
Date: Mon, 20 Jul 2026 09:54:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/rockchip: lvds: add RK3568 support
To: Rok Markovic <rok@kanardia.eu>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>
References: <20260717120005.2087386-1-rok@kanardia.eu>
 <20260717120005.2087386-4-rok@kanardia.eu>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260717120005.2087386-4-rok@kanardia.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9f7d3b0eee03a7kunmae00338f1d2cb8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUxOVkxNTEpNQxhMTBpIH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=fGaSFrmtAq9Zm9i+EivkmOIz/2NPZ3/XxwjUasJmYxVkitxTDhUlAixtqWleZGVJiu+YIMuz90INFCceAj/VK7GI8tjQS6V6JZwTA2CFwYE6SDD3oxGJ+jl0DAjwZ4gvGyBUiBm9tAkmidSLNru0eGF1yxpueblRJs1RyW9sBdQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=0ZU4UPHBu/3uY02SJQ9uBBNkmVWDmaewVSFdHdw5PBw=;
 h=date:mime-version:subject:message-id:from;
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

Hello Rok,

Thank you for your patch. Please see the comment below:

On 7/17/2026 8:00 PM, Rok Markovic wrote:
> The RK3568 LVDS transmitter has no register block of its own. It is
> driven entirely through the GRF and re-uses the MIPI DSI0 D-PHY in
> PHY_MODE_LVDS, which phy-rockchip-inno-dsidphy already supports.
> 
> Based on Alibek Omarov's earlier posting [1], with the changes below.
> 
> Power the D-PHY from the encoder enable path rather than from probe.
> phy_power_on() runs the phy driver's whole LVDS bring-up: PLL and
> bandgap power-on, a settle, PLL mode select, then a reset pulse of the
> serializer and the lane enables. None of that is safe at probe time -
> the GRF has not yet switched the block to LVDS mode (LVDS0_MODE_EN is
> set from rk3568_lvds_poweron(), i.e. the enable path) and the VOP is
> not driving dclk. The serializer is clocked from dclk and latches its
> state coming out of that reset, so it comes up dead and stays dead.
> The failure is silent: every register in the phy, the GRF and the VOP
> reads back exactly as on a working system while the lanes sit at
> common mode and never toggle.
>

Could you please confirm this? Based on my earlier tests, after PHY
poweron, re-disabling and re-enabling the GRF did not reproduce the
issue you described.

> Program RK3568_LVDS0_DCLK_INV_SEL from the CRTC state's bus_flags so
> the panel's declared pixelclk-active is honoured on the LVDS block as
> well as on the VOP pin polarity. Both have to agree with the edge the
> panel samples on.
> 
> Re-assert RK3568_LVDS0_P2S_EN in rk3568_lvds_poweron().
> rk3568_lvds_poweroff() clears MODE_EN and P2S_EN together, so setting
> P2S_EN once at probe would leave the parallel-to-serial converter off
> after the first disable/enable cycle.
> 
> Use regmap_write() rather than regmap_update_bits() for the GRF. These
> registers are write-masked - the upper 16 bits select which of the
> lower 16 a write may change - so there is nothing to preserve and no
> reason to read first. Passing a FIELD_PREP_WM16() value as both the
> mask and the value of an update_bits() applies the masking twice and
> only works by accident.
> 
> Between the two, nothing needs programming at probe at all: the GRF is
> written entirely from the enable path, so px30_lvds_probe() is left
> alone rather than being refactored into a shared phy helper.
> 
> [1] https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail.com/
> 
> Co-developed-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Signed-off-by: Rok Markovic <rok@kanardia.eu>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 161 +++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_lvds.h |  10 ++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 95fa0a9..f45d04a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -435,6 +435,133 @@ static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
>  	drm_panel_unprepare(lvds->panel);
>  }
>  
> +static int rk3568_lvds_poweron(struct rockchip_lvds *lvds)
> +{
> +	int ret;
> +
> +	ret = clk_enable(lvds->pclk);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pm_runtime_get_sync(lvds->dev);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
> +		clk_disable(lvds->pclk);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Enable LVDS mode and the parallel-to-serial converter. These are
> +	 * write-masked registers, so a plain write only touches the bits named
> +	 * here; there is nothing to preserve and no need to read first.
> +	 */

I think this comment is redundant. We all know this is a common design
on Rockchip platform, right? :)

> +	return regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
> +			    RK3568_LVDS0_MODE_EN(1) |
> +			    RK3568_LVDS0_P2S_EN(1));
> +}
> +
> +static void rk3568_lvds_poweroff(struct rockchip_lvds *lvds)
> +{
> +	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
> +		     RK3568_LVDS0_MODE_EN(0) | RK3568_LVDS0_P2S_EN(0));
> +
> +	pm_runtime_put(lvds->dev);
> +	clk_disable(lvds->pclk);
> +}
> +
> +static int rk3568_lvds_grf_config(struct drm_encoder *encoder,
> +				  struct drm_display_mode *mode)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +	struct rockchip_crtc_state *s =
> +		to_rockchip_crtc_state(encoder->crtc->state);
> +	bool negedge = !!(s->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE);
> +
> +	if (lvds->output != DISPLAY_OUTPUT_LVDS) {
> +		DRM_DEV_ERROR(lvds->dev, "Unsupported display output %d\n",
> +			      lvds->output);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The LVDS block has its own dclk inversion select, separate from the
> +	 * VOP's pin polarity. Both have to agree with what the panel samples on.
> +	 */
> +	regmap_write(lvds->grf, RK3568_GRF_VO_CON2,
> +		     RK3568_LVDS0_DCLK_INV_SEL(negedge));
> +
> +	/* Set format */
> +	return regmap_write(lvds->grf, RK3568_GRF_VO_CON0,
> +			    RK3568_LVDS0_SELECT(lvds->format) |
> +			    RK3568_LVDS0_MSBSEL(1));
> +}

I think rk3568_lvds_poweron() and rk3568_lvds_grf_config() can be merged
to reduce extra register operations. 

> +
> +static void rk3568_lvds_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> +	int ret;
> +
> +	drm_panel_prepare(lvds->panel);
> +
> +	ret = rk3568_lvds_poweron(lvds);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to power on LVDS: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	ret = rk3568_lvds_grf_config(encoder, mode);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to configure LVDS: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	/*
> +	 * Only now bring the D-PHY up. phy_power_on() runs the whole
> +	 * inno_dsidphy_lvds_mode_enable() sequence - PLL and bandgap power-on,
> +	 * a settle, PLL mode select, then a reset pulse of the serializer and
> +	 * the lane enables. All of that has to happen with the block already
> +	 * switched to LVDS mode in the GRF (above) and with the VOP's dclk
> +	 * running, because the serializer is clocked from dclk and latches its
> +	 * state out of that reset.
> +	 *
> +	 * Doing it at probe instead - as this driver used to - resets and
> +	 * enables the serializer against a block that is not in LVDS mode yet
> +	 * and has no input clock. Every register then reads back correct while
> +	 * the lanes sit at common mode forever. Rockchip's BSP orders it this
> +	 * way (GRF writes, then phy_set_mode + phy_power_on).
> +	 */

I think this comment is redundant. These are internal details of
phy_set_mode() and don't need to be explained here. Also, the
ordering requirements are quite common. You can describe them in the
commit message.

> +	ret = phy_set_mode(lvds->dphy, PHY_MODE_LVDS);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to set phy mode: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	ret = phy_power_on(lvds->dphy);
> +	if (ret) {
> +		DRM_DEV_ERROR(lvds->dev, "failed to power on phy: %d\n", ret);
> +		drm_panel_unprepare(lvds->panel);
> +		return;
> +	}
> +
> +	drm_panel_enable(lvds->panel);
> +}
> +
> +static void rk3568_lvds_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +
> +	drm_panel_disable(lvds->panel);
> +	phy_power_off(lvds->dphy);
> +	rk3568_lvds_poweroff(lvds);
> +	drm_panel_unprepare(lvds->panel);
> +}
> +
>  static const
>  struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
>  	.enable = rk3288_lvds_encoder_enable,
> @@ -449,6 +576,13 @@ struct drm_encoder_helper_funcs px30_lvds_encoder_helper_funcs = {
>  	.atomic_check = rockchip_lvds_encoder_atomic_check,
>  };
>  
> +static const
> +struct drm_encoder_helper_funcs rk3568_lvds_encoder_helper_funcs = {
> +	.enable = rk3568_lvds_encoder_enable,
> +	.disable = rk3568_lvds_encoder_disable,
> +	.atomic_check = rockchip_lvds_encoder_atomic_check,
> +};
> +
>  static int rk3288_lvds_probe(struct platform_device *pdev,
>  			     struct rockchip_lvds *lvds)
>  {
> @@ -512,6 +646,22 @@ static int px30_lvds_probe(struct platform_device *pdev,
>  	return phy_power_on(lvds->dphy);
>  }
>  
> +static int rk3568_lvds_probe(struct platform_device *pdev,
> +			     struct rockchip_lvds *lvds)
> +{
> +	/*
> +	 * Grab and init the phy, but do NOT power it on here - that is done in
> +	 * rk3568_lvds_encoder_enable() once the GRF is in LVDS mode and dclk is
> +	 * running. See the comment there. The GRF is not touched at probe
> +	 * either: every bit of it is programmed from the enable path.
> +	 */

Please see the comments above.

> +	lvds->dphy = devm_phy_get(&pdev->dev, "dphy");
> +	if (IS_ERR(lvds->dphy))
> +		return PTR_ERR(lvds->dphy);
> +
> +	return phy_init(lvds->dphy);
> +}
> +
>  static const struct rockchip_lvds_soc_data rk3288_lvds_data = {
>  	.probe = rk3288_lvds_probe,
>  	.helper_funcs = &rk3288_lvds_encoder_helper_funcs,
> @@ -522,6 +672,11 @@ static const struct rockchip_lvds_soc_data px30_lvds_data = {
>  	.helper_funcs = &px30_lvds_encoder_helper_funcs,
>  };
>  
> +static const struct rockchip_lvds_soc_data rk3568_lvds_data = {
> +	.probe = rk3568_lvds_probe,
> +	.helper_funcs = &rk3568_lvds_encoder_helper_funcs,
> +};
> +
>  static const struct of_device_id rockchip_lvds_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3288-lvds",
> @@ -531,6 +686,10 @@ static const struct of_device_id rockchip_lvds_dt_ids[] = {
>  		.compatible = "rockchip,px30-lvds",
>  		.data = &px30_lvds_data
>  	},
> +	{
> +		.compatible = "rockchip,rk3568-lvds",
> +		.data = &rk3568_lvds_data
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
> @@ -601,6 +760,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	encoder = &lvds->encoder.encoder;
>  	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
>  							     dev->of_node);
> +	rockchip_drm_encoder_set_crtc_endpoint_id(&lvds->encoder,
> +						  dev->of_node, 0, 0);
>  
>  	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
>  	if (ret < 0) {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
> index 2d92447..93d3415 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
> @@ -121,4 +121,14 @@
>  #define   PX30_LVDS_P2S_EN(val)			FIELD_PREP_WM16(BIT(6), (val))
>  #define   PX30_LVDS_VOP_SEL(val)		FIELD_PREP_WM16(BIT(1), (val))
>  
> +#define RK3568_GRF_VO_CON0			0x0360
> +#define   RK3568_LVDS0_SELECT(val)		FIELD_PREP_WM16(GENMASK(5, 4), (val))
> +#define   RK3568_LVDS0_MSBSEL(val)		FIELD_PREP_WM16(BIT(3), (val))
> +
> +#define RK3568_GRF_VO_CON2			0x0368
> +#define   RK3568_LVDS0_DCLK_INV_SEL(val)	FIELD_PREP_WM16(BIT(9), (val))
> +#define   RK3568_LVDS0_DCLK_DIV2_SEL(val)	FIELD_PREP_WM16(BIT(8), (val))
> +#define   RK3568_LVDS0_MODE_EN(val)		FIELD_PREP_WM16(BIT(1), (val))
> +#define   RK3568_LVDS0_P2S_EN(val)		FIELD_PREP_WM16(BIT(0), (val))
> +
>  #endif /* _ROCKCHIP_LVDS_ */

-- 
Best, 
Chaoyi
