Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E7BC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B37899D4;
	Mon, 10 Aug 2026 07:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jr8iHqXE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1CC899D4
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:26:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7D20600B1;
 Mon, 10 Aug 2026 07:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515921F00A3A;
 Mon, 10 Aug 2026 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786346813;
 bh=PyEbjIgybH8eVskit9SJ6WDB+jwgH5gPvOVFFCmv17U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jr8iHqXEvLbOIbajtTnhKfPFxcis7v47P9vZvqvhqzrOp9zbONG99gXzRCA4ct+HA
 OLDrB5+CdA3A7JTQInKkzL2WeC5guZx/F9yE9a+mGrM94GUZ/26gSXtZBQLiKnfDY/
 3/PsTSuoH4Q1RhSIaKtcYEACE0diAIVcXGeJgxQbHAdqrCi6K9nRkTOyjYk+K1ZKzk
 fqdXmKHT3hwNNE8oLOr+Ss3ewPYHQLaNgLFg4g3/4XK54EAcExKv2Ty0ogcLm4pKR7
 FPr7ZfczARXmIq7R+X4BPf7Bo4Q5Byd5Xy7Y57Gb815WLCTPs1MUTBXYX9r6g92gh6
 UDziDC4cU/p8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-nwl-dsi-fixes-v3-5-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
 <20260810-nwl-dsi-fixes-v3-5-256da9d672e1@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:26:52 +0000
Message-Id: <20260810072653.515921F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Implicit 64-bit division using the `/` operator causes link errors=
 on 32-bit architectures.
- [Low] Integer overflow in `dsi->mode.clock * 1000` for high pixel clocks.
- [Low] Redundant picosecond period conversion introduces precision loss an=
d forces 64-bit math.
--

--- Patch [5]: [PATCH v3 5/5] drm/bridge: nwl-dsi: Correct MIPI DSI horizon=
tal sync timing ---
commit 54cf1e5377e7b6795c12c78939b18d1607d54031
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

The commit updates the NWL MIPI Host controller's horizontal sync timing
calculations. It converts hfp, hsa, and hbp to DSI packet bytes and
subtracts the packet header size. This aligns the timing configuration
with the i.MX 8M reference manual.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index e90588299c5ea..87d22b3bd79c7 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
[ ... ]
> @@ -317,9 +322,62 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>  			      dsi->mode.hdisplay);
>  	}
> =20
> -	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
> +	pclk_period =3D DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->mode.clock * 1000);

[Severity: Low]
Could this multiplication overflow on high pixel clocks? dsi->mode.clock is=
 a
signed 32-bit integer, so multiplying by 1000 could overflow if the clock
exceeds roughly 2.147 GHz. The resulting negative number would then be
sign-extended into a large unsigned long long for DIV_ROUND_UP_ULL(). Perha=
ps
casting to 1000ULL would avoid this?

> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "pclk_period: %llu\n", pclk_period);
> +
> +	hs_period =3D DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->phy_cfg.mipi_dphy.hs_=
clk_rate);
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_period: %llu\n", hs_period);
> +
> +	/*
> +	 * Calculate the bytes needed, according to the RM formula:
> +	 * Time of DPI event =3D time to transmit x number of bytes on the DSI
> +	 * interface
> +	 * dpi_event_size * dpi_pclk_period =3D dsi_bytes * 8 * hs_bit_period /
> +	 * num_lanes
> +	 * =3D=3D=3D>
> +	 * dsi_bytes =3D dpi_event_size * dpi_pclk_period * num_lanes /
> +	 * (8 * hs_bit_period)
> +	 */
> +	hfp =3D hfront_porch * pclk_period * dsi->lanes / (8 * hs_period);
> +	hbp =3D hback_porch * pclk_period * dsi->lanes / (8 * hs_period);
> +	hsa =3D hsync_len * pclk_period * dsi->lanes / (8 * hs_period);

[Severity: Low]
Does calculating the period in picoseconds introduce unnecessary precision =
loss?
By calculating pclk_period and hs_period first and then dividing them, the
math effectively does (10^12 / pclk) / (10^12 / hs_clk). For example, 148.5=
MHz
becomes 6735ps instead of 6734.0067ps. Using the raw clock rates directly
might eliminate intermediate rounding errors.

[Severity: High]
Will this standard division operator cause build failures on 32-bit platfor=
ms?
pclk_period and hs_period are 64-bit variables, so using the / operator here
will result in undefined reference to __udivdi3 during linking on 32-bit
architectures. Using div64_u64() or refactoring to use a 32-bit denominator
would prevent this link error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-nwl-dsi-fi=
xes-v3-0-256da9d672e1@geanix.com?part=3D5
