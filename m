Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25982C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AAF890B2;
	Wed, 15 Jul 2026 12:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OB924rr0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3AD3890B2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31FCD600BB;
 Wed, 15 Jul 2026 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AEC1F000E9;
 Wed, 15 Jul 2026 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784117076;
 bh=39LpnGfPl1PsxPWe/OMibZQgc6ev37/IXN6dWhZZh5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OB924rr0oiWQLISPjO07OElv347yfs2zJEdPEk/apCc4lnhDEfId09Gy2sSyd4cZC
 oSWOrZEhre9KgFcMZ2iXX2OCP2A/42SSOtWBRnEd97+mBN4qT8jZBe0OuES0stUtW3
 lOGj+LFBwr7jK0IZUog4mqc4Nqkjx/7gvA7UrGwK6otC95qKnSWDKK4E0v5Iv0d28G
 AVkD5TO41EzyC+WbtdOyZqqNtEUbL0MgjaUZjYI8f8hSpqfcot2XA20CCowuUTO06U
 HxRcpi4FLbVQaOM+nWIgNTrXXK5P7Z9CjJ7vlCBT3yz6RYi7XEGTZMvs9HJA2ZNGRl
 vtaNlTHYTYPwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715114916.19690-6-angelogioacchino.delregno@collabora.com>
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:04:36 +0000
Message-Id: <20260715120436.A9AEC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unsafe IRQ enablement before clocks are enabled leads to hard lock=
up or interrupt storm.
- [High] Data race on `dsi->irq_data` can lead to lost wakeups and hardware=
 reset.
- [Medium] Unconditional return of IRQ_HANDLED defeats spurious interrupt d=
etection.
--

--- Patch [5]: [PATCH v5 05/11] drm/mediatek: mtk_dsi: Enable interrupt at =
component bind time ---
commit dc54549e6b7ff6ba83355eb88d72dfbf4c41558d
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This patch moves the DSI interrupt enablement to the component bind time and
disables it on unbind, rather than doing so during probe/remove. It uses
IRQF_NO_AUTOEN to prevent the interrupt from firing before the component
is ready.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index e3d7338c35e39..d1aa258e3799c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -225,6 +225,7 @@ struct mtk_dsi {
>  	int refcount;
>  	bool enabled;
>  	bool lanes_ready;
> +	int irq;
>  	u32 irq_data;
>  	wait_queue_head_t irq_wait_queue;
>  	const struct mtk_dsi_driver_data *driver_data;

[ ... ]

> @@ -1096,6 +1097,8 @@ static int mtk_dsi_bind(struct device *dev, struct =
device *master, void *data)
>  		return ret;
>  	}
> =20
> +	enable_irq(dsi->irq);

[Severity: High]
This isn't a bug introduced by this patch, but can enabling the interrupt
here cause a hard lockup or interrupt storm?

The DSI engine_clk and digital_clk are not enabled until mtk_dsi_poweron() =
is
called later. If an interrupt fires while clocks are disabled, the handler
mtk_dsi_irq() will read unclocked registers.

If unclocked reads return 0xffffffff, status is non-zero and the loop:

mtk_dsi_irq() {
    ...
    do {
        mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
        tmp =3D readl(dsi->regs + DSI_INTSTA);
    } while (tmp & DSI_BUSY);
    ...
}

executes infinitely (since DSI_BUSY is BIT(31)), causing a hard lockup in
hardirq context.

> +
>  	return 0;
>  }

[ ... ]

> @@ -1381,17 +1385,15 @@ static int mtk_dsi_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, dsi);
> =20
> +	ret =3D devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race on
dsi->irq_data?

mtk_dsi_irq_data_set() runs in hardirq context and sets bits in dsi->irq_da=
ta:
    dsi->irq_data |=3D irq_bit;

Concurrently, mtk_dsi_irq_data_clear() runs in process context and performs:
    dsi->irq_data &=3D ~irq_bit;

If an interrupt fires exactly after the load but before the store in
mtk_dsi_irq_data_clear(), could new flags set by the interrupt handler be
overwritten and permanently lost when the process context writes back its
stale value?


[Severity: Medium]
This is a pre-existing issue, but does mtk_dsi_irq() unconditionally return
IRQ_HANDLED even when no interrupt flags are detected?

If status is 0, the handler does nothing to clear the hardware state but
still returns IRQ_HANDLED. Will this defeat the kernel's spurious interrupt
detector and cause an interrupt storm if a spurious interrupt triggers or if
the hardware asserts an unmasked interrupt flag not handled by the driver?

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715114916.1969=
0-1-angelogioacchino.delregno@collabora.com?part=3D5
