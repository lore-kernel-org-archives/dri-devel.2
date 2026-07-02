Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E60C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8108210F188;
	Thu,  2 Jul 2026 07:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nOVtSOw6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992B410F188
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:43:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA66460121;
 Thu,  2 Jul 2026 07:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF451F000E9;
 Thu,  2 Jul 2026 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782978206;
 bh=JJh2YovE8azfh5WS7k8z12MTEh+cqxZ3vCRHRwazEzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nOVtSOw6xZuei8kK/kRuiIBT7AdPdCFzFvv7RvVD0jerHY5Quku6SghAE7WE75YCJ
 x1fs9lfI8/1g2qiB24jwgTgKq9lB2LxHkR2iYGJmPUiGaKaLNbW+PAfjsrtvlAWSUd
 64cfbgkY4UvKOOtkbPy9BjUaOZO8W5rQtjju1PE7XvCiz2D0vLwJdJ4XbxX/ydaYBu
 PEeNu06qW384ndr8NdxlIDh8YLeyPyDrmdHvKKkpRNGkwFhsG/evrcnahRy/MUixhC
 xQsfPLp8ugiTYuKeQqKHCcX1dWsBUWgTAhRFLxVqoeUwiuqu4b0eoYG8Bi+45GowJk
 6g+gWh9AAJD1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] drm/i915/display: Make get_vblank_counter use
 intel_de_read_fw()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-10-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-10-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:43:25 +0000
Message-Id: <20260702074326.5EF451F000E9@smtp.kernel.org>
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
- [High] Bypassing the DMC wakelock using `intel_de_read_fw()` in `g4x_get_=
vblank_counter()` causes unprotected reads of powered-down registers on mod=
ern platforms (Xe2+).

Pre-existing issues:
- [High] Tracepoints calling `intel_get_crtc_scanline()` acquire the sleepa=
ble `uncore->lock` in atomic context, leading to a PREEMPT_RT lockdep splat.
- [High] Acquiring `wl->lock` in `icl_dsi_frame_update()` while hardware in=
terrupts are disabled causes a PREEMPT_RT lockdep splat.
--

commit a4aff240080d4b3a8f37dee585514c6912bb489d
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Make get_vblank_counter use intel_de_read_fw()

This commit modifies g4x_get_vblank_counter() to use intel_de_read_fw()
instead of intel_de_read() to avoid taking a sleeping lock in atomic
context, fixing a lockdep splat on PREEMPT_RT.

>     Fixes the following lockdep splat on PREEMPT_RT:
>     <3> BUG: sleeping function called from invalid context at kernel/lock=
ing/spinlock_rt.c:48
[ ... ]
>     <4>  #9: ffff888114f7b8b8 (&intel_dp->psr.lock){+.+.}-{3:3}, at: inte=
l_psr_lock+0xc5/0xf0 [xe]
>     <4>  #10: ffff88812a0cbbc0 (&wl->lock){+.+.}-{2:2}, at: intel_dmc_wl_=
get+0x3c/0x140 [xe]
>    =20
>     This splat will happen otherwise on all tracepoints too, for similar =
reasons.

[Severity: High]
This is a pre-existing issue, but do tracepoints calling
intel_get_crtc_scanline() still acquire the sleepable uncore->lock in
atomic context, leading to a PREEMPT_RT lockdep splat?

For example, trace_intel_pipe_update_start executes with preemption disable=
d:

intel_display_trace.h:TRACE_EVENT() {
    ...
    __entry->scanline =3D intel_get_crtc_scanline(crtc);
    ...
}

Which calls the locking function:

intel_vblank.c:intel_get_crtc_scanline() {
    ...
    intel_vblank_section_enter_irqf(display, &irqflags);
    ...
}

And acquires the lock:

intel_vblank.c:intel_vblank_section_enter_irqf() {
    ...
    spin_lock_irqsave(&uncore->lock, *flags);
    ...
}

On PREEMPT_RT, uncore->lock becomes an rt_spinlock which can sleep. Acquiri=
ng
a sleeping lock with preemption disabled causes a BUG splat and system
instability.

While i915_get_vblank_counter() was fixed in a subsequent patch in this ser=
ies
(commit drm/i915/display: Do not take uncore lock in i915_get_vblank_counte=
r),
intel_get_crtc_scanline() remains unfixed at the end of the series.

[Severity: High]
This is a pre-existing issue, but does acquiring wl->lock in
icl_dsi_frame_update() while hardware interrupts are disabled cause a
PREEMPT_RT lockdep splat?

The hardware update sequence between intel_pipe_update_start() and
intel_pipe_update_end() executes with hardware interrupts disabled via
local_irq_disable().

Within this section:

intel_crtc.c:intel_pipe_update_end() {
    ...
    icl_dsi_frame_update(new_crtc_state);
    ...
}

Which calls:

icl_dsi.c:icl_dsi_frame_update() {
    ...
    intel_de_rmw(display, DSI_CMD_FRMCTL(port), 0,
                 DSI_FRAME_UPDATE_REQUEST);
    ...
}

This attempts to acquire the DMC wakelock (wl->lock), which is a sleepable
rt_spinlock on PREEMPT_RT. Taking it while IRQs are disabled triggers a
sleeping function called from invalid context bug.

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
Does bypassing the DMC wakelock here cause unprotected reads of powered-down
registers on modern platforms?

PIPE_FRMCOUNT_G4X (0x70040) is within the powered_off_ranges
(0x60000 - 0x7FFFF) defined in intel_dmc_wl.c. On modern platforms like Xe2=
+,
MMIO reads do not automatically wake the hardware from DC states, and the
DMC wakelock must be explicitly held. Could using intel_de_read_fw() lead
to reading garbage data (0xFFFFFFFF) or cause MMIO timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D9
