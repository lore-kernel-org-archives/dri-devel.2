Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6240DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEA910E9FE;
	Mon, 13 Jul 2026 14:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HfwsUEqC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA4210E9FE
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:39:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F30C6013A;
 Mon, 13 Jul 2026 14:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EA81F000E9;
 Mon, 13 Jul 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953580;
 bh=rzqCzBhTDMYrS1I3OF5Oh9I3VYs5qD1ttI7rnGPFtgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HfwsUEqCYoOJ1sVwKB422q2WL9oB6pJyePySvpmnbbbsEDe1bfCELIC0hClQeRZ+j
 JVRanRgO/Zr0tUBBdjHbIkIeE6BbcFRkFaQZ/f97s196zILIaWJEs4RnRhV1G/JVZN
 P8JQR8zHKMsQwXqGXrSgbnZQdAEmf7L23yI3Mpty4rIUZCqtLCykRh7tGQqNu7JNwC
 +vIs9Keda/WA/jVIyAbwdaMOY/yd8VlLCZxDAonAMQLViibIDJR1dZ6dqTcpAEoXPM
 MM/qS79tLma64YaNKgVbXlBFn/3HwKJLnjFXMWcge+49ce+h8AnfKLi6XG+mPpsyVk
 aVycTj5SFJfQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713142746.40259-8-angelogioacchino.delregno@collabora.com>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:39:39 +0000
Message-Id: <20260713143940.75EA81F000E9@smtp.kernel.org>
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
- [High] Dimensional unit mismatch in HW QoS calculations mixing 'bytes' an=
d 'buffer units' leads to FIFO overflow misconfiguration
- [High] Incorrect use of `vactive` instead of `hactive` for horizontal TX =
buffer read/write times calculation
--

--- Patch [7]: [PATCH v4 07/10] drm/mediatek: mtk_dsi: Add support for MT81=
96 ---
commit 53b751cd3a037b336029e926c7c021a5e451f750
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8196

Add support for the new DSI IP found in the Kompanio Ultra MT8196 SoC.
It initializes QoS parameters and makes use of a DSI SRAM reserved
buffer.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 5f06749349289..93bc507d77e20 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -776,6 +873,102 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *d=
si)
>  	return drm_dsc_compute_rc_parameters(dsc);
>  }
> =20
> +static void mtk_dsi_config_hw_buffers(struct mtk_dsi *dsi)
> +{

[ ... ]

> +	/* Read as: [Data rate (MHz)] * [Number of DSI lanes] / [8 buffer block=
s] */
> +	tmp =3D (u64)dsi->data_rate * dsi->lanes;
> +	data_rate_per_buf =3D div_u64(tmp, 8 * buffer_unit * HZ_PER_MHZ);
> +
> +	/*
> +	 * Anti-latency buffer output threshold for absolute timer mode: this
> +	 * parameter controls the maximum amount of output data that the FIFO
> +	 * can hold before running out of buffer space.
> +	 *
> +	 * The data will therefore be sent either when the DSI IP0s internal
> +	 * vblank vs bus QoS timer expires or when it reaches the amount of
> +	 * buffers set in BUF_OUT_VALID_THRESHOLD (regardless of QoS) to avoid
> +	 * partially, or entirely, losing frame(s).
> +	 */
> +	out_valid_thresh =3D MTK_DSI_DEFAULT_QOS_VALID_FIFO_US * data_rate_per_=
buf;
> +	out_valid_thresh =3D min(out_valid_thresh, MTK_DSI_MAX_FIFO_BYTES - 1);

[Severity: High]
Does this incorrectly cap a value in buffer blocks against a constant in by=
tes?

Since data_rate_per_buf is computed in buffer blocks per microsecond,
out_valid_thresh is calculated in buffer blocks. Capping it against=20
MTK_DSI_MAX_FIFO_BYTES - 1 (1553) allows up to 1553 blocks. This cap
evaluates to 49,696 bytes, which defeats the safety limit for the
1554-byte physical FIFO limit.

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
> +	fill_rate =3D div_u64((u64)pclk_mhz * data->pixels_per_iter * dsi_buf_b=
pp,
> +			    buffer_unit);
> +
> +	/* Calculate QoS Anti-Latency parameters */
> +	sodi_hi =3D MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;
> +	sodi_hi -=3D (fill_rate - data_rate_per_buf) * 12 / 10;

[Severity: High]
Does this mix incompatible units?

sodi_hi initializes as bytes (MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers),
but then subtracts a value in buffer blocks per microsecond
((fill_rate - data_rate_per_buf) * 1.2). This mixes incompatible units
and may result in mathematically meaningless values being programmed
into the hardware.

> +	sodi_lo =3D MTK_DSI_DEFAULT_QOS_SODI_LO_OVERHEAD * data_rate_per_buf;
> +	preultra_hi =3D MTK_DSI_DEFAULT_QOS_PREULTRA_HI_US * data_rate_per_buf;
> +	preultra_lo =3D MTK_DSI_DEFAULT_QOS_PREULTRA_LO_US * data_rate_per_buf;
> +	ultra_hi =3D MTK_DSI_DEFAULT_QOS_ULTRA_HI_US * data_rate_per_buf;
> +	ultra_lo =3D MTK_DSI_DEFAULT_QOS_ULTRA_LO_US * data_rate_per_buf;
> +	urgent_hi =3D MTK_DSI_DEFAULT_QOS_URGENT_HI_US * data_rate_per_buf;
> +	urgent_lo =3D MTK_DSI_DEFAULT_QOS_URGENT_LO_US * data_rate_per_buf;
> +	rw_times =3D dsi->vm.vactive * dsi_buf_bpp;
> +	rw_times /=3D data->num_burst_lines * data->pixels_per_iter;

[Severity: High]
Should this use dsi->vm.hactive instead of vactive?

Multiplying screen height (vactive) by bytes per pixel seems physically
meaningless for calculating horizontal line buffering burst characteristics.
Using hactive (horizontal pixels per line) might be the intended metric
to compute horizontal burst timings correctly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713142746.4025=
9-1-angelogioacchino.delregno@collabora.com?part=3D7
