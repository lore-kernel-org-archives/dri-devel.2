Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D45CD6E55
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C001125B9;
	Thu,  4 Jun 2026 02:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZlktMWAh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0015E1125B9
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:53:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49D07601DD;
 Thu,  4 Jun 2026 02:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0B31F00893;
 Thu,  4 Jun 2026 02:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541589;
 bh=LpW9F0QsoKF4xghBdJcZ+2WeikeE1dM68qKjuf6fs0c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZlktMWAhf+lLTPAVgYPEoQDinTGNwXLo9obLfWYpL9aSlV/9pROwYUwqe+eURAFDD
 FQNn0d5bQ+CgP/UAkhD66uam+5snsQMrwKSwsgLZnvfq69xj8TWWl/g3y7hPkjb4jF
 WVq2w7RdWGHcVAgVcJOwchPUdsO8EFarfKiFRCJvv4dwPTOCgQp4Sm8PKE5vlFsCdm
 Zfqi10gWjN4AqRaGNTpEAKGANB/S9muTvJxvGR8Bs65AWjPu5yR0gC/krPsSrCZdMv
 kPmFnIgHJyuMYkHbrPxbAvVo2jNuUpaN9/zcp3VB0gTkQJ6ACM5sa5rXz3kzEoKnYS
 ZcXpN2ul41D4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/14] drm/v3d: Make
 v3d_get_cpu_indirect_csd_params() a pure parser
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-9-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-9-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:53:08 +0000
Message-Id: <20260604025308.CC0B31F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Error path cleans up DRM scheduler jobs that have already been=
 pushed, causing Use-After-Free and scheduler corruption.
- [Critical] Uninitialized locking context is passed to fini on the success=
 path for CPU jobs without BOs, leading to a kernel panic.
- [High] BO reservation locks acquired for `clean_job` are leaked if subseq=
uent validation fails.
- [High] Userspace can trigger a kernel deadlock by specifying the same BO =
handle in both the CPU job and the CSD job.
- [High] GFP_KERNEL allocation while holding dma_resv locks causes an AB-BA=
 deadlock with memory reclaim.
--

commit e7875ac22f6ebc1c0172f365953ce0df35e9465b
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser

This commit modifies v3d_get_cpu_indirect_csd_params() to only parse the
indirect CSD extension and stash the arguments. The creation of CSD and
clean jobs, along with their BO locking, is moved into
v3d_submit_cpu_ioctl() to prepare for the unified submission chain.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index fcaf3a6cfddc6..64eba912dc646 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> @@ -1404,6 +1403,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,
>  		goto fail;
>  	}
> =20
> +	if (cpu_job->job_type =3D=3D V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
> +		ret =3D v3d_setup_csd_jobs_and_bos(file_priv, v3d,
> +						 &cpu_job->indirect_csd.args,
> +						 &cpu_job->indirect_csd.job,
> +						 &cpu_job->indirect_csd.clean_job,
> +						 NULL,
> +						 &cpu_job->indirect_csd.exec);
> +		if (ret)
> +			goto fail;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this create a lock leak
on error paths?

If v3d_setup_csd_jobs_and_bos() successfully locks BO reservations using
cpu_job->indirect_csd.exec, and later in v3d_submit_cpu_ioctl() a failure
occurs (for example, in v3d_lookup_bos() or v3d_lock_bo_reservations()),
the error handling jumps to fail:

v3d_submit_cpu_ioctl() {
    ...
    if (ret)
        goto fail;
    ...
}

This appears to bypass the fail_unreserve: label, leaving the ww_mutex and
dma_resv locks permanently held. Could this cause subsequent GPU operations
attempting to use these BOs to stall indefinitely?

[Severity: High]
This is a pre-existing issue, but could this lead to a deadlock if userspace
specifies the same BO handle in both the CPU job and the CSD job?

When v3d_submit_cpu_ioctl() uses two separate locking contexts in the same
thread, the first context acquires the WW mutexes for the CSD job's BOs:

    ret =3D v3d_setup_csd_jobs_and_bos(..., &cpu_job->indirect_csd.exec);

The second locking context then attempts to acquire WW mutexes for the CPU
job's BOs:

    ret =3D v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);

If the same BO is specified in both jobs, would the second context (younger
transaction) block indefinitely attempting to acquire a WW mutex already he=
ld
by the first context, leading to an unrecoverable self-deadlock?

[Severity: Critical]
This is a pre-existing issue, but is it safe to clean up DRM scheduler jobs
that have already been pushed?

In v3d_submit_cpu_ioctl(), once jobs are pushed to the DRM scheduler via
v3d_push_job(), the scheduler takes ownership of their lifecycle.

If a subsequent operation fails:

    ret =3D drm_sched_job_add_dependency(&clean_job->base, ...);
    if (ret)
        goto fail_unreserve;

The error path jumps to fail_unreserve: and then fail:, calling
v3d_job_cleanup() on the already-pushed jobs.

Does calling drm_sched_job_cleanup() on a pushed job destroy its s_fence and
dependencies xarray while the background scheduler thread might still be
accessing them, potentially causing a use-after-free and scheduler state
corruption?

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for an
uninitialized locking context to be passed to the cleanup functions?

In v3d_submit_cpu_ioctl(), the local locking context is bypassed if the CPU
job has no BOs:

    if (args->bo_handle_count) {
        ...
        ret =3D v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
    }

The function then proceeds to the success path and calls:

    drm_gem_unlock_reservations(job->bo, job->bo_count, acquire_ctx);

Could this result in passing uninitialized stack memory to drm_exec_fini() =
or
ww_acquire_fini(), causing the cleanup function to dereference and free
garbage pointers?

[Severity: High]
This is a pre-existing issue, but does this allocation trigger an AB-BA
deadlock with memory reclaim?

In v3d_submit_cpu_ioctl(), dependencies are added while BOs are locked:

    ret =3D drm_sched_job_add_dependency(&csd_job->base.base,
                                       dma_fence_get(cpu_job->base.done_fen=
ce));

This internally uses xa_alloc() with the GFP_KERNEL flag while the thread
holds dma_resv locks acquired by v3d_lock_bo_reservations().

If system memory is tight, could the memory allocator trigger the shrinker,
which would attempt to evict GEM objects and acquire dma_resv locks, leading
to a deadlock?

>  	clean_job =3D cpu_job->indirect_csd.clean_job;
>  	csd_job =3D cpu_job->indirect_csd.job;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D9
