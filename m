Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29BAC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1CA10E07F;
	Wed, 15 Jul 2026 14:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZbklglZH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBFA10E07F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00F24414DD;
 Wed, 15 Jul 2026 14:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959071F00A3A;
 Wed, 15 Jul 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784127083;
 bh=7czwNP/DC26y02anai799/yhnVFywZAVI7k7Oh6SLZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZbklglZHPBeEbgAStDBei6Z45ldnrN/MkHCYtIbX8HVJbjWOX1DDpFkv7m1kMf1Rw
 zpipAtgIl+95aMNjxmwtDNGySWg/+hojKVc/S8fH+o8fYdbgGH6PKVws64BRsMREQN
 T26LCC9z2OMB5VMTk072106atvC+zsQrwg1Q7MLR7E+pO/cm6OYghMUQRSsd2OQ+D4
 91PuSEbhzeIYueoZdHUvR+QzSGKg8Hr8MLRCSP6GuS2Vmg6GDXBb9UvzyZfFZgxrHe
 +yQgw6kIQU9BIdDZM5PK25rv86kdMWohpm2YT1ChFoDmvrj0eteYvwuyqBBISzLKNe
 DIMz9gqBxU06g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/11] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260715135703.46540-9-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:51:23 +0000
Message-Id: <20260715145123.959071F00A3A@smtp.kernel.org>
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
- [High] Calculation of QoS `rw_times` uses vertical active lines (`vactive=
`) instead of horizontal active pixels (`hactive`).

Pre-existing issues:
- [High] Data race between hardirq and process contexts on the `dsi->irq_da=
ta` state variable can result in lost interrupts.
- [High] Lack of serialization in MIPI DSI host transfer operations (`mtk_d=
si_host_transfer`), allowing concurrent transfers to corrupt the command qu=
eue and state.
--

--- Patch [8]: [PATCH v6 08/11] drm/mediatek: mtk_dsi: Add support for MT81=
96 ---
commit a997b4c68ea4198553bbed678f80fe423d11793b
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8196

Add support for the new DSI IP found in the Kompanio Ultra MT8196
SoC and its Dimensity and Genio variants.

Differently from the older DSI IPs, the one from MT8196 requires
the initialization of all of the QoS parameters and can make use
of a DSI SRAM reserved buffer (present also on older SoCs but not
mandatory on those).

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 95f7d94bdad3b..d2fdeaeb97bea 100644
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
> +	rw_times /=3D data->num_burst_lines * data->pixels_per_iter;

[Severity: High]
Does this calculation incorrectly use the vertical active lines (vactive)
instead of horizontal active pixels (hactive)?

Since DSI line buffers operate on horizontal lines, their size and bandwidth
depend on the line width. Using vactive here seems dimensionally incorrect =
and
might be a typo. Could this result in incorrect QoS parameters for
anti-latency buffers and cause display corruption or underflow?

> +
> +	/* Write all QoS parameters: Screen On Deep Idle, (pre)Ultra, Urgent, R=
W times */
> +	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_SODI_HIGH], BUF_THRESHOLD_PARAM, sodi=
_hi);

[ ... ]

[Severity: High]
This is a pre-existing issue, but can mtk_dsi_irq_data_clear() and
mtk_dsi_irq_data_set() drop interrupts due to a data race?

In mtk_dsi_irq_data_clear() (process context):

    dsi->irq_data &=3D ~irq_bit;

And mtk_dsi_irq_data_set() (hardirq context):

    dsi->irq_data |=3D irq_bit;

If the hardirq fires while process context is executing the non-atomic bit
clear, could an interrupt completion flag (like VM_DONE_INT_FLAG) be silent=
ly
erased? This could cause wait_event_interruptible_timeout() to fail and log=
 a
timeout, potentially hanging the display pipeline.


[Severity: High]
This is a pre-existing issue, but does mtk_dsi_host_transfer() lack required
serialization?

Unlike many DSI host drivers, mtk_dsi_host_transfer() does not take a mutex.
Can concurrent transfers from userspace via sysfs, modeset threads, or
backlights corrupt the command queue or DSI state by concurrently calling
mtk_dsi_host_send_cmd()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135703.4654=
0-1-angelogioacchino.delregno@collabora.com?part=3D8
