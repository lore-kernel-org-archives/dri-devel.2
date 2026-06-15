Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F42CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F98A10E65E;
	Mon, 15 Jun 2026 20:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cuGAkIOP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0074D10E65E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:32:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 785566008A;
 Mon, 15 Jun 2026 20:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEF61F000E9;
 Mon, 15 Jun 2026 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555560;
 bh=N01921id+lBgSpTDtHbLhLAg5rNYupZM6ui4neCuRYo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cuGAkIOP0J3QH2jTaY+dgynGXFIwZgimg+46G7kWTIrgEgR7g0ahVz7OWaWKjhoBG
 sfbSS09znB0Gs2D6PEqjpMGfBKGDis9Cs6FVCXMT1cT92shanhZe5S4D2/GGQC58Cx
 MrLz59zqyLKihHc8LZ9hmN1ViPBv7sVbj1R8k2z9fAtNAp+lbiWTWSoxCahr4fheHh
 LiTX4KTr5lJTJKyDXQXVF3v/y/ktFyKadaJ4ngtkaAN07ah5yDiSNQMsNpiSVP5mm5
 2iSNVSXEPaIs0p51kP2L7rSSEiFrtG29EFDygzwC0hXwpkaPMCCONcPwOTtJPlEA/f
 DXop054LLbP9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/27] drm/i915: Use preempt_disable/enable_rt()
 where recommended
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-9-dev@lankhorst.se>
References: <20260615201846.307297-9-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:32:39 +0000
Message-Id: <20260615203240.0BEF61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of atomic context protection (interrupt and preemption dis=
abling) during time-critical vblank register reads for the Xe driver on non=
-RT kernels.
--

commit 4b863f1335422d07b094a5072752ea5c148f7cbc
Author: Mike Galbraith <umgwanakikbuti@gmail.com>

drm/i915: Use preempt_disable/enable_rt() where recommended

This commit replaces unconditional local_irq_save() calls with a new
intel_vblank_section_enter_irqf() helper and adds conditional
preempt_disable() for PREEMPT_RT during vblank timestamping.

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index 6f1fa952b5391..07dca05332e5b 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
[ ... ]
> @@ -324,6 +338,17 @@ static void intel_vblank_section_enter(struct intel_=
display *display)
>  static void intel_vblank_section_exit(struct intel_display *display)
>  {
>  }
> +
> +static void intel_vblank_section_enter_irqf(struct intel_display *displa=
y, unsigned long *flags)
> +{
> +	*flags =3D 0;
> +}
> +
> +static void intel_vblank_section_exit_irqf(struct intel_display *display=
, unsigned long flags)
> +{
> +	if (flags)
> +		return;
> +}
>  #endif
> =20
>  static bool i915_get_crtc_scanoutpos(struct drm_crtc *_crtc,
> @@ -360,10 +385,10 @@ static bool i915_get_crtc_scanoutpos(struct drm_crt=
c *_crtc,
>  	 * timing critical raw register reads, potentially with
>  	 * preemption disabled, so the following code must not block.
>  	 */
> -	local_irq_save(irqflags);
> -	intel_vblank_section_enter(display);
> +	intel_vblank_section_enter_irqf(display, &irqflags);
> =20
> -	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();

[Severity: High]
Does this leave the timing-critical vblank register reads completely
unprotected on non-RT kernels when the #else path is taken?

Previously, local_irq_save() was unconditionally called to protect the
timestamping delta. With this change, the #else implementation of
intel_vblank_section_enter_irqf() is a no-op. Because preempt_disable()
is now strictly guarded by CONFIG_PREEMPT_RT, a standard non-RT kernel
taking this path executes with both interrupts and preemption enabled.

Could this allow random latency spikes during context switches or
interrupts, artificially inflating the delta between stime and etime
and resulting in timestamping failures?

> =20
>  	/* Get optional system timestamp before query. */
>  	if (stime)
[ ... ]
> @@ -468,13 +493,11 @@ int intel_get_crtc_scanline(struct intel_crtc *crtc)
>  	unsigned long irqflags;
>  	int position;
> =20
> -	local_irq_save(irqflags);
> -	intel_vblank_section_enter(display);
> +	intel_vblank_section_enter_irqf(display, &irqflags);
> =20
>  	position =3D __intel_get_crtc_scanline(crtc);
> =20
> -	intel_vblank_section_exit(display);
> -	local_irq_restore(irqflags);
> +	intel_vblank_section_exit_irqf(display, irqflags);

[Severity: High]
Similarly, does this leave __intel_get_crtc_scanline() entirely unprotected
from interrupts and preemption when the #else path is used on non-RT kernel=
s?

> =20
>  	return position;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D8
