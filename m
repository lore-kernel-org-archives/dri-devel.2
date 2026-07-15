Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE2C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9DF10E1B2;
	Wed, 15 Jul 2026 14:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cPlEjEXv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3072210E1B2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:25:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D459642B5B;
 Wed, 15 Jul 2026 14:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15CD1F000E9;
 Wed, 15 Jul 2026 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784125514;
 bh=Q6rpGCj2mXJOH0DUXBRPr+rXAxWYkPLRpQv5jQmdMP0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cPlEjEXveHt12oduvC0sQ5sSK0JoBlTeylHUh3enIpywLdm6n9aKhMJOew3+gz6fP
 xNF911oyQn6b8S9h7FLhmuhb+4VqUJ8UJI8Q7AFbyQNeF8JxuB89W90dToCOkBhUNk
 nfwzLSX6RbOFN6KSSup0LENtmgF6m30/ZqyOtZQnYfnDrPghsiVqLBpE2QXtqpNase
 xkM7sU/pyoZL1UklV3BC0Xpbh+I3kWJk3PBmcNSdU0EHf4TRPK+rtECPRDe9WFOzaz
 tlII3wAy0LC/zGu+bbS75WThyiUR8rYD0jNjWodU9UmuqSTvSJIDpntMW6aUJXFip0
 XHtm3niu1A55g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] drm/mediatek: mtk_dsi: Cleanup encoder if
 reset fails during bind
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260715135703.46540-5-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:25:13 +0000
Message-Id: <20260715142513.A15CD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unprotected read-modify-write of shared state `dsi->irq_data` acro=
ss process and hardirq contexts.
- [High] Incorrect handling of `wait_event_interruptible_timeout()` return =
value treats interrupted system calls as successful operations.
- [High] Infinite busy-wait loop in the hardware interrupt handler.
- [High] DSI Host is registered before the interrupt handler is requested, =
causing timeouts during panel probe.
--

--- Patch [4]: [PATCH v6 04/11] drm/mediatek: mtk_dsi: Cleanup encoder if r=
eset fails during bind ---
commit 4140e363279861f85198ff2dac937aba26d9610b
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: mtk_dsi: Cleanup encoder if reset fails during bind

This commit adds an error handling path during DSI component binding. It
ensures the encoder is properly cleaned up if the optional device reset
fails, avoiding a potential use-after-free on module removal.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3237dc765701d..e4a156a474e08 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1090,7 +1090,13 @@ static int mtk_dsi_bind(struct device *dev, struct=
 device *master, void *data)
>  	if (ret)
>  		return ret;
> =20
> -	return device_reset_optional(dev);
> +	ret =3D device_reset_optional(dev);
> +	if (ret) {
> +		drm_encoder_cleanup(&dsi->encoder);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
> =20
>  static void mtk_dsi_unbind(struct device *dev, struct device *master,

While reviewing this file, I noticed a few pre-existing regressions in other
parts of the code.

[Severity: High]
This isn't a bug introduced by this patch, but does this code risk losing
interrupts?

In drivers/gpu/drm/mediatek/mtk_dsi.c, mtk_dsi_irq_data_clear() modifies
shared state from process context:

static void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
{
        dsi->irq_data &=3D ~irq_bit;
}

Meanwhile, the hardirq handler calls mtk_dsi_irq_data_set():

static void mtk_dsi_irq_data_set(struct mtk_dsi *dsi, u32 irq_bit)
{
        dsi->irq_data |=3D irq_bit;
}

Because the process context modification is a non-atomic read-modify-write
without disabling interrupts, could an interrupt firing between the read
and write cause the bit set by the interrupt handler to be overwritten and
lost, leading to spurious timeouts?


[Severity: High]
This is a pre-existing issue, but does this negation correctly handle
signal interruptions?

In mtk_dsi_host_send_cmd(), the code checks the return value of
mtk_dsi_wait_for_irq_done():

        if (!mtk_dsi_wait_for_irq_done(dsi, flag, 2000))
                return -ETIME;
        else
                return 0;

A similar check exists in mtk_dsi_switch_to_cmd_mode():

        if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
                drm_err(drm, "failed to switch cmd mode\n");
                return -ETIME;
        } else {
                return 0;
        }

Since mtk_dsi_wait_for_irq_done() returns the result of
wait_event_interruptible_timeout(), it can return -ERESTARTSYS if
interrupted by a signal. Because -ERESTARTSYS is non-zero, this evaluates to
false, taking the else branch and returning 0 (success). Could this cause
the driver to falsely assume the hardware operation completed successfully
and read uninitialized or stale data?


[Severity: High]
This is a pre-existing issue, but is it safe to poll this register
indefinitely inside the hardirq handler?

In mtk_dsi_irq(), the driver enters a loop waiting for DSI_BUSY to clear:

                do {
                        mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
                        tmp =3D readl(dsi->regs + DSI_INTSTA);
                } while (tmp & DSI_BUSY);

Since this runs in hardirq context without a timeout or counter, if a
hardware malfunction keeps the DSI_BUSY bit asserted, could this cause the
CPU to spin indefinitely with interrupts disabled, causing a hard lockup?


[Severity: High]
This isn't a bug introduced by this patch, but is the DSI host registered
too early?

In mtk_dsi_probe(), mipi_dsi_host_register() is called before the interrupt
handler is requested:

        ret =3D mipi_dsi_host_register(&dsi->host);
        if (ret < 0)
                return dev_err_probe(dev, ret, "Failed to register DSI host=
\n");

        ret =3D devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
                               IRQF_TRIGGER_NONE, dev_name(&pdev->dev), dsi=
);

Registering the host immediately triggers enumeration and probing of child
panel drivers. If a panel driver sends a DCS command during its probe()
routine before devm_request_irq() completes, the hardware interrupt will be
missed. Could this cause the wait queue to time out and the panel probe to
spuriously fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135703.4654=
0-1-angelogioacchino.delregno@collabora.com?part=3D4
