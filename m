Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114CDC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D68010EAA5;
	Wed, 29 Jul 2026 06:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ohr5o9DD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766DF10EAA5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:34:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1BD860A61;
 Wed, 29 Jul 2026 06:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B61F000E9;
 Wed, 29 Jul 2026 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785306871;
 bh=REbYZDKk9Tlp9gekluscvyYnusT6uZK/5tkBQ/7cuOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ohr5o9DDlsM5tEjj19E5v/pTmxKwo/psgc4OR/oVE7/h3rvMq5qkCKDleqrLxlJbg
 0+oSAEhLKsrETqGUY2ln4cdBUfH/F1Im75gKjjlfJ/v7mJpIp3hMrNerpJykIzr/xS
 IXs9cEjPcac+Ri46CNoM+oyYKkzcXO7mZ7xfJWdPl4e2LAC0KiD+nkD7Eq+yFgsCXH
 2ZTdWXQWNt++k1Xn5uO5jVul7UYQKwg6BYBqEgJrklo/vRYG8wDH70MVydtnmo4yaG
 umK6WHT4V+6WSCXLHkeLWSVR7zAHofjMxucTzvSNrvcz0IAMYsf3Pz8BTx90MgANR/
 mrG4zPWkAiLxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-panthor-cache-flush-fix-v1-2-205921ed3c81@collabora.com>
References: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
 <20260729-panthor-cache-flush-fix-v1-2-205921ed3c81@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:34:30 +0000
Message-Id: <20260729063431.363B61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The timeout fallback logic creates a TOCTOU race with the threaded=
 IRQ handler, potentially causing subsequent requests to falsely succeed im=
mediately.
- [High] If a soft reset actually times out in hardware, the pending flag i=
s never cleared, permanently breaking all future soft reset attempts.
--

--- Patch [2]: [PATCH 2/3] drm/panthor: Revisit reqs_lock handling in flush=
/reset paths ---
commit 179344ff59dcf475c58ff1e22983a6fa7e1203f4
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/panthor: Revisit reqs_lock handling in flush/reset paths

This patch revisits the handling of the reqs_lock in the panthor driver's
flush and reset paths. It switches from using spin_lock_irqsave() around a
wait_event_timeout() block to using wait_event_lock_timeout() with standard
spinlocks. This ensures the pending_reqs register is read and updated under
the lock without unnecessarily disabling interrupts.

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index c013d6bf9a599..f015bde80abf0 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
[ ... ]
> @@ -330,35 +330,34 @@ int panthor_gpu_flush_caches(struct panthor_device =
*ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
[ ... ]
> -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> -				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +				ptdev->gpu->reqs_lock, msecs_to_jiffies(100))) {
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) !=3D 0=
 &&
>  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COM=
PLETED))
>  			ret =3D -ETIMEDOUT;
>  		else
>  			ptdev->gpu->pending_reqs &=3D ~GPU_IRQ_CLEAN_CACHES_COMPLETED;

[Severity: High]
This isn't a bug introduced by this patch, but does this timeout fallback=20
logic create a race condition with the threaded IRQ handler?

If the timeout occurs because the threaded IRQ handler was delayed (e.g. by
high CPU load), the fallback path clears the pending_reqs flag based on=20
INT_RAWSTAT, but it doesn't clear the physical interrupt via INT_CLEAR.

When the threaded IRQ handler eventually runs, won't it read the pending
interrupt and clear pending_reqs again? If a subsequent request was submitt=
ed
in the meantime, could its pending flag be spuriously cleared, causing its
wait to falsely succeed immediately?

> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}
> +	spin_unlock(&ptdev->gpu->reqs_lock);
> =20
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
[ ... ]
> @@ -378,27 +377,25 @@ int panthor_gpu_soft_reset(struct panthor_device *p=
tdev)
>  {
[ ... ]
> -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
> +				ptdev->gpu->reqs_lock,
>  				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) !=3D 0 &&
>  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
>  			timedout =3D true;
>  		else
>  			ptdev->gpu->pending_reqs &=3D ~GPU_IRQ_RESET_COMPLETED;

[Severity: High]
This is the same pre-existing race condition as in panthor_gpu_flush_caches=
(),
where clearing the pending flag without clearing the hardware interrupt cou=
ld
allow a subsequent soft reset to succeed spuriously.

> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}
> =20
>  	if (timedout) {

[Severity: High]
This is a pre-existing issue, but if a soft reset actually times out in
hardware and timedout is set to true, does this early return bypass
clearing GPU_IRQ_RESET_COMPLETED from pending_reqs?

Looking at the end of panthor_gpu_soft_reset(), there is a
ptdev->gpu->pending_reqs =3D 0; after the timeout check. If we return early
here via return -ETIMEDOUT, the pending flag is left set.

Would any subsequent calls to panthor_gpu_soft_reset() hit the drm_WARN_ON
check at the start of the function, skip issuing the hardware command, and
permanently fail with a timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-panthor-ca=
che-flush-fix-v1-0-205921ed3c81@collabora.com?part=3D2
