Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1D606A337
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClHmC2LM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD7F1126D2;
	Thu,  5 Nov 2026 15:17:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9C51126D2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E71AA44035;
 Thu,  5 Nov 2026 15:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23901F000C1;
 Thu,  5 Nov 2026 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793891816;
 bh=2eqpYC+ErdyTkd4JdTHO9JL1pDnkSJzmXhsejVTPFQw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ClHmC2LMrkAmtieoWuZIJg2CYKNzhPqtdZtn8TO+9YwZydre0v9SlcCSUAr/y9jhb
 +PnhIJJXX+WYFpnOsc6yswiD2IsY7BCYGBfTGFMBO6OduNBbak/aanGC7QcaPQWAf+
 MNaoGTX1wgUiZYAGF4pZx0FjG4Y3Luv3cNTNHvmFHEs87c4gjjNKncvWaDTPzkqq3+
 vt8NG950anG1iZ/8IXiY+/nzmJJnaGHUpPwhy3cVnqQiC2j385SszsqCJRa0u4KqiD
 FeDGnVeacruzrYscI2hn9piUuru808zU3PpC1Varkt+H1ZnQqb8JPLA2s+fKSuO6p+
 IK3neI3Np5xnQ==
Message-ID: <sashiko-outbox-199305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/vblank: Cancel vblank timer outside of critical
 section
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105145946.896674-3-tzimmermann@suse.de>
References: <20261105145946.896674-1-tzimmermann@suse.de>
 <20261105145946.896674-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:16:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/vblank: uninitialized spinlock in drm_crtc_vblank_cancel_timer=
()
--

commit 0925c513110481f6c38259e0df588ad4194770ca
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vblank: Cancel vblank timer outside of critical section

This commit introduces a sync_vblank callback in struct drm_crtc_funcs so
that vblank timers can be synchronously canceled via hrtimer_cancel() outsi=
de
of vblank_time_lock. It also adds drm_crtc_vblank_stop_canceled_timer() and
drm_crtc_vblank_stop_timer(), and updates vmwgfx and the vblank timer helpe=
rs
to use them.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 8cc8d018d353a..ca3a6f17564b5 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
[ ... ]
> @@ -2246,28 +2249,58 @@ EXPORT_SYMBOL(drm_crtc_vblank_start_timer);
>   * @crtc: the CRTC
>   *
>   * Drivers should call this function from their CRTC's disable_vblank
> - * function to stop a vblank timer.
> + * function to stop a vblank timer. Only signals the timer to stop at
> + * the next invocation. Non-blocking. To fully stop the vblank timer,
> + * drivers should invoke drm_crtc_vblank_stop_timer().
>   */
>  void drm_crtc_vblank_cancel_timer(struct drm_crtc *crtc)
>  {
>  	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
>  	struct drm_vblank_crtc_timer *vtimer =3D &vblank->vblank_timer;
> -	unsigned long flags;
> =20
>  	/*
> -	 * Calling hrtimer_cancel() can result in a deadlock with DRM's
> -	 * vblank_time_lime_lock and hrtimers' softirq_expiry_lock. So
> +	 * Calling hrtimer_cancel() here can result in a deadlock between
> +	 * DRM's vblank_time_lock and hrtimers' softirq_expiry_lock. So
>  	 * clear interval and indicate cancellation. The timer function
> -	 * will cancel itself on the next invocation.
> +	 * will cancel itself on the next invocation. Otherwise cancel it
> +	 * in drm_crtc_vblank_stop_canceled_timer().
>  	 */
> +	scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
> +		vtimer->interval =3D 0;
> +}
> +EXPORT_SYMBOL(drm_crtc_vblank_cancel_timer);
> +
> +/**
> + * drm_crtc_vblank_stop_canceled_timer - Stops a CRTC's previously cance=
led vblank timer
> + * @crtc: the CRTC
> + *
> + * Drivers should call this function from their CRTC's sync_vblank
> + * function to fully stop a vblank timer. The timer must have been
> + * canceled before. Use drm_crtc_vblank_stop_timer() to stop a vblank
> + * timer unconditionally.
> + *
> + * The function blocks until a running timer function has returned.
> + */
> +void drm_crtc_vblank_stop_canceled_timer(struct drm_crtc *crtc)
> +{
> +	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> +	struct drm_vblank_crtc_timer *vtimer =3D &vblank->vblank_timer;
> +	ktime_t interval;
> =20
> -	spin_lock_irqsave(&vtimer->interval_lock, flags);
> -	vtimer->interval =3D 0;
> -	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
> +	if (!vtimer->crtc)
> +		return;

[Severity: High]
Should drm_crtc_vblank_cancel_timer() also check for !vtimer->crtc before
acquiring vtimer->interval_lock?

In drm_vblank_init(), dev->vblank is allocated with drmm_kcalloc(), leaving
vtimer zero-initialized. Both vtimer->crtc and vtimer->interval_lock are
only initialized lazily on the first call to drm_crtc_vblank_start_timer():

drivers/gpu/drm/drm_vblank.c:drm_crtc_vblank_start_timer() {
	if (!vtimer->crtc) {
		/*
		 * Set up the data structures on the first invocation.
		 */
		vtimer->crtc =3D crtc;
		spin_lock_init(&vtimer->interval_lock);
		hrtimer_setup(&vtimer->timer, drm_vblank_timer_function,
			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
	}

While drm_crtc_vblank_stop_canceled_timer() guards against an uninitialized
timer with if (!vtimer->crtc) return, drm_crtc_vblank_stop_timer() calls
drm_crtc_vblank_cancel_timer() first:

vmw_vkms_crtc_cleanup()
  -> drm_crtc_vblank_stop_timer()
       -> drm_crtc_vblank_cancel_timer()
            -> scoped_guard(spinlock_irqsave, &vtimer->interval_lock)
       -> drm_crtc_vblank_stop_canceled_timer()

When vmw_vkms_crtc_cleanup() runs during CRTC teardown on a display unit
where vblank was never enabled, wouldn't drm_crtc_vblank_cancel_timer() lock
vtimer->interval_lock before spin_lock_init() has ever been called on it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105145946.8966=
74-1-tzimmermann@suse.de?part=3D2
