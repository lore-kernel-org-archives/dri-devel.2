Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88932C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B3010F0ED;
	Wed, 15 Jul 2026 14:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGv4iySm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9128510F03F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:29:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 527E44091B;
 Wed, 15 Jul 2026 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC281F000E9;
 Wed, 15 Jul 2026 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784125780;
 bh=im1k+IfTUTLk3amJC9dHFxUNEwpUogrUfZBR4wgapVo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mGv4iySmB8Qgcxphg9g6l8W8V7oZugFuufB/viYqV9llWLLCAEXopxzn/xjvaD5O8
 SYhbfy+K9gVsTc66/ANI+1TtpPxi0LA+WHQjqBiTVhmdp6Lt93PNdeUoDskZCwD+aA
 9h3XiP7liSV3CG88kRgdJtKoDzUUsrjA70Hdjp0Gv1+MAVHoOb9qeHRctvhIqcoL8U
 Uwi8TWxawTcqe/Gy6ue/6gXvg1x0tm4HGy2XovOgX4R18z4P+iPhqyAkwnu52jViai
 ZhodIvrtn+xI5AFVGc1KBHa3FIQWl+41qdche/Vk0RJwf0j9tney5FCFlYVsg+KJI7
 N/Irh9w1AP0Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260715135703.46540-6-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:29:39 +0000
Message-Id: <20260715142939.DCC281F000E9@smtp.kernel.org>
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
- [High] Data race on `dsi->irq_data` between process context and hardirq c=
ontext can cause false positive interrupt completions.
- [High] Unbounded hardware polling loop in hardirq handler can lock up the=
 CPU.
--

--- Patch [5]: [PATCH v6 05/11] drm/mediatek: mtk_dsi: Enable interrupt at =
component bind time ---
commit 869a346c570d4022e4d54a10b57fcff068a735b6
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

Having the DSI interrupt enabled before actually binding the DSI
component to the display controller driver is both useless and dangerous.
This commit fixes this by requesting the interrupt with IRQF_NO_AUTOEN,
and enabling it only when binding DSI to its display controller component.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index e4a156a474e08..070d7d555bdbe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -225,6 +225,7 @@ struct mtk_dsi {
>  	int refcount;
>  	bool enabled;
>  	bool lanes_ready;
> +	int irq;
>  	u32 irq_data;

[Severity: High]
This isn't a bug introduced by this patch, but can the data race on
dsi->irq_data between process context and hardirq context cause false posit=
ive
interrupt completions?

The dsi->irq_data variable is modified locklessly using read-modify-write
operations:

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq_data_clear() {
    ...
    dsi->irq_data &=3D ~irq_bit;
    ...
}

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq_data_set() {
    ...
    dsi->irq_data |=3D irq_bit;
    ...
}

If a delayed interrupt sets a flag while a process on another CPU is cleari=
ng
a different flag for a new command, the process's clear operation can be lo=
st
if the interrupt handler overwrites it.

The previously cleared flag remains set, causing mtk_dsi_wait_for_irq_done()
to falsely return success.

>  	wait_queue_head_t irq_wait_queue;
>  	const struct mtk_dsi_driver_data *driver_data;
>  };

[ ... ]

> @@ -1381,17 +1385,15 @@ static int mtk_dsi_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, dsi);
> =20
> +	ret =3D devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);

[Severity: High]
This isn't a bug introduced by this patch, but could the unbounded hardware
polling loop in the mtk_dsi_irq() hardirq handler lock up the CPU?

The mtk_dsi_irq() function runs in hardirq context and uses an unbounded lo=
op
to wait for the hardware:

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq() {
    ...
    do {
        mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
        tmp =3D readl(dsi->regs + DSI_INTSTA);
    } while (tmp & DSI_BUSY);
    ...
}

If the DSI hardware hangs, loses its clock, or DSI_BUSY never clears for any
other reason, the loop never terminates, which will permanently hang the CP=
U.

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135703.4654=
0-1-angelogioacchino.delregno@collabora.com?part=3D5
