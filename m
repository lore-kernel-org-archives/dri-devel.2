Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921C2CD8C90
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 02:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8017510EC55;
	Mon,  8 Jun 2026 02:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGN9Tbbz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCA610EC55
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:44:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4F20600AE;
 Mon,  8 Jun 2026 02:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B21F00893;
 Mon,  8 Jun 2026 02:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780886657;
 bh=7VvzNw4uxKFyd+LT1VhXzohYTCt/TTJI3Jzw0KzevNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGN9Tbbz8oIh1CALuO7SRpycmJZoJ0P8uJydXrdef6zgeD6OE0ZFI8HdTaMj8akbM
 v0zw3NPQJ7CL6L2mx38fxsCJy/SFn2mhtHX85wG51aNLtCN7ETnCDVSMaesPZPOcOO
 Use+BKuW7Nj9Lx/IKUK0O4jsYRRoPp6xWp3ANOv05RJqEAwhQmiP+apbcHnKbVEqEs
 dqZ1FOAEWnqGxMc0Ha2t7N2It+ktiao+VXwUNw44wgsI62pSHVeKrkLmEaSOTV/63k
 EGxwJv/fjfHullcqsc4e+VWC2ZBBBfzzho3laeBBEtS73abewHvInEtYGmlfdNDPCV
 KeVQrzRHKMcdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] drm/verisilicon: introduce per-variant hardware
 ops table
To: "Joey Lu" <a0987203069@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260608023237.305036-4-a0987203069@gmail.com>
References: <20260608023237.305036-4-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 02:44:16 +0000
Message-Id: <20260608024416.AC6B21F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The disable sequence in `vs_dc8200_bridge_disable` reverses the or=
der of clearing `VSDC_DISP_PANEL_START` and `VSDC_DISP_PANEL_CONFIG`.
- [High] Incorrect teardown sequence in CRTC disable path where pixel clock=
 is disabled before calling the CRTC hardware disable hook.

Pre-existing issues:
- [High] The plane disable function incorrectly sets the enable bit instead=
 of clearing it.
- [High] Calling `clk_prepare_enable()` and `clk_disable_unprepare()` in th=
e CRTC atomic enable/disable callbacks violates atomic context rules.
- [High] Potential NULL pointer dereference if IRQ fires before drm_dev is =
initialized.
--

commit 7843af23baf865801f80d2910ca556ff5e144ece
Author: Joey Lu <a0987203069@gmail.com>
Subject: drm/verisilicon: introduce per-variant hardware ops table

The DC8200 and DCUltraLite share a broadly similar register layout but
differ in how the bridge, CRTC, primary plane and IRQ paths are driven.
Introduce a vs_dc_funcs vtable so each variant can supply its own
implementation without scattering conditionals across multiple files.

> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/veri=
silicon/vs_crtc.c
> index 0b8a35d09cd2e..679d6541ba1b9 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
[ ... ]
> @@ -30,6 +53,9 @@ static void vs_crtc_atomic_disable(struct drm_crtc *crt=
c,
>  	drm_crtc_vblank_off(crtc);
> =20
>  	clk_disable_unprepare(dc->pix_clk[output]);

[Severity: High]
This is a pre-existing issue, but does calling clk_disable_unprepare() here
violate atomic context rules?

The DRM subsystem requires that CRTC atomic disable callbacks run in atomic
context where sleeping is forbidden, but clk_disable_unprepare() can sleep.

> +
> +	if (dc->funcs->crtc_disable)
> +		dc->funcs->crtc_disable(dc, output);
>  }

[Severity: High]
Could disabling the pixel clock before invoking the hardware-specific
crtc_disable callback cause bus hangs?

If the crtc_disable hook requires the pixel clock to be active to perform
register writes, turning it off first might result in dropped writes or
stalls. Should the clock be disabled after the hook is called, reversing
the setup sequence?

> =20
>  static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
> @@ -42,6 +68,9 @@ static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
>  	drm_WARN_ON(&dc->drm_dev->base,
>  		    clk_prepare_enable(dc->pix_clk[output]));

[Severity: High]
This is a pre-existing issue, but does this clk_prepare_enable() call also
violate atomic context rules?=20

Since atomic_enable runs in atomic context, calling sleeping functions can
cause kernel warnings or potential deadlocks during non-blocking commits.

> =20
> +	if (dc->funcs->crtc_enable)
> +		dc->funcs->crtc_enable(dc, output);
> +
>  	drm_crtc_vblank_on(crtc);
>  }
> =20
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> index dad9967bc10b8..c949570241890 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -33,7 +31,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void *pri=
vate)
>  	struct vs_dc *dc =3D private;
>  	u32 irqs;
> =20
> -	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> +	irqs =3D dc->funcs->irq_handler(dc);
> =20
>  	vs_drm_handle_irq(dc, irqs);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the IRQ to
fire before the DRM device is fully initialized?

If the bootloader leaves the display hardware active and generating VSYNC
interrupts, vs_dc_irq_handler() could execute and call vs_drm_handle_irq(),
which accesses dc->drm_dev. Since devm_request_irq() is called in
vs_dc_probe() before vs_drm_initialize() allocates dc->drm_dev, could
this lead to a NULL pointer dereference during early boot?

[ ... ]
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8200.c
> new file mode 100644
> index 0000000000000..db9e1b3cd9032
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
[ ... ]
> +static void vs_dc8200_bridge_disable(struct vs_dc *dc, unsigned int outp=
ut)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> +			  VSDC_DISP_PANEL_CONFIG_RUNNING);
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> +			  VSDC_DISP_PANEL_START_RUNNING(output));

[Severity: High]
Does this reversal of the clearing sequence cause bus stalls or visual tear=
ing?

In the original code, VSDC_DISP_PANEL_START was cleared before
VSDC_DISP_PANEL_CONFIG. This refactored sequence disables the panel
configuration while the pipeline is potentially still active. Should
VSDC_DISP_PANEL_START be cleared first to safely stop the pipeline?

[ ... ]
> +static void vs_dc8200_plane_disable_ex(struct vs_dc *dc, unsigned int ou=
tput)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +			VSDC_FB_CONFIG_EX_FB_EN);
> +
> +	vs_dc8200_plane_commit(dc, output);
> +}

[Severity: High]
This is a pre-existing issue carried over from the original code, but
does this actually disable the plane?

By using regmap_set_bits() with VSDC_FB_CONFIG_EX_FB_EN, the frame buffer
enable bit is being set to 1 instead of being cleared. Should this use
regmap_clear_bits() instead to properly disable the hardware plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608023237.3050=
36-1-a0987203069@gmail.com?part=3D3
