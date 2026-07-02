Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA8C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1E310E500;
	Thu,  2 Jul 2026 15:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hg24F+Nv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F37C10F4A6
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5567601F0;
 Thu,  2 Jul 2026 15:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F96F1F00A3A;
 Thu,  2 Jul 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783007397;
 bh=7EETzgEdGiW3GI+WOAmrdvxHIMvBIDziFh3SwcPz1NU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hg24F+NvK8qvX4tH1+Kv0etyHpTkt6aPPiDDbsmcohsmmianjTVn9ZJhcA4xZTHnj
 skHqpGSJKgZltyquBejquZrxeQ/7OvwZhkpnKn0IkgSkVp3CIJhmLOXHgd5cR06gxT
 gVPDTQxRue2m/a4yK138fBhj1EmjZugm+OgErzxsmXjZcLhm7CZnENsLDzmscaFj36
 O0PVluq8vUFjWBQc4G49LGgXRNJJ64igLXr5oWxJ6uq4FrGXtOIVHrZCv162z084XM
 k69ZS5WJj2sSgEzmP2P4cnw3xTJ7jybGZ06WXkwvPz0ykXJ++3OJvefWkU3Dxri8N1
 L7i99tsCc0vzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vblank: Don't arm vblank timer with invalid
 frame duration
To: "Roman Ilin" <me@romanilin.is>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702152356.45045-1-me@romanilin.is>
References: <20260613224434.96501-1-me@romanilin.is>
 <20260702152356.45045-1-me@romanilin.is>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:49:56 +0000
Message-Id: <20260702154957.2F96F1F00A3A@smtp.kernel.org>
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
- [High] The patch adds `drm_WARN_ON_ONCE` for overflow checks, allowing un=
privileged userspace to trigger kernel warnings and potential panics via cr=
afted display modes.
- [High] `drm_calc_timestamping_constants()` returns `-EINVAL` early on inv=
alid clock or overflow, but most callers ignore the error, leaving `hwmode`=
 and duration fields in a stale state.

Pre-existing issues:
- [High] Open-coded synchronous timer cancellation in `drm_crtc_vblank_star=
t_timer()` creates an AB-BA deadlock with the timer callback.
--

commit 6d4b57b75f1f23141c8e01d2b53c4658b23ed07f
Author: Roman Ilin <me@romanilin.is>

drm/vblank: Don't arm vblank timer with invalid frame duration

This commit adds validation to drm_calc_timestamping_constants() to check
for INT_MAX overflows with small pixel clocks, returning an error instead
of arming the timer with negative values. It modifies the return type from
void to int and adds an error check in drm_crtc_vblank_start_timer().

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..b6a342e48601a 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
[ ... ]
> @@ -631,43 +631,50 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
[ ... ]
> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> -				     const struct drm_display_mode *mode)
> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> +				    const struct drm_display_mode *mode)
>  {
[ ... ]
> +	if (dotclock <=3D 0) {
> +		drm_err(dev, "crtc %u: Can't calculate constants, dotclock =3D %d!\n",
> +			crtc->base.id, dotclock);
> +		return -EINVAL;
> +	}

[Severity: High]
Could returning early here leave the vblank state stale?

When drm_calc_timestamping_constants() returns early on an invalid clock
or overflow, it now bypasses the updates to vblank->hwmode and duration
fields.

Since existing external callers don't check the new return value:

drm_atomic_helper_calc_timestamping_constants() {
    if (new_crtc_state->enable)
        drm_calc_timestamping_constants(crtc, &new_crtc_state->adjusted_mod=
e);
}

Will they continue using stale hardware state from the previously active
display mode instead of zeroed out values?

> -		/*
> -		 * Convert scanline length in pixels and video
> -		 * dot clock to line duration and frame duration
> -		 * in nanoseconds:
> -		 */
> -		linedur_ns  =3D div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
> -		framedur_ns =3D div_u64((u64) frame_size * 1000000, dotclock);
> +	/*
> +	 * Convert scanline length in pixels and video dot clock to line durati=
on
> +	 * and frame duration in nanoseconds.
> +	 */
> +	linedur_ns  =3D div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
> +	framedur_ns =3D div_u64((u64)frame_size * 1000000, dotclock);
> +
> +	/*
> +	 * Fields of interlaced scanout modes are only half a frame duration.
> +	 */
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		framedur_ns /=3D 2;
> +
> +	if (drm_WARN_ON_ONCE(dev, linedur_ns > INT_MAX) ||
> +	    drm_WARN_ON_ONCE(dev, framedur_ns > INT_MAX))
> +		return -EINVAL;

[Severity: High]
Does adding drm_WARN_ON_ONCE() here allow unprivileged userspace to trigger
kernel warnings?

If a virtualized SPICE agent or X server submits a display mode with a very
small pixel clock and large dimensions via KMS atomic modeset APIs, the
computed framedur_ns can exceed INT_MAX.

Since this is user-triggerable, could it lead to log spam or a kernel panic
if panic_on_warn is enabled?

[ ... ]
> @@ -2221,6 +2231,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *cr=
tc)
[ ... ]
>  	} else {
>  		/*
>  		 * Timer should not be active. If it is, wait for the
>  		 * previous cancel operations to finish.
>  		 */
>  		while (hrtimer_active(&vtimer->timer))
>  			hrtimer_try_to_cancel(&vtimer->timer);

[Severity: High]
This isn't a bug introduced by this patch, but does this open-coded
cancellation loop create a potential AB-BA deadlock?

If drm_vblank_enable() is called, it acquires dev->vblank_time_lock and
calls down to drm_crtc_vblank_start_timer().

If the hrtimer fires concurrently, drm_vblank_timer_function() begins
execution on another CPU and waits to acquire dev->vblank_time_lock via
drm_handle_vblank():

drm_handle_vblank()
   spin_lock(&dev->vblank_time_lock);

Meanwhile, drm_crtc_vblank_start_timer() enters this while loop:

drm_crtc_vblank_start_timer()
   while (hrtimer_active(&vtimer->timer))
       hrtimer_try_to_cancel(&vtimer->timer);

Will this spin loop never terminate because the callback is blocked waiting
for the lock held by the caller?

>  	}
> =20
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	ret =3D drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	if (ret)
> +		return ret;
> =20
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);
>  	vtimer->interval =3D ns_to_ktime(vblank->framedur_ns);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152356.4504=
5-1-me@romanilin.is?part=3D1
