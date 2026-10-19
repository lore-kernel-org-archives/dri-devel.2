Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA229CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381B210E820;
	Mon, 19 Oct 2026 10:44:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE0D10EA30
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:44:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12A4940F27;
 Mon, 19 Oct 2026 10:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713C31F000C4;
 Mon, 19 Oct 2026 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792406687;
 bh=kyk2wQ9JjK5OLB2gseKGH6q7NLcg48KyXPMNlxewy80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l9im3uNHlDky4HxJDCNK+kWm+OULnt+atS/HeDt+MiCFcK4xwsTTigN0CIn000Y+E
 9oMSHBJakoKop1MJ+yzKGQmqx4U/bMgc9jHlkx3hsHHaj+OblShkwVS48f5AVvSz25
 ye07osH3uD5pLaQK7jEc+lceM9heHJz/6moUbDJIytfKUnswE/+E0HTR+MPF1Mh5s6
 r8uxRuRyg/0ItHtxaY7mmQ2AR5B0AWOmJ7yrdj2Alius5e3ggpYgVBtc1S2V6DPk25
 RAKkPVibWA6j5ZHsEqOfGB1LTSKnbyKclG6HBn78gnFeB4MtONII27LvTrSegXSsQo
 M/AXuFmmCMcmQ==
Message-ID: <sashiko-outbox-177008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: rockchip: rk356x: Add eDP controller
 and phy nodes
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261019102824.3157044-7-damon.ding@rock-chips.com>
References: <20261019102824.3157044-1-damon.ding@rock-chips.com>
 <20261019102824.3157044-7-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:44:45 +0000
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
- [High] phy: rockchip: missing set_lanes handling in rockchip_edp_phy_conf=
igure()
--

commit 30f8999d3eeb2007dc841979e7a48410043b002b
Author: Damon Ding <damon.ding@rock-chips.com>

arm64: dts: rockchip: rk356x: Add eDP controller and phy nodes

This commit adds the eDP PHY GRF (with the eDP PHY child node) and the eDP
controller device tree nodes for the RK3568 and RK3566 SoCs.

> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index a5832895bd392..3b60e4355ad8c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -403,6 +403,20 @@ usb2phy1_grf: syscon@fdca8000 {
>  		reg =3D <0x0 0xfdca8000 0x0 0x8000>;
>  	};
> =20
> +	edp_phy_grf: syscon@fdcb0000 {
> +		compatible =3D "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd";
> +		reg =3D <0x0 0xfdcb0000 0x0 0x100>;
> +		clocks =3D <&cru PCLK_EDPPHY_GRF>;
> +
> +		edp_phy: edp-phy {
> +			compatible =3D "rockchip,rk3568-edp-phy";
> +			clocks =3D <&pmucru XIN_OSC0_EDPPHY_G>;
> +			clock-names =3D "refclk";
> +			#phy-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +	};
> +
>  	pmucru: clock-controller@fdd00000 {
>  		compatible =3D "rockchip,rk3568-pmucru";
>  		reg =3D <0x0 0xfdd00000 0x0 0x1000>;
> @@ -879,6 +893,33 @@ hdmi_out: port@1 {
>  		};
>  	};
> =20
> +	edp: edp@fe0c0000 {
> +		compatible =3D "rockchip,rk3568-edp";
> +		reg =3D <0x0 0xfe0c0000 0x0 0x10000>;
> +		clocks =3D <&pmucru XIN_OSC0_EDPPHY_G>, <&cru PCLK_EDP_CTRL>, <&cru HC=
LK_VO>;
> +		clock-names =3D "dp", "pclk", "hclk";
> +		interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		phys =3D <&edp_phy>;
> +		phy-names =3D "dp";

[Severity: High]
Can the Analogix eDP controller complete link training when wired to
edp_phy ("rockchip,rk3568-edp-phy") without handling opts->dp.set_lanes in
rockchip_edp_phy_configure()?

When analogix_dp_link_start() runs in
drivers/gpu/drm/bridge/analogix/analogix_dp_core.c, it calls
analogix_dp_set_link_bandwidth(), analogix_dp_set_lane_count(), and
analogix_dp_set_lane_link_training() in
drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c. Each of these functions
zero-initializes a local union phy_configure_opts phy_cfg =3D {0} and sets
only set_rate, set_lanes, or set_voltages individually:

drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:
analogix_dp_set_lane_link_training() {
	if (dp->phy) {
		union phy_configure_opts phy_cfg =3D {0};

		for (lane =3D 0; lane < dp->link_train.lane_count; lane++) {
			...
			phy_cfg.dp.voltage[lane] =3D vs;
			phy_cfg.dp.pre[lane] =3D pe;
		}

		phy_cfg.dp.set_voltages =3D true;
		ret =3D phy_configure(dp->phy, &phy_cfg);

However, in drivers/phy/rockchip/phy-rockchip-naneng-edp.c,
rockchip_edp_phy_configure() only checks opts->dp.set_rate and
opts->dp.set_voltages:

drivers/phy/rockchip/phy-rockchip-naneng-edp.c:
rockchip_edp_phy_configure() {
	if (opts->dp.set_rate) {
		ret =3D rockchip_edp_phy_set_rate(edpphy, &opts->dp);
		if (ret) {
			dev_err(edpphy->dev, "Failed to set rate\n");
			return ret;
		}
	}

	if (opts->dp.set_voltages) {
		ret =3D rockchip_edp_phy_set_voltages(edpphy, &opts->dp);
		if (ret) {
			dev_err(edpphy->dev, "Failed to set voltages\n");
			return ret;
		}
	}

Because each phy_configure() call passes a fresh struct with only one
action flag set:

1. In analogix_dp_set_link_bandwidth(), phy_cfg.dp.set_rate is true while
phy_cfg.dp.lanes is 0. rockchip_edp_phy_verify_config() skips the lanes
check because dp->set_lanes is false, and rockchip_edp_phy_set_rate() then
evaluates ~GENMASK(dp->lanes - 1, 0) with dp->lanes =3D=3D 0, underflowing
dp->lanes - 1 when programming EDP_PHY_TX_PD_MASK and EDP_PHY_TX_IDLE_MASK:

drivers/phy/rockchip/phy-rockchip-naneng-edp.c:
rockchip_edp_phy_set_rate() {
	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
		     FIELD_PREP_WM16(EDP_PHY_PD_PLL_MASK, 0));
	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, ~GENMASK(dp->lanes - 1, 0)));
	...
	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, ~GENMASK(dp->lanes - 1, 0)));

2. In analogix_dp_set_lane_count(), phy_cfg.dp.set_lanes is true and
phy_cfg.dp.lanes holds the lane count, but rockchip_edp_phy_configure()
ignores opts->dp.set_lanes, neither saving the lane count nor updating the
lane power and idle masks.

3. In analogix_dp_set_lane_link_training(), phy_cfg.dp.set_voltages is true
while phy_cfg.dp.lanes is 0, so rockchip_edp_phy_set_voltages() loops from
0 to dp->lanes (0) and never writes the voltage swing or pre-emphasis
settings:

drivers/phy/rockchip/phy-rockchip-naneng-edp.c:
rockchip_edp_phy_set_voltages() {
	u8 lane;

	for (lane =3D 0; lane < dp->lanes; lane++)
		rockchip_edp_phy_set_voltage(edpphy, dp, lane);

	return 0;
}

Should the Naneng eDP PHY driver handle opts->dp.set_lanes and cache the
configured lane count in struct rockchip_edp_phy so that separate
set_rate, set_lanes, and set_voltages calls from the Analogix DP controller
work properly?

> +		power-domains =3D <&power RK3568_PD_VO>;
> +		resets =3D <&cru SRST_EDP_24M>, <&cru SRST_P_EDP_CTRL>;
> +		reset-names =3D "dp", "apb";
> +		status =3D "disabled";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019102824.3157=
044-1-damon.ding@rock-chips.com?part=3D6
