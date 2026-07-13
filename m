Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5435DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6D410E9AA;
	Mon, 13 Jul 2026 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V4P7dMN4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FC510E9A5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:13:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB1D740186;
 Mon, 13 Jul 2026 13:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CAC1F00A3A;
 Mon, 13 Jul 2026 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948404;
 bh=xKuLx5hdwNwogybYGDWzfQB8Wq9jPzMMcdqfYTlkphs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V4P7dMN4+SnP/AYl7Wg0RQ2q9//dRnVig+vkWMMrjOqi9dJRBPuIkEsOXxlelIBlw
 kanUyjRZMzXvy56O0y+/GoZld+SD5y1/CaSfHovlhJ99uMbOL8PLmxFZap9cK7Pq0+
 KdTcye0N9rCg9m435CwYSzXBT7BHCUjXjMhJeEnRMVlcXcNEODYBDMkK0k4rGPxF+z
 7ydoWT+sw4+OD53Ol4ugXXoFekFOtAwOl+b5g9jRPRfGEIugPgNlTQFDAF5xNVvhJ+
 /+kVD1KbGE2zut37wP4kUuagMYdFdUu2M4eDJCtuynLucC7huTxn4DAgNgntClI9Sb
 HVwDtXEE0AOWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260713130103.34654-5-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:13:24 +0000
Message-Id: <20260713131324.79CAC1F00A3A@smtp.kernel.org>
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
- [High] Enabling the DSI IRQ before hardware clocks are enabled, or leavin=
g it enabled while clocks are disabled, risks bus hangs from spurious or pe=
nding interrupts.
- [High] Unprotected read-modify-write operations on `dsi->irq_data` can le=
ad to lost interrupts and spurious timeouts.
- [High] Signal interruptions during DSI transfers are incorrectly treated =
as successful completions, potentially leaking stale hardware register data.
--

--- Patch [4]: [PATCH v3 04/10] drm/mediatek: mtk_dsi: Enable interrupt at =
component bind time ---
commit 9bfbf9137c89977bfb322670b9598bed791b5832
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This patch changes the DSI interrupt initialization by requesting it with
IRQF_NO_AUTOEN during probe. The interrupt is then explicitly enabled
during component bind and disabled during unbind. This prevents spurious
interrupts and storms before the hardware engine is fully initialized.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index ec5b94f7fa68e..bdb9ea2e7b6f6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -1088,7 +1089,13 @@ static int mtk_dsi_bind(struct device *dev, struct=
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

[Severity: High]
This is a pre-existing issue, but does enabling the IRQ here risk a bus
hang if an interrupt fires before the hardware clocks are fully enabled?

Looking at mtk_dsi_bind(), the IRQ is unmasked here, but the engine_clk
and digital_clk are not enabled until mtk_dsi_poweron() is called later.
If a spurious or pending interrupt fires during this window, the handler:

mtk_dsi_irq()
    status =3D readl(dsi->regs + DSI_INTSTA) & flag;

will access clock-gated registers, which can cause an unrecoverable system
error or bus stall on MediaTek SoCs. A similar window seems to exist in
mtk_dsi_poweroff() where clocks are disabled without masking the IRQ.

> +
> +	return 0;
>  }

[ ... ]

> @@ -1372,17 +1380,15 @@ static int mtk_dsi_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, dsi);
> =20
> +	ret =3D devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);

[Severity: High]
This isn't a bug introduced by this patch, but are there data races in how
the interrupt handler updates the status flags?

The irq_data field is modified concurrently by process context and hardirq
context without locking:

Process context:
mtk_dsi_irq_data_clear()
    dsi->irq_data &=3D ~irq_bit;

Hardirq context:
mtk_dsi_irq_data_set()
    dsi->irq_data |=3D irq_bit;

If mtk_dsi_irq() fires between the non-atomic load and store in process
context, the flag set by the interrupt handler would be overwritten and los=
t,
potentially causing spurious timeouts.

[Severity: High]
This is a pre-existing issue, but does the wait condition correctly handle
signals?

When waiting for the interrupt:

mtk_dsi_host_send_cmd()
    if (!mtk_dsi_wait_for_irq_done(dsi, flag, 2000))
        return -ETIME;
    else
        return 0;

If wait_event_interruptible_timeout() in mtk_dsi_wait_for_irq_done() is
interrupted by a signal, it returns -ERESTARTSYS. Since !negative evaluates
to false (0), the error check is bypassed and it returns 0 (success). This
could cause the driver to read uninitialized RX data from DSI registers and
corrupt the communication state machine.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D4
