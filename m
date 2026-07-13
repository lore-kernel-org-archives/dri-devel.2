Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AF2C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE1410E8C9;
	Mon, 13 Jul 2026 10:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F10EcXTg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F84B10E8C9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:11:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 655A140B32;
 Mon, 13 Jul 2026 10:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131A1F00A3A;
 Mon, 13 Jul 2026 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937511;
 bh=z0cA5q51bXw9VlmvO3E3YfQZz9L7jLWesCBtAsfOthM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F10EcXTgFQZUSUGcK6gmGIhKFzxbhrFJeeh7NxStMlnu/z/+ZCi0MOeWbi7OUuNCb
 GDMNW/lzljoSXKjelkUNmuZWib+IKruHKYbfsTdhLh9882B2cYJaupgk2k2SDjzyud
 KuvpfnfCYMFdp0GpJDHS2R+MN7nUzlFF4IpxIfS2T0S5McXUoV7qf3lxf3pW1rAF2s
 +zvxugIOG6T7bBM3qYNWKvDhmVH0sgWK1uXE8oEMJXCQmAKvYipgShzLShVM7GZmFE
 x+9H9cTUCbS+t2uZUmvX28TistVgMav/yDEJS01rzh+eBUhfPG547++1XlROOCnD0I
 aHIUcRKuH3xvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260713095837.16590-5-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:11:50 +0000
Message-Id: <20260713101150.B131A1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `enable_irq()` in `mtk_dsi_bind()` executes before the IRQ=
 is requested, leaving the interrupt permanently disabled.

Pre-existing issues:
- [High] Data race on `dsi->irq_data` between process and hardirq context l=
eads to dropped interrupts.
- [High] `mtk_dsi_host_send_cmd()` incorrectly interprets `-ERESTARTSYS` as=
 success, causing the driver to process stale hardware memory.
- [High] Unbounded busy-wait loop in `mtk_dsi_irq()` hard-locks the CPU if =
hardware stalls.
--

--- Patch [4]: [PATCH v2 04/10] drm/mediatek: mtk_dsi: Enable interrupt at =
component bind time ---
commit ab0ed7e073fb408fbb00443f437ebcc970005f69
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This patch changes the DSI interrupt to be requested with IRQF_NO_AUTOEN
and enables it later during the component bind phase. This aims to prevent
interrupt storms and artifacts caused by interrupts arriving before the
display controller is fully ready.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3e22553ca990f..284dae372c7c2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -1052,7 +1053,13 @@ static int mtk_dsi_bind(struct device *dev, struct=
 device *master, void *data)
>  	if (ret)
>  		return ret;
> =20
> -	return device_reset_optional(dev);
> +	ret =3D device_reset_optional(dev);
> +	if (ret)
> +		return ret;
> +
> +	enable_irq(dsi->irq);
> +
> +	return 0;
>  }
> =20
>  static void mtk_dsi_unbind(struct device *dev, struct device *master,
> @@ -1060,6 +1067,8 @@ static void mtk_dsi_unbind(struct device *dev, stru=
ct device *master,
>  {
>  	struct mtk_dsi *dsi =3D dev_get_drvdata(dev);
> =20
> +	disable_irq(dsi->irq);
> +
>  	drm_encoder_cleanup(&dsi->encoder);
>  }

[ ... ]

> @@ -1338,8 +1346,8 @@ static int mtk_dsi_probe(struct platform_device *pd=
ev)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to register DSI host\n");
> =20
> -	ret =3D devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
> -			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), dsi);
> +	ret =3D devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);

[Severity: High]
Does mipi_dsi_host_register() trigger component binding synchronously before
the IRQ is actually requested here?

If mtk_dsi_probe() invokes mipi_dsi_host_register() before devm_request_irq=
():
1. mipi_dsi_host_register() synchronously probes child panel devices
2. The child devices invoke component_add() for the DSI component
3. If the aggregate device is ready, this synchronously triggers mtk_dsi_bi=
nd()
4. mtk_dsi_bind() then calls enable_irq(dsi->irq)

Since devm_request_irq() hasn't run yet, will enable_irq() encounter an
unrequested IRQ descriptor and abort without unmasking the hardware? When
devm_request_irq() subsequently runs with IRQF_NO_AUTOEN, it seems the IRQ
might remain disabled forever, completely breaking display operation.

[Severity: High]
This is a pre-existing issue, but can this code drop interrupts due to a da=
ta
race on dsi->irq_data?

Process context uses a load-modify-store to clear flags:

mtk_dsi_irq_data_clear()
    dsi->irq_data &=3D ~irq_bit;

While hardirq context uses a non-atomic operation to set flags:

mtk_dsi_irq_data_set()
    dsi->irq_data |=3D irq_bit;

If an interrupt fires between the load and store in process context, the
interrupt handler will set its status flag, but the process context's store
will overwrite dsi->irq_data with its stale value, destroying the newly set
flag and potentially causing wait_event polling timeouts.

[Severity: High]
This is a pre-existing issue, but does mtk_dsi_host_send_cmd() incorrectly
interpret -ERESTARTSYS as success?

mtk_dsi_wait_for_irq_done() returns -ERESTARTSYS if interrupted by a signal:

mtk_dsi_wait_for_irq_done()
    ret =3D wait_event_interruptible_timeout(...);

However, mtk_dsi_host_send_cmd() evaluates the return value as a boolean:

mtk_dsi_host_send_cmd()
    if (!mtk_dsi_wait_for_irq_done(dsi, flag, 2000))
        return -ETIME;
    else
        return 0;

Since -ERESTARTSYS is non-zero, its negation evaluates to false, causing
execution to bypass the error path and return 0. The caller then assumes the
hardware operation completed successfully and might proceed to read stale
memory from the hardware RX registers.

[Severity: High]
This is a pre-existing issue, but can the busy-wait loop in mtk_dsi_irq()
cause a hard lockup?

The mtk_dsi_irq() interrupt handler runs in hardirq context and contains
a polling loop without a timeout:

mtk_dsi_irq()
    do {
        mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
        tmp =3D readl(dsi->regs + DSI_INTSTA);
    } while (tmp & DSI_BUSY);

If the DSI hardware encounters an error, loses its clock, or gets stuck in a
busy state, the DSI_BUSY bit will never clear and the CPU will spin
indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D4
