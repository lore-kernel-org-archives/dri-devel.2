Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF84C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0717710E5F7;
	Mon, 10 Aug 2026 03:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KhkRlFLv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBC010E5F7
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:55:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8766741AE2;
 Mon, 10 Aug 2026 03:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402591F000E9;
 Mon, 10 Aug 2026 03:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786334118;
 bh=ZE1l1tmKc6bJtxDdS2g0o+iLefmzf3VsnGCVXbHe7ts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KhkRlFLvrqw+KV7VsLxvByW+xTizjZbRZc406BLQNDqWYwEwRsB8TJ7YKPz/OP6Az
 CnHCg0vM6+XaPSZgYzNhxO1/jqusTGpbig5/QHpTuf1lLJXsqqeyjRVh4BVZ9rYKPz
 9GzPVQCWwPkMw/TyFHXaP9E8KwAWUin6iXCThguqL5JoIIhrtLYZL8g8qc1xN8QIHd
 2Pa0DNOCplmiM97BdWjXQRy3eYgx/Tyyx4KOlyWiJnP7qJEC6RG0H96BPX1y9KKg9R
 W4qV4XgxTuGy0W1oN3rycAJ9GA1dvqr+R/j4Ie4o92J0cB3lUkAQOGrkgbHQTkfzdX
 omJANRlypvd9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810034139.148-2-kernel@airkyi.com>
References: <20260810034139.148-1-kernel@airkyi.com>
 <20260810034139.148-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 03:55:17 +0000
Message-Id: <20260810035518.402591F000E9@smtp.kernel.org>
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
- [High] Potential divide-by-zero kernel panic if the PLL reference clock r=
eturns a rate of 0 Hz.
--

--- Patch [1]: [PATCH v3 1/3] drm/rockchip: dsi: Add maximum per lane bit r=
ate calculation ---
commit d9f1ff11296ed644cdf72ac949c279cf1d55f770
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Add maximum per lane bit rate calculation

This commit adds calculations for the maximum per-lane bit rate across
various rockchip platforms. It introduces a new max_bit_rate_per_lane field
to the chip data and uses it to determine the max_mbps dynamically.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 268d4993a04fd..fd91343d0f6d5 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
[ ... ]
> @@ -572,6 +573,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
>  	unsigned long _fbdiv, best_fbdiv;
>  	unsigned long min_delta =3D ULONG_MAX;
> =20
> +	max_mbps =3D dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;
>  	dsi->format =3D format;
>  	bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
>  	if (bpp < 0) {

[Severity: High]
This is a pre-existing issue, but while reviewing this function, I noticed
a potential divide-by-zero vulnerability further down in
dw_mipi_dsi_get_lane_mbps().

If clk_get_rate(dsi->pllref_clk) returns 0, which could occur if the clock
provider is uninitialized, disabled, or misconfigured in the device tree,
fin becomes 0. The calculations for min_prediv and max_prediv would then
both evaluate to 0.

This would cause the subsequent loop to execute once with _prediv =3D 0:

	for (_prediv =3D min_prediv; _prediv <=3D max_prediv; _prediv++) {
		u64 tmp;
		u32 delta;
		/* Fvco =3D Fref * M / N */
		tmp =3D (u64)fout * _prediv;
		do_div(tmp, fin);

Could this do_div(tmp, fin) trigger a kernel panic due to division by zero?

Would it make sense to add a check validating that fin is greater than zero
before proceeding with the calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810034139.148-=
1-kernel@airkyi.com?part=3D1
