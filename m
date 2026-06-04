Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4931CD6E55
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014EF1125C4;
	Thu,  4 Jun 2026 02:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="INXEZmTy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE021125C4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:58:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2A88601DD;
 Thu,  4 Jun 2026 02:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426891F00893;
 Thu,  4 Jun 2026 02:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541886;
 bh=b0JFZm/HVxEw+6oIVzBKVhmL8OsLurbh2dJl/F6ysto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=INXEZmTylUJJzFArLg/ewX2zvvK/p4Gaw8aRgiSIQsBJ+PcZFwOD5QcMF+wa4tmiP
 m1BKwQVrZntnq4rZMN9Q/gMjlxB3K322a1Zw89KFSgdynWh4PC4E+FzxrOAO7Iq36j
 QxfKp3mn8CIzeNza6twL1OruAyTkBzOVAet8RGLQ80z3lplRbSu3+DwIym7m3Gp/lX
 ZDD1VLbe1OL9qj4P8RlPFS2ejplxRmHAsfmpdbtfMDuK3enCFwR/PHbp4IWrjr6Jay
 N3u0YzFw3Gv5hF6/5tiLXebPO2r+C2bjlqyaGzRxugl/HOwkS/apnzR/qxnhGy+gvt
 rLDngyl/vJU9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/14] drm/v3d: Refactor CPU ioctl into unified
 submission chain
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-11-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-11-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:58:05 +0000
Message-Id: <20260604025806.426891F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing validation of `drm_gem_object_lookup()` return value l=
eads to a deterministic kernel crash.
- [Critical] Calling `vmap()` on imported PRIME BOs panics the kernel due t=
o a NULL pages array.
- [High] Calling `drm_sched_job_cleanup()` on jobs that have already been p=
ushed to the DRM scheduler causes a use-after-free and corrupts the schedul=
er's internal state.
- [High] Implicit BO fences are only added to the last job in a submission,=
 causing earlier GPU jobs to execute prematurely without waiting for synchr=
onization.
--

commit 572410b6778693137514a8800e2af096467fd0aa
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Refactor CPU ioctl into unified submission chain

Restructure the CPU ioctl so that all job types, including indirect CSD,
use a single struct v3d_submit chain and a single DRM exec context.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 62c23feb8fbba..1df7ab528422a 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1317,90 +1312,51 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void=
 *data,
[ ... ]
> +	/* Look up the CPU jobs' BOs before v3d_setup_csd_jobs_and_bos() appends
> +	 * the CSD and clean jobs in the case of indirect CSD job.
> +	 */
>  	if (args->bo_handle_count) {
>  		ret =3D v3d_lookup_bos(&submit, args->bo_handles, args->bo_handle_coun=
t);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like BOs might be
attached exclusively to the last job in the submission.

v3d_lookup_bos() assigns the user-provided BO array and bo_count to
submit->jobs[submit->job_count - 1]. Later, v3d_submit_lock_reservations()
iterates over the jobs and calls drm_sched_job_add_implicit_dependencies()
only for jobs with bo_count > 0.

Consequently, earlier jobs in the submission, such as the BIN job in a CL
submission or the CSD job in an indirect CSD submission, receive no
implicit dependencies for the BOs they access. Could this allow them to be
scheduled and executed immediately, racing with other processes or queues
currently writing to those BOs on the GPU?

[Severity: Critical]
This is a pre-existing issue, but I am wondering if mapping these BOs prope=
rly
handles imported PRIME BOs.

v3d_get_bo_vaddr() maps GEM objects into kernel space by calling
vmap(obj->pages, ...). However, for PRIME BOs imported via
v3d_prime_import_sg_table(), the drm_gem_shmem backend does not populate the
obj->pages array.

By bypassing the drm_gem_shmem_vmap() helper and directly accessing obj->pa=
ges,
v3d_get_bo_vaddr() passes NULL as the pages array to vmap(). Can a local
user trigger a kernel panic by importing a DMA-buf, passing it as a buffer =
to
a CPU job, and causing v3d_get_bo_vaddr() to crash?

>  		if (ret)
>  			goto fail;
[ ... ]
> +	if (cpu_job->job_type =3D=3D V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
> +		ret =3D v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.arg=
s,
> +						 NULL);

[Severity: Critical]
This is a pre-existing issue, but shouldn't the return value of
drm_gem_object_lookup() be validated when processing the indirect CSD param=
s?

In v3d_get_cpu_indirect_csd_params(), drm_gem_object_lookup() is called
with a user-provided handle and the return value is assigned directly to
info->indirect without checking for NULL.

If userspace passes an invalid handle, NULL is stored. Later, when the CPU =
job
executes, v3d_rewrite_csd_job_wg_counts_from_indirect() calls
v3d_get_bo_vaddr(to_v3d_bo(indirect_csd->indirect)).=20

Would this pass a NULL pointer to v3d_get_bo_vaddr(), which unconditionally
accesses obj->pages, resulting in a deterministic kernel panic?

[ ... ]
> +	ret =3D v3d_submit_jobs(&submit, 0, &se);
> +	if (ret)
> +		goto fail_unreserve;
> =20
>  	return 0;
> =20
>  fail_unreserve:
>  	v3d_submit_unlock_reservations(&submit);
>  fail:
>  	v3d_submit_cleanup_jobs(&submit);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
v3d_submit_cleanup_jobs() here clean up jobs that have already been pushed?

In v3d_submit_jobs(), jobs are pushed to the DRM scheduler via v3d_push_job=
().
If a subsequent call to drm_sched_job_add_dependency() fails for a later job
in the submission chain, the function returns an error without unwinding the
already-pushed jobs.

The caller then branches to this error path that invokes
v3d_submit_cleanup_jobs(), which iterates over all jobs and calls
v3d_job_cleanup() -> drm_sched_job_cleanup().

Calling drm_sched_job_cleanup() on a job that the scheduler already owns
violates the scheduler API contract. It sets job->s_fence =3D NULL and dest=
roys
the dependencies XArray while the scheduler thread might be executing the j=
ob.
Can this lead to a NULL pointer dereference and memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D11
