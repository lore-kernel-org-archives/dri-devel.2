Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5103AC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EDA10F00E;
	Wed, 15 Jul 2026 12:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zq001a4q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53C310F00E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:08:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16D1E6001A;
 Wed, 15 Jul 2026 12:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F91F000E9;
 Wed, 15 Jul 2026 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784117285;
 bh=im0CYS+xm4VMApFgpj4vISI9oS35l1ku55WZHFfzNL8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zq001a4qPvf5ntgrGVKIwn5Ae+rkG4RT7jVPS3I57Z3kbwL4uCXl/R8CutWzDJbBk
 A5I5mYQFnvvWRI9c3intF9Ru/Sca4JksRiM7/XwHRYNcIGoVLBXJlXI8838VMI1IOs
 6R5q3EWUlrx+w5/TUZqCGekAfPYzGGTexs90BiYJtNocD+bXAJ3DgIgcmueNmgDeuy
 RupRif/4qV3WInbpc81dMJC+uj6VsrecIM40ovrIqsU7zzuIGjgFK7DsQtmvwbrTxD
 rZJMrYIwQi212iDbkuTg4pPagCoEB31xy56kAtWg76ixv1vO8g6oArO2S9Er1B1n+0
 AMqjlH9AZatJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/11] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715114916.19690-9-angelogioacchino.delregno@collabora.com>
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:08:05 +0000
Message-Id: <20260715120805.7C6F91F000E9@smtp.kernel.org>
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
- [High] Dimensional mismatch in QoS Anti-Latency FIFO threshold calculatio=
ns results in grossly inflated thresholds.
- [Medium] Unconditional mask of `DSI_VDE` can silently corrupt the `DSI_ST=
ART` register on generic SoCs.
--

--- Patch [8]: [PATCH v5 08/11] drm/mediatek: mtk_dsi: Add support for MT81=
96 ---
commit 1786ad54a3e9896a0d86f110a26f6c5cb91b0619
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8196

Add support for the new DSI IP found in the Kompanio Ultra MT8196 SoC.
It requires initialization of QoS parameters and can use a DSI SRAM
reserved buffer.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3f58683be70fa..4d8a02cbee385 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -776,6 +873,102 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *d=
si)

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
Does this mix dimensional units? out_valid_thresh is calculated using
data_rate_per_buf (which appears to be in blocks), but it is capped
against MTK_DSI_MAX_FIFO_BYTES, which is in bytes. Will this prevent the cap
from functioning correctly?

> +	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_BUF_CON1], BUF_OUT_VALID_THRESH, out_=
valid_thresh);
> +
> +	/* Enable ULTRA signal trigger between SOF and VACT */
> +	mtk_dsi_mask(dsi, data->reg_adv[DSI_VDE], VDE_BLOCK_ULTRA, 0);

[Severity: Medium]
If a future patch enables HW buffers for an older SoC (as the commit message
suggests is possible) but doesn't define DSI_VDE in reg_adv, will
reg_adv[DSI_VDE] evaluate to 0?

If so, this offset might map to DSI_START in the main register space. Could
this silently clear BIT(29) of the DSI_START register? Would it be safer
to check if DSI_VDE is defined before applying this mask?

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
Is it possible we are also mixing bytes and blocks here? MTK_DSI_MAX_FIFO_B=
YTES
is used without dividing by buffer_unit, which could result in a threshold
of 1554 blocks instead of 1554 bytes.

Could this grossly inflated threshold prevent the hardware from asserting
the anti-latency trigger and cause FIFO over/underflows?

> +	sodi_lo =3D MTK_DSI_DEFAULT_QOS_SODI_LO_OVERHEAD * data_rate_per_buf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715114916.1969=
0-1-angelogioacchino.delregno@collabora.com?part=3D8
