Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4536C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E526910F153;
	Fri, 18 Sep 2026 03:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YOV1ROvV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2812110F153
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 498276020A;
 Fri, 18 Sep 2026 03:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15211F000FF;
 Fri, 18 Sep 2026 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789701194;
 bh=oHoa8mBzUg4+1mcj7snDJWPyEN/yFQ+pya4QRdtQYHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YOV1ROvVVg/2q4EbQTk6GpQZnOKUa7F7LCtkXF3/4NRKQKVfGkB+q9tUrU4slPmPq
 qhuEap8NIgM81uYGwHA/FfNpP/RDzF2Oqw6KbRj+tPOWV3hNRjKSyHt2t4qq5ij5UX
 VQXsGT5ZUC8pPDHzsvkiv4kOkDWq8u+WYqkQul2ukNbM/mY8o2wQOAoh+u0YS7sHle
 LCd83taefdbu0rc9vG37xG/DEMWLOozGkuxjHqHFQmHH/S/6EWEFltaeGeYazHoVBb
 HdDf9NlcWpFT79aQUpLo1j7hLjGr9ryKom80w7hmLC0CHJcyiNhbHRLij18z87akE3
 IeptyFiSe/rjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] drm/verisilicon: add DC8000 (DCUltraLite)
 display controller support
To: "Joey Lu" <a0987203069@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260918030125.315978-5-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-5-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:13:13 +0000
Message-Id: <20260918031313.B15211F000FF@smtp.kernel.org>
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
- [High] drm/verisilicon: missing IRQ acknowledgment causes interrupt storm
- [High] drm/verisilicon: wrong register configured in vs_dc8000_panel_enab=
le_ex
- [High] drm/verisilicon: reversed VALID bit logic causes incomplete state =
latching
--

commit 091826cd38f41f7f76fdaab38a3712b19c6f3f16
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DC8000 (DCUltraLite) display controller support

This patch adds support for the DC8000 display controller to the
verisilicon DRM driver. It introduces a new vs_dc_funcs implementation
for the DC8000 generation.

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
The commit message mentions that panel output starts as soon as
PANEL_CONFIG.RUNNING is set. However, does this code configure the wrong
register?

It sets and clears the VSDC_FB_CONFIG_RESET bit in the framebuffer
configuration register instead of the panel configuration register, which m=
ight
leave the panel hardware unstarted and the framebuffer held in reset.

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
Is the VALID bit logic reversed here?=20

Setting VSDC_FB_CONFIG_VALID in vs_dc8000_crtc_begin() asserts to hardware
that the configuration is ready before new plane updates are written, and
clearing it in vs_dc8000_crtc_flush() marks the completed configuration as
invalid.=20

Can this reversed signaling cause the hardware to latch an incomplete state
during atomic updates?

[ ... ]

> +static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
> +{
> +	u32 hw_irqs, unified =3D 0, known =3D 0;
> +	unsigned int i;
> +
> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &hw_irqs);
> +
> +	for (i =3D 0; i < VSDC_MAX_OUTPUTS; i++) {
> +		known |=3D VSDC_DISP_IRQ_VSYNC(i);
> +		if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
> +			unified |=3D VSDC_IRQ_VSYNC(i);
> +	}
> +
> +	drm_WARN_ONCE(&dc->drm_dev->base, hw_irqs & ~known,
> +		      "Unknown hardware IRQ bits: %#x\n", hw_irqs & ~known);
> +
> +	return unified;
> +}

[Severity: High]
Does this function fail to clear the pending hardware interrupts?=20

It reads VSDC_DISP_IRQ_STA to check pending interrupts but does not write b=
ack
to clear them. For hardware without a dedicated ACK register, the status
register usually acts as a write-1-to-clear mechanism.=20

Can failing to write back leave the interrupt asserted in the hardware and
cause an infinite interrupt storm when the VBLANK interrupt fires?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918030125.3159=
78-1-a0987203069@gmail.com?part=3D4
