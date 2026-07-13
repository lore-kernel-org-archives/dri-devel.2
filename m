Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D986C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E809210E8CA;
	Mon, 13 Jul 2026 10:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E/kFnxQ1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BAF10E8CA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:13:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 086D743B91;
 Mon, 13 Jul 2026 10:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5E11F000E9;
 Mon, 13 Jul 2026 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937585;
 bh=nC4OZ58ETTeCF7peTj2WIW3KIY2k58M6dxPQQ2rjIu0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/kFnxQ1f6XZc1s44fE+SqxhUrPobwn67/oPEQC3tfYBeEsfB736uCbEzomk8D1UL
 Gd3U1rDCy0M4yNPFAGVwa1Z7ioQR93YAqyiwtfntGfk0+BO0rnq5yTwjvFZtgYvtTV
 5T9iNKjc2KWkgcUEKY36AViK3Yxl49wJrcQRldopcJXxj0O7nAeSJfBWkldZfwJ8k1
 NIWpzw0XuvKbhnJrLHD6tlQkMnnjiJzNap92x7qAv3aQu+HekmLxqcurdidXPdAxnh
 oQlaaGGfirN9DIpz2K0qIeSpv9ZRs7bP2nm363lW4W7HN/GbystGLWnDrZacif+KRd
 coyPdvH2xSvXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] drm/mediatek: mtk_dsi: Add support for MT8189
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713095837.16590-7-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:13:05 +0000
Message-Id: <20260713101305.9C5E11F000E9@smtp.kernel.org>
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

New issues:
- [High] Inaccurate link rate overestimation falsely rejects valid modes an=
d incorrectly configures the PHY clock when DSC is enabled.

Pre-existing issues:
- [High] Silent 32-bit integer overflow when calculating DSI data rate for =
high-resolution panels on 32-bit architectures.
- [Medium] 32-bit signed integer overflow in `wanted_link_rate` calculation=
 allows maliciously crafted modes to bypass the maximum link rate security =
check.
--

--- Patch [6]: [PATCH v2 06/10] drm/mediatek: mtk_dsi: Add support for MT81=
89 ---
commit 06bb023e18f2fab2efd045626f608227b5c0522f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dsi: Add support for MT8189

This commit adds support for the DSI IP in the MT8189 SoC, which supports a
higher link rate of 2.5Gbps. It introduces a max_link_rate_mbps member to
parameterize the maximum link rate per SoC and updates the mode validation
callback to use this new parameter with 64-bit math.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 6a77ce8eea91f..2df2a9d5ec038 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1070,13 +1072,20 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *brid=
ge,
>  			  const struct drm_display_mode *mode)
>  {
>  	struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +	const struct mtk_dsi_driver_data *data =3D dsi->driver_data;
> +	u64 wanted_link_rate, max_link_rate;
>  	int bpp;
> =20
>  	bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
>  	if (bpp < 0)
>  		return MODE_ERROR;
> =20
> -	if (mode->clock * bpp / dsi->lanes > 1500000)
> +	wanted_link_rate =3D mode->clock * bpp;

[Severity: Medium]
This is a pre-existing issue, but does this calculation allow a 32-bit sign=
ed
integer overflow? Since mode->clock and bpp are both evaluated as 32-bit
signed integers, an abnormally high clock value could wrap around to a small
positive value before being zero-extended and assigned to the 64-bit
wanted_link_rate. Could this allow crafted modes to bypass the maximum link
rate check?

[Severity: High]
Does this calculation also overestimate the link rate when Display Stream
Compression (DSC) is enabled? By using the raw uncompressed bpp instead of
the compressed bit rate (dsi->dsc->bits_per_pixel), high-resolution
DSC-enabled displays might be falsely rejected as MODE_CLOCK_HIGH.

[Severity: High]
This is a pre-existing issue, but does a similar 32-bit integer overflow oc=
cur
in mtk_dsi_poweron() on 32-bit architectures?=20

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_poweron() {
    ...
    dsi->data_rate =3D DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel,
                                      dsi->lanes);
    ...
}

On 32-bit systems, pixelclock is a 32-bit unsigned long. For high-resolution
panels, the multiplication could overflow the 32-bit limit before the macro
casts the result to unsigned long long, resulting in a corrupted frequency
being sent to clk_set_rate().

Additionally, does mtk_dsi_poweron() configure the hardware DSI HS clock
using the uncompressed data rate rather than the DSC compressed data rate?
If so, could this overclock the hardware and cause it to fail when DSC is
active?

> +	max_link_rate =3D data->max_link_rate_mbps;
> +	max_link_rate *=3D dsi->lanes;
> +	max_link_rate *=3D KILO;
> +
> +	if (wanted_link_rate > max_link_rate)
>  		return MODE_CLOCK_HIGH;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D6
