Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F657C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF3A10E3DF;
	Fri, 11 Sep 2026 15:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UiisYy43";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A38610E3DF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:52:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B191060202;
 Fri, 11 Sep 2026 15:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01061F000FF;
 Fri, 11 Sep 2026 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789141962;
 bh=DQF2TcrsjmsJUxKzEazdTNP9aOG6WziNEWQ8N0SmEGk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UiisYy433kVS5J0urxniFGL6xCiVs2HQZdXnRQ+sMZPuilGRxer5Us/g+jAkvLowD
 v0VO8IPlFEhKYejp/X0dW4YcMMNYn9axMKdVN/K7etgttzV4UspfByBORVkTTqXtS4
 0Xl7QTPV7fOVB43ZC8KlMLHVw23/XWPB9OSP/O7Pfqa+oxB9XzLZlVvoeNDu4sbfBC
 bQQ272+Yk4iIdRB13vXayuThOW/wLIeNM15gHlzGDC2SxbLg9yCgkvynYeBtLkJXFg
 sngKzV9u7zEiSRZEPd2sbHphZWl9Yg6dn6zXVndRVjvO8dQndICr3edOnC3MJB4HfS
 tiY8kiMcHUEaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/17] phy: qcom: edp: Add Nord LDO, TX lane and TX
 resistor calibration callbacks
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, linux-phy@lists.infradead.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260911-nord-drv-dt-v1-15-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-15-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:52:41 +0000
Message-Id: <20260911155241.E01061F000FF@smtp.kernel.org>
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
- [High] The `qcom_edp_ldo_config_nord()` function unconditionally hardcode=
s LDO configuration values, contradicting the requirements documented in it=
s block comment and the commit message.
--

commit c4e3fc5c792992e3093d5a643cdeaee499d326f5
Author: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

phy: qcom: edp: Add Nord LDO, TX lane and TX resistor calibration callbacks

This commit adds PHY configuration callbacks for the Nord platform, introdu=
cing
specific LDO levels, TX lane control offsets, and TX resistor calibration c=
odes
based on HPG Table 2-1-d.

> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/p=
hy-qcom-edp.c
> index 4d1b2c81d9563..361f4e4673518 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c

[ ... ]

> +/*
> + * nord LDO configuration.
> + * From HPG Table 2-1-d: LDO Configuration section.
> + * eDP mode: 0xD1 for rates <=3D 8.1 Gbps, 0x00 for UHBR (>8.1 Gbps).
> + * DP mode: always 0x00.
> + * Also programs EDP2_DP_PHY_LDO_CFG: 0x03 for eDP rates <=3D 8.1G, 0x00=
 otherwise.
> + */
> +static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts =3D &edp->dp_opts;
> +	u32 ldo_config;
> +	u32 phy_ldo_cfg;
> +
> +	ldo_config =3D 0xd0;
> +	phy_ldo_cfg =3D 0x03;

[Severity: High]
The block comment directly above specifies that the LDO configuration
should be set dynamically based on the operating mode and link rate, such as
0xD1 for eDP rates <=3D 8.1 Gbps and 0x00 for UHBR or DP mode.

Does unconditionally hardcoding these values to 0xd0 (which also appears to=
 be
a typo for 0xD1) and 0x03 cause incorrect LDO voltages to be applied when t=
he
PHY is initialized for DP mode or high-speed eDP links?

Applying these values unconditionally during device probe or link training
might lead to PHY instability or link failures when operating in DP mode
or high-speed eDP modes where the hardware programming guide requires 0x00.

> +
> +	writel(ldo_config, edp->tx0 + TXn_LDO_CONFIG);
> +	writel(dp_opts->lanes > 2 ? ldo_config : 0x00, edp->tx1 + TXn_LDO_CONFI=
G);
> +	writel(phy_ldo_cfg, edp->edp + DP_PHY_LDO_CFG);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-nord-drv-d=
t-v1-0-e25c073cf1b6@oss.qualcomm.com?part=3D15
