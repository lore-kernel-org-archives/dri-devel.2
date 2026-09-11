Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2992C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53C910E3C6;
	Fri, 11 Sep 2026 15:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bzox/uuO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC0F10E3C6
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:49:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7560841B00;
 Fri, 11 Sep 2026 15:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8FD1F00893;
 Fri, 11 Sep 2026 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789141749;
 bh=baLZca9m/jVhaS+WTiyTOtwD2+JJChaOsn8UfHM6UuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bzox/uuO/qApBgZ74WOd2twhbzder3sxYgJfJUqMG4esgt1Av3hVVp2K20PaREAWH
 djpjcJIqNIWhWSRJ8HIFiv8SphKvr4p1WCfWrL2fXVnXHExhM6xRmx/h//8Y8kBnew
 E+7VZ6raclQzSamDUur4fBWDd/5ud5pe8B0t3YCohTroV2twvLAXCSyxwNXBJe3WXz
 mFne69DbX1UVExko3PVr1A0xJmuXuRkIjV1JZErmXka3NsMuTzNroWo7QSHAazSqjN
 YGSfErEyzf2ev382xqrubZEoxWiteIo1iKLT9uwOuJl5mdixPWaxuXqGR1saq/iN/G
 f8gsYTiNQM34g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] phy: qcom: edp: Add Nord bias and clock buffer
 enable callback
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, vkoul@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260911-nord-drv-dt-v1-12-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-12-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:49:08 +0000
Message-Id: <20260911154908.DC8FD1F00893@smtp.kernel.org>
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
- [Medium] Redundant function added due to an incorrect commit message claim
--

commit 3bc884119c8e394e11daa5276d830b8881379d66
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord bias and clock buffer enable callback

This commit introduces a new callback for the Nord platform to enable the
internal bias generator and clock buffer. It writes 0x1f to the
BIAS_EN_CLKBUFLR_EN register.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index 6cac4b55b66f6..ec4220cffe693 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1637,6 +1637,14 @@ static int qcom_edp_phy_com_resetsm_cntrl_nord(con=
st struct qcom_edp *edp)
>  }
> =20
> =20
> +static int qcom_edp_com_bias_en_clkbuflr_nord(const struct qcom_edp *edp)
> +{
> +	writel(0x1f, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);
> +
> +	return 0;
> +}
> +
> +

[Severity: Medium]
The commit message states that setting BIAS_EN_CLKBUFLR_EN to 0x1f "differs=
=20
from the value used on existing SoCs". Is this description accurate?

The existing qcom_edp_com_bias_en_clkbuflr_v8() function already writes exa=
ctly=20
0x1f to the same DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN register.

Does this new qcom_edp_com_bias_en_clkbuflr_nord() function introduce redun=
dant=20
code? Could the existing v8 variant be reused to avoid duplication, or shou=
ld=20
the commit message be updated to explain why a separate identical callback =
is=20
required?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D12
