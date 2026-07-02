Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7209C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151C810F554;
	Thu,  2 Jul 2026 18:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UfpRJ7wc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1751A10F554
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:23:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A5A1601CA;
 Thu,  2 Jul 2026 18:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E541F000E9;
 Thu,  2 Jul 2026 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783016585;
 bh=hQPGTBO7BbHvPwkGXu3jmxAP0JkMtpnzCEyh7M3dW+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UfpRJ7wcJUUJe+AvjFFgEQDa3Ra1nVg/wvzi30SuxQsj24btQgIfLnqO1cHtWF3O3
 RO5x2Q5j6aQDze0XoY7BQ9kVMUrADnUu4hBgOWbG5PphBREi4u3MchXjtc5PPUxBlc
 bXzFL5pEKj70kDfQRM0FnMD5g4ZHLIHYPVuGDoLx20ziYxWcbzYcDCw9ERhS6wBJhC
 WhTmd9xiz52en+deNCBp38TNv+I0QBnaMA5mViEEILzR8cmRKsdBLdIOqa7twmNDG9
 1pGU02WOz0kjbFO5lh/JqApw/kQOIhImJDNohc4qZQADDgzAzBg4azVtUGaBUIAwlj
 pxemaz8ddIdJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/vblank: Don't arm vblank timer with invalid
 frame duration
To: "Roman Ilin" <me@romanilin.is>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702181027.98526-1-me@romanilin.is>
References: <20260613224434.96501-1-me@romanilin.is>
 <20260702181027.98526-1-me@romanilin.is>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:23:04 +0000
Message-Id: <20260702182305.04E541F000E9@smtp.kernel.org>
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
- [Critical] drm_crtc_vblank_start_timer() deadlocks when synchronously spi=
nning on hrtimer cancellation if the timer callback is concurrently running.
--

commit ea5cbfbf25c3ea02070a1ec1d83634d5505e475b
Author: Roman Ilin <me@romanilin.is>

drm/vblank: Don't arm vblank timer with invalid frame duration

This commit fixes a bug where an extremely small pixel clock results in a
computed frame duration that wraps to a negative value, causing the vblank
hrtimer to fail and stall pending page flips. It updates the calculation to
use u64 and adds overflow checks, returning an error to fall back to
immediate vblank events.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..629b9fcc7a52d 100644
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
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but does this busy-wait loop
cause a deadlock if the timer callback is running concurrently?

When drm_vblank_enable() is called, it takes dev->vblank_time_lock before
calling down to __enable_vblank(), which eventually calls
drm_crtc_vblank_start_timer().

If the timer fires on another CPU at this exact moment, this loop will spin
indefinitely waiting for the callback to finish. However, the timer callback
executes drm_handle_vblank(), which tries to acquire dev->vblank_time_lock:

drm_vblank_timer_function() -> drm_handle_vblank() {
    ...
    spin_lock(&dev->vblank_time_lock);
}

Could this result in a deadlock between the spinning thread holding
vblank_time_lock and the timer callback trying to acquire it?

> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	ret =3D drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	if (ret)
> +		return ret;
> =20
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181027.9852=
6-1-me@romanilin.is?part=3D1
