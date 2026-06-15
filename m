Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74225CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF1710E702;
	Mon, 15 Jun 2026 20:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h10c3BfP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD8E10E701
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:39:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6729940B2D;
 Mon, 15 Jun 2026 20:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7951F000E9;
 Mon, 15 Jun 2026 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555954;
 bh=IC1MTl5RI3u7PMxx6XJlkUrr2TsErn7c2o9aasZn6fA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h10c3BfPQsp1LXgpvee/RyZSrvB5XaZl5gme7QtK5szLZfPuVb8fehDd4nemxZ5z7
 +qlCN2uksS44dHqx1HHnSf6q9iCPBEDZ7g0TI/scpRz1Tew2owFqrBRhdeG7OikTTG
 HC0ZkYWDXJYxXYOYISNH1WBI391mld0VnVC0STDgHiI2GabWbDTHxWP2YkRG7Hk8Tn
 hxiKnJBu3I28MRFHp5CjJhyQkjYqJRZDQeLWl47ZL+aNmY4M6kvwc1lcQtVTQpkX4n
 lr3cMWp4/IgOBGYCvbO1aAHOqh2D82Lon6pC8gAWlNFV21lsrtDADFQ+zudAuz27OR
 qr/T5mlDac1WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/27] drm/i915/display: Make get_vblank_counter use
 intel_de_read_fw()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-10-dev@lankhorst.se>
References: <20260615201846.307297-10-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:39:13 +0000
Message-Id: <20260615203914.2E7951F000E9@smtp.kernel.org>
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

New issues:
- [High] Bypassing uncore->lock serialization by using intel_de_read_fw() c=
auses machine hangs on older architectures like Ivybridge.
- [High] intel_de_read_fw() bypasses the DMC wakelock, causing powered-off =
register reads during the vblank disable timer.

Pre-existing issues:
- [High] drm_crtc_vblank_put() is called with hardware interrupts disabled,=
 leading to a sleeping-in-atomic bug on PREEMPT_RT.
--

commit cfe5d45290a062b6a0335162bbb5cd6c13db5e3d
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Make get_vblank_counter use intel_de_read_fw()

This commit changes g4x_get_vblank_counter() to use intel_de_read_fw()
to avoid a sleeping-in-atomic lockdep splat on PREEMPT_RT.

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index 07dca05332e5b..c0cc0a4c25dbe 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
> @@ -132,7 +132,7 @@ u32 g4x_get_vblank_counter(struct drm_crtc *crtc)
>  	if (!vblank->max_vblank_count)
>  		return 0;
> =20
> -	return intel_de_read(display, PIPE_FRMCOUNT_G4X(display, pipe));
> +	return intel_de_read_fw(display, PIPE_FRMCOUNT_G4X(display, pipe));

[Severity: High]
Does bypassing the uncore->lock serialization here risk cacheline concurrent
access bugs on older architectures like Ivybridge?

As documented in intel_de.h, unlocked MMIO accessors can cause machine hangs
on older platforms if the same cacheline is accessed concurrently by differ=
ent
clients. PIPE_FRMCOUNT_G4X shares a cacheline with registers like
PIPE_FRMTMSTMP.

Since this is called holding only the vbl_lock, could an underrun interrupt
handler or other subsystem access the same cacheline concurrently without
holding vbl_lock and cause a hang?


[Severity: High]
Can using the fw variant here cause a read from a powered-off register?

By using intel_de_read_fw(), this bypasses the display microcontroller wake=
lock.
If g4x_get_vblank_counter() is called by drm_update_vblank_count() during t=
he
asynchronous vblank_disable_fn() timer, the display engine pipeline might be
in a deep power-saving state like DC5/DC6.

Would reading this register while powered off return garbage and cause a
massive jump in the vblank counter?

[ ... ]
>  static u32 intel_crtc_scanlines_since_frame_timestamp(struct intel_crtc =
*crtc)
>  {
[ ... ]
>  	do {
>  		/*
>  		 * This field provides read back of the display
>  		 * pipe frame time stamp. The time stamp value
>  		 * is sampled at every start of vertical blank.
>  		 */
>  		scan_prev_time =3D intel_de_read_fw(display,
>  						  PIPE_FRMTMSTMP(crtc->pipe));

[Severity: High]
This isn't a bug introduced by this patch, but the same DC5 power state bug
seems to exist here.

Because intel_crtc_scanlines_since_frame_timestamp() also uses
intel_de_read_fw(), could it also suffer from the exact same issue and
read garbage if called during the disable timer?


While reviewing the atomic context handling for vblank locks, I noticed a
related pattern in drivers/gpu/drm/i915/display/intel_crtc.c:

intel_pipe_update_start() {
        ...
	local_irq_disable();

	crtc->debug.min_vbl =3D evade.min;
	crtc->debug.max_vbl =3D evade.max;
	trace_intel_pipe_update_start(crtc);

	scanline =3D intel_vblank_evade(&evade);

	drm_crtc_vblank_put(&crtc->base);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
drm_crtc_vblank_put() here with hardware interrupts disabled?

If offdelay_ms is set to less than zero, drm_vblank_put() synchronously
calls vblank_disable_fn(), which attempts to acquire the dev->vbl_lock
spinlock.

On PREEMPT_RT, spinlock_t becomes a sleeping rt_mutex. Would attempting to
acquire this sleeping lock while hardware interrupts are disabled cause an
atomic context violation and a lockdep splat?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D9
