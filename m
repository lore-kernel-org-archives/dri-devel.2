Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67019CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85C710F102;
	Mon, 12 Oct 2026 13:43:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E7110E38E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:43:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC92241A27;
 Mon, 12 Oct 2026 13:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571BC1F0089B;
 Mon, 12 Oct 2026 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791812587;
 bh=HU8W7WyvQhr6+WPeL0/gx4fQymldhTyReuYTGv/aPN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XdBhCkqtSGb0JMR0LcYhaWbbRIwpLceLXs+GpbyJhFZflUgf2/lFwshzZsHeFlgJA
 3nQuAKSmOt+F6NJaSTVFnwdML2KTYo4g2f8etbqB3Vpa2FBE1suWJaAXgasuR4qQ1f
 c1GWQ24uo+qrWYa++bkmdi31OcgpDnzG8HnwuVAOsVs6Ov3/1RwfE/ktkyNkZsUqxt
 9fWirxuQym+a4PZzyUdEGPD1gBDQkJrEBnIM5sUifbdBP4oBzA4gUbx8OqNFldlh5C
 4rGLXnZDHxjRm1Pjsafp/bAPbeflk1rh0fROezPZ7pbBoA29iTRaeXo7J/pxnGg/dH
 mVcY6PrMm7H6Q==
Message-ID: <sashiko-outbox-168203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] phy: qcom: edp: Add Nord PHY configuration
 data tables
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org
In-Reply-To: <20261012-nord-drv-dt-v2-12-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-12-a2ab9af954d2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:43:06 +0000
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
- [Low] build: unused static symbols break compilation under Werror
--

commit bc3d5c7d159a12dc8bac2f06bcc9089584cfa877
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord PHY configuration data tables

This commit adds Nord-specific AUX channel, VCO divider, LDO and TX
resistor calibration data. These tables are sourced from HPG Tables
2-1-a, 2-1-b and 2-1-d.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index 3e857d1056680..cb5f6e0ae607b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1741,6 +1741,39 @@ static int qcom_edp_com_configure_pll_nord(const s=
truct qcom_edp *edp)
>  	return 0;
>  }
> =20
> +static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] =3D {
> +	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02,=
 0x04,
> +};
> +
> +static const u8 edp_phy_vco_div_cfg_nord[4] =3D {
> +	0x00, 0x00, 0x02, 0x01,
> +};

[Severity: Low]
Does this code introduce unused static variables?

These arrays, as well as tx_res_cfg_nord below, are defined as static but a=
re
not referenced anywhere in this commit. Defining unreferenced static arrays
triggers a -Wunused-const-variable compiler warning.

If the kernel is built with CONFIG_WERROR=3Dy, this warning is promoted to =
an
error and breaks the build. While a later patch in this series (commit
1393c79f29bd788a83ce23c45373ba39e69132d0) references these tables,
intermediate patches must compile cleanly to maintain git bisectability.

> +
> +static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts =3D &edp->dp_opts;
> +
> +	writel(0xd0, edp->tx0 + TXn_LDO_CONFIG);

[Severity: Low]
Does this code introduce an unused static function?

Similar to the static arrays above, qcom_edp_ldo_config_nord is defined as
static but never called in this commit. This triggers a -Wunused-function
warning, which will also break the build under CONFIG_WERROR=3Dy.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-nord-drv-d=
t-v2-0-a2ab9af954d2@oss.qualcomm.com?part=3D12
