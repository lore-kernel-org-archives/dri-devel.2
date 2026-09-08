Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8134DC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EDC10EAE2;
	Tue,  8 Sep 2026 10:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="esKUUaDC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E817110EAE2
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 10:04:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE9FA419C7;
 Tue,  8 Sep 2026 10:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E82C1F00A3A;
 Tue,  8 Sep 2026 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788861861;
 bh=y3VDoJY/ddJR02OQMQtg9KGif/6Y6mDm+so2rnX5Zds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=esKUUaDC07Qmu3eis1IvG+RKjneRZ2c/UmvmWrNh/BjImTJzNZKpXt2jYrwHgvlje
 WbGIxIh+icdyUymFcNahT55dhFWUiA15SoVO6ZnTueQh+ANrXe/m0Vy5IC4IRDRm+H
 Q2U3ewe49x+//sXCnkP4WveoGDzBfaZHihUk0mUsMnBrW4ifTbe8pKfL0RmDDmm6A2
 wNnpboanzaY69LQXwI//pkSDrOhzUqJdO+rpnPOed355KH40kZhq8jLf/cIwB8/65U
 ynPMbQmFJBoBXzc5UpfxaTuzYeFm9jE9ObvcnPgEX3uBc+ZPq2JwjNxMTesxrMHgAv
 oNI3JJL7+Ka+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] drm/verisilicon: add DC8000 (DCUltraLite)
 display controller support
To: "Joey Lu" <a0987203069@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260908092840.225220-5-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-5-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:04:20 +0000
Message-Id: <20260908100421.4E82C1F00A3A@smtp.kernel.org>
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
- [High] The `vs_dc8000_panel_enable_ex` and `vs_dc8000_panel_disable_ex` f=
unctions incorrectly modify the `VSDC_FB_CONFIG` register using the `VSDC_F=
B_CONFIG_RESET` bit, instead of setting the `PANEL_CONFIG.RUNNING` bit.
- [High] The `vs_dc8000_crtc_begin` and `vs_dc8000_crtc_flush` functions ha=
ve inverted logic for the `VSDC_FB_CONFIG_VALID` bit.
- [Medium] The `vs_dc8000_irq_ack` function reads `VSDC_DISP_IRQ_STA` but f=
ails to perform any hardware write to clear the pending hardware interrupts.

Pre-existing issues:
- [High] Early interrupt registration in `vs_dc_probe` causes a NULL pointe=
r dereference if an interrupt fires before DRM initialization is complete.
--

commit 71018d22eb0156b0806e61d4495897f9c4f2d35b
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DC8000 (DCUltraLite) display controller support

This commit adds support for the DC8000 (DCUltraLite) display controller
generation to the Verisilicon DRM driver. It introduces a new vs_dc_funcs
implementation that directly latches framebuffer updates through FB_CONFIG,
handles panel output, and acknowledges VSYNC interrupts.

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8000.c
> new file mode 100644
> index 0000000000000..df7bd5bdd7f2a
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
> @@ -0,0 +1,92 @@

[ ... ]

> +static void vs_dc8000_panel_enable_ex(struct vs_dc *dc, unsigned int out=
put)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_RESET);
> +}
> +
> +static void vs_dc8000_panel_disable_ex(struct vs_dc *dc, unsigned int ou=
tput)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			  VSDC_FB_CONFIG_RESET);
> +}

[Severity: High]
The commit message states that "panel output starts as soon as
PANEL_CONFIG.RUNNING is set", but vs_dc8000_panel_enable_ex() and
vs_dc8000_panel_disable_ex() modify VSDC_FB_CONFIG with the
VSDC_FB_CONFIG_RESET bit instead of setting the PANEL_CONFIG.RUNNING bit.
Will this cause the panel output to never start and inadvertently hold the
framebuffer in reset?

> +static void vs_dc8000_crtc_begin(struct vs_dc *dc, unsigned int output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_VALID);
> +}
> +
> +static void vs_dc8000_crtc_flush(struct vs_dc *dc, unsigned int output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			  VSDC_FB_CONFIG_VALID);
> +}

[Severity: High]
Does this invert the logic for the VSDC_FB_CONFIG_VALID bit? By asserting
validity in vs_dc8000_crtc_begin() before plane register updates occur, and
de-asserting it in vs_dc8000_crtc_flush() after the plane state is written,
could this prevent the hardware from latching the correct configuration and
lead to visual corruption?

[ ... ]

> +static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
> +{
> +	u32 hw_irqs, unified =3D 0, known =3D 0;
> +	unsigned int i;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &hw_irqs);

[Severity: Medium]
The commit message implies the VSYNC interrupt is acknowledged through
DISP_IRQ_STA/DISP_IRQ_EN, but vs_dc8000_irq_ack() only reads from
VSDC_DISP_IRQ_STA without performing any hardware write to clear the
pending interrupts. If the register does not auto-clear on read, could this
missing clear mechanism cause an interrupt storm and hang the system?

> +
> +	for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
> +		known |=3D VSDC_DISP_IRQ_VSYNC(i);
> +		if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
> +			unified |=3D VSDC_IRQ_VSYNC(i);
> +	}
> +
> +	drm_WARN_ONCE(&dc->drm_dev->base, hw_irqs & ~known,
> +		      "Unknown hardware IRQ bits: %#x\n", hw_irqs & ~known);

[Severity: High]
This is a pre-existing issue, but in vs_dc_probe() the interrupt line is
registered and unmasked via devm_request_irq() before vs_drm_initialize()
is called. If an interrupt fires early (e.g. left over from the bootloader),
vs_dc8000_irq_ack() will be called while dc->drm_dev is still NULL, causing
a NULL pointer dereference when accessing &dc->drm_dev->base here. Can the
interrupt registration be deferred until DRM initialization is complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092840.2252=
20-1-a0987203069@gmail.com?part=3D4
