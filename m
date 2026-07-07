Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD54EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF5310E520;
	Tue,  7 Jul 2026 22:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IlL21TZ9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5395810E520
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:55:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F54C60008;
 Tue,  7 Jul 2026 22:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DC1F000E9;
 Tue,  7 Jul 2026 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783464899;
 bh=drxehSaTCeobpGzGWd+CDquNB3QWbOTqJy4KuB3O+oI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IlL21TZ9oDG/yi9/pchPYrngSPMVPg8FgdlCXSCyAFX3ZRyaLTSsV/y0RFRSwunsh
 X0CoGQKn+nTkXuFZMLo4Y2pvH8o+DVNPcPCYI7ww8DARBGN0kPuNOByPJ9W2qNWnhg
 gAKZ3VNkxpyVcFWhmcX/9auoTDhMPcdG7/8tH+PVBGKixx1WtbiaqzbdzQJgLd1mUR
 6pF5c3ktvIAiIltz+CWGzz9AQreVTuhjcUjJq0+uDutk6u3w5CNTrG0wM/6nfZ/gK5
 uRJ9EtCvq4L1q4vwg6qEC5SAF6P2mlfjdxonTROMq9c4duhHk8tptYvUv0XhnYMYGH
 iks2XVmQeeOxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/v3d: bound CPU-job query writes to their
 destination BO
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707223607.3897912-1-michael.bommarito@gmail.com>
References: <20260707223607.3897912-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 22:54:58 +0000
Message-Id: <20260707225458.E90DC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free of query arrays when an error occurs during CPU jo=
b parameter parsing.
- [High] vmap memory leak when multiple job BOs point to the same GEM objec=
t.
- [High] Unchecked vmap failure leads to NULL pointer dereference in CPU jo=
b executors.
- [High] Implicit dma_resv synchronization is bypassed for early jobs in a =
multi-job submission.
- [High] User-controlled values can trigger WARN_ON and potential panic in =
CSD job setup.
- [High] Unaligned pointer dereferences in CPU jobs can trigger kernel alig=
nment faults.
--

--- Patch [1]: [PATCH v5] drm/v3d: bound CPU-job query writes to their dest=
ination BO ---
commit a2da5ab54906c3c7d9b8afa2e86a50fb3f868e0a
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: drm/v3d: bound CPU-job query writes to their destination BO

This commit validates the full access extent against the BO size once
the BOs are looked up, before the job is queued, rejecting out-of-range
geometry with -EINVAL.

Links:
[1] https://lore.kernel.org/dri-devel/20260703-v3d-cpu-job-fixes-v3-0-bc51b=
1f3eeb5@igalia.com/
v3: https://lore.kernel.org/all/20260617125811.3692951-1-michael.bommarito@=
gmail.com/
v2: https://lore.kernel.org/all/20260614211644.217116-1-michael.bommarito@g=
mail.com/
v1: https://lore.kernel.org/all/20260614131058.2525157-1-michael.bommarito@=
gmail.com/

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index ee2ac2540ed50..14d0b46a6c105 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> @@ -1300,6 +1302,134 @@ static const unsigned int cpu_job_bo_handle_count=
[] =3D {
[ ... ]
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
> +		/* Each query writes one u64 timestamp slot into bo[0]. */
> +		dst =3D to_v3d_bo(job->base.bo[0]);
> +
> +		for (i =3D 0; i < tquery->count; i++) {
> +			if ((u64)tquery->queries[i].offset + sizeof(u64) >
> +			    dst->base.base.size)
> +				goto err_range;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does this offset
calculation risk triggering a kernel alignment fault?

While this code validates that the user-supplied offset is within bounds,
the executor uses it directly in a 64-bit store without checking alignment:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_timestamp_query() {
    ...
    value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
    *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;
}

If userspace provides a misaligned offset on a strict-alignment
architecture (like ARM32), will this direct cast and dereference trigger
a fatal hardware alignment fault?

[Severity: High]
This isn't a bug introduced by this patch, but does the executor properly
handle vmap() failures?

If vmap() fails due to memory pressure, v3d_get_bo_vaddr() assigns NULL
to bo->vaddr. Later, CPU job executors like v3d_timestamp_query()
calculate the address:

    value_addr =3D ((u8 *)bo->vaddr) + timestamp_query->queries[i].offset;
    *((u64 *)value_addr) =3D i =3D=3D 0 ? ktime_get_ns() : 0ull;

If bo->vaddr is NULL, this resolves to just the offset. Will this cause
a fatal page fault by dereferencing an unmapped or user-space address from
the kernel thread?

> +		return 0;
> +	case V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY:
> +		/* Copies one u64 per query from bo[1] into bo[0]. */
> +		dst =3D to_v3d_bo(job->base.bo[0]);
> +		src =3D to_v3d_bo(job->base.bo[1]);

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a memory
leak if userspace provides the same GEM object for multiple BOs?

In v3d_copy_query_results(), both BOs are mapped:

    v3d_get_bo_vaddr(bo);
    v3d_get_bo_vaddr(timestamp);

If bo and timestamp resolve to the same struct v3d_bo pointer,
v3d_get_bo_vaddr() will unconditionally overwrite bo->vaddr:

drivers/gpu/drm/v3d/v3d_bo.c:v3d_get_bo_vaddr() {
    ...
    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, VM_MAP,
                     pgprot_writecombine(PAGE_KERNEL));
}

Does this permanently leak the first vmap allocation since the cleanup
path will only unmap the second one?

[ ... ]
> +	case V3D_CPU_JOB_TYPE_INDIRECT_CSD: {
> +		struct v3d_indirect_csd_info *indirect_csd =3D &job->indirect_csd;
> +
> +		/* 3 is the three dimensions (x, y, z) of the workgroup counts. */
> +		src =3D to_v3d_bo(job->base.bo[0]);
> +		if ((u64)indirect_csd->offset + 3 * sizeof(u32) >
> +		    src->base.base.size)
> +			goto err_range;

[Severity: High]
This isn't a bug introduced by this patch, but can user-controlled values
trigger a kernel crash or WARN_ON in the CSD job setup?

In v3d_rewrite_csd_job_wg_counts_from_indirect(), num_batches is
calculated from user inputs without validating wg_size:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_rewrite_csd_job_wg_counts_from_indirect=
() {
    ...
    num_batches =3D DIV_ROUND_UP(indirect_csd->wg_size, 16) *
                  (wg_counts[0] * wg_counts[1] * wg_counts[2]);

    if (v3d->ver < 71 || (v3d->ver =3D=3D 71 && v3d->rev < 6))
        args->cfg[4] =3D num_batches - 1;
    ...
    WARN_ON(args->cfg[4] =3D=3D ~0);
}

If userspace submits a job with wg_size =3D 0, num_batches becomes 0, and
args->cfg[4] underflows to ~0. Will this intentionally trigger the WARN_ON
and panic the kernel if panic_on_warn is enabled?

[ ... ]
> @@ -1364,6 +1494,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,
>  			goto fail;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but do early jobs in a multi-job
submission bypass implicit fencing?

When v3d_lookup_bos() processes the BOs, it assigns them all to the last
job in the submission:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_lookup_bos() {
    ...
    struct v3d_job *last_job =3D submit->jobs[submit->job_count - 1];
    last_job->bo_count =3D bo_count;
}

Later, v3d_submit_lock_reservations() iterates through the jobs and only
adds implicit dependencies if job->bo_count > 0:

    for (j =3D 0; j < job->bo_count; j++) {
        ret =3D drm_sched_job_add_implicit_dependencies(&job->base,
                                                      job->bo[j],
                                                      true);

Will early jobs like 'bin' or 'csd' be submitted to the GPU scheduler with
no implicit dependencies, potentially racing with active BO users?

> +	ret =3D v3d_cpu_job_bounds_check(cpu_job);
> +	if (ret)
> +		goto fail;

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error path in
v3d_get_cpu_timestamp_query_params() lead to a double free?

If v3d_get_cpu_timestamp_query_params() encounters an error, it calls:

drivers/gpu/drm/v3d/v3d_sched.c:v3d_timestamp_query_info_free() {
    ...
    kvfree(query_info->queries);
    // query_info->queries is not set to NULL
}

Then the error propagates to v3d_submit_cpu_ioctl(), which jumps to the
fail label and calls v3d_submit_cleanup_jobs(), eventually reaching:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_cpu_job_free() {
    ...
    v3d_timestamp_query_info_free(&job->timestamp_query,
                                  job->timestamp_query.count);
}

Will this second call execute kvfree() again on the dangling pointer?

> +
>  	if (cpu_job->job_type =3D=3D V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
>  		ret =3D v3d_setup_csd_jobs_and_bos(&submit, &cpu_job->indirect_csd.arg=
s,
>  						 NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707223607.3897=
912-1-michael.bommarito@gmail.com?part=3D1
