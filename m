Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FD607826F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMipYyc0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D0A10EF66;
	Mon,  2 Nov 2026 14:53:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4D810EF64
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:52:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F46A605D4;
 Mon,  2 Nov 2026 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD191F00A16;
 Mon,  2 Nov 2026 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793631177;
 bh=/vmAi3qz/MUcn21z2Zel3BJOCM1kWxGyScvi4/JSGQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FMipYyc0pX/ecZmgopAhQpthQPlntfnm3bQCEwOs9L6xt5Oxid8+fIUU1RhnVkoE3
 kz1HbVkY068jKBptDtnoJ04IAPK7K7slpJWEkjTlI9HXhQwTGqw40zgwUtvj8nXhsW
 bcD1wU+jCKPZ320mUY2wr0pNIEcdP3SPfrHholMsUeYbQjuLLFHw0TEd7rczqfTtLZ
 VuziWA+VJWIggKWm0puIG3My40wUM/9ExV7Y/hrj/ZafvChvN+uN+s4RSuOrBVSLBi
 B7hmIOdPpVYYkrtZSkrwuQUdZ4iYM4jB47aF+I9qXa/CH/4BPpx7l4bwvdGa9dBybi
 6JYZD/fPh1imA==
Message-ID: <sashiko-outbox-193616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vblank: Restart enabling vblank timer on possible
 deadlock
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102143919.1672293-1-tzimmermann@suse.de>
References: <20261102143919.1672293-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:52:56 +0000
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
- [High] drm/vblank: deadlock in drm_vblank_enable() retry when outer locks=
 are held
--

commit 0a0f76a052c65f5a2ede08f67964f40f4ca7f5fc
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vblank: Restart enabling vblank timer on possible deadlock

This commit updates drm_crtc_vblank_start_timer() to return -EDEADLK when
hrtimer_try_to_cancel() indicates the vblank hrtimer callback is currently
running, and updates drm_vblank_enable() to drop and reacquire
vblank_time_lock before retrying.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..5a4c11e57484c 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1182,10 +1182,12 @@ static int __enable_vblank(struct drm_device *dev=
, unsigned int pipe)
>  static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
>  {
>  	struct drm_vblank_crtc *vblank =3D drm_vblank_crtc(dev, pipe);
> -	int ret =3D 0;
> +	int ret;
> =20
>  	assert_spin_locked(&dev->vbl_lock);
> =20
> +retry:
> +	ret =3D 0;
>  	spin_lock(&dev->vblank_time_lock);
> =20
>  	if (!vblank->enabled) {
> @@ -1199,7 +1201,11 @@ static int drm_vblank_enable(struct drm_device *de=
v, unsigned int pipe)
>  		ret =3D __enable_vblank(dev, pipe);
>  		drm_dbg_core(dev, "enabling vblank on crtc %u, ret: %d\n",
>  			     pipe, ret);
> -		if (ret) {
> +		if (ret =3D=3D -EDEADLK) {
> +			spin_unlock(&dev->vblank_time_lock);
> +			cpu_relax();
> +			goto retry;

[Severity: High]
Can this retry loop still deadlock when outer locks are held across
drm_vblank_enable()?

When drm_crtc_vblank_start_timer() returns -EDEADLK because
drm_vblank_timer_function() is currently executing on another CPU,
drm_vblank_enable() only releases dev->vblank_time_lock while continuing to
hold dev->vbl_lock and any caller-held locks.

However, the running timer callback drm_vblank_timer_function() calls into
drm_handle_vblank(), which acquires dev->event_lock before
dev->vblank_time_lock, and can also call vblank_disable_fn(), which acquires
dev->vbl_lock:

drivers/gpu/drm/drm_vblank.c:drm_handle_vblank() {
	...
	spin_lock_irqsave(&dev->event_lock, irqflags);
	spin_lock(&dev->vblank_time_lock);
	...
	if (disable_irq)
		vblank_disable_fn(&vblank->disable_timer);
}

In addition, vkms_crtc_handle_vblank_timeout() acquires vkms_output->lock
before calling drm_crtc_handle_vblank():

drivers/gpu/drm/vkms/vkms_crtc.c:vkms_crtc_handle_vblank_timeout() {
	...
	spin_lock(&output->lock);
	ret =3D drm_crtc_handle_vblank(crtc);
	...
}

Callers that enable vblank during atomic flush or work scheduling hold these
outer locks before calling drm_crtc_vblank_get() -> drm_vblank_get() ->
drm_vblank_enable(). For example, drm_crtc_vblank_atomic_flush() holds
dev->event_lock:

drivers/gpu/drm/drm_vblank_helper.c:drm_crtc_vblank_atomic_flush() {
	...
	spin_lock_irq(&dev->event_lock);
	...
	if (event) {
		if (drm_crtc_vblank_get(crtc) =3D=3D 0)
			drm_crtc_arm_vblank_event(crtc, event);
	...
	spin_unlock_irq(&dev->event_lock);
}

Similarly, vkms_crtc_atomic_begin() and vkms_crtc_atomic_flush() hold both
vkms_output->lock and dev->event_lock across drm_crtc_vblank_get(), and
drm_vblank_get() always holds dev->vbl_lock across drm_vblank_enable().

If drm_vblank_timer_function() already read a non-zero vtimer->interval bef=
ore
a prior disable cleared it, and is now waiting on vkms_output->lock,
dev->event_lock, or dev->vbl_lock, won't CPU A spin forever in the retry lo=
op
in drm_vblank_enable() while holding the very locks that the timer callback=
 on
CPU B needs to finish?

Also, because vtimer->timer is set up with HRTIMER_MODE_REL rather than
HRTIMER_MODE_REL_HARD, on CONFIG_PREEMPT_RT the timer callback runs in soft=
irq
context. If a task calling drm_vblank_enable() preempts the timer callback =
on
the same CPU and spins with cpu_relax() while holding spinlocks, can the
preempted timer callback ever complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102143919.1672=
293-1-tzimmermann@suse.de?part=3D1
