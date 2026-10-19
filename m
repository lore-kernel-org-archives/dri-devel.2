Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C741CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A5210E7B7;
	Mon, 19 Oct 2026 10:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7298610E7B7
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:37:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 435094163D;
 Mon, 19 Oct 2026 10:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7C1F000C4;
 Mon, 19 Oct 2026 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792406252;
 bh=/oHQ4bdH43j1fuumTS02Am3jQZBjLwwUEwkgUZPR6zI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Naa44i3bJPqsT7f0nOe/lglmj1/NFLsOEbmh3rbA62SBQLNYlWu4pf5JVcf5Pu6SF
 Xb91lgPSM8eWmMTsQCfAz+/s9E/JnZr1vlYbH+FWualm8lAI08BBYyU9cOeoU0cDaP
 CcRq0dsVSudcSYuhS1VU/8lOtimRIMGm34W/5WbpqxxMi4qmaFYFDWPaO4hYysnpVM
 MEnxtdnAslBCPYyvrvjNXiveQi5b7QqYWKCwOzDICPLznqjp/gSK67dhWJAEgPkBww
 Fy1MxG8r42DWrT7VhqI32XHwE5nL0Vh6xewUBOdcWvjXEcK+Ql3sI5XK7HNPfi7ZGA
 fRpMwogchSsow==
Message-ID: <sashiko-outbox-177004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] phy: rockchip: Add support for Naneng eDP phy
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261019102824.3157044-5-damon.ding@rock-chips.com>
References: <20261019102824.3157044-1-damon.ding@rock-chips.com>
 <20261019102824.3157044-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:37:31 +0000
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
- [High] phy: rockchip: missing set_lanes handling in rockchip_edp_phy_conf=
igure()
- [Medium] phy: rockchip: uninitialized val read in rockchip_edp_phy_enable=
d()
--

commit d07a3a0e3533b84cdc67b6de45db340e9d9898c9
Author: Damon Ding <damon.ding@rock-chips.com>

phy: rockchip: Add support for Naneng eDP phy

This commit adds a driver for the Rockchip eDP transmitter PHY with the
NaNeng IP block found on the RK3568 SoC, controlled via the eDP PHY GRF
syscon regmap.

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-edp.c b/drivers/phy=
/rockchip/phy-rockchip-naneng-edp.c
> new file mode 100644
> index 0000000000000..a407714f639a7
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-edp.c

[ ... ]

> +static int rockchip_edp_phy_set_voltages(struct rockchip_edp_phy *edpphy,
> +					 struct phy_configure_opts_dp *dp)
> +{
> +	u8 lane;
> +
> +	for (lane =3D 0; lane < dp->lanes; lane++)
> +		rockchip_edp_phy_set_voltage(edpphy, dp, lane);
> +
> +	return 0;
> +}
> +
> +static int rockchip_edp_phy_set_rate(struct rockchip_edp_phy *edpphy,
> +				     struct phy_configure_opts_dp *dp)
> +{
> +	u32 value;
> +	int ret;

[ ... ]

> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0, FIELD_PREP_WM16(EDP_PHY_PD_=
PLL_MASK, 0));
> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
> +		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, ~GENMASK(dp->lanes - 1, 0)));
> +	ret =3D regmap_read_poll_timeout(edpphy->grf, EDP_PHY_GRF_STATUS0,
> +				       value, value & PLL_RDY, 100, 1000);
> +	if (ret) {
> +		dev_err(edpphy->dev, "Failed to wait for PHY PLL ready: %d\n", ret);
> +		return ret;
> +	}
> +
> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON5, FIELD_PREP_WM16(EDP_PHY_TX_=
MODE_MASK, 0x0));
> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
> +		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, ~GENMASK(dp->lanes - 1, 0))=
);
> +
> +	return 0;
> +}
> +
> +static int rockchip_edp_phy_verify_config(struct rockchip_edp_phy *edpph=
y,
> +					  struct phy_configure_opts_dp *dp)
> +{
> +	int i;
> +
> +	/* If changing link rate was required, verify it's supported. */
> +	if (dp->set_rate) {
> +		switch (dp->link_rate) {
> +		case 1620:
> +		case 2700:
> +			/* valid bit rate */
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (dp->set_lanes) {
> +		/* Verify lane count. */
> +		switch (dp->lanes) {
> +		case 1:
> +		case 2:
> +		case 4:
> +			/* valid lane count. */
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * If changing voltages is required, check swing and pre-emphasis
> +	 * levels, per-lane.
> +	 */
> +	if (dp->set_voltages) {
> +		/* Lane count verified previously. */
> +		for (i =3D 0; i < dp->lanes; i++) {
> +			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
> +				return -EINVAL;
> +
> +			/*
> +			 * Sum of voltage swing and pre-emphasis levels cannot
> +			 * exceed 3.
> +			 */
> +			if (dp->voltage[i] + dp->pre[i] > 3)
> +				return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_edp_phy_configure(struct phy *phy, union phy_configu=
re_opts *opts)
> +{
> +	struct rockchip_edp_phy *edpphy =3D phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret =3D rockchip_edp_phy_verify_config(edpphy, &opts->dp);
> +	if (ret) {
> +		dev_err(edpphy->dev, "Invalid params for phy configure\n");
> +		return ret;
> +	}
> +
> +	if (opts->dp.set_rate) {
> +		ret =3D rockchip_edp_phy_set_rate(edpphy, &opts->dp);
> +		if (ret) {
> +			dev_err(edpphy->dev, "Failed to set rate\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (opts->dp.set_voltages) {
> +		ret =3D rockchip_edp_phy_set_voltages(edpphy, &opts->dp);
> +		if (ret) {
> +			dev_err(edpphy->dev, "Failed to set voltages\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: High]
How does rockchip_edp_phy_configure() handle callers that issue separate
phy_configure() calls for rate, lane count, and voltage levels?

Looking at drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c, the Analogix =
DP
bridge issues three separate phy_configure() calls, each with a
zero-initialized union phy_configure_opts:

1. analogix_dp_set_link_bandwidth() sets only phy_cfg.dp.link_rate and
phy_cfg.dp.set_rate =3D true, leaving phy_cfg.dp.lanes =3D 0:

    union phy_configure_opts phy_cfg =3D {0};

    phy_cfg.dp.link_rate =3D
        drm_dp_bw_code_to_link_rate(dp->link_train.link_rate) / 100;
    phy_cfg.dp.set_rate =3D true;
    ret =3D phy_configure(dp->phy, &phy_cfg);

When rockchip_edp_phy_set_rate() runs, dp->lanes is 0 (and unvalidated since
dp->set_lanes is false), so GENMASK(dp->lanes - 1, 0) evaluates
GENMASK(UINT_MAX, 0) when programming EDP_PHY_TX_PD_MASK and
EDP_PHY_TX_IDLE_MASK.

2. analogix_dp_set_lane_count() sets phy_cfg.dp.lanes and
phy_cfg.dp.set_lanes =3D true, but rockchip_edp_phy_configure() never checks
opts->dp.set_lanes, so the lane-dependent TX configuration is not applied a=
nd
the active lane count is not stored in struct rockchip_edp_phy.

3. analogix_dp_set_lane_link_training() sets phy_cfg.dp.voltage[],
phy_cfg.dp.pre[], and phy_cfg.dp.set_voltages =3D true, with phy_cfg.dp.lan=
es
left at 0. Both rockchip_edp_phy_verify_config() and
rockchip_edp_phy_set_voltages() loop up to dp->lanes, so 0 iterations run a=
nd
no voltage swing or pre-emphasis registers are written (or if a caller pass=
es
set_voltages =3D true with set_lanes =3D false and an unvalidated dp->lanes=
 > 4,
the loops read past the end of dp->voltage[4] and dp->pre[4]).

Should the lane-dependent TX configuration be applied in a set_lanes handler
that also stores the lane count in struct rockchip_edp_phy for set_voltages
to use?

> +static bool rockchip_edp_phy_enabled(struct rockchip_edp_phy *edpphy)
> +{
> +	u32 val;
> +
> +	regmap_read(edpphy->grf, EDP_PHY_GRF_STATUS0, &val);
> +
> +	return FIELD_GET(PLL_RDY, val);
> +}

[Severity: Medium]
What happens in rockchip_edp_phy_enabled() if regmap_read() fails?

Because val is uninitialized and the return value of regmap_read() is not
checked, FIELD_GET(PLL_RDY, val) will read an uninitialized stack variable,
which can cause rockchip_edp_phy_power_on() to return 0 early without
powering on or configuring the PHY AUX channel.

Should val be initialized to 0 (or the regmap_read() error checked)?

[ ... ]

> --=20
> 2.34.1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019102824.3157=
044-1-damon.ding@rock-chips.com?part=3D4
