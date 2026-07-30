Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55857C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A03F10E148;
	Thu, 30 Jul 2026 12:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CTIHyGXp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDE410E148
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:02:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD0AF43D4B;
 Thu, 30 Jul 2026 12:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5F1F00A3E;
 Thu, 30 Jul 2026 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785412949;
 bh=niREjF1u/hSp4TP75lpF0JJ1AMPUXJEjC/Upxr9OQv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CTIHyGXpARs7FpI5v0W9QYu2pBwy+Cjb22Fb+g5UfgqT2TPzkAfGI7C1I4Nw+d/lN
 +uT43dVdA3ymB6tqWKPWNf6racZ6i2Vd1xkqEPT9O7nTLyg2Ghh3G/sVkYVm/RvtCa
 J+CmzWdSXUWVtY64GeDAViU4GZdTtuPQQUouA16WC4yFglIcK9ouYTYf9+/t8pov8O
 qkYL6wiX205YvGJpUxmwlmA6bR8LzQVmWEkqlEAGFJZme29j0gtpiOkP3suLkhFEYg
 lH5QuELDz3NvnH/aGv90Ftp0TYPMkk8rw+/HhmGjSRJ6mLUnG2swvPPSDEDmHbmE66
 zNe2TzvcMpn3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:02:29 +0000
Message-Id: <20260730120229.9EC5F1F00A3E@smtp.kernel.org>
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
- [High] Race condition between the threaded IRQ handler and the wait timeo=
ut logic causes spurious GPU resets.
--

--- Patch [2]: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in fl=
ush/reset paths ---
commit ec14154f1ff35bca85396f0f6f71d7d7b1d6eb6d
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/panthor: Revisit reqs_lock handling in flush/reset paths

The patch updates the handling of reqs_lock in panthor_gpu_flush_caches() a=
nd
panthor_gpu_soft_reset(). It replaces wait_event_timeout() with
wait_event_lock_timeout(), and uses spin_lock() instead of spin_lock_irqsav=
e()
since the lock is not acquired in an atomic context.

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index e52c5675981f5..cd591c17198be 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -329,35 +329,34 @@ int panthor_gpu_flush_caches(struct panthor_device =
*ptdev,

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

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition he=
re
with the threaded IRQ handler?

If panthor_gpu_irq_handler() clears the hardware interrupt status via
INT_CLEAR before acquiring reqs_lock, it can be preempted:

    gpu_write(gpu->irq.iomem, INT_CLEAR, status);
   =20
    // ... preemptible window ...
   =20
    spin_lock(&ptdev->gpu->reqs_lock);
    if (status & ptdev->gpu->pending_reqs) {

If the 100ms timeout expires during this precise window, the fallback condi=
tion
above evaluates under reqs_lock.

It finds that pending_reqs still indicates the request is pending, but
checking INT_RAWSTAT shows the interrupt is not pending (because it was just
cleared by the preempted thread).=20

Could this cause the wait logic to falsely conclude the hardware timed out,
return -ETIMEDOUT, and schedule a spurious full GPU reset?

[ ... ]

> @@ -377,27 +376,25 @@ int panthor_gpu_soft_reset(struct panthor_device *p=
tdev)

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

[Severity: High]
This is a pre-existing issue, but does this suffer from the same race condi=
tion
with the threaded IRQ handler as the flush caches timeout logic above?

>  		else
>  			ptdev->gpu->pending_reqs &=3D ~GPU_IRQ_RESET_COMPLETED;
> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-panthor-ca=
che-flush-fix-v2-0-28790478bfff@collabora.com?part=3D2
