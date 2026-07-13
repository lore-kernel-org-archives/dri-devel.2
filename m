Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E741DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02F10E8CD;
	Mon, 13 Jul 2026 10:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VoLD8bc7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0933610E8CD
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:13:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E682043B90;
 Mon, 13 Jul 2026 10:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D12C1F00A3D;
 Mon, 13 Jul 2026 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937622;
 bh=H7vQ7bWq9uCbycXa4tVFVOTqwgXO8ifRlZEJt7lWlb0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VoLD8bc72E+UAuQ7u2oqxyFtPzYQLgI2ck/3jEN35bWXZdeEpc4rH7oq/9SOs+kzU
 MfqGZrrK/LaPcftCNOem54TpKR5cL4HVTmq30ww1RJWZRZhjJgGYy9KpMUcHp/EJq4
 G1EsRVECI2CjcFFQ8NskEdUoEFdS01e2q4oOvB4Jo6sos5h2FXfLA4OD2sba/EnAZE
 +Kb8usRc0UAW4NS+CEW6d+Bwd1GkibNcb/+SV5cTGjo1GcatIbNTC4xDseB7Rr7tdq
 IM691RfvsYuSMf0Rw0HmTcIunRVJiqlLkzhuhFUWihKWo1yCscb3nYVzk8Fc7m9qsH
 Ug/GtQ7VkWHWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713095837.16590-8-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:13:42 +0000
Message-Id: <20260713101342.7D12C1F00A3D@smtp.kernel.org>
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
- [High] Integer overflow and time-domain unit mismatch (bps vs Mbps) in Qo=
S HW buffer calculations corrupts DSI thresholds.
- [High] Space domain unit mismatch (Bytes vs Buffer Units) in QoS threshol=
d calculations bypasses physical FIFO limits.
--

--- Patch [7]: [PATCH v2 07/10] drm/mediatek: mtk_dsi: Add support for MT81=
96 ---
commit b12ec6677a476992917258eedb82bde7663b944c
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dsi: Add support for MT8196

Add support for the new DSI IP found in the Kompanio Ultra MT8196 SoC.
This introduces the initialization of QoS parameters and can make use
of a DSI SRAM reserved buffer.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 2df2a9d5ec038..5af44c13bd5ac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -753,6 +849,89 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *ds=
i)
> +static void mtk_dsi_config_hw_buffers(struct mtk_dsi *dsi)
> +{
[ ... ]
> +	data_rate_per_buf =3D dsi->data_rate * dsi->lanes / 8 / buffer_unit;

[Severity: High]
Will this calculation overflow 32-bit arithmetic for typical displays?
Since dsi->data_rate is in Hz, a bandwidth over 1 Gbps combined with 4 lanes
will exceed the u32 limit before the division.

Also, is it intentional that data_rate_per_buf is calculated in units per
second instead of units per microsecond? Later in mtk_dsi_config_hw_buffers=
(),
it is mixed with microsecond constants and fill_rate.

> +
> +	/* Calculate valid threshold and avoid exceeding FIFO size */
> +	out_valid_thresh =3D MTK_DSI_DEFAULT_QOS_VALID_FIFO_US * data_rate_per_=
buf;
> +	out_valid_thresh =3D min(out_valid_thresh, MTK_DSI_MAX_FIFO_BYTES - 1);

[Severity: High]
Does this min() correctly clamp the threshold? out_valid_thresh appears to =
be
calculated in buffer units, but it is being clamped against a limit specifi=
ed
in bytes (MTK_DSI_MAX_FIFO_BYTES - 1, which is 1553). For an MT8196 where a
buffer unit is 32 bytes, this would allow up to 1553 buffer units (49,696
bytes), bypassing the intended physical FIFO limits.

[ ... ]
> +	pclk_mhz =3D dsi->vm.pixelclock / HZ_PER_MHZ;
> +	fill_rate =3D pclk_mhz * data->pixels_per_iter * dsi_buf_bpp / buffer_u=
nit;
> +
> +	/* Calculate QoS Anti-Latency parameters */
> +	sodi_hi =3D MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;

[Severity: High]
Is this mixing bytes and buffer units? MTK_DSI_MAX_FIFO_BYTES is in bytes,
but it seems to be multiplied by the number of hardware buffers here instead
of a byte-based metric.

> +	sodi_hi -=3D (fill_rate - data_rate_per_buf) * 12 / 10;

[Severity: High]
Could this subtraction cause an integer underflow? fill_rate is calculated
using pclk_mhz so it is a per-microsecond rate, while data_rate_per_buf is
a per-second rate. Subtracting a large per-second rate from a small
per-microsecond rate will wrap around.

> +	sodi_lo =3D (23 + 5) * data_rate_per_buf;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D7
