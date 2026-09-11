Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA88C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0875E10E379;
	Fri, 11 Sep 2026 07:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F8OFhlcJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC6710E379
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:51:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF61140AE5;
 Fri, 11 Sep 2026 07:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC61F000FF;
 Fri, 11 Sep 2026 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789113091;
 bh=okg3TokBT9+oTqBqWFBGuSEM8HNU1T7RP163axqjBP8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F8OFhlcJozoo+sRBWmvgVJ+/q9AUIVezeemz0skMOqou2EUIg7CfPO60m1cxqQvy+
 8VaQXDW4TmUgtz0V78X80VFMObGaFUTCSVGPO4TmcJhdweUDTWfPiKC8V41VuT7E9G
 Kg7JTxE39RrRE+ITs6i63eCEK6ZcI89IkLhIXT+eqAGHQ6ICXbhOuKsprstCiVhj6L
 gscntUiP7psql3+fJnbocVJANX0bWgwDEhaWpYcxjoskDHaRd+7oZ8nDKbLjepw0Sr
 14cSNGhh6jSgwCdk3lHJ/AWIQrb3n/sz6AVmZwiHXohGurOfi9LYBllTWK4i4peCp1
 MF2OyRmAikQKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc
 divisor overflow
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org
In-Reply-To: <20260911074015.9994-2-angelogioacchino.delregno@collabora.com>
References: <20260911074015.9994-1-angelogioacchino.delregno@collabora.com>
 <20260911074015.9994-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:51:30 +0000
Message-Id: <20260911075131.48BC61F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] Multiplications involving `MEGA` and `GIGA` macros overflow on 32-=
bit architectures, breaking clock calculations.
--

commit 83c70bcce00287d7e880c60c53f322581568117d
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow

When trying to calculate a PLL rate for target display resolutions
above 2560x1440, 24bpp, 30Hz, the pixel clock value will be more
than 32-bits long but the division to finally calculate the digital
clock divider is being done with div_u64(), which expects a 32bit
unsigned divisor.

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt8195.c
> index 1426a2db984d5..e6ee8e0800222 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -290,7 +290,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdm=
i_phy, struct clk_hw *hw,
>  	posdiv2 =3D 1;
> =20
>  	/* Digital clk divider, max /32 */
> -	digital_div =3D div_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
> +	digital_div =3D div64_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);

[Severity: High]
This isn't a bug introduced by this patch, but since this patch fixes
32-bit overflows, could the multiplications involving MEGA and GIGA in
mtk_hdmi_pll_calc() and mtk_hdmi_pll_drv_setting() also overflow on 32-bit
architectures?

In drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:mtk_hdmi_pll_calc(), the
bounds checks use MEGA and GIGA:

    else if (tmds_clk >=3D 54 * MEGA && (tmds_clk * 100) < 14835 * MEGA)

and:

    if (ns_hdmipll_ck >=3D 5 * GIGA &&
        ns_hdmipll_ck <=3D 12 * GIGA)

Since MEGA and GIGA are defined with the UL suffix in <linux/units.h>, do
values like 14835 * MEGA and 5 * GIGA silently wrap around when evaluated as
32-bit unsigned long values (e.g., 14835 * MEGA becoming ~1.95 billion)?

Similarly, in mtk_hdmi_pll_drv_setting():

    } else if (((u64)pixel_clk * 1000) >=3D 74175 * MEGA && pixel_clk <=3D =
300 * MEGA) {

Would 74175 * MEGA wrap to ~1.13 billion on 32-bit builds instead of 74.1
billion, potentially intercepting conditions that should fall to a different
impedance configuration block?

>  	if (!(digital_div <=3D 32 && digital_div >=3D 1))
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074015.9994=
-1-angelogioacchino.delregno@collabora.com?part=3D1
