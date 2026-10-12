Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE72BCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BA310E38E;
	Mon, 12 Oct 2026 13:44:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6605010E38E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:44:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FA21418A0;
 Mon, 12 Oct 2026 13:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875A01F0089B;
 Mon, 12 Oct 2026 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791812644;
 bh=9wQoPvhNfBCFt5eMYidhxwpZ5tIuDmEhDCV+FxI69zM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UYxcdu5A2QHfrps407/SvwJZ6ISMO+lWX5js/3trBOkQG6OFbIQMAy7BSMb8LZ86v
 0J8PAVwRBD6LdZIirGjMxKRWcewuank+DqVaiBjWr+bhxPswUt5e3dH2UtE6iJw008
 IcMw7P+qQuoTx5J1ZvG4d364NLLmVv4TgsDMgo1iuVXKnXbQXVhdtkb4ZAtqpeRnl1
 wlI6PFZkjrM5ICzIxV/AYi49/JR4viepg3eua2AhXqZTxWplpddDKYYnMBJyhEnkEe
 i8uXbKXMRMA8Ai4gSDttJn4U2u5uozqz1gqxxv7diGHIKQcTKwcjx6i81vJiSn1ttO
 qmvd4X4jnIFtw==
Message-ID: <sashiko-outbox-168204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] phy: qcom: edp: Add Nord phy_cfg, ops and OF
 compatible
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: olteanv@gmail.com, robh@kernel.org, linux-phy@lists.infradead.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-nord-drv-dt-v2-13-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-13-a2ab9af954d2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:44:03 +0000
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
- [High] phy: qcom-edp: legacy TXn_TX_BAND writes corrupt Nord hardware sta=
te
- [High] phy: qcom-edp: hardcoded TXn_TX_DRV_LVL writes break voltage updat=
es on Nord PHY
--

commit 1393c79f29bd788a83ce23c45373ba39e69132d0
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord phy_cfg, ops and OF compatible

This commit adds the configuration structures, operations, and device tree
matching for the Nord DP PHY. It defines the Nord-specific tables for AUX,
VCO, swing, and pre-emphasis, along with updated status register offsets.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index cb5f6e0ae607b..87400d61323a6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c

[ ... ]

> @@ -1774,6 +1774,30 @@ static const struct qcom_edp_tx_res_entry tx_res_c=
fg_nord[] =3D {
>  	QCOM_EDP_TX_RES_ENTRY_END,
>  };
> =20
> +static const struct phy_ver_ops qcom_edp_phy_ops_nord =3D {
> +	.com_power_on		=3D qcom_edp_phy_power_on_v8,
> +	.com_resetsm_cntrl	=3D qcom_edp_phy_com_resetsm_cntrl_v8,
> +	.com_bias_en_clkbuflr	=3D qcom_edp_com_bias_en_clkbuflr_v8,
> +	.com_configure_pll	=3D qcom_edp_com_configure_pll_nord,
> +	.com_configure_ssc	=3D qcom_edp_com_configure_ssc_nord,
> +	.com_ldo_config		=3D qcom_edp_ldo_config_nord,
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
> +	.tx2_tx3_lane_ctl	=3D DP_PHY_TX2_TX3_LANE_CTL_NORD,
> +	.tx_res_cfg		=3D tx_res_cfg_nord,

[Severity: High]
The tx_res_cfg_nord table correctly configures the relocated offset for
TX_BAND (0x0024). However, does qcom_edp_phy_power_on() still unconditional=
ly
write to the legacy TX_BAND offset (0x0028) before applying the tx_res_cfg
table?

qcom_edp_phy_power_on() {
    ...
    writel(0x04, edp->tx0 + TXn_TX_BAND);
    ...
    writel(0x04, edp->tx1 + TXn_TX_BAND);
    ...
}

Could this cause a write to the wrong offset on Nord hardware, potentially
corrupting whatever unrelated register now exists at 0x0028?

Should this register offset be parameterized or moved entirely to tx_res_cf=
g?

[Severity: High]
Similarly, tx_res_cfg_nord initializes DP_PHY_TX_LN0_DRV_LVL_NORD (offset
0x00e4), indicating the drive level registers were also relocated.

However, doesn't qcom_edp_set_voltages() still dynamically write the voltage
swing values to the legacy TXn_TX_DRV_LVL offset (0x0014) during DP link
training?

qcom_edp_set_voltages() {
    ...
    writel(swing, edp->tx0 + TXn_TX_DRV_LVL);
    ...
    writel(swing, edp->tx1 + TXn_TX_DRV_LVL);
    ...
}

Will DP link training fail on Nord PHYs because the actual drive level
register at 0x00e4 is never updated with the dynamic voltage levels?

> +	.cmn_status_reg		=3D DP_QSERDES_V8_COM_CMN_STATUS_NORD,
> +	.c_ready_status_reg	=3D DP_QSERDES_V8_COM_C_READY_STATUS_NORD,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-nord-drv-d=
t-v2-0-a2ab9af954d2@oss.qualcomm.com?part=3D13
