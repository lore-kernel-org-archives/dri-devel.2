Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657FAC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE3410E3E6;
	Fri, 11 Sep 2026 15:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oiMCpa6U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9C110E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:56:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D486843D73;
 Fri, 11 Sep 2026 15:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4846E1F000FF;
 Fri, 11 Sep 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789142201;
 bh=73uTfeFMu9/xVvopMPeT6jjeQlBMO5pBA6IxMwBr8kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oiMCpa6UQcMSJLoOWiWHxrKf7TGKIK/43kvns1ERnqKq3kZDtHnl6Wvk83TVfI7eq
 8n+3LESB6Eo+/nvAanDjiSCfaiPpJnNugEy8iexuIZHjT64FUVEU3Z4YbKg1RQrRL6
 5UEpmNbfAVfy+L6eHuRpvSDR0kTbbdmmBoSPgTy86bxkPe9RwBgLkvIZi6atSqP8Q1
 vf6WFcov9XOpeSHs66/K8wuZ5eXZzvuZuYRd8cE24/99WUMnKVGPYXWu0kKgO7Q4Mw
 EJ/IBBD5PBVicXAjyPHJvAPNOE8igHCPZ5R/wK9/4j8LVscPb+2DzfcjcCehFz9G7p
 Gl9tuvlu12oTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/17] phy: qcom: edp: Introduce Nord phy_ver_ops and
 phy_cfg descriptor
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, olteanv@gmail.com, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org
In-Reply-To: <20260911-nord-drv-dt-v1-16-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-16-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:56:40 +0000
Message-Id: <20260911155641.4846E1F000FF@smtp.kernel.org>
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
- [High] The common power-on flow unconditionally writes to the legacy TX_B=
AND offset, which corrupts registers on the Nord platform.
- [High] The Nord LDO configuration ignores DP mode and applies incorrect e=
DP settings, contradicting the Hardware Programming Guide.
--

commit ff420262cd547c67f8bafbb24b3a2db77628fd60
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Introduce Nord phy_ver_ops and phy_cfg descriptor

Add qcom_edp_phy_ops_nord wiring all eight Nord-specific callbacks and
nord_edp_phy_cfg collecting the Nord AUX, VCO divider, swing/pre-emphasis
tables and ver_ops.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index 361f4e4673518..338f28cb404fb 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1847,6 +1847,29 @@ static int qcom_edp_phy_tx_res_cfg_nord(const stru=
ct qcom_edp *edp)
>  }
> =20
> =20
> +static const struct phy_ver_ops qcom_edp_phy_ops_nord =3D {
> +	.com_power_on		=3D qcom_edp_phy_power_on_nord,
> +	.com_resetsm_cntrl	=3D qcom_edp_phy_com_resetsm_cntrl_nord,
> +	.com_bias_en_clkbuflr	=3D qcom_edp_com_bias_en_clkbuflr_nord,
> +	.com_configure_pll	=3D qcom_edp_com_configure_pll_nord,
> +	.com_configure_ssc	=3D qcom_edp_com_configure_ssc_nord,
> +	.com_ldo_config		=3D qcom_edp_ldo_config_nord,

[Severity: High]
Does this hardcode the incorrect LDO configuration for DP mode?

The comments for qcom_edp_ldo_config_nord() document that DP mode must use
0x00 and eDP mode must use 0xD1.

However, the implementation seems to unconditionally hardcode 0xd0 and 0x03,
ignoring edp->is_edp completely:

qcom_edp_ldo_config_nord()
	ldo_config =3D 0xd0;
	phy_ldo_cfg =3D 0x03;

	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);

Could this cause instability or link failures when running in DP mode due to
contradicting the hardware requirements?

> +	.phy_tx_lane_cfg	=3D qcom_edp_phy_tx_lane_cfg_nord,

[Severity: High]
Can the common power-on flow corrupt registers on the Nord platform here?

When qcom_edp_phy_power_on() runs, it calls this phy_tx_lane_cfg() callback
which correctly programs the Nord-specific TX_BAND offset at 0x0024:

qcom_edp_phy_power_on()
	if (edp->cfg->ver_ops->phy_tx_lane_cfg) {
		ret =3D edp->cfg->ver_ops->phy_tx_lane_cfg(edp);
        ...

But immediately afterward, the common flow unconditionally writes to the
legacy TX_BAND offset:

qcom_edp_phy_power_on()
	/* TX-0 register configuration */
    ...
	writel(0x04, edp->tx0 + TXn_TX_BAND);

Since TXn_TX_BAND moved to 0x0024 on Nord, writing to the legacy offset
(0x0028) might clobber whatever unknown register resides there now.

Would it be better to conditionally bypass the legacy TX_BAND write when the
Nord specific callback is used?

> +	.phy_tx_res_cfg		=3D qcom_edp_phy_tx_res_cfg_nord,
> +};
> +
> +static const struct qcom_edp_phy_cfg nord_edp_phy_cfg =3D {
> +	.is_edp			=3D false,
> +	.aux_cfg		=3D edp_phy_aux_cfg_nord,
> +	.vco_div_cfg		=3D edp_phy_vco_div_cfg_nord,
> +	.dp_swing_pre_emph_cfg	=3D &nord_dp_swing_pre_emph_cfg,
> +	.edp_swing_pre_emph_cfg	=3D &nord_edp_swing_pre_emph_cfg,
> +	.ver_ops		=3D &qcom_edp_phy_ops_nord,
> +	.phy_status_reg		=3D DP_PHY_STATUS_NORD,
> +	.bias1_en_2lane		=3D 0x03,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D16
