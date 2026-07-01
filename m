Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F614C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AD310EF7A;
	Wed,  1 Jul 2026 12:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xn5hvw/o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEB210EF7A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3F1F60138;
 Wed,  1 Jul 2026 12:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5801F00A3E;
 Wed,  1 Jul 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909066;
 bh=RkQ36NxwB4OetEFBmYuS4HB1Opd6PUWhQXPYbKioANU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xn5hvw/oqq+7IC3C7UNKMgZKnrWvmtyreWPMpXlcQf29+OljmiAqDyY9xYdGtxdH8
 nIg1vppVv3q280yoFZ2p6kCwDpFJ8d6NOqwD0DLkePT/ZPa9iZMtjjWmsWM4B/Ge4p
 bdzfmmr7v8PIbL34J5Gnm7hMzG5m/7iCGoEJ5cPQovKWa7J3nyDUWfidYv8zxpGVuo
 qK08qGhEYzX08PRUz5BKI1WG+OLYbhGdwOZFF6zpWMMwqsQU7WDGx94zidm3N3zAQq
 7Xx5u0umuYRvdXBi0mFNmDY09Pigujrho0OBdK+wXhxbYHeBu+o/4XmQKrMmmMjpPE
 huiij0UE0+vsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc
 divisor overflow
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, olteanv@gmail.com, vkoul@kernel.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260701121936.19407-2-angelogioacchino.delregno@collabora.com>
References: <20260701121936.19407-1-angelogioacchino.delregno@collabora.com>
 <20260701121936.19407-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:31:05 +0000
Message-Id: <20260701123106.1B5801F00A3E@smtp.kernel.org>
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
- [High] Calculations using `14835 * MEGA`, `5 * GIGA`, and `12 * GIGA` sil=
ently overflow 32-bit `unsigned long` types on 32-bit architectures, comple=
tely breaking clock tiering and boundary checks.
--

commit 8179a32cf1dac8f1d080e57bbce79246661b50eb
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow

This commit fixes an issue where calculating a PLL rate for high display
resolutions results in a pixel clock exceeding 32 bits, but the digital
clock divider calculation uses div_u64(), which expects a 32-bit divisor.
It resolves this by using div64_u64() instead to prevent overflow.

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt8195.c
> index 1426a2db984d5..e6ee8e0800222 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -290,7 +290,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdm=
i_phy, struct clk_hw *hw,

[Severity: High]
This is a pre-existing issue, but do the constants in this function silently
overflow on 32-bit architectures?

Earlier in mtk_hdmi_pll_calc(), there are tier threshold calculations like:

    else if ((tmds_clk * 100) >=3D 14835 * MEGA && (tmds_clk * 10) < 2967 *=
 MEGA)

and later boundary checks:

    if (ns_hdmipll_ck >=3D 5 * GIGA &&
        ns_hdmipll_ck <=3D 12 * GIGA)

If MEGA and GIGA evaluate as 32-bit types on 32-bit systems, a multiplicati=
on
like 14835 * MEGA evaluates to 14,835,000,000, which wraps around modulo 2^=
32
to 1,950,098,112 before being promoted to u64 for the comparison against
tmds_clk * 100.

Similarly, 5 * GIGA and 12 * GIGA would overflow, potentially rendering the
valid PLL clock range mathematically unreachable and forcing the function to
always return -EINVAL on 32-bit builds.

Should these constants be explicitly typed or cast to u64 to ensure the
comparisons work correctly on 32-bit kernels?

>  	posdiv2 =3D 1;
> =20
>  	/* Digital clk divider, max /32 */
> -	digital_div =3D div_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
> +	digital_div =3D div64_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
>  	if (!(digital_div <=3D 32 && digital_div >=3D 1))
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701121936.1940=
7-1-angelogioacchino.delregno@collabora.com?part=3D1
