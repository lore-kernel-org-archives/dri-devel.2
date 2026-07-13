Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D46C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9952C10E8F1;
	Mon, 13 Jul 2026 10:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQXKinrI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6089410E8F1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:48:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82B8E6004E;
 Mon, 13 Jul 2026 10:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14401F000E9;
 Mon, 13 Jul 2026 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783939716;
 bh=joM5xgBMc4RGmzMrirARnsAMqCbi+hseeTpklEeWnqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NQXKinrIg9//o0fJBswvaUnIFClXlbvufjwxhxiQzNiUN+VETRDFM+7g5gdvzDQ6O
 9E/IjbbdeM/Qk4P4xEk68XBBPQkFM7pUlk+STlyXZLaNY6McVVm2f//w5QriwD4bJm
 1NAga6WZLWuFHzfhVbT6YwQRAUmGOkDLVfjGdbDnklZqy23of59R+2tKeTQr8uGnh4
 29uVQzOQaeveYE2RNSWh0sfVqTqiC1caWZmBcEEIqxxG3RADDCGmdOUwqK9xi2I7Fd
 jzRtGNYrJFLEVb4IqRA/NViBACFFYFg+g6y5RSF0daOJVS5CZc/v325MZyYHGqe1GL
 +oyFUnnAyq7zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org, robh@kernel.org,
 olteanv@gmail.com
In-Reply-To: <20260713103805.23030-3-angelogioacchino.delregno@collabora.com>
References: <20260713103805.23030-1-angelogioacchino.delregno@collabora.com>
 <20260713103805.23030-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:48:35 +0000
Message-Id: <20260713104835.B14401F000E9@smtp.kernel.org>
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
- [Medium] Signaling voltage boost is exclusively tied to the absolute maxi=
mum clamped frequency, preventing high data rates from receiving the boost.
--

--- Patch [2]: [PATCH v3 2/2] phy: mediatek: Add support for MT8196 MIPI DS=
I PHY ---
commit a6b40caad1ac266a0481ef7b26baffceb672008c
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: mediatek: Add support for MT8196 MIPI DSI PHY

This commit adds support for the MIPI DSI PHY found in the MediaTek MT8196
SoC and its variants. It introduces a new register layout and basic D-PHY
functionality needed to drive MIPI DSI displays.

> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c b/drivers/phy=
/mediatek/phy-mtk-mipi-dsi-mt8196.c
> new file mode 100644
> index 0000000000000..eac3db9922dba
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c

[ ... ]

> +static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx =3D mtk_mipi_tx_from_clk_hw(hw);
> +	void __iomem *base =3D mipi_tx->regs;
> +	u32 voltage =3D RG_DSI_PRD_REF_MINI;
> +	u32 pres =3D MIPITX_PRESERVED_MINI;
> +	unsigned long long pcw_calc;
> +	unsigned int txdiv, txdiv0;
> +	u32 pcw;
> +
> +	dev_dbg(mipi_tx->dev, "enable: %u bps\n", mipi_tx->data_rate);
> +
> +	if (mipi_tx->data_rate >=3D DSI_PHY_PLL_MAX_RATE_HZ) {
> +		/* Select higher signaling voltage for fast data rates */
> +		voltage =3D RG_DSI_PRD_REF_DEF;
> +		pres =3D MIPITX_PRESERVED_DEF;
> +		txdiv =3D 1;
> +		txdiv0 =3D 0;
> +	} else if (mipi_tx->data_rate >=3D 1000000000) {

[Severity: Medium]
Does this logic unintentionally restrict the higher signaling voltage to on=
ly
exact matches of the maximum PLL rate?

Since mtk_mipi_tx_pll_determine_rate() clamps the clock rate to
DSI_PHY_PLL_MAX_RATE_HZ (2.0 GHz), mipi_tx->data_rate can never exceed this
value. Consequently, panels requesting data rates slightly below 2.0 GHz
(for example, 1.99 GHz) will fall through to the 1.0 GHz branch instead of
receiving the voltage boost and correct PLL dividers intended for fast data
rates.

Could this conflation between the PLL octave band threshold and the maximum
frequency clamp macro also break the PLL divider logic if the maximum
supported rate limit is increased in the future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713103805.2303=
0-1-angelogioacchino.delregno@collabora.com?part=3D2
