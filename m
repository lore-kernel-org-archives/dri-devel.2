Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7872FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B22E10F1B0;
	Thu,  2 Jul 2026 07:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKKHupYJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8B910F1B0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:36:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 046B660122;
 Thu,  2 Jul 2026 07:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BE1F01568;
 Thu,  2 Jul 2026 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977784;
 bh=uYuChMWeyjygpJBzozr9u764MlUAtz7dVHBrKYMC5Mc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jKKHupYJaKhm6pJanLXQVzMd6LkaKDJyZwnPH646hI0Tgndg3DVZkNiuc/0zKPeiD
 kpPnR4t8vyiS/7dthDPEGNqstAoq6xaAPZSGHTEP3cMziiPXZLB2HEx4S0QXofdy7R
 OfJipVxs74Yiqy1nP9MGbVT0zIhNEtTvpinITKLSNtjD6xGgX7iaCK7mCdmiBKVrcV
 zNzPYW1sB1BBAZVlhbaQq7te37w7PvxmVVATcVJOJwAa3TpoCOEH1zc5hEh9M5d/qu
 D/bFk1iz7mj0O5xoVYN/b/Sm70XMWNmf6CKaMX1fPLR14NY4j2x6i5oQwLNJSYJoLd
 sEimAFeJvmESA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] drm/i915/display: Remove locking from
 intel_vblank_evade critical section
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-7-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-7-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:36:23 +0000
Message-Id: <20260702073624.8C1BE1F01568@smtp.kernel.org>
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
- [High] Bypassing `uncore->lock` for scanline reads breaks the hardware se=
rialization workaround for older platforms like Ivy Bridge and Haswell, pot=
entially causing hardware hangs.

Pre-existing issues:
- [High] drm_crtc_vblank_put() is called with local interrupts disabled in =
intel_pipe_update_start().
--

commit a415cb59c253b3a3fa754a68afc62b743249b0f2
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Remove locking from intel_vblank_evade critical section
   =20
finish_wait() may take a lock, which means that it can take any amount
of time. On PREEMPT-RT we should not be taking any lock after disabling
preemption, so ensure that the completion is done before disabling
interrupts.

This also has the benefit of making vblank evasion more deterministic,
by performing the final vblank check after all locking is done.

> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/=
i915/display/intel_crtc.c
> index 34a159f7c9a43..8218938985b41 100644
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
Does bypassing uncore->lock here break the hardware serialization workaround
for older platforms?

Calling __intel_get_crtc_scanline() without the lock in intel_pipe_update_e=
nd()
risks concurrent mmio access with other threads, such as when reading the
PIPEDSL register, which could cause hardware hangs on platforms like Ivy Br=
idge
and Haswell.

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index 28d81199792ef..ca08059e088ea 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
> @@ -732,6 +732,16 @@ void intel_vblank_evade_init(const struct intel_crtc=
_state *old_crtc_state,
>  		evade->min -=3D vblank_delay;
>  }
> =20
> +static bool scanline_in_safe_range(struct intel_vblank_evade_ctx *evade,=
 int *scanline, bool unlocked)
> +{
> +	if (unlocked)
> +		*scanline =3D intel_get_crtc_scanline(evade->crtc);
> +	else
> +		*scanline =3D __intel_get_crtc_scanline(evade->crtc);

[Severity: High]
Could this lockless scanline read cause a hardware hang during evasion?

Similar to the above, calling __intel_get_crtc_scanline() here during
the preempt-disabled evasion loop in scanline_in_safe_range() bypasses the
required hardware serialization lock. Older platforms might experience hangs
due to unsynchronized mmio cacheline access.

> +
> +	return *scanline < evade->min || *scanline > evade->max;
> +}

[ ... ]

[Severity: High]
This is a pre-existing issue, but intel_pipe_update_start() calls
drm_crtc_vblank_put() with local interrupts disabled:

drivers/gpu/drm/i915/display/intel_crtc.c:intel_pipe_update_start() {
    ...
    local_irq_disable();

    crtc->debug.min_vbl =3D evade.min;
    crtc->debug.max_vbl =3D evade.max;
    trace_intel_pipe_update_start(crtc);

    scanline =3D intel_vblank_evade(&evade);

    drm_crtc_vblank_put(&crtc->base);
    ...
}

Could this lead to scheduling while atomic on preempt-rt kernels?

When the reference count drops to zero, drm_crtc_vblank_put() might acquire
dev->vbl_lock, which is a spinlock_t that sleeps on preempt-rt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D6
