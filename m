Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFECCC88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2499210E466;
	Fri, 11 Sep 2026 15:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2aeZfbK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4D110E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:53:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E354960202;
 Fri, 11 Sep 2026 15:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE901F000FF;
 Fri, 11 Sep 2026 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789142033;
 bh=WplX7OL6orMvmYV8PDzGFduiYKPQWLKUXjRdFEq/V34=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U2aeZfbKlysx2d8nsN+buKhmOlUNduBboJnswNHNXI4yqRDguIwFeB8Y+4azwyYlw
 9zBgv1dat2m5zUGMNbiA3AkAN0bUgmQmDaICrR7voYOcQmddJgq+im2drY+jFp8x1k
 /HfWvD4Wm9ktvP+gPc75egPIL+uXh8ak1nJuDXLE6llEW40F7H91hbyo/FOAzC/EAW
 TXVyj91XHnyx4Y/VsjIPfpYuHvP8JjsCjqKdxkzEwaFLiVpnLn099R89jMfS9pokP4
 ba8Kz/jYkaZgvQ4j/5PbMMN+Y5kzYibcuIGAvb8UpqgQnGtXTwuI6cunnwkO4RQtbR
 JvnWCZ/+uEahw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/17] phy: qcom: edp: Add Nord PLL configuration callback
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: olteanv@gmail.com, dri-devel@lists.freedesktop.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20260911-nord-drv-dt-v1-14-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-14-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:53:52 +0000
Message-Id: <20260911155353.0FE901F000FF@smtp.kernel.org>
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
- [High] The PLL configuration incorrectly writes 0x1d to DP_QSERDES_V8_COM=
_BIAS_EN_CLKBUFLR_EN, silently overwriting the 0x1f value set during initia=
lization.
--

commit 16052638682492657891d8a92561073f1ca35358
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord PLL configuration callback

Nord uses a 38.4 MHz CXO reference with a different QSERDES v8 COM register
layout and PLL coefficients. This commit adds a configuration callback to
program the QSERDES COM PLL registers with link-rate-dependent values.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index a0f4b12e561e9..4d1b2c81d9563 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
[ ... ]
> @@ -1688,6 +1688,118 @@ static int qcom_edp_com_configure_ssc_nord(const =
struct qcom_edp *edp)
[ ... ]
> +static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
> +{
[ ... ]
> +	writel(0x0a, edp->pll + DP_QSERDES_V8_COM_BG_TIMER);
> +	writel(core_clk_div_mode0, edp->pll + DP_QSERDES_V8_COM_CORECLK_DIV_MOD=
E0);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_VCO_TUNE_CTRL);
> +	writel(0x1d, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);

[Severity: High]
Will this unconditional write of 0x1d silently overwrite the 0x1f bias enab=
le
value required and set during PHY initialization?

It looks like qcom_edp_phy_init() calls com_bias_en_clkbuflr_nord() to set
this register to 0x1f. Later, when qcom_edp_phy_power_on() calls
com_configure_pll_nord(), this exact register is overwritten with 0x1d.

Could clearing this bit (bit 1) prevent the PLL from locking or cause link
training failures resulting in a blank display?

> +	writel(0x0f, edp->pll + DP_QSERDES_V8_COM_CORE_CLK_EN);
> +	writel(code1_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_M=
ODE0);
> +	writel(code2_mode0, edp->pll + DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_M=
ODE0);
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D14
