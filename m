Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC7A10E9A5;
	Mon, 13 Jul 2026 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="etrzTFq1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0076610E9A5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:13:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 440EF6004E;
 Mon, 13 Jul 2026 13:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1B31F000E9;
 Mon, 13 Jul 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948404;
 bh=nPPbVfeBDtFBts62tQhN/as11CFK0syN/en3nddvyuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=etrzTFq1dSmpmfZXwogFya7nUTs5i/r9/KLlbWzwuA+9kSQ0Ev52A6BBUG9uvHNtm
 XUHP0CE1xr6We7HP1/y5hALn8ob4OhwuSab7xl34lsEYKw9w1XrINl+qvaL5do9r1q
 3CgAq8blgWeez33TN0GCcV2AzH7ODyyDtRJ5pO9frHygw8ClfXXdq8nm27W6sTBLHf
 BocY1b4a6R1Q47DilzyoWerfuS3NxuWRjwSq+R7TH0w9bcjadoMJa4hM9K+zO3nx+A
 G4AlX1yhsCB5/Sk+R4REkJn56uuxsP7x9Epibi4p8ffwDlPQybet2TpxX+kcAIC2W3
 a3EkMwySs5Tgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] drm/mediatek: mtk_dsi: Add support for MT8189
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260713130103.34654-7-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:13:23 +0000
Message-Id: <20260713131323.9F1B31F000E9@smtp.kernel.org>
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
- [High] DSI link bandwidth and clock rate calculations ignore DSC (Display=
 Stream Compression), incorrectly rejecting valid high-resolution modes and=
 configuring the PHY clock out of spec.
--

--- Patch [6]: [PATCH v3 06/10] drm/mediatek: mtk_dsi: Add support for MT81=
89 ---
commit 89dc8fbb4f8f90dfbd3c155b69311aad3902771f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8189

This commit adds support for the DSI IP in the MT8189 SoC. It increases the
maximum link rate to 2.5Gbps and introduces a max_link_rate_mbps parameter
to replace hardcoded values. It also casts calculations to u64 to avoid
overflows with higher pixel clock rates.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 4d5cb91c788f6..dffb6befc749e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -924,7 +926,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	}
>  	bit_per_pixel =3D ret;
> =20
> -	dsi->data_rate =3D DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel,
> +	dsi->data_rate =3D DIV_ROUND_UP_ULL((u64)dsi->vm.pixelclock * bit_per_p=
ixel,
>  					  dsi->lanes);
> =20
>  	ret =3D clk_set_rate(dsi->hs_clk, dsi->data_rate);

[Severity: High]
Does this code ignore Display Stream Compression (DSC) when calculating the
PHY clock rate? The calculation uses the uncompressed bits per pixel, which
might set the DSI hardware PHY clock far higher than the actual compressed
link rate requires.

[ ... ]

> @@ -1099,13 +1101,21 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *brid=
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
> +	wanted_link_rate =3D mode->clock;
> +	wanted_link_rate *=3D bpp;
> +	max_link_rate =3D data->max_link_rate_mbps;
> +	max_link_rate *=3D dsi->lanes;
> +	max_link_rate *=3D KILO;
> +
> +	if (wanted_link_rate > max_link_rate)
>  		return MODE_CLOCK_HIGH;

[Severity: High]
Does this calculation also ignore DSC?=20

The wanted_link_rate is calculated using the uncompressed bpp instead of the
compressed bits per pixel. This could incorrectly reject valid high-resolut=
ion
display modes if their uncompressed bandwidth exceeds the DSI link's maximum
capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D6
