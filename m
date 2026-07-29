Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02056C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEFA10E61F;
	Wed, 29 Jul 2026 03:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GQNOqehw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBA210E61F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:08:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 598A260A5E;
 Wed, 29 Jul 2026 03:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E521F000E9;
 Wed, 29 Jul 2026 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294495;
 bh=foXlVr31BPqKNCZ6KVN8PyGdmY6MiEqDP5tE3seohdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GQNOqehwxzgt43/93Qe3jIkF3NYzibX6BjwgFxiTMpgWuey4P0KVknfSFbmsZbkFv
 ZmIRRKzcrRZl+qr2S5wsKYJBxIexBlfvEsA6EuHFmIb2al3QNIuxCntbfQknPFFPeg
 F8wL5QIV7GQosyj0v0RYlu0PtZxqbLRKDHZR1gwGSXaHMGy+NnF6MKkBwMOBDEKHEg
 MMrHw9Xco0cGtgCmQzKvSLcQxjWL5Q8BL0jLJ00PzHFUnxEQgGrPcBnTFb/0kozVih
 ociSCMLDqscRJaOEpKgH2zNPll47ym9iVhofswFecIt1ETmuVxVw1myZemG15SXVGx
 +HcoDSOmhYS2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/13] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-13-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-13-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:08:14 +0000
Message-Id: <20260729030814.E4E521F000E9@smtp.kernel.org>
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
- [Critical] The error path in `panfrost_perfcnt_enable_locked` incorrectly=
 sets `perfcnt->user =3D user` instead of `NULL`, leading to a corrupt stat=
e and Use-After-Free.
- [Medium] Hardware reset notification is permanently lost if the ioctl wai=
t is interrupted by a signal.
--

--- Patch [13]: [PATCH v4 13/13] drm/panfrost: Bump driver minor to reflect=
 new DUMP IOCTL req field ---
commit 33e476c0f2af99299bbeb687048c33539616ce05
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit fixes races between the reset sequence and perfcnt session
teardown. It uses a read/write semaphore to serialize access to the
hardware during resets and updates the DRM uAPI to notify userspace of
resets during a perfcnt DUMP operation.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ad1156678e91c..b92ad90618931 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
> @@ -55,38 +59,97 @@ void panfrost_perfcnt_sample_done(struct panfrost_dev=
ice *pfdev)
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
>  }
> =20
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> +					u64 *reset_happened)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	u64 retries =3D PERFCNT_DUMP_MAX_RETRIES;
>  	int ret;
> =20
> -	reinit_completion(&pfdev->perfcnt->dump_comp);
> -	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_INT_CLEAR,
> -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +dump_retry:
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*reset_happened =3D perfcnt->reset_happened;
> +		perfcnt->reset_happened =3D false;

[Severity: Medium]
Does this code permanently lose the hardware reset notification if the ioctl
wait is interrupted by a signal?

Since the internal state is cleared prior to the interruptible wait and not
restored on the -ERESTARTSYS error path, could a restarted syscall overwrite
req->hw_reset with the cleared value, causing userspace to accumulate
counters that were actually reset?

> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
[ ... ]
> @@ -127,60 +192,46 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
[ ... ]
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
> =20
> -	perfcnt->user =3D user;
> -
>  	return 0;
> =20
>  err_vunmap:
> +	scoped_guard(rwsem_read, &pfdev->reset.lock)
> +		perfcnt->user =3D user;

[Severity: Critical]
Is it possible this error path incorrectly reassigns perfcnt->user to user
instead of setting it to NULL?

If panfrost_perfcnt_hw_enable() fails (e.g. when panfrost_mmu_as_get fails
because address spaces are exhausted), could this leave perfcnt->user set
while the backing resources are freed, possibly leading to a use-after-free
on subsequent ioctls?

>  	drm_gem_vunmap(&bo->base, &map);
>  err_put_mapping:
>  	panfrost_gem_mapping_put(perfcnt->mapping);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D13
