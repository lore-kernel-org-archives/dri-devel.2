Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E19CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667C710E124;
	Wed, 17 Jun 2026 13:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YAuSE/H6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D55910E124
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:15:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06D10404D6;
 Wed, 17 Jun 2026 13:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB21F000E9;
 Wed, 17 Jun 2026 13:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781702105;
 bh=Nqur/hWB6sbgpCBssMAVCBBIF2e9CJ8AHPnJIO9LDl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YAuSE/H6rkWUc3ZCe3aG9ehF3LsYAEBZ8/cgKthfjW7g5NNxa0ZFCdqZFEEgnnf6o
 ffwRifBLTpNlX7s1Qxd2tyjEOGAa7LyDOR0vTVu3CnFyM9LGJ+Xg8yj/UoVFhooxgs
 x/7Iewta7QVNi3iNlydSEWdZdPqHyi14hMW+6O5bAKTlv4uwsF1RdlSbHRzvQVw6+z
 jigRqh/7k7Gq7teExn2qRgvcKqo90Q8RjzFixOELuQmjpVhXu/TJCaR8VUM7QFElSr
 8g5eOi/Oin9gvG11zSrFkacR3wuWXVZA8IwAWotVDMzKiDz/Gcdzj+EsQsb5enZSf2
 qhM3sGdc7X15A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/v3d: bound CPU-job query writes to their
 destination BO
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617125811.3692951-1-michael.bommarito@gmail.com>
References: <20260617125811.3692951-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 13:15:05 +0000
Message-Id: <20260617131505.C0EB21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Medium] Loop variable 'i' declared as signed 'int' causes negative index=
ing and out-of-bounds reads when 'tquery->count' exceeds INT_MAX.

Pre-existing issues:
- [Critical] Uninitialized CPU job structure cleanup causes a NULL pointer =
dereference in `drm_sched_job_cleanup()`.
- [Critical] Cleaning up CPU jobs that have already been pushed to the DRM =
scheduler queue causes severe state corruption and Use-After-Free.
- [High] Memory and WW mutex leaks for INDIRECT_CSD clean_job BO references=
 on intermediate error paths.
- [High] Missing check for vmap() allocation failure leads to NULL pointer =
dereferences in CPU job executors.
- [High] The INDIRECT_CSD CPU job accesses the indirect GEM BO without extr=
acting its implicit dependencies, causing it to race with prior GPU jobs.
- [High] Double vmap() on the same Buffer Object permanently leaks virtual =
memory mappings.
- [High] User-controlled wg_counts integer overflow evaluates to 0, trigger=
ing a WARN_ON and potential Denial of Service.
--

commit 176c9c3615bb9c83354ef76d006e602c0a5318e8
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: drm/v3d: bound CPU-job query writes to their destination BO

The commit adds bounds checking for CPU jobs to ensure that user-supplied
offsets and indices do not result in reads or writes outside their
associated Buffer Objects (BOs), preventing potential out-of-bounds memory
accesses by render-node users.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 1db43c6a078d5..0d3a388fbba57 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> +static int
> +v3d_cpu_job_bounds_check(struct v3d_cpu_job *job)
> +{
> +	struct drm_device *dev =3D &job->base.v3d->drm;
> +	struct v3d_timestamp_query_info *tquery =3D &job->timestamp_query;
> +	struct v3d_copy_query_results_info *copy =3D &job->copy;
> +	u32 elem =3D copy->do_64bit ? sizeof(u64) : sizeof(u32);
> +	struct v3d_bo *dst, *src;
> +	u64 slots, write_size;
> +	int i;
> +
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/*
> +		 * Each query writes one u64 timestamp slot into bo[0]. The
> +		 * offset is cast to u64 so a 0xffffffff query offset cannot wrap
> +		 * the addition past the BO size.
> +		 */
> +		dst =3D to_v3d_bo(job->base.bo[0]);
> +
> +		for (i =3D 0; i < tquery->count; i++) {

[Severity: Medium]
Is it possible for tquery->count to exceed the maximum value of a signed in=
t?
If so, does the counter i wrap around to a negative number, causing an
out-of-bounds read when accessing tquery->queries[i].offset?

> +			if ((u64)tquery->queries[i].offset + sizeof(u64) >
> +			    dst->base.base.size)
> +				goto err_range;
> +		}
> +		return 0;
[ ... ]
> @@ -1346,6 +1478,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,
>  		if (ret)
>  			goto fail;
> =20
> +		ret =3D v3d_cpu_job_bounds_check(cpu_job);
> +		if (ret)
> +			goto fail;
> +

[Severity: High]
This is a pre-existing issue, but does jumping to the fail label here bypass
the fail_unreserve cleanup path?

For INDIRECT_CSD jobs, v3d_setup_csd_jobs_and_bos() dynamically allocates j=
obs
and locks the reservations for clean_job->bo. Does bypassing the
fail_unreserve label permanently leak the WW mutexes and cause deadlocks for
subsequent operations on these BOs?

>  		ret =3D v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
>  		if (ret)
>  			goto fail;

While reviewing this patch, I also noticed a few pre-existing issues in the
surrounding code:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_submit_cpu_ioctl() {
    ...
    if (args->bo_handle_count !=3D cpu_job_bo_handle_count[cpu_job->job_typ=
e]) {
        drm_dbg(dev, "This CPU job was not submitted with the proper number=
 of BOs.\n");
        ret =3D -EINVAL;
        goto fail;
    }
    ...
fail:
    v3d_job_cleanup((void *)cpu_job);
}

[Severity: Critical]
This is a pre-existing issue, but since the error occurs before
v3d_job_init() is called, cpu_job->base.s_fence is NULL. Does the
subsequent call to drm_sched_job_cleanup() unconditionally dereference
job->s_fence->finished.refcount, causing a kernel panic?


drivers/gpu/drm/v3d/v3d_submit.c:v3d_submit_cpu_ioctl() {
    ...
    v3d_push_job(&cpu_job->base);
    ...
    case V3D_CPU_JOB_TYPE_INDIRECT_CSD:
        ret =3D drm_sched_job_add_dependency(&csd_job->base.base,
                                           dma_fence_get(cpu_job->base.done=
_fence));
        if (ret)
            goto fail_unreserve;
    ...
fail_unreserve:
    ...
fail:
    v3d_job_cleanup((void *)cpu_job);
}

[Severity: Critical]
This is a pre-existing issue, but when goto fail_unreserve falls through
to the fail label and calls v3d_job_cleanup(cpu_job), does this corrupt the
state of jobs that have already been armed and pushed to the active DRM
scheduler queue?


drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr() {
    ...
    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP, pg=
prot_writecombine(PAGE_KERNEL));
    ...
}

[Severity: High]
This is a pre-existing issue, but the result of vmap() is assigned directly
to bo->vaddr. If vmap() returns NULL due to memory fragmentation, do CPU
job executors like v3d_rewrite_csd_job_wg_counts_from_indirect() blindly
dereference this NULL pointer?


drivers/gpu/drm/v3d/v3d_submit.c:v3d_get_cpu_indirect_csd_params() {
    ...
    info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);
    ...
}

[Severity: High]
This is a pre-existing issue, but since the indirect BO is not added to
cpu_job->base.bo, it appears to bypass v3d_lock_bo_reservations(). Does this
allow v3d_rewrite_csd_job_wg_counts_from_indirect() to read and modify the =
BO
while a prior GPU dispatch might still be writing to it?


drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
    ...
    v3d_get_bo_vaddr(bo);
    v3d_get_bo_vaddr(indirect);
    ...
}

[Severity: High]
This is a pre-existing issue, but if a user provides the exact same GEM
object handle for both the primary bo and the indirect BO, does the second
vmap() silently overwrite the vaddr pointer from the first, permanently
leaking the prior virtual memory mapping?


drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
    ...
    num_batches =3D DIV_ROUND_UP(indirect_csd->wg_size, 16) * (wg_counts[0]=
 * wg_counts[1] * wg_counts[2]);
    ...
    args->cfg[4] =3D num_batches - 1;
    ...
    WARN_ON(args->cfg[4] =3D=3D ~0);
}

[Severity: High]
This is a pre-existing issue, but since wg_counts are user-supplied 32-bit
unsigned integers, can specific inputs cleanly overflow the product to 0?
Does this underflow args->cfg[4] to 0xFFFFFFFF and trigger the WARN_ON,
potentially crashing systems with panic_on_warn enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617125811.3692=
951-1-michael.bommarito@gmail.com?part=3D1
