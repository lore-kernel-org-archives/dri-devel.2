Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E369C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDB410E9B3;
	Mon, 13 Jul 2026 13:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VJspJBMN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81F510E9C1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:11:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4543E600AA;
 Mon, 13 Jul 2026 13:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11C21F00A3A;
 Mon, 13 Jul 2026 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948263;
 bh=Rx34yiMHP3dtMokDvLG+d6m0CB0mXQweyMxiFGb19VE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VJspJBMNKJGHM9OilSAAIgNQwAHhCAgi1z8b8BFHWSWcz/xYLnrfgiey+HgQYPsir
 g+1Yq4FQzTMGoByw3gcTVjqvw71VvSpC88grbJhzikLyFHWa6d7itzkU+T20tPQ+Gx
 s12D7N+eOdxFpMmGFDkDdUR6TmXKit8+qJhgWiOEVKcXhdIQV2JzhymHO5jFfFXzZ6
 //KsofN2K4cEPBjMk0j6t18VN1a0xOmAYipNpl1aOvXd302HVQdhuHMGLvKcNXuCWa
 ztets/uNngJxpRJBRipNN+BdzrhTHKX08A5zgL9ZR++D6ZhQpU7WUhSrTD7SvKEZz8
 NDFUana+uoMUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713130103.34654-8-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:11:02 +0000
Message-Id: <20260713131102.A11C21F00A3A@smtp.kernel.org>
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
- [High] Unit mismatch between DSI data rate (Hz) and pixel clock rate (MHz=
) leads to integer underflow and incorrect QoS hardware buffer configuratio=
n.
- [High] 64-bit division by a non-constant variable causes a build error on=
 32-bit platforms.
--

--- Patch [7]: [PATCH v3 07/10] drm/mediatek: mtk_dsi: Add support for MT81=
96 ---
commit 92e543d518b805c7b9129880068f5a6955059779
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dsi: Add support for MT8196

This commit adds support for the new DSI IP in the MT8196 SoC. It
implements hardware buffer configuration and initializes QoS parameters
required by this newer hardware.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index dffb6befc749e..573299f0e63b6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -776,6 +872,91 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *ds=
i)
>  	return drm_dsc_compute_rc_parameters(dsc);
>  }
> =20
> +static void mtk_dsi_config_hw_buffers(struct mtk_dsi *dsi)
> +{
[ ... ]
> +	tmp =3D (u64)dsi->data_rate * dsi->lanes;
> +	data_rate_per_buf =3D tmp / 8 / buffer_unit;

[Severity: High]
Does this 64-bit division break builds on 32-bit platforms?

Since tmp is a u64 and buffer_unit is a non-constant u32, this will likely
cause an undefined reference to __udivdi3 or __aeabi_uldivmod when compiling
for 32-bit architectures. Should this use div_u64() instead?

> +
> +	/* Calculate valid threshold and avoid exceeding FIFO size */
> +	out_valid_thresh =3D MTK_DSI_DEFAULT_QOS_VALID_FIFO_US * data_rate_per_=
buf;

[Severity: High]
Are there unit mismatches in these rate calculations?

Since dsi->data_rate is in Hz, data_rate_per_buf is calculated
as buffers per second (e.g., ~15,000,000). Multiplying it by
MTK_DSI_DEFAULT_QOS_VALID_FIFO_US (25) will result in a huge value
that will always over-saturate the FIFO limit.

> +	out_valid_thresh =3D min(out_valid_thresh, MTK_DSI_MAX_FIFO_BYTES - 1);
> +	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_BUF_CON1], BUF_OUT_VALID_THRESH, out_=
valid_thresh);
> +
> +	/* Enable ULTRA signal trigger between SOF and VACT */
> +	mtk_dsi_mask(dsi, data->reg_adv[DSI_VDE], VDE_BLOCK_ULTRA, 0);
> +
> +	/* Calculate fill rate with line counter mode for DSI Video Mode */
> +	if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> +		dsi_buf_bpp =3D 2;
> +	else
> +		dsi_buf_bpp =3D 3;
> +
> +	pclk_mhz =3D dsi->vm.pixelclock / HZ_PER_MHZ;
> +	fill_rate =3D pclk_mhz * data->pixels_per_iter * dsi_buf_bpp / buffer_u=
nit;
> +
> +	/* Calculate QoS Anti-Latency parameters */
> +	sodi_hi =3D MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;
> +	sodi_hi -=3D (fill_rate - data_rate_per_buf) * 12 / 10;

Similarly, here fill_rate is computed using pclk_mhz and results in
buffers per microsecond (e.g., ~40). Subtracting the much larger
buffers-per-second value of data_rate_per_buf will cause an integer
underflow, resulting in incorrect hardware buffer configurations.

Could data_rate_per_buf be converted to a per-microsecond rate to align
with fill_rate and the microseconds constant?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D7
