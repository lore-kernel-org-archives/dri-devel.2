Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B1C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49D210E3A0;
	Sat, 12 Sep 2026 17:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UcR+HvvH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DCFB10E3A0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 17:39:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00E2260237;
 Sat, 12 Sep 2026 17:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3411F000FF;
 Sat, 12 Sep 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789234792;
 bh=0Jm2aLCmap94dWbkMc8QQ7NF+qJYhkE4haN7SV7fKeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UcR+HvvHRi/v/YPT5rc8buuT2kXYk45kVn1tiN6yOgt+ip9aFPK6xxAm4EYzSI+dU
 HfkGH4darX15ppIdYXAjyGmjYneD9yMoAq8eV3aEq8y4SLANB/W+ibXoftKpP700Cu
 NZg9KkNMswpJOd7A6D0D1D6GTbPTLbflGKkqLUxEvSN/vBTaE73MX/QCVY9yv7PGzY
 JIXOOyphWoVemLCVWybrp3VQTp7p95/DrICcLed25CZS7PQbeuu5+HNdzgOifnb11Z
 OeYbBXdwDhev3vSSGMcp7+59AaVR14vne9zZkue5Rd2X/iBHWlXs+2kI+Hu7kLE9dK
 oYs9Jsjkyo3Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: replace kmalloc_array with kmalloc_objs
To: "Lalit Shankar Chowdhury" <lalitshankarch@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912172552.70502-1-lalitshankarch@gmail.com>
References: <20260912172552.70502-1-lalitshankarch@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 17:39:52 +0000
Message-Id: <20260912173952.7F3411F000FF@smtp.kernel.org>
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
- [High] Synchronous dma_fence_wait() while holding dma_resv locks.
- [High] High-order kmalloc() driven by unprivileged user without __GFP_NOW=
ARN fallback.
--

commit 80829efff044950d51193562a7bf95d3d15c515b
Author: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>

drm/amdgpu: replace kmalloc_array with kmalloc_objs

Replace the remaining kmalloc_array instances with kmalloc_objs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 743b41db5b7cb..cbdbd8196eb28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
[ ... ]
> @@ -726,13 +725,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_devi=
ce *dev, struct drm_file *fil
>  	struct drm_exec exec;
>  	int i, cnt, r;
> =20
> -	fence_info =3D kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
> -				   GFP_KERNEL);
> +	fence_info =3D kmalloc_objs(*fence_info, wait_info->num_fences);
>  	if (!fence_info)
>  		return -ENOMEM;
> =20
> -	fences =3D kmalloc_array(wait_info->num_fences, sizeof(*fences),
> -			       GFP_KERNEL);
> +	fences =3D kmalloc_objs(*fences, wait_info->num_fences);

[Severity: High]
This isn't a bug introduced by this patch, but could these allocations trig=
ger
a system-wide denial of service if wait_info->num_fences is large?

An unprivileged user can pass a large value for wait_info->num_fences via t=
he
AMDGPU_USERQ_WAIT ioctl. Since this directly drives kmalloc_objs() using
GFP_KERNEL without __GFP_NOWARN, a high-order allocation failure on a
fragmented system could wake kswapd, stall compaction, and spam the kernel
log with massive stack traces.

Should these allocations be converted to use kvmalloc_array() or include
__GFP_NOWARN to prevent userspace abuse?

[Severity: High]
This is a pre-existing issue, but I noticed a potential deadlock later in
this function. Does this code safely wait on fences while holding dma_resv
locks?

Later in amdgpu_userq_wait_return_fence_info(), the driver locks the
user-provided GEM objects and iterates through their fences:

	drm_exec_until_all_locked(&exec) {
		r =3D drm_exec_prepare_array(&exec, gobj_read, ...);
		...
	}

	for (i =3D 0; i < num_read_bo_handles; i++) {
		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
					DMA_RESV_USAGE_READ, fence) {
			r =3D amdgpu_userq_wait_add_fence(wait_info, fences,
							&num_fences, fence);
			if (r)
				goto error_unlock;
		}
	}

If the number of iterated fences exceeds wait_info->num_fences,
amdgpu_userq_wait_add_fence() calls dma_fence_wait(fence, true) synchronous=
ly:

static int amdgpu_userq_wait_add_fence(...) {
	...
	if (*num_fences >=3D wait_info->num_fences)
		return dma_fence_wait(fence, true);
	...
}

Waiting on a dma_fence while holding a dma_resv lock can create a circular
lock dependency, because dma_fence signaling must not wait for dma_resv
locks, but reclaim under a dma_resv lock can wait on a dma_fence. Could this
reachable path from unprivileged userspace trigger a lockdep splat or
deadlock?

>  	if (!fences) {
>  		r =3D -ENOMEM;
>  		goto free_fence_info;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912172552.7050=
2-1-lalitshankarch@gmail.com?part=3D1
