Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA08CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9ED10E2E3;
	Mon, 15 Jun 2026 09:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wp7iFXX3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6072010E2B7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:04:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8331D6008A;
 Mon, 15 Jun 2026 09:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34011F000E9;
 Mon, 15 Jun 2026 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781514297;
 bh=qLw2SCqcDFLa4nvdw6UC4l6oTRH8NFq2j+M0ojC1c1Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wp7iFXX360GrpOsrhERHy8KJf+bfsZ/6OWAVKW0OE6D4PKMD+iD0Gf/mLWFZFGJlQ
 8y+zmhKQ6vqxNUSYh9kYRwv4lyPcWyNLWEevwPPAYuxCClI+ItOmoun7dsspxEhK6o
 4r13IAZPtAZ/FwwB8zVb8jhrCgQdSWr7pKtXst5ROJw9n7vR8bTp0peDaNSV9QTi66
 ET5lK6PWH/ySM03dCJTRh8XtDQWzcu24GaWSvWvCXbvNPlfeQYnIp7YqrMz5cofplS
 sIp4co83LbwUCf9NB/fTKAircpB9fbYKFLgwwlymuSbCTOpTB7j2x07WQbQUohYdFB
 gIUT84723SFQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] drm/verisilicon: add DC8000 (DCUltraLite)
 display controller support
To: "Joey Lu" <a0987203069@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260615065003.76661-5-a0987203069@gmail.com>
References: <20260615065003.76661-5-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 09:04:56 +0000
Message-Id: <20260615090456.F34011F000E9@smtp.kernel.org>
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
- [High] Missing RUNNING bit configuration in panel_enable_ex prevents pane=
l output.
- [High] Framebuffer enable bit placed in CRTC callbacks prevents independe=
nt plane disablement, causing Use-After-Free.
- [High] Pixel clock is disabled before writing to CRTC registers during di=
sablement.
- [High] Uninitialized stack memory leak when reading IRQ status registers.
- [Medium] Positional clock-names array causes schema validation failure fo=
r abbreviated clock topologies.

Pre-existing issues:
- [High] DC8200 primary plane disable hook erroneously sets the enable bit.
- [High] IRQ handler registration races with drm_dev initialization, causin=
g NULL pointer dereference.
--

commit 7f62f89410b84fe09c3b006e2a2c8a7c5dedfeaa
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DC8000 (DCUltraLite) display controller support

This commit adds support for the Verisilicon DC8000 (DCUltraLite) display
controller found on the Nuvoton MA35D1 SoC. It handles differences in regis=
ter
layout, commit cycles, and clock topology by introducing a new vs_dc8000_fu=
ncs
structure.

> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> index 9729b693d360e..9499fffbca58e 100644
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

[Severity: High]
This is a pre-existing issue, but does vs_dc8200_primary_plane_disable_ex()
fail to disable the hardware plane?=20

It uses regmap_set_bits() for VSDC_FB_CONFIG_EX_FB_EN instead of clearing i=
t:

vs_dc8200.c:vs_dc8200_primary_plane_disable_ex() {
    regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
                    VSDC_FB_CONFIG_EX_FB_EN);
    ...
}

Will the display controller continue accessing the freed memory when DRM fr=
ees
the framebuffer after the atomic commit, leading to a use-after-free?

[Severity: High]
This is also a pre-existing issue, but does vs_dc_probe() register the IRQ
handler before the DRM device is fully initialized?

If an interrupt fires immediately after devm_request_irq(), could
vs_drm_handle_irq() dereference dc->drm_dev->crtcs[i] and dc->drm_dev->base
before vs_drm_initialize() has allocated dc->drm_dev?

> +	else
> +		dc->funcs =3D &vs_dc8000_funcs;
> =20
>  	if (port_count > dc->identity.display_count) {
>  		dev_err(dev, "too many downstream ports than HW capability\n");
[ ... ]
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8000.c
> new file mode 100644
> index 0000000000000..be0c0d7baf52e
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[ ... ]
> +static void vs_dc8000_panel_enable_ex(struct vs_dc *dc, unsigned int out=
put)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_RESET);
> +}

[Severity: High]
Does this function miss configuring the RUNNING bit?=20

The commit message states that panel output starts when PANEL_CONFIG.RUNNING
is set, but this implementation only sets VSDC_FB_CONFIG_RESET. Will the
display controller fail to output pixels to the panel without setting
VSDC_DISP_PANEL_CONFIG_RUNNING?

[ ... ]
> +static void vs_dc8000_crtc_enable(struct vs_dc *dc, unsigned int output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			VSDC_FB_CONFIG_ENABLE);
> +}

[Severity: High]
Does placing the framebuffer enable bit in the CRTC enable callback prevent
independent plane disablement?

If the DRM core disables the primary plane while keeping the CRTC active,
vs_primary_plane_atomic_disable() will act as a no-op because the plane
disable hook is NULL in vs_dc8000_funcs. Will the hardware continue scanning
out from the freed framebuffer, resulting in a use-after-free and potential
IOMMU faults?

> +static void vs_dc8000_crtc_disable(struct vs_dc *dc, unsigned int output)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
> +			  VSDC_FB_CONFIG_ENABLE);
> +}

[Severity: High]
Will writing to the CRTC register during disablement cause a bus fault?

In vs_crtc_atomic_disable(), clk_disable_unprepare() is called on the
pixel clock before invoking the crtc_disable hook:

vs_crtc.c:vs_crtc_atomic_disable() {
    clk_disable_unprepare(dc->pix_clk[output]);

    if (dc->funcs->crtc_disable)
        dc->funcs->crtc_disable(dc, output);
    ...
}

Does this cause vs_dc8000_crtc_disable() to access hardware registers
after their corresponding clock is disabled?

[ ... ]
> +static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
> +{
> +	u32 irqs;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
> +	return irqs;
> +}

[Severity: High]
Can this leak uninitialized stack memory?

If regmap_read() fails, the irqs variable remains uninitialized. Will this
cause the function to return garbage data that is then passed to
vs_drm_handle_irq(), potentially causing an information leak when logged by
drm_warn_once or spurious execution of VBLANK handlers?

[ ... ]

[Severity: Medium]
Will the abbreviated clock topology cause device tree validation failures?

Since the commit makes the axi and ahb clocks optional, the device tree cou=
ld
use a simpler topology with just core and pix0. However, the DT binding sch=
ema
in verisilicon,dc.yaml uses a rigid positional items array for clock-names
(expecting axi at index 1). Would a node using clock-names =3D "core", "pix=
0"
fail validation because pix0 is evaluated against the const: axi requiremen=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615065003.7666=
1-1-a0987203069@gmail.com?part=3D4
