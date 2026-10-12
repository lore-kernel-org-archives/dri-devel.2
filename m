Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA1CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F80910E587;
	Mon, 12 Oct 2026 13:46:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8980E10E587
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:46:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EAA94034C;
 Mon, 12 Oct 2026 13:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEE91F0089B;
 Mon, 12 Oct 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791812765;
 bh=Wv6ang5TgCLCkNPmUiBl924LanCQv29by1MibJLgtNU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dwX5VupGiRRxLWPtn46fHua62Nqv57fcXAtJwdjebzz4MX4AZRKq0qs/Y2XBwaGl+
 sGfCyNLt3PBu4A2NrmLRapjZtxwMvZGt7FViJrDOxRud3pH579H8oaIORsAGdYZ9gw
 DK1k1lQ7I5Y91Q8DSmX04x+0zRiUfh8NIx0wFF4w5sghp5V0lm08cc1iCUZeGLsDgP
 NopR/x9XISmmqUzTLK7H9WKYwP03qncxKvOa6yqcV6k5IHSaG4d9q0PDtOkkiBwOua
 AgpNysw1YeXGyvSQRlvPexamgd7aa/e6aue1qu6Dl2/5HWKMJJDCCBlmrv7dTZdEmB
 UasMLMVTfmY2A==
Message-ID: <sashiko-outbox-168210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] phy: qcom: edp: Generalize power-on path for
 per-SoC overrides
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org, vkoul@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-nord-drv-dt-v2-8-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-8-a2ab9af954d2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:46:04 +0000
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
- [High] phy: qcom: edp: resource leak on error paths in qcom_edp_phy_init
--

commit 21c4ca6694dd5d440a6b00869831eb17626e0879
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Generalize power-on path for per-SoC overrides

This patch generalizes the power-on path by introducing a data-driven loop
for TX resistor writes and adding several SoC-specific registers to the
configuration structure. It also makes the com_clk_fwd_cfg callback optiona=
l.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index d5c6835b6c704..c5df1086607f0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c

[ ... ]

> @@ -313,9 +328,11 @@ static int qcom_edp_phy_init(struct phy *phy)
> =20
>  	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
> =20
> -	ret =3D edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> -	if (ret)
> -		return ret;
> +	if (edp->cfg->ver_ops->com_clk_fwd_cfg) {
> +		ret =3D edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> +		if (ret)
> +			return ret;

[Severity: High]
Does this error path leak the regulators and clocks?

Earlier in qcom_edp_phy_init(), regulators and clocks are successfully
enabled via regulator_bulk_enable() and clk_bulk_prepare_enable(). If the
newly wrapped optional com_clk_fwd_cfg() callback returns an error, the
function returns directly. This entirely bypasses the out_disable_supplies
cleanup label, resulting in a permanent leak of the regulator references.

Furthermore, there is no corresponding clk_bulk_disable_unprepare() call at
all, meaning the clocks will permanently leak as well.

> +	}
> =20
>  	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>  	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-nord-drv-d=
t-v2-0-a2ab9af954d2@oss.qualcomm.com?part=3D8
