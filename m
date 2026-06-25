Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7478CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1579210F221;
	Thu, 25 Jun 2026 10:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JMtrQzbI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8193510F20B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:10:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EA9A43DB5;
 Thu, 25 Jun 2026 10:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033F71F000E9;
 Thu, 25 Jun 2026 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382212;
 bh=4MRAHh21H8DfvwwLaBsyi3XjaNDgJsP578LKwktU75Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JMtrQzbIv6B26X6avW+jtyuBHPv1GOfqnNu3b5Y0nrl4QJOHsqyOHumdjSabZUiRK
 njDodaz8R/mm80XS7IXZ6ewu8b7ha7PbYk/DYgapUJXm/n41s+H4zEjWVNK8k/l3a7
 gm9geCE3H6C+04b3m/7/tXnbZYc8Ew3XqE+OpfPLeve5qALaoLZ8fw0UyQYg19jfwN
 AoHkOKQj40iKFrffhaZ4v8GzjUGHk5E6tgtbLvxYXRWfKgvSlytSNfJ6dcLgVyBjYw
 MoPRt7OX01K4E0jcp8Nr8DwtY1is+pv9u7PLnPUZhCuny+FmAYiDKChDI7iW9wSkU9
 ZqGWrjkj2r3cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] drm/verisilicon: add DC8000 (DCUltraLite)
 display controller support
To: "Joey Lu" <a0987203069@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260625094449.708386-6-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-6-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:10:11 +0000
Message-Id: <20260625101012.033F71F000E9@smtp.kernel.org>
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
- [High] The DC8000 panel enable, CRTC begin, and CRTC flush operations use=
 incorrect registers and bits, directly contradicting the commit message an=
d breaking hardware functionality.
- [Medium] The hw_irqs variable is passed to regmap_read() uninitialized an=
d used without checking for read failures.

Pre-existing issues:
- [High] The DC8200 primary plane disable function erroneously sets the ena=
ble bit instead of clearing it, keeping the plane active.
- [High] The IRQ handler unconditionally dereferences dc->drm_dev, but the =
interrupt is enabled before dc->drm_dev is allocated and remains active aft=
er it is freed.
--

commit a518460571afb18a0b4ff8e14af894a66907ebde
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DC8000 (DCUltraLite) display controller support

The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite display
controller (DC8000 generation) whose register layout differs from
the DC8200 in several important ways:

> 1. No CONFIG_EX commit path: framebuffer updates use the enable (bit 0)
>    and reset (bit 4) bits in FB_CONFIG instead of the DC8200 staging
>    registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT,
>    FB_BLEND_CONFIG, PANEL_CONFIG_EX).
>
> 2. No PANEL_START register: panel output starts when
>    PANEL_CONFIG.RUNNING is set; there is no multi-display sync start
>    register.

[Severity: High]
Do the functions implemented in this patch use the correct registers and bi=
ts
as described in the commit message?

In vs_dc8000_panel_enable_ex(), the code sets a reset bit
(VSDC_FB_CONFIG_RESET) in VSDC_FB_CONFIG instead of writing to PANEL_CONFIG.

Additionally, vs_dc8000_crtc_begin() and vs_dc8000_crtc_flush() use an
unmentioned VALID bit (VSDC_FB_CONFIG_VALID), and clear it after updates
complete, which seems to invert normal latch semantics.

Could this mismatch prevent the display panel from enabling properly?

> 3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA (0x147C) /
>    DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
>    TOP_IRQ_EN (0x0014).
>
> 4. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
>    divider) clocks; no axi or ahb clocks required.
>
> Signed-off-by: Joey Lu <a0987203069@gmail.com>

> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/veris=
ilicon/Makefile
> index 9d4cd16452fa1..d2fd8e4dff242 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> =20
> -verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_dr=
m.o vs_hwdb.o \
> +verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_dc=
8000.o vs_drm.o vs_hwdb.o \

[Severity: High]
This is a pre-existing issue, but while reviewing the driver files included
here, I noticed a potential problem in
vs_dc8200.c:vs_dc8200_primary_plane_disable_ex().

The function appears to call regmap_set_bits() on VSDC_FB_CONFIG_EX_FB_EN
instead of regmap_clear_bits():

vs_dc8200.c:vs_dc8200_primary_plane_disable_ex() {
        ...
        regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
                        VSDC_FB_CONFIG_EX_FB_EN);
        ...
}

Does this erroneously keep the primary plane active when the DRM framework
expects it to be turned off, potentially breaking power management?

>  	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
> =20
>  obj-$(CONFIG_DRM_VERISILICON_DC) +=3D verisilicon-dc.o

[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> index fd1f5fe67a68b..9499fffbca58e 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -134,7 +134,10 @@ static int vs_dc_probe(struct platform_device *pdev)
>  	dev_info(dev, "Found DC%x rev %x customer %x\n", dc->identity.model,
>  		 dc->identity.revision, dc->identity.customer_id);
> =20
> -	dc->funcs =3D &vs_dc8200_funcs;
> +	if (dc->identity.generation =3D=3D VSDC_GEN_DC8200)
> +		dc->funcs =3D &vs_dc8200_funcs;
> +	else
> +		dc->funcs =3D &vs_dc8000_funcs;

[Severity: High]
This is a pre-existing issue, but I noticed a potential lifecycle regression
in vs_dc_probe() just below this block.

The function calls devm_request_irq() to register vs_dc_irq_handler() before
calling vs_drm_initialize(), which is responsible for allocating and assign=
ing
dc->drm_dev.

If an interrupt fires during this window, for example if the bootloader left
VSYNC interrupts enabled, the handler is invoked:

vs_drm.c:vs_drm_handle_irq() {
        ...
        if (dc->drm_dev->crtcs[i])
                drm_crtc_handle_vblank(&dc->drm_dev->crtcs[i]->base);
        ...
}

Will this unconditionally dereference dc->drm_dev and cause a NULL pointer
dereference before vs_drm_initialize() has completed?

> =20
>  	if (port_count > dc->identity.display_count) {
>  		dev_err(dev, "too many downstream ports than HW capability\n");

[ ... ]

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8000.c
> new file mode 100644
> index 0000000000000..fbe0fa516cac9
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
> @@ -0,0 +1,86 @@

[ ... ]

> +static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
> +{
> +	u32 hw_irqs, unified =3D 0;
> +	unsigned int i;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &hw_irqs);

[Severity: Medium]
Is it safe to use hw_irqs here if regmap_read() fails?

If regmap_read() returns an error code, hw_irqs will remain uninitialized
stack memory.

The function then proceeds to bitwise-AND this uninitialized value to
determine which VSYNC interrupts fired:

        for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
                if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
                        unified |=3D VSDC_IRQ_VSYNC(i);
        }

Could this result in spurious VSYNC events being dispatched to the DRM core=
 if
a read failure occurs?

> +
> +	for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
> +		if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
> +			unified |=3D VSDC_IRQ_VSYNC(i);
> +	}
> +
> +	return unified;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094449.7083=
86-1-a0987203069@gmail.com?part=3D5
