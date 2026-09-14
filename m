Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF99C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1225610E19B;
	Mon, 14 Sep 2026 12:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kqL6Z2Wo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B4410E19B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BC62601DB;
 Mon, 14 Sep 2026 12:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA61C1F00898;
 Mon, 14 Sep 2026 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789388439;
 bh=Fma9rGpR3kYSf6wqhkSVql+tZr4Z1DqBDtJJrSnRMHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kqL6Z2WoW+fwSIZ3MQh48r0gXKPIO/NRvfPleSh2gRLebWojoD49abUbRCH/5JMRB
 A1EBLFn7nMsOAHMWEVjeFaet4Hxj8BhTuJqzaCTl2nHuJeg00aJ3/hs9dTOfQaJI8a
 EeS9y9Wi45+akCkTEKD4ULqgTJISg3sqzdMmzwsY1PpqhxBSUALRKyqQmjKwHAsr95
 YCk0FJY/7QIKqvBuIsygP5JZfCzVbiT/aXMC94ZCOs/59dbMb9tuactA3XlYERzgvz
 DJ7Uq9PldvmVvjlLq68AlL5tGpjKoWM5oC91lMhcn6FT7uMh0m1galANMPBU5csrLT
 FbLg2QlCTYI+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/13] drm/mediatek: mtk_dsi: Add support for MT8189
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260914115812.22751-9-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:20:38 +0000
Message-Id: <20260914122038.AA61C1F00898@smtp.kernel.org>
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

Pre-existing issues:
- [High] Out-of-bounds MMIO write in mtk_dsi_cmdq() due to unchecked msg->t=
x_len.
- [High] Register access with disabled clocks after mtk_dsi_poweron() fails=
 causes kernel panic.
--

commit f15ebc6147af7232db3b125277a76b1726ee2a6a
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8189

This commit adds support for the DSI IP found in the MT8189 SoC. It updates
the device tree match table to map the new compatible string to the DSI
driver.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index bd2d17017bd2f..08f6be311dd14 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
[ ... ]
> @@ -826,6 +826,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>  	{ .compatible =3D "mediatek,mt8188-dsi",
>  	  .data =3D (void *)MTK_DSI },
> +	{ .compatible =3D "mediatek,mt8189-dsi",
> +	  .data =3D (void *)MTK_DSI },

[Severity: High]
This isn't a bug introduced by this patch, but adding a new DSI user exposes
a pre-existing issue in mtk_dsi_cmdq().

Does this code overflow the MMIO boundaries if msg->tx_len is large?

In drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_cmdq():

	for (i =3D 0; i < msg->tx_len; i++)
		mtk_dsi_mask(dsi, (data->reg_adv[DSI_CMDQ] + cmdq_off + i) & (~0x3U),
			     (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
			     tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));

Because msg->tx_len isn't validated against the hardware command queue size,
a large payload could write past the queue's boundary and corrupt adjacent
hardware registers.


[Severity: High]
This is a pre-existing issue, but registering a new DSI device also inherits
this error handling regression.

Can this sequence cause a panic if mtk_dsi_poweron() fails?

In drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_bridge_atomic_pre_enable():

	ret =3D mtk_dsi_poweron(dsi);
	if (ret < 0)
		drm_err(drm, "failed to power on dsi\n");

	mtk_dsi_lane_ready(dsi);
	mtk_dsi_clk_hs_mode(dsi, 1);

If power-on fails, the error path within mtk_dsi_poweron() disables the
clocks.

However, this function ignores the failure, logs an error, and
unconditionally proceeds to call mtk_dsi_lane_ready(dsi) and
mtk_dsi_clk_hs_mode(dsi, 1).

These subsequent calls write to hardware registers while the device clocks
are gated, which typically triggers a synchronous external abort.

>  	{ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D8
