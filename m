Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ED9C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB0510E69C;
	Wed, 16 Sep 2026 11:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XUOIozSp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2362F10E69C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:20:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6094860234;
 Wed, 16 Sep 2026 11:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6691F000FF;
 Wed, 16 Sep 2026 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789557623;
 bh=rMnnTOIQPw5GbSbh+2D87y33OBz/BjSR4Dov8/dgrh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XUOIozSp54z8mXL4cSNR3+YIAqWAM29DUiheMFuwCJZZf21zAmG1lzzDEIdZUdqz+
 RPBM2+seSlC4XAqCtXcOD9Td6H9usAYtWimdi/DA3OAsXs5LWUgGMCjaF9jbvMYPu8
 rrUqm8uEjQ1iWeJJPvXyTz1TX5OuDcy9ZEtjan5vINUbjmFI/TxT9tUYOywZm2niDk
 r13it3aif1cpTNj0Q7k+VMRjvehssmZQvpyOoZIutoPa0TOW6/Efudu0ouXquogH13
 HCVCvrCY49bYh84r7G9tNTnG68FuHLCc5ZGG6JyPguZknJdw2HBAqEOHW6kyPsIzpq
 TMu77k/XYE+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/13] drm/mediatek: mtk_dsi: Add support for SRAM
 QoS setting
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260916110825.102631-10-angelogioacchino.delregno@collabora.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:20:22 +0000
Message-Id: <20260916112022.BC6691F000FF@smtp.kernel.org>
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
- [High] drm/mediatek: incorrect scaling of fill_rate by pixels_per_iter
- [High] drm/mediatek: rw_times uses vactive instead of hactive
- [High] drm/mediatek: dimensional unit mismatch in QoS thresholds
--

commit 5e7052b5da8774e8f7f52c475c5eb2ff80c36e96
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for SRAM QoS setting

Add support for automatically calculating and setting the Quality
of Service (QoS) parameters and DSI IP SRAM Line Buffering in the
newest DSI IPs like the one found on MT8196, MT6991 and variants.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 9d701cadf7eac..64dfc100f0338 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -772,6 +817,102 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *d=
si)
> +static void mtk_dsi_config_hw_buffers(struct mtk_dsi *dsi)
> +{
> +	const struct mtk_dsi_driver_data *data =3D dsi->driver_data;
> +	const u16 *reg_qos =3D data->reg_qos;
> +	u32 buffer_unit, sram_unit, num_hw_buffers;
> +	u32 preultra_hi, preultra_lo;
> +	u32 urgent_hi, urgent_lo;
> +	u32 ultra_hi, ultra_lo;
> +	u32 sodi_hi, sodi_lo;
> +	u32 data_rate_per_buf;
> +	u32 out_valid_thresh;
> +	u32 dsi_buf_bpp;
> +	u32 fill_rate;
> +	u32 pclk_mhz;
> +	u32 rw_times;
> +	u32 val;
> +	u64 tmp;

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
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
[Severity: High]
Does this min() check compare mismatched units?

The data_rate_per_buf value is calculated in units of buffer_units / us.
Consequently, out_valid_thresh is calculated in buffer_units. However, it is
clamped using MTK_DSI_MAX_FIFO_BYTES (1554), which is an absolute byte coun=
t.

Because MTK_DSI_MAX_FIFO_BYTES is an absolute byte count, clamping a
buffer_unit value against 1553 allows the threshold to drastically exceed t=
he
actual hardware FIFO capacity.=20

The same unit mix-up appears to occur below with sodi_hi, which is initiali=
zed
as a byte count but has a buffer_units / us rate subtracted from it.

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
                                            ^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
Is it correct to multiply by data->pixels_per_iter here?

In mtk_dsi_config_hw_buffers(), pclk_mhz is derived from dsi->vm.pixelclock,
which is the display's total pixel clock. Multiplying this by
data->pixels_per_iter (which is 2 for MT8196) effectively doubles the pixel
rate, as pixelclock already accounts for all pixels being transmitted.

This artificially inflates the byte fill rate to a physically impossible va=
lue,
causing incorrect QoS anti-latency parameters to be programmed into the
hardware.

> +			    buffer_unit);
> +
> +	/* Calculate QoS Anti-Latency parameters */
> +	sodi_hi =3D MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;
> +	sodi_hi -=3D (fill_rate - data_rate_per_buf) * 12 / 10;
> +	sodi_lo =3D MTK_DSI_DEFAULT_QOS_SODI_LO_OVERHEAD * data_rate_per_buf;
> +	preultra_hi =3D MTK_DSI_DEFAULT_QOS_PREULTRA_HI_US * data_rate_per_buf;
> +	preultra_lo =3D MTK_DSI_DEFAULT_QOS_PREULTRA_LO_US * data_rate_per_buf;
> +	ultra_hi =3D MTK_DSI_DEFAULT_QOS_ULTRA_HI_US * data_rate_per_buf;
> +	ultra_lo =3D MTK_DSI_DEFAULT_QOS_ULTRA_LO_US * data_rate_per_buf;
> +	urgent_hi =3D MTK_DSI_DEFAULT_QOS_URGENT_HI_US * data_rate_per_buf;
> +	urgent_lo =3D MTK_DSI_DEFAULT_QOS_URGENT_LO_US * data_rate_per_buf;
> +	rw_times =3D dsi->vm.vactive * dsi_buf_bpp;
                   ^^^^^^^^^^^^^^^
[Severity: High]
Should this use hactive instead of vactive for line buffer timing?

The code calculates rw_times for line buffer bursts using dsi->vm.vactive
(vertical active lines). Since this is a horizontal burst line calculation,
shouldn't it be based on the line length (hactive) rather than the vertical
height of the display?=20

Using vactive leads to incorrect burst transmission timings that change
depending on the panel orientation.

> +	rw_times /=3D data->num_burst_lines * data->pixels_per_iter;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916110825.1026=
31-1-angelogioacchino.delregno@collabora.com?part=3D9
