Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD801C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24ED10FB32;
	Tue, 15 Sep 2026 08:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8bN45Sr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13D010FB32
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:57:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EECAE602CB;
 Tue, 15 Sep 2026 08:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0451F00893;
 Tue, 15 Sep 2026 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789462626;
 bh=b/1BTnO4t78KaoVq7MSnPrHktwmGY2LxhAV4pppAx5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n8bN45SrcnCz5dn8GgMBRs0IEABUj/QBx+qZIjc8RYCD9VQJAQuMhPenIw964cj1T
 oYQ72D/iLYplaXc5HCE2N8BrQhpBaj477FSQJzcQdVUsf9YZTRXevTQdWfP2enEq5T
 FISkmJGg4J7nzrC7rYkgud55/IDRccns5+9wdFv6C9AP/nFeF/M9vEwueX3HNEMF4d
 7L/Tn0X5jCpw/z7bw0Zo5G8xgdOtaWoQCbHgo1Sm1OG9ElUWeU5rt418Gqo9VWUV6D
 AXtT7qYGhwDaTGundWXFWP8eA/1N6mpQ8gGMEh7DKdf7waFt8UogWOlbfgfhfqaitm
 mtQJY/BEwFYvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/13] drm/mediatek: mtk_dsi: Add support for MT8196
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260915084148.11385-11-angelogioacchino.delregno@collabora.com>
References: <20260915084148.11385-1-angelogioacchino.delregno@collabora.com>
 <20260915084148.11385-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:57:05 +0000
Message-Id: <20260915085706.4C0451F00893@smtp.kernel.org>
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
- [Medium] drm/mediatek: Incomplete initialization of DSI QoS parameters (m=
issing PREURGENT)
--

commit 2eeb791791ca07e53d5c59d273b7795e846f2238
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Add support for MT8196
   =20
Add support for the new DSI IP found in the Kompanio Ultra MT8196
SoC and its Dimensity and Genio variants.

Differently from the older DSI IPs, the one from MT8196 requires
the initialization of all of the QoS parameters and can make use
of a DSI SRAM reserved buffer (present also on older SoCs but not
mandatory on those).

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 16bf08bee38e3..6f176515e2587 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -373,6 +373,59 @@ static const u16 mtk_dsi_regs_mt8186[DSI_ADV_REG_MAX=
] =3D {
>  	[DSI_CMDQ] =3D 0xd00,
>  };
> =20
> +static const u16 mtk_dsi_regs_main_v2[DSI_MAIN_REG_MAX] =3D {
[ ... ]
> +static const u16 mtk_dsi_regs_qos_v2[DSI_QOS_REG_MAX] =3D {
> +	[DSI_QOS_BUF_CON0] =3D 0x300,
> +	[DSI_QOS_BUF_CON1] =3D 0x304,
> +	[DSI_QOS_TX_BUF_RW_TIMES] =3D 0x310,
> +	[DSI_QOS_SODI_HIGH] =3D 0x314,
> +	[DSI_QOS_SODI_LOW] =3D 0x318,
> +	[DSI_QOS_PREULTRA_HIGH] =3D 0x324,
> +	[DSI_QOS_PREULTRA_LOW] =3D 0x328,
> +	[DSI_QOS_ULTRA_HIGH] =3D 0x32c,
> +	[DSI_QOS_ULTRA_LOW] =3D 0x330,
> +	[DSI_QOS_URGENT_HIGH] =3D 0x334,
> +	[DSI_QOS_URGENT_LOW] =3D 0x338,
> +	[DSI_QOS_PREURGENT_HIGH] =3D 0x33c
> +};

[Severity: Medium]
Is the DSI_QOS_PREURGENT_LOW mapping missing from this array?

The array maps DSI_QOS_PREURGENT_HIGH but completely omits a mapping or enum
definition for DSI_QOS_PREURGENT_LOW.=20

Additionally, the commit message explicitly states that the MT8196 IP requi=
res
the initialization of all of the QoS parameters, but it appears PREURGENT
is skipped entirely.=20

When the DSI driver probes on SoCs using the new HW buffers and calls
mtk_dsi_config_hw_buffers(), it programs all other QoS thresholds (SODI,
PREULTRA, ULTRA, URGENT) but omits PREURGENT:

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_config_hw_buffers() {
    ...
	/* Write all QoS parameters: Screen On Deep Idle, (pre)Ultra, Urgent, RW t=
imes */
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_SODI_HIGH], BUF_THRESHOLD_PARAM, sodi_hi=
);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_SODI_LOW], BUF_THRESHOLD_PARAM, sodi_lo);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_PREULTRA_HIGH], BUF_THRESHOLD_PARAM, pre=
ultra_hi);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_PREULTRA_LOW], BUF_THRESHOLD_PARAM, preu=
ltra_lo);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_ULTRA_HIGH], BUF_THRESHOLD_PARAM, ultra_=
hi);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_ULTRA_LOW], BUF_THRESHOLD_PARAM, ultra_l=
o);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_URGENT_HIGH], BUF_THRESHOLD_PARAM, urgen=
t_hi);
	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_URGENT_LOW], BUF_THRESHOLD_PARAM, urgent=
_lo);
	writel(rw_times, dsi->regs + reg_qos[DSI_QOS_TX_BUF_RW_TIMES]);
    ...
}

Could omitting this parameter lead to suboptimal DSI FIFO scheduling, displ=
ay
artifacts, or underflows, since the hardware configuration is left incomple=
te?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915084148.1138=
5-1-angelogioacchino.delregno@collabora.com?part=3D10
