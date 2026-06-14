Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E77CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDE310E127;
	Sun, 14 Jun 2026 21:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kB4azypa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F09810E127
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:31:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA8706008A;
 Sun, 14 Jun 2026 21:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD91F000E9;
 Sun, 14 Jun 2026 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781472666;
 bh=E5tXKI8EsXT9lwRv27B2w8NKXwq6SpFw5nz6lZyXXhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kB4azypa5QIX0MBVqUPsuaux7wkU/AriLaWi7rV3EL0JgwJTG3HHpzNfiFVbZJXUP
 tK/udVYlMbCRclw9pQkbP8Es5FggnIMV/uzTE7t2EVELB8vio9tQgSphlLaWo8dKQ5
 yey/13EG8F5fUJDFhEYChTDhssOoRtjc6yuyMfI3d1ROcDzp5xTBL6LWUZQ9PMtkI1
 XKToi1rcbHVWCqOmFdzutuwTh1waj9KOK4WvJPTobSzMU7/HKjyf5ppispszsF1XkQ
 JUdMDL4P9Mk1ajfT5tGxkLJLKMQvjl6zlO9xPJPENzf05aFP+eDTF3wW3Y49FZNrQ0
 uAONnYvQEzVZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/v3d: bound CPU-job query writes to their
 destination BO
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260614211644.217116-1-michael.bommarito@gmail.com>
References: <20260614211644.217116-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 21:31:05 +0000
Message-Id: <20260614213106.47BD91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The V3D_CPU_JOB_TYPE_INDIRECT_CSD job type was omitted from th=
e new CPU job bounds checks, leaving unmitigated arbitrary out-of-bounds ke=
rnel memory read and write vulnerabilities.
- [High] v3d_get_cpu_indirect_csd_params does not check if drm_gem_object_l=
ookup returns NULL for the indirect handle, leading to a NULL pointer deref=
erence during job execution.
- [High] Kernel crash due to calling cleanup functions on uninitialized mem=
ory if CPU job validation fails early.
--

commit 0ce9f49e205ba6d1094ea08101223cdd03baade5
Author: Michael Bommarito <michael.bommarito@gmail.com>
Subject: drm/v3d: bound CPU-job query writes to their destination BO

This commit adds bounds checking for CPU job queries to ensure they do not
write past their destination buffer object. It validates the full write
extent against the destination BO size before the job is queued.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 1db43c6a078d5..ed45989b84b28 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
[ ... ]
> +/* Reject a query CPU job whose writes would land outside their BO. */
> +static int
> +v3d_cpu_job_bounds_check(struct v3d_cpu_job *job)
> +{
[ ... ]
> +	switch (job->job_type) {
> +	case V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY:
> +	case V3D_CPU_JOB_TYPE_RESET_TIMESTAMP_QUERY:
[ ... ]
> +	default:
> +		return 0;

[Severity: Critical]
This isn't a bug introduced by this patch, but since we are adding bounds
checking here, should V3D_CPU_JOB_TYPE_INDIRECT_CSD be validated as well?

Because this switch falls through to the default case for INDIRECT_CSD
jobs, the user-controlled indirect_csd->offset is left unvalidated.
When this is later used in v3d_rewrite_csd_job_wg_counts_from_indirect():

v3d_rewrite_csd_job_wg_counts_from_indirect()
    wg_counts =3D (uint32_t *)(bo->vaddr + indirect_csd->offset);
    ...
    ((uint32_t *)indirect->vaddr)[uniform_idx] =3D wg_counts[i];

Could this allow out-of-bounds kernel memory reads and writes?

> +	}
> +
> +err_range:
> +	drm_dbg(dev, "CPU job query offset exceeds the BO.\n");
> +	return -EINVAL;
> +}
> +
>  /**
>   * v3d_submit_cpu_ioctl() - Submits a CPU job to the V3D.
>   * @dev: DRM device
> @@ -1346,6 +1444,10 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void =
*data,
>  		if (ret)
>  			goto fail;
> =20
> +		ret =3D v3d_cpu_job_bounds_check(cpu_job);
> +		if (ret)
> +			goto fail;
> +

[Severity: High]
This is a pre-existing issue, but does calling goto fail here or earlier
in v3d_submit_cpu_ioctl() risk a NULL pointer dereference?

If validation fails before v3d_job_init() is called (for example, if
bo_handle_count is incorrect), cpu_job->base.s_fence remains NULL. The
error path then cleans up the uninitialized job:

v3d_submit_cpu_ioctl()
    ...
    if (args->bo_handle_count !=3D ...)
        goto fail;
    ...
fail:
    v3d_job_cleanup((void *)cpu_job);

When drm_sched_job_cleanup() is reached:

drm_sched_job_cleanup()
    if (kref_read(&job->s_fence->finished.refcount)) {

Would this unconditionally dereference the NULL s_fence and crash the
kernel?

[Severity: High]
This is another pre-existing issue in the CPU job submission path, but
is it possible for the indirect_csd parameters to trigger a crash if
the user provides an invalid GEM handle?

In v3d_get_cpu_indirect_csd_params(), the return value of
drm_gem_object_lookup() is stored without a NULL check:

v3d_get_cpu_indirect_csd_params()
    info->indirect =3D drm_gem_object_lookup(file_priv, indirect_csd.indire=
ct);

If this is NULL, when the job executes:

v3d_rewrite_csd_job_wg_counts_from_indirect()
    v3d_get_bo_vaddr(indirect);

v3d_get_bo_vaddr()
    bo->vaddr =3D vmap(obj->pages, obj->base.size >> PAGE_SHIFT, ...);

Will this lead to an immediate NULL pointer dereference when obj->pages or
obj->base.size is accessed?

>  		ret =3D v3d_lock_bo_reservations(&cpu_job->base, &acquire_ctx);
>  		if (ret)
>  			goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614211644.2171=
16-1-michael.bommarito@gmail.com?part=3D1
