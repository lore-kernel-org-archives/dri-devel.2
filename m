Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E719CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AAD10E80A;
	Tue, 13 Oct 2026 13:02:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B0C10E80A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:02:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3931D602C3;
 Tue, 13 Oct 2026 13:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7144B1F000FF;
 Tue, 13 Oct 2026 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791896551;
 bh=XJ2kkZ+RvTB0VG/+3wOa1NDgrg0e/cxGLS6EIfDrKl0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dNyZjoAD/in71vjBe7A66me2pfaxbPkqCz5x3+X2HGyV/XzafFOe/4clLZSg5Ymz6
 GVu3mMl6ddDBDSgBfK7Fr1fG3ug982XyaVHF9h7UBBSZDmO0OgVonYUdltBZYDDGfw
 Fmu2/icpsh/7Sxb/SD4DAPwqs5d3UIFHascDPI1/yBIp/VT8cV9o+L7BEhKjeO57ye
 4BoUwM47Ftwhla/CKI5zG/VaKwDVvr4jHZc79M6C7zBUayWmjIrmaXMve/5QPre5HN
 rfQpjsKoHelP6prnA4Owk4xpErMWpQP9z1qavOW7NKYCii/zk1JMY0RrFjPqry2aYN
 +/qBBcPNDObGQ==
Message-ID: <sashiko-outbox-169767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/6] phy: rockchip: Add support for Naneng eDP phy
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261013124946.1807886-5-damon.ding@rock-chips.com>
References: <20261013124946.1807886-1-damon.ding@rock-chips.com>
 <20261013124946.1807886-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:02:31 +0000
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
- [High] phy: rockchip: Missing set_lanes configuration and UB on unverifie=
d dp->lanes
- [Medium] Uninitialized variable val used if regmap_read fails
--

commit be568cbd60b1a73a69ea7b9233f6bd9cf9a8b067
Author: Damon Ding <damon.ding@rock-chips.com>

    phy: rockchip: Add support for Naneng eDP phy
   =20
    Add a driver for the Rockchip eDP transmitter PHY with NaNeng IP
    block, as found on the RK3568 SoC.

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-edp.c b/drivers/phy=
/rockchip/phy-rockchip-naneng-edp.c
> new file mode 100644
> index 0000000000000..a407714f639a7
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-edp.c
[ ... ]
> +static int rockchip_edp_phy_set_rate(struct rockchip_edp_phy *edpphy,
> +				     struct phy_configure_opts_dp *dp)
> +{
[ ... ]
> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0, FIELD_PREP_WM16(EDP_PHY_PD_=
PLL_MASK, 0));
> +	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
> +		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, ~GENMASK(dp->lanes - 1, 0)));

[Severity: High]
If a caller passes a struct where dp->lanes is 0, will this trigger undefin=
ed
behavior?

If dp->lanes is 0, ~GENMASK(dp->lanes - 1, 0) evaluates to
GENMASK(UINT_MAX, 0), triggering a negative right-shift count in C. This can
occur if a caller invokes phy_configure() with opts->dp.set_rate =3D 1 with=
out
having first configured the lane count.

[ ... ]
> +static int rockchip_edp_phy_verify_config(struct rockchip_edp_phy *edpph=
y,
> +					  struct phy_configure_opts_dp *dp)
> +{
[ ... ]
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

[Severity: High]
Is it possible for dp->lanes to be used unvalidated here?

The comment says "Lane count verified previously", but the validation of
dp->lanes is bypassed if dp->set_lanes is false. If a driver calls
phy_configure() with opts->dp.set_voltages =3D 1 and opts->dp.set_lanes =3D=
 0,
an uninitialized or invalid dp->lanes value could lead to out-of-bounds arr=
ay
reads.

[ ... ]
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
Is opts->dp.set_lanes intentionally ignored when configuring the PHY?

The opts->dp.set_lanes flag isn't handled here, meaning the hardware lane
count is never configured. This missing state also causes the uninitialized
dp->lanes issues in rockchip_edp_phy_set_rate() and
rockchip_edp_phy_set_voltages().

[ ... ]
> +static bool rockchip_edp_phy_enabled(struct rockchip_edp_phy *edpphy)
> +{
> +	u32 val;
> +
> +	regmap_read(edpphy->grf, EDP_PHY_GRF_STATUS0, &val);
> +
> +	return FIELD_GET(PLL_RDY, val);

[Severity: Medium]
If regmap_read() fails, does this return stack garbage?

A failure in regmap_read() leaves val uninitialized. Using the uninitialized
stack variable could cause the driver to incorrectly assume the PHY is alre=
ady
enabled.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013124946.1807=
886-1-damon.ding@rock-chips.com?part=3D4
