Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11857C54F54
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321A410EA65;
	Wed, 29 Jul 2026 03:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="miE1hmTM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E0410EA65
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:06:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F26840F20;
 Wed, 29 Jul 2026 03:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63E91F000E9;
 Wed, 29 Jul 2026 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294398;
 bh=/gY6zD/O7YiTUOIVvqRCXf1YHCSOn/g8/KXUW0tUAEY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=miE1hmTM022Vwy389nwboOuweHQBxqHatAxBFZIKavtH4vrMm4wVYjQEs9Vxv0KfN
 0NFNbs/eQ6itHMoYLnw9+dBx42o27c16hheWF6WrKp//s2W4eeLW/IT0cpCXDv/CW8
 clvSMOj/vBJ9jzv/UKD2Sf7aoiAoRy3xCUKth+Z0u+J2+0j4JnzYQSgwAz+hKznJuy
 QtPwVbVKsBgJVcFBWXpC8uzcXXzQTgOUevWYrbLbOcyDa4xjovES4vz910C5DiyZf5
 g6i2wx7L4QQ3pS50BUmoDbBeHoY09YTBdHvWIHe0LnAAulBXIzQL+J9eulvRg9RroD
 0vFdRBd0gQNSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-12-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-12-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:06:37 +0000
Message-Id: <20260729030637.E63E91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] The error path in `panfrost_perfcnt_enable_locked` incorrectly=
 assigns `perfcnt->user =3D user` instead of clearing it, leading to a dang=
ling session state and severe Use-After-Free vulnerabilities.
- [High] In `panfrost_perfcnt_disable_locked`, the MMU Address Space (AS) i=
s released before the GPU performance counters are disabled.
- [High] The loop counter `retries` in `panfrost_perfcnt_dump_locked` is ty=
ped as an unsigned 64-bit integer, making the loop condition `--retries >=
=3D 0` always true.
- [High] `panfrost_perfcnt_postreset()` ignores the return value of `panfro=
st_perfcnt_hw_enable()`, leading to Address Space (AS) reference count unde=
rflows and unconfigured hardware.
- [Medium] Clearing `perfcnt->reset_happened` before an interruptible wait =
in `panfrost_perfcnt_dump_locked` causes reset notifications to be lost if =
the wait is interrupted.
--

--- Patch [12]: [PATCH v4 12/13] drm/panfrost: Fix races between perfcnt an=
d reset sequence ---
commit 33e476c0f2af99299bbeb687048c33539616ce05
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix races between perfcnt and reset sequence

This commit uses the reset r/w semaphore to govern hardware access during=20
resets. It expands the DRM uAPI for the perfcnt DUMP operation to notify
userspace if a reset occurred, and reestablishes perfcnt to its original
configuration post-reset.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ad1156678e91c..b92ad90618931 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
[ ... ]
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
Could clearing perfcnt->reset_happened before the wait cause lost
notifications?

If wait_for_completion_interruptible_timeout() is interrupted by a signal, =
it
returns a negative error code (like -ERESTARTSYS). The ioctl will fail and
skip copying the hw_reset state to userspace.

When the kernel transparently restarts the syscall, the flag has already be=
en
cleared here. Does this result in userspace successfully getting a dump but
missing the reset notification, leading to invalid performance counter delt=
as?

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
> -	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (ret > 0) {
> +			if (perfcnt->reset_happened) {
> +				if (--retries >=3D 0)

[Severity: High]
Can this loop condition ever be false?

Since retries is declared as an unsigned u64 at the top of the function,
decrementing it past zero wraps around to ULLONG_MAX, which is always >=3D =
0.

If a hardware reset is continually detected (for example, a workload
repeatedly hanging the GPU), does this trap the ioctl in an infinite loop
instead of gracefully returning -EBUSY?

> +					goto dump_retry;
> +				else
> +					ret =3D -EBUSY;
> +			} else {
> +				ret =3D 0;
> +			}
> +		} else if (!ret) {
> +			ret =3D -ETIMEDOUT;
> +		}
> +	}
> =20
>  	return ret;
>  }
[ ... ]
>  static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  					  struct drm_file *file_priv,
>  					  unsigned int counterset)
>  {
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
Is this intended to assign 'user', or should it clear the user pointer?

If a failure occurs (such as in panfrost_perfcnt_hw_enable()), the error
path jumps to err_vunmap where it unmaps the buffers and frees the mappings=
.=20

By assigning perfcnt->user =3D user here instead of NULL, the user pointer
remains valid while the underlying resources are freed. Can a subsequent ca=
ll
to disable or dump the counters by the same user bypass the active session
check and trigger a use-after-free on the freed memory?

>  	drm_gem_vunmap(&bo->base, &map);
>  err_put_mapping:
>  	panfrost_gem_mapping_put(perfcnt->mapping);
> @@ -203,13 +254,15 @@ static int panfrost_perfcnt_disable_locked(struct p=
anfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	panfrost_perfcnt_gpu_disable(pfdev);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +		panfrost_perfcnt_gpu_disable(pfdev);

[Severity: High]
Is it safe to release the Address Space (AS) before disabling the hardware
that uses it?

By calling panfrost_mmu_as_put() first, the AS reference count drops and it
becomes immediately available for reallocation to another concurrent contex=
t.

However, the performance counters are still actively configured to write to
this AS index until panfrost_perfcnt_gpu_disable() executes. Does this crea=
te
a race window where performance counters emit data into a repurposed address
space, potentially causing memory corruption or page faults?

> +		perfcnt->user =3D NULL;
> +	}
> =20
> -	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf =3D NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
[ ... ]
> +void panfrost_perfcnt_postreset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +
> +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> +		return;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +
> +	if (!perfcnt->user)
> +		return;
> +
> +	panfrost_perfcnt_hw_enable(pfdev);

[Severity: High]
Should we check the return value of panfrost_perfcnt_hw_enable() here?

During a GPU reset, all Address Spaces are reset and their reference counts
zeroed. If panfrost_perfcnt_hw_enable() fails (for example, if no AS is
available and panfrost_mmu_as_get returns -EBUSY), the hardware remains
unconfigured and the AS reference count is not incremented.

Since this failure is silently discarded, when the session is eventually
disabled, panfrost_perfcnt_disable_locked() will unconditionally call
panfrost_mmu_as_put(). Will this decrement the AS count below zero,
triggering a warning and corrupting the MMU AS tracking logic?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D12
