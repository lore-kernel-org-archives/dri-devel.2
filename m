Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB57CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A5D10E701;
	Mon, 15 Jun 2026 20:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDLkUA91";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1EB10E701
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B585342CEB;
 Mon, 15 Jun 2026 20:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9601F000E9;
 Mon, 15 Jun 2026 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555953;
 bh=MPpYSshhV4f0UYKVUTB7Rg+e+yJzx4HVUiUV4+gDxcU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CDLkUA91dqv/wXwWdpJyWWLqFUBMHnNN28cQWWw8X+UtXeoZ4ybObHLg/FTWajp4S
 wNn9zdt4rkRcsSjy8HdEjL7VBJ5gyIG70dkbmi6LCr2Zq6cHyHeWgTO0mKBIsh69/G
 wOKU/ncdJZGOwRuWEl1BkaRMIGw/lUriF6nZndWcagSVhTeX/gFQHwZhMh8OLJx/72
 l5VdyZVDwjtlS0boIQVAVd+uReG2QxxfWrkyj9yZ3YIpa1lKGn3hkfPpXSP/NWqF4W
 CJr+gKgtPygHAq1GyZqBpjasOQVyuc/vZNXAZkDouBSI/ND+hIh9SRujM773tkLI1L
 AorXJQdl4MscA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/27] drm/i915/display: Remove locking from
 intel_vblank_evade critical section
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-7-dev@lankhorst.se>
References: <20260615201846.307297-7-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:39:13 +0000
Message-Id: <20260615203913.7C9601F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Bypassing `uncore->lock` during vblank evasion allows concurrent M=
MIO accesses, leading to hardware hangs on older platforms like Ivybridge a=
nd Haswell.

Pre-existing issues:
- [High] drm_crtc_vblank_put() can acquire the sleeping lock dev->vbl_lock =
while local IRQs are disabled, causing a BUG on PREEMPT_RT.
--

commit 8b19163d6f27afde254220a0f64b5572fb1ac0f0
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Remove locking from intel_vblank_evade critical section

This commit avoids calling sleeping functions with local interrupts disabled
during vblank evasion to fix PREEMPT_RT bugs. It also replaces
intel_get_crtc_scanline() with __intel_get_crtc_scanline() in unlocked
contexts to prevent taking spinlocks.

> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/=
i915/display/intel_crtc.c
> index 6b71810803139..89d1091a56805 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -734,7 +734,7 @@ void intel_pipe_update_end(struct intel_atomic_state =
*state,
>  	struct intel_crtc_state *new_crtc_state =3D
>  		intel_atomic_get_new_crtc_state(state, crtc);
>  	enum pipe pipe =3D crtc->pipe;
> -	int scanline_end =3D intel_get_crtc_scanline(crtc);
> +	int scanline_end =3D __intel_get_crtc_scanline(crtc);

[Severity: High]
Does bypassing uncore->lock here and in scanline_in_safe_range() risk
hardware hangs on older platforms?

By using __intel_get_crtc_scanline() inside the local_irq_disable() critical
section, the code performs raw MMIO reads that bypass the lock. Older
platforms like Ivybridge and Haswell require all register accesses to the
same cacheline to be serialized via uncore->lock.

Could this concurrent MMIO access cause those platforms to hang?

>  	u32 end_vbl_count =3D intel_crtc_get_vblank_counter(crtc);
>  	ktime_t end_vbl_time =3D ktime_get();

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index 28d81199792ef..ca08059e088ea 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
[ ... ]
> @@ -739,24 +749,12 @@ int intel_vblank_evade(struct intel_vblank_evade_ct=
x *evade)
>  	struct intel_display *display =3D to_intel_display(crtc);
>  	long timeout =3D msecs_to_jiffies_timeout(1);
>  	wait_queue_head_t *wq =3D drm_crtc_vblank_waitqueue(&crtc->base);
> -	DEFINE_WAIT(wait);
>  	int scanline;
> =20
>  	if (evade->min <=3D 0 || evade->max <=3D 0)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but does the critical section surrounding
intel_vblank_evade() still have a PREEMPT_RT bug?

In intel_pipe_update_start(), local_irq_disable() is called before the
evasion loop. Immediately after the loop, drm_crtc_vblank_put() is called,
still within the IRQ-disabled section.

If drm_vblank_offdelay is set to < 0, drm_crtc_vblank_put() synchronously
calls vblank_disable_fn(), which acquires dev->vbl_lock. On PREEMPT_RT,
dev->vbl_lock maps to a sleeping rt_mutex, which triggers a sleeping in
atomic context BUG when acquired with local IRQs disabled.

Is this something that needs to be addressed for PREEMPT_RT?

> =20
> -	for (;;) {
> -		/*
> -		 * prepare_to_wait() has a memory barrier, which guarantees
> -		 * other CPUs can see the task state update by the time we
> -		 * read the scanline.
> -		 */
> -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
> -
> -		scanline =3D intel_get_crtc_scanline(crtc);
> -		if (scanline < evade->min || scanline > evade->max)
> -			break;
> -
> +	while (!scanline_in_safe_range(evade, &scanline, false)) {
>  		if (!timeout) {
>  			drm_dbg_kms(display->drm,
>  				    "Potential atomic update failure on pipe %c\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D6
