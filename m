Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19CDC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2575F10E8F6;
	Mon, 13 Jul 2026 10:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OlFiZV6H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FDC10E8F6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:32:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C70146004E;
 Mon, 13 Jul 2026 10:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E37C1F000E9;
 Mon, 13 Jul 2026 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783938763;
 bh=5Dz+t3Wdm4GaqxoQWFG0bDZjkowP7rv++fG1N/ZnYUk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OlFiZV6HQSV3MRGlNbsU7DBAge7FSP/fOzEIbvsnqj8zT1kI7H7BFHtDw1p5XX8/h
 XFEjK+mxnND9ErxmRAFDmJ4jxmghGGc9bNWuhXw2TZ7LwiWQLYZM3ui6ngOMg0IKZo
 L8YY9ekTT7WBzSyAvzb0QMhOj44tWcVWYciEbXLKnrOUhHqbdQ+oTMrDLodS0IqoCV
 pCajFg+EvQwEEGcpcvXDk2GS8t3/uJeAtkM1wuxzz3YEF4z+5eb/+RyjZqwMsl8Hho
 6WiS0Vpvh32SBN+EKgznQtSU/t582+zxA6Hk/d2ks1c3R4kG3ANJ5b8+RJC7P6Nw6u
 WYYfCCgjqgqig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org
In-Reply-To: <20260713102322.21782-3-angelogioacchino.delregno@collabora.com>
References: <20260713102322.21782-1-angelogioacchino.delregno@collabora.com>
 <20260713102322.21782-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:32:42 +0000
Message-Id: <20260713103243.0E37C1F000E9@smtp.kernel.org>
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
- [High] Sleeping in Atomic Context
- [Low] Dead Code / Hardware Capability Restriction
--

--- Patch [2]: [PATCH v2 2/2] phy: mediatek: Add support for MT8196 MIPI DS=
I PHY ---
commit 290d9427c436e302c4aba5a26f5e3e1e9bb728f5
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: mediatek: Add support for MT8196 MIPI DSI PHY

Add support for the MIPI DSI PHY found in the MediaTek MT8196 SoC
and its variants. This PHY has a different register layout and provides
support for more hardware features compared to the previous generation.

> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c b/drivers/phy=
/mediatek/phy-mtk-mipi-dsi-mt8196.c
> new file mode 100644
> index 0000000000000..273f236fa7e9e
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c
> @@ -0,0 +1,196 @@
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
> +	if (mipi_tx->data_rate >=3D 2000000000) {
> +		/* Select higher signaling voltage for fast data rates */
> +		voltage =3D RG_DSI_PRD_REF_DEF;

[Severity: Low]
Is this block reachable? Later in mtk_mipi_tx_pll_determine_rate(),
req->rate is clamped to a maximum of 1,600,000,000 Hz. If the hardware
supports rates above 2.0 GHz, does the clamp limit need to be increased,
or is this dead code?

> +		pres =3D MIPITX_PRESERVED_DEF;
> +		txdiv =3D 1;
> +		txdiv0 =3D 0;
> +	} else if (mipi_tx->data_rate >=3D 1000000000) {
[ ... ]
> +	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +	usleep_range(30, 60);

[Severity: High]
Does this code sleep in an atomic context?

The mtk_mipi_tx_pll_enable() function is registered as the .enable
callback in mtk_mipi_tx_pll_ops below. The Common Clock Framework invokes
.enable under an enable_lock spinlock with interrupts disabled.

Calling usleep_range() here, which internally calls schedule(), will lead
to scheduling while atomic. Should this use an atomic-safe delay like
udelay(30), or should this logic be moved to the sleepable .prepare
callback?

> +
> +	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	writel(pcw, base + MIPITX_PLL_CON0);
> +	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
> +	usleep_range(30, 60);
> +
> +	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +	usleep_range(30, 60);
> +
> +	return 0;
> +}
[ ... ]
> +static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
> +					  struct clk_rate_request *req)
> +{
> +	req->rate =3D clamp_val(req->rate, 125000000, 1600000000);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops mtk_mipi_tx_pll_ops =3D {
> +	.enable =3D mtk_mipi_tx_pll_enable,
> +	.disable =3D mtk_mipi_tx_pll_disable,
> +	.determine_rate =3D mtk_mipi_tx_pll_determine_rate,
> +	.set_rate =3D mtk_mipi_tx_pll_set_rate,
> +	.recalc_rate =3D mtk_mipi_tx_pll_recalc_rate,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713102322.2178=
2-1-angelogioacchino.delregno@collabora.com?part=3D2
