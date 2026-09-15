Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CA4C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1862410FB29;
	Tue, 15 Sep 2026 08:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PdiRRWjx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A66D10FB29
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E068602C8;
 Tue, 15 Sep 2026 08:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41291F000FF;
 Tue, 15 Sep 2026 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789462494;
 bh=nhFDk1spMGQrf3O5K/5bVDZ1T+4kcRRIr3mLvyFTDis=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PdiRRWjxp9Jxxi7zY6LtJWDNdlF+UL2bMU8Cl5+eVt/o9GnvIkyIicv1tOXEPZnkb
 6NbAZ/pFMU7cuJ/Z/qIk/qpqEaqcxJMX0opToIYLu68o5L8DFf4Wbccy0YEUm/5BZW
 0PHX2t4aYllSMcoCTMalsbJWh+3wErXRg1m0QBYoWdPvtCxhtvMff3XWHr0BnzOBUf
 hfR4WxHvxsqG/Cgum2iNFAVIWM5R1dqwibCx/AgdaY0Lw4FFnfRLEX8AyIJQdiW3xX
 Pn3qU76cgznh5g5uzdE+ZXTbIdu3uX8YVIdelJGMrV/LdrVBpw1EXHBHDfzc7NBsPj
 JSsJReGDImNIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/13] drm/mediatek: mtk_dsi: Add support for SRAM
 QoS setting
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260915084148.11385-10-angelogioacchino.delregno@collabora.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:54:53 +0000
Message-Id: <20260915085453.C41291F000FF@smtp.kernel.org>
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
- [High] drm/mediatek: dimensional mismatch in DSI QoS threshold calculatio=
ns
- [High] drm/mediatek: DSI TX buffer RW times incorrectly based on vertical=
 resolution
--

commit beb6a7b889e54e3fb8cb1cebc84be4316c0c70e3
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for SRAM QoS setting

Add support for automatically calculating and setting the Quality of Service
(QoS) parameters and DSI IP SRAM Line Buffering in the newest DSI IPs like
the one found on MT8196, MT6991 and variants.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 6e92e4e1586f7..16bf08bee38e3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -771,6 +816,102 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *d=
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
Does this code inadvertently compare buffer units against bytes?

In mtk_dsi_config_hw_buffers(), data_rate_per_buf is calculated in
buffer units. Multiplying it by MTK_DSI_DEFAULT_QOS_VALID_FIFO_US yields
out_valid_thresh in buffer units. However, it is then capped against
MTK_DSI_MAX_FIFO_BYTES, which is a byte count. This dimensional mismatch
writes incorrect configuration values to the DSI QoS hardware registers,
which could lead to FIFO under-provisioning or values exceeding SRAM capaci=
ty.

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
Is it intentional to subtract buffer units from a value initialized in byte=
s?

Here in mtk_dsi_config_hw_buffers(), sodi_hi is initialized using
MTK_DSI_MAX_FIFO_BYTES (in bytes), but the subtracted amount is based on
fill_rate and data_rate_per_buf, which appear to be in buffer units. This
mismatch can corrupt the calculation and cause hardware lockups or display
corruption.

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
Does this calculate the transmission burst times based on the vertical
resolution instead of the horizontal line width?

In mtk_dsi_config_hw_buffers(), rw_times is calculated using the display's
vertical active lines (dsi->vm.vactive). This results in computing bytes
per column instead of bytes per line, which makes the computed line
transmission burst times incorrect for the DSI SRAM line buffers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915084148.1138=
5-1-angelogioacchino.delregno@collabora.com?part=3D9
