Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CDCCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D6C10F20A;
	Thu, 25 Jun 2026 10:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nziqe2Au";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F95210F20A
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:00:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DED8960018;
 Thu, 25 Jun 2026 10:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E841F000E9;
 Thu, 25 Jun 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381616;
 bh=wgqrg+pDY8DEBKTtztJHqt8nN41A0NzbpJrZQtNh23M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nziqe2AuiEBUkSnQhMkpnNj6s5AqqNR1v9fFMz91GVm6bZDAaY3QJEGGVQ6k9jE2+
 AQoZsXDQj4uxaeCiVP2pB/WBDIzjbaBOAHyoG8QilOG8fVeFr/5Upun9c1lumHCsAG
 +1wTM3biXuks49oqxGrzSo6bIoM+0aHpw5Ec/xq9AMLlZNemuKcMpxQnpxLR6jZF6j
 +JqFp5qI0S+otyvEGlrN2dmoStTwwOYsF3LtzYBQLesvEaW4Ws045D44HgQF+rhzYU
 2lR+8KBaqc4+8Hv4K73o0+j/dIjK+LHBmSXvwk8THuGCpkPuhFvDz917flmV/iJWmB
 2zCmrd2MzkZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] drm/verisilicon: introduce per-variant hardware
 ops table
To: "Joey Lu" <a0987203069@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260625094449.708386-4-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-4-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:00:15 +0000
Message-Id: <20260625100016.18E841F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] CRTC disable hardware operation is called after disabling the pixe=
l clock.
- [High] The register clearing sequence in `vs_dc8200_panel_disable_ex` is =
inverted compared to the original code, clearing the configuration bit befo=
re stopping the panel.
- [Medium] Unknown hardware interrupts are silently filtered out by the irq=
_ack abstraction, rendering the unknown interrupt diagnostic warning unreac=
hable.

Pre-existing issues:
- [High] Primary plane disable function incorrectly sets the enable bit rat=
her than clearing it.
- [High] The driver requests its IRQ line before it fully initializes its i=
nternal state, creating a race condition that can lead to a NULL pointer de=
reference.
- [High] `vs_dc_irq_handler` unconditionally returns `IRQ_HANDLED` regardle=
ss of whether any interrupt bits were set.
--

commit d0e2c6765378754f6b5239526ba6f62ca9de0dd3
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: introduce per-variant hardware ops table

The DC8200 and DCUltraLite share a broadly similar register layout but diff=
er
in how the bridge, CRTC, primary plane and IRQ paths are driven. This commit
introduces a vs_dc_funcs vtable so each variant can supply its own
implementation without scattering conditionals across multiple files.

> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/veri=
silicon/vs_crtc.c
> index 0b8a35d09cd2e..1c4aac7086694 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
[ ... ]
> @@ -30,6 +53,9 @@ static void vs_crtc_atomic_disable(struct drm_crtc *crt=
c,
>  	drm_crtc_vblank_off(crtc);
> =20
>  	clk_disable_unprepare(dc->pix_clk[output]);
> +
> +	if (dc->funcs->crtc_disable_ex)
> +		dc->funcs->crtc_disable_ex(dc, output);
>  }

[Severity: High]
Is it safe to access hardware registers via crtc_disable_ex() after the pix=
el
clock has been gated? The teardown order should typically reverse the
initialization order, meaning the hook must be invoked before gating the cl=
ock.

[ ... ]
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisi=
licon/vs_dc.c
> index dad9967bc10b8..9729b693d360e 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -33,7 +31,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void *pri=
vate)
>  	struct vs_dc *dc =3D private;
>  	u32 irqs;
> =20
> -	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
> +	irqs =3D dc->funcs->irq_ack(dc);
> =20
>  	vs_drm_handle_irq(dc, irqs);
> =20
>  	return IRQ_HANDLED;

[Severity: High]
This isn't a bug introduced by this patch, but does unconditionally returni=
ng
IRQ_HANDLED prevent the kernel from detecting and disabling a stuck shared
interrupt line? If the handler processes no interrupts, shouldn't it return
IRQ_NONE?

[Severity: High]
This is another pre-existing issue, but in vs_dc_probe(), the IRQ is
requested before vs_drm_initialize() is called. Can the IRQ handler fire
before dc->drm_dev is allocated, resulting in a NULL pointer dereference
when vs_drm_handle_irq() executes?

[ ... ]
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c b/drivers/gpu/drm/ve=
risilicon/vs_dc8200.c
> new file mode 100644
> index 0000000000000..17378f4ef96d1
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
[ ... ]
> +static void vs_dc8200_panel_disable_ex(struct vs_dc *dc, unsigned int ou=
tput)
> +{
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
> +			  VSDC_DISP_PANEL_CONFIG_RUNNING);
> +	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> +			  VSDC_DISP_PANEL_START_RUNNING(output));

[Severity: High]
Does reversing the clear order of the configuration and start registers risk
hardware underflows or state desynchronization? In the original
vs_bridge_atomic_disable() implementation, the panel was shut down by first
clearing VSDC_DISP_PANEL_START_RUNNING and then clearing
VSDC_DISP_PANEL_CONFIG_RUNNING.

[ ... ]
> +static void vs_dc8200_primary_plane_disable_ex(struct vs_dc *dc, unsigne=
d int output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +			VSDC_FB_CONFIG_EX_FB_EN);
> +
> +	vs_dc8200_plane_commit(dc, output);
> +}

[Severity: High]
This is a pre-existing issue carried over from the original code, but does
the primary plane disable sequence leave the plane enabled by using
regmap_set_bits() instead of clearing the VSDC_FB_CONFIG_EX_FB_EN bit?

[ ... ]
> +static u32 vs_dc8200_irq_ack(struct vs_dc *dc)
> +{
> +	u32 hw_irqs, unified =3D 0;
> +	unsigned int i;
> +
> +	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &hw_irqs);
> +
> +	for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
> +		if (hw_irqs & VSDC_TOP_IRQ_VSYNC(i))
> +			unified |=3D VSDC_IRQ_VSYNC(i);
> +	}
> +
> +	return unified;
> +}

[Severity: Medium]
Does this filter out unknown hardware interrupts, making the diagnostic
warning in vs_drm_handle_irq() unreachable? By only passing through known
VSDC_IRQ_VSYNC bits, any unmapped hardware interrupt bits are silently
discarded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094449.7083=
86-1-a0987203069@gmail.com?part=3D3
