Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46769C88E65
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13B510ED69;
	Mon, 14 Sep 2026 11:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="egNb/13C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F93E10ED69
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:11:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C43F0601DB;
 Mon, 14 Sep 2026 11:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300691F00898;
 Mon, 14 Sep 2026 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789384289;
 bh=DX4P1yDSx3Jinn4cf7zxkYLcnN/yGIhblsLbJ9RBrz4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=egNb/13C9boVskP8CndonHGB59H/I/TxNln3HKNPRprOPnjy11SW/hn1HR51tx/XK
 6WXYxy6CnH9lb9FK1hG5ptmYPLJS+XAaIC0hPsztiZhTGAdTMQB9HNHkqtZ1N3Y3AA
 UR5OVyTDE7I3UYA3TvnEipLm0gYtUYVw92aaL9BE7jriSE8bytd2KeG6BRvIWsv1gN
 Hiy/j9qOKwZdvsIOn7ASRA9aqxunvqJcW7moOj8ms7eED9C3Z42sCGP2vJVONPHsYz
 QfsUPi4SogXAoyTCl0pm+XbcWgRf6hBgbw3E+b8aWNw+4WLeU/VCl+h97hu7imUKv8
 iUMzgbGL4CgUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid
 frame duration
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260914110004.211027-1-tzimmermann@suse.de>
References: <20260914110004.211027-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:11:28 +0000
Message-Id: <20260914111129.300691F00898@smtp.kernel.org>
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

Pre-existing issues:
- [High] AB-BA deadlock between synchronous hrtimer cancellation in drm_crt=
c_vblank_start_timer() and drm_handle_vblank() taking vblank_time_lock.
--

commit de00db596b26306bffcd319a867015e9f4b1faa6
Author: Roman Ilin <me@romanilin.is>

drm/vblank: Don't arm vblank timer with invalid frame duration

This commit modifies drm_calc_timestamping_constants() to check for INT_MAX
overflows and returns an error instead of proceeding with invalid frame
durations. It also updates drm_crtc_vblank_start_timer() to propagate this
error, allowing the driver to fall back to immediate vblank events.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..72b543bca9e31 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c

[ ... ]

> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *cr=
tc)
>  	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
>  	struct drm_vblank_crtc_timer *vtimer =3D &vblank->vblank_timer;
>  	unsigned long flags;
> +	int ret;
> =20
>  	if (!vtimer->crtc) {
>  		/*
> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *cr=
tc)
>  			hrtimer_try_to_cancel(&vtimer->timer);

[Severity: High]
This is a pre-existing issue, but can this busy-wait loop cause a hard
deadlock?

When CPU 1 enables vblanks, it holds the vblank_time_lock while executing t=
his
synchronous cancellation loop:

CPU 1:
drm_vblank_enable() {
    spin_lock(&dev->vblank_time_lock);
    __enable_vblank(dev, pipe);
    ...
    drm_crtc_vblank_start_timer(crtc);
    while (hrtimer_active(&vtimer->timer))
        hrtimer_try_to_cancel(&vtimer->timer);

If the timer has just fired concurrently, CPU 2 executes the callback which
attempts to acquire the same lock:

CPU 2:
drm_vblank_timer_function() {
    ...
    drm_handle_vblank(dev, pipe);
    spin_lock(&dev->vblank_time_lock);

This creates an AB-BA deadlock where CPU 1 spins forever waiting for the
callback to finish on CPU 2, while CPU 2 spins forever waiting for CPU 1
to release vblank_time_lock. Is it safe to synchronously cancel the timer
here while holding a lock that the timer's callback also takes?

>  	}
> =20
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	ret =3D drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	if (ret)
> +		return ret;
> =20
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);
>  	vtimer->interval =3D ns_to_ktime(vblank->framedur_ns);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914110004.2110=
27-1-tzimmermann@suse.de?part=3D1
