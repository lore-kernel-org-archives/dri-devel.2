Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8880C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B7810E728;
	Sat, 11 Jul 2026 03:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vo4zNqlM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7DC10E728
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:23:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D061160051;
 Sat, 11 Jul 2026 03:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE991F000E9;
 Sat, 11 Jul 2026 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740192;
 bh=2NAdVXz72Tw7k2ZTcGCQKBu8w/8hPzDUv32/vbYGBho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vo4zNqlMPCB/IHlntiaCAMvmqXw+QnALZioWY9tYyZqP8grGrap6H4rnonkOxjsf4
 AGdfX+cW+SiygYi5dEbqYTspSh8DJo0OKvM/efBy9FG0pAUGWk2nF16V6Jjoj7ZLHt
 3aXi1V0RUiBrMXZbhW841AcW+Nigwa/+afIrthatvTigdOo+TAACuBBrd66w4O9vgS
 1KGkA2VdsJG4fwfr4hmnyHIchuYvEU7JR5un0EQbVT9CLvg8n0oqmlczN3webuCpOs
 G8AwpiRXNtVOXmpmoSbZT1di/yd+y0I3zp9NmvvVRrrnPzkQb80yS0zqIMsp4nhlqj
 nXdQVtWh+fKng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 26/33] drm/xe: Add tracepoint for xe_gem_create_ioctl
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-27-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-27-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:23:11 +0000
Message-Id: <20260711032312.5CE991F000E9@smtp.kernel.org>
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
- [Medium] Tracepoint metric lock_ns incorrectly includes lock-dropped back=
off sleep time due to WW mutex contention retries.
--

--- Patch [26]: [PATCH v3 26/33] drm/xe: Add tracepoint for xe_gem_create_i=
octl ---
commit 08fb65ed7bb6e79b15efc1ef9667995aaebd39fe
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add tracepoint for xe_gem_create_ioctl

This commit adds a tracepoint to profile GEM creation in the xe driver.
It records the BO size, placement, CPU caching, ASID, total IOCTL
duration, and the time spent under the dma-resv lock to help evaluate
out-of-lock preallocation performance.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index a646a72122d40..caf5aa0bab533 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -4100,6 +4105,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, vo=
id *data,
>  			if (err)
>  				break;
>  		}
> +
> +		if (lock_start =3D=3D ktime_set(0, 0))
> +			lock_start =3D ktime_get();
> +

[Severity: Medium]
Will this lock_start timestamp incorrectly include lock-dropped backoff
sleep time when a WW mutex contention retry occurs?

When contention happens, drm_exec_cleanup() drops all locks and the next
iteration might sleep in dma_resv_lock_slow_interruptible() without holding
any dma-resv locks. Because of the zero-check guard here, lock_start is
retained from the first iteration.

Could this cause the lock_ns metric to encapsulate the unbounded lock-dropp=
ed
sleep time and corrupt the intended profiling metric? If vm !=3D NULL, remo=
ving
this zero-check would exclude the sleep (which happens early in
xe_vm_drm_exec_lock). However, if vm =3D=3D NULL, the sleep occurs inside
xe_bo_create_user(), so does this require capturing the start time inside
the locking functions or accumulating the actual duration per iteration?

>  		bo =3D xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
>  				       bo_flags, have_prealloc ? &prealloc : NULL,
>  				       &exec);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D26
