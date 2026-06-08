Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11045CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 02:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7EF10EC56;
	Mon,  8 Jun 2026 02:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QZbhP1sl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE50D10EC56
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:47:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CA3D402EA;
 Mon,  8 Jun 2026 02:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4411F00893;
 Mon,  8 Jun 2026 02:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780886854;
 bh=DCAATr5FXXQxeJftbn4eGjyBu73W45mmXw+uL1g6PQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QZbhP1sle3mve6ZPGsdNFyA75oHi803RKyuuq85/oaJQCJv3J7JTF3cDGKk1j2fYt
 nYSIsD4zw+hlhyO9GOCk6Cib0rHK8WRPFWl/BU7zKEtcpxZXq2yCwNT77m6AbbFnnZ
 i8mXqnUFAseWCp+fjJpC/ChcYKFrwmnTg41e90yHmm0WN4qHX8S0Pj+DBRyxCs3zSe
 zAhce/vMdYzX2u4orcE5w9/GfjVrZBvduQvEl2t5f/Fn4w23/FLMi2Db8i5qfQxXNI
 7LpgU1j5Q0jpKFt6l1UnTTWY1WrTDXazxsC6e8CGE49tqSZ/PW57KfXGB7wDn/YQqj
 tVRZRDbegmpoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/verisilicon: add Nuvoton MA35D1 DCU Lite
 display controller support
To: "Joey Lu" <a0987203069@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260608023237.305036-5-a0987203069@gmail.com>
References: <20260608023237.305036-5-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 02:47:33 +0000
Message-Id: <20260608024734.2C4411F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] The DCU Lite driver does not start the panel output because it fai=
ls to set the PANEL_CONFIG.RUNNING bit in the bridge enable path.
- [High] The DCU Lite driver does not implement a plane_disable_ex callback=
, breaking independent primary plane disable.
- [High] The pixel clock is disabled before the CRTC hardware is disabled, =
causing potential register access hangs.
- [High] The DCUltraLite IRQ handler fails to clear the interrupt status, l=
eading to an interrupt storm.
- [Medium] The `irqs` variable in `vs_dcu_lite_irq_handler` may be used uni=
nitialized if `regmap_read` fails.

Pre-existing issues:
- [High] The DC8200 plane disable function incorrectly sets the enable bit =
instead of clearing it.
- [High] The IRQ handler is registered before DRM initialization is complet=
e and remains active after teardown, risking a NULL pointer dereference.
--

commit c0e566390dbc25177931f48aa8bb45a4670fc241
Author: Joey Lu <a0987203069@gmail.com>
Subject: drm/verisilicon: add Nuvoton MA35D1 DCU Lite display controller su=
pport

This commit adds support for the Nuvoton MA35D1 DCUltraLite display
controller. It introduces vs_dcu_lite.c with a new vs_dc_funcs vtable and
adjusts the probe function to handle optional clocks.

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
[ ... ]
> @@ -134,7 +134,10 @@ static int vs_dc_probe(struct platform_device *pdev)
>  	dev_info(dev, "Found DC%x rev %x customer %x\n", dc->identity.model,
>  		 dc->identity.revision, dc->identity.customer_id);
> =20
> -	dc->funcs =3D &vs_dc8200_funcs;
> +	if (dc->identity.generation =3D=3D VSDC_GEN_DC8200)
> +		dc->funcs =3D &vs_dc8200_funcs;
> +	else
> +		dc->funcs =3D &vs_dcu_lite_funcs;
> =20
>  	if (port_count > dc->identity.display_count) {
>  		dev_err(dev, "too many downstream ports than HW capability\n");

[Severity: High]
This is a pre-existing issue, but I noticed a potential race during probe
and initialization later in vs_dc_probe().

vs_dc.c:vs_dc_probe() {
    ...
    ret =3D devm_request_irq(dev, irq, vs_dc_irq_handler, ...);
    ...
    ret =3D vs_drm_initialize(dc, pdev);
    ...
}

The IRQ handler is registered before vs_drm_initialize() completes. If an
interrupt fires early, vs_drm_handle_irq() will be invoked:

vs_drm.c:vs_drm_handle_irq() {
    ...
    if (dc->drm_dev->crtcs[i])
        drm_crtc_handle_vblank(&dc->drm_dev->crtcs[i]->base);
    ...
}

Could this cause a NULL pointer dereference since dc->drm_dev is not fully
set up until vs_drm_initialize() finishes?

> diff --git a/drivers/gpu/drm/verisilicon/vs_dcu_lite.c b/drivers/gpu/drm/=
verisilicon/vs_dcu_lite.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
> @@ -0,0 +1,78 @@
[ ... ]
> +static void vs_dcu_lite_bridge_enable(struct vs_dc *dc, unsigned int out=
put)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_RESET);
> +}

[Severity: High]
The commit message notes that panel output starts when PANEL_CONFIG.RUNNING
is set. However, vs_dcu_lite_bridge_enable() only sets VSDC_FB_CONFIG_RESET
and does not appear to write to VSDC_DISP_PANEL_CONFIG.

Will the display output pipeline start successfully without setting the
RUNNING bit?

[ ... ]
> +static u32 vs_dcu_lite_irq_handler(struct vs_dc *dc)
> +{
> +	u32 irqs;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
> +	return irqs;
> +}

[Severity: Medium]
If regmap_read() fails, the irqs variable remains uninitialized. Could this
result in returning a garbage value that gets processed as a bitmask of
triggered interrupts?

[Severity: High]
Also, vs_dcu_lite_irq_handler() reads the status register but does not seem
to perform a write operation to acknowledge or clear the pending interrupts.
Will this cause the IRQ line to remain asserted, potentially leading to an
interrupt storm?

> +const struct vs_dc_funcs vs_dcu_lite_funcs =3D {
> +	.bridge_enable		=3D vs_dcu_lite_bridge_enable,
> +	.bridge_disable		=3D vs_dcu_lite_bridge_disable,
> +	.crtc_begin		=3D vs_dcu_lite_crtc_begin,
> +	.crtc_flush		=3D vs_dcu_lite_crtc_flush,
> +	.crtc_enable		=3D vs_dcu_lite_crtc_enable,
> +	.crtc_disable		=3D vs_dcu_lite_crtc_disable,
> +	.enable_vblank		=3D vs_dcu_lite_enable_vblank,
> +	.disable_vblank		=3D vs_dcu_lite_disable_vblank,
> +	.irq_handler		=3D vs_dcu_lite_irq_handler,
> +};

[Severity: High]
Looking at vs_primary_plane_atomic_disable() in vs_primary_plane.c, it
relies on plane_disable_ex() to disable the plane. Since vs_dcu_lite_funcs
lacks a plane_disable_ex callback, will the hardware keep scanning out the
old framebuffer if user-space disables the primary plane while keeping the
CRTC active?

[Severity: High]
This isn't a bug introduced by this patch, but since we are discussing plane
disable operations, I noticed an issue with the DC8200 equivalent.

vs_dc8200.c:vs_dc8200_plane_disable_ex() {
    regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
                    VSDC_FB_CONFIG_EX_FB_EN);
}

This function calls regmap_set_bits() with VSDC_FB_CONFIG_EX_FB_EN. Does
this incorrectly set the enable bit to 1 instead of clearing it, preventing
the primary plane from being properly disabled?

[Severity: High]
This is a pre-existing issue, but looking at how crtc_disable is used in
vs_crtc.c:vs_crtc_atomic_disable():

vs_crtc.c:vs_crtc_atomic_disable() {
    clk_disable_unprepare(dc->pix_clk[output]);

    if (dc->funcs->crtc_disable)
        dc->funcs->crtc_disable(dc, output);
    ...
}

The pixel clock is disabled before the crtc_disable hardware callback
accesses the registers. Could this cause bus faults or leave the hardware in
an invalid state since the pipeline's primary pixel clock is already off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608023237.3050=
36-1-a0987203069@gmail.com?part=3D4
