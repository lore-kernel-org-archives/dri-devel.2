Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916DCC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9E110E7F8;
	Mon, 17 Aug 2026 14:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BhMCoOEp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F36710E7F8
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:18:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFC94401E3;
 Mon, 17 Aug 2026 14:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805AE1F00A3E;
 Mon, 17 Aug 2026 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786976283;
 bh=rQ3FAWy1fUPt+AaBIWkdkQVQ1rshjUoBBU2aOoY0pac=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BhMCoOEpoN2q2r2QFGul9dChxKKUnLKb7JI1PsF920T4sndNT4gLOTzfJ19GZISGY
 lIEtdMAOA6kgOhEU1RVDU2wh6TP2y6BRcSrMQWhIkYcNYI1AeIzxNQJk4Qk9ehEKyE
 5j1v9Skdn3pPi/aZkmHLrNXzTr72MlRs+wq25PvCXeh/bGaLWPJ764NLZd6xoMn4aU
 1xZxFt72XC5QfO/usO6oc2KzM2bhUhgDesumCgo7mZzSe68+87BfMW3tl5Y1Y0yTp9
 FCmigOc9ECnMdzCHICskC5JxNX9woFwny+HoSFfh/DP6YJ3fQCa2FUVJSEsgIdP1S0
 3iXbluYQ/Y3hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] drm/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:18:03 +0000
Message-Id: <20260817141803.805AE1F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free on `rjob->tasks` array during job submission failu=
re.
- [Critical] NULL pointer dereference in `rocket_iommu_domain_put()`.
- [High] Missing read fence attachment for input BOs causes implicit synchr=
onization data races.
- [High] PM usage counter leak and DRM scheduler hang on `rocket_job_run()`=
 error paths.
- [High] Calling `drm_sched_job_cleanup()` after `drm_sched_job_arm()` viol=
ates the scheduler API contract.
- [High] Silent failure handling due to unpropagated return value in `rocke=
t_ioctl_submit()`.
- [High] Reference count leak of IOMMU group in `rocket_job_handle_irq()`.
- [Medium] Unconditional memory leak of `scheds` array on success for singl=
e-core setups.
- [Medium] Potential integer overflow in BO array allocation bypasses const=
raints.
--

--- Patch [1]: [PATCH v4 1/2] drm/rocket: Check allocations before use ---
commit c89b0a284de194304c5f1c1f130d90f61e831c73
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Check allocations before use

This commit adds checks for the return values of kvmalloc_array() in
rocket_job_push() and kmalloc_objs() in rocket_job_open() to prevent NULL
pointer dereferences when allocations fail.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ac51bff39833f..adcc792541ec1 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -192,6 +192,9 @@ static int rocket_job_push(struct rocket_job *job)
> =20
>  	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
>  			     GFP_KERNEL);

[Severity: Medium]
This is a pre-existing issue, but can job->in_bo_count + job->out_bo_count
overflow?

If these attacker-controlled 32-bit integers wrap around to 0,
kvmalloc_array() would return a ZERO_SIZE_PTR. This causes the subsequent
memcpy() calls to write out of bounds.

> +	if (!bos)
> +		return -ENOMEM;
> +
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));

[ ... ]

> @@ -509,9 +515,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  				    scheds,
>  				    rdev->num_cores, NULL);
>  	if (WARN_ON(ret))
> -		return ret;
> +		kfree(scheds);
> =20
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but does this leak the scheds
array on success when num_cores =3D=3D 1?

If drm_sched_entity_init() succeeds, it internally sets
entity->sched_list =3D NULL for single-core setups. Since the scheds array
is never saved (e.g., to rocket_priv->scheds), it gets leaked.

Later, rocket_job_close() will attempt to free entity->sched_list which is
NULL, meaning the scheds array is leaked on every file descriptor open/close
cycle.

Additional pre-existing issues found in drivers/accel/rocket/rocket_job.c:

[Severity: Critical]
This is a pre-existing issue, but is there a double free on the rjob->tasks
array during job submission failure?

If rocket_copy_tasks() fails (e.g., due to invalid user pointers), it frees
rjob->tasks but does not nullify the pointer:

rocket_copy_tasks() {
    ...
fail:
    kvfree(rjob->tasks);
    return ret;
}

The error then propagates up to rocket_ioctl_submit_job(), which calls
rocket_job_put() and ultimately rocket_job_cleanup(). The cleanup function
unconditionally frees the same dangling pointer:

rocket_job_cleanup() {
    ...
    kvfree(job->tasks);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does rocket_job_push() miss
attaching read fences for input BOs?

The driver correctly attaches write completion fences to out_bos:

rocket_job_push() {
    ...
    rocket_attach_object_fences(job->out_bos, job->out_bo_count,
                                job->inference_done_fence);
    ...
}

However, it entirely omits attaching the fence to in_bos. Without a
DMA_RESV_USAGE_READ fence, subsequent jobs or operations writing to these
input BOs will not wait for this read operation to complete, which could
generate read-after-write GPU data races.

[Severity: High]
This is a pre-existing issue, but could rocket_job_run() leak the PM runtime
usage counter and hang the DRM scheduler on error paths?

rocket_job_run() {
    ...
    ret =3D pm_runtime_get_sync(core->dev);
    if (ret < 0)
        return fence;

    ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
    if (ret < 0)
        return fence;
    ...
}

If either fails, the function immediately returns the newly created, unsign=
aled
fence. The DRM scheduler will wait forever for this fence, leading to a job
timeout and hardware reset. Furthermore, pm_runtime_get_sync() increments t=
he
usage counter even on failure, so missing a pm_runtime_put_noidle() call
causes a PM counter leak.

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling for
job submission violate the DRM scheduler API contract?

In rocket_job_push(), the job is armed first:

rocket_job_push() {
    ...
        drm_sched_job_arm(&job->base);
        ...
        ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
                                           &job->base, false);
        if (ret)
            goto err_unlock;
    ...
}

If acquiring fences fails, the code jumps to the error path and eventually
rocket_ioctl_submit_job() calls drm_sched_job_cleanup() on the aborted job:

rocket_ioctl_submit_job() {
    ...
out_cleanup_job:
    if (ret)
        drm_sched_job_cleanup(&rjob->base);
    ...
}

Calling cleanup on an armed job is forbidden by the DRM scheduler API becau=
se
it invalidates sequence numbers and leaves a dangling initialized fence.

[Severity: High]
This is a pre-existing issue, but will rocket_ioctl_submit() silently ignore
job submission failures?

rocket_ioctl_submit() {
    ...
    for (i =3D 0; i < args->job_count; i++)
        rocket_ioctl_submit_job(dev, file, &jobs[i]);

exit:
    kvfree(jobs);

    return ret;
}

The return value of rocket_ioctl_submit_job() is ignored. If a job fails
initialization, validation, or pushing to the scheduler, the failure is
silenced and the ioctl still returns success to userspace.

[Severity: Critical]
This isn't a bug introduced by this patch, but might rocket_job_cleanup()
cause a NULL pointer dereference?

If drm_gem_objects_lookup() fails early in rocket_ioctl_submit_job(),
rjob->domain is never initialized and remains NULL. The cleanup path will
call rocket_job_cleanup(), which unconditionally passes this NULL domain
pointer to rocket_iommu_domain_put():

rocket_job_cleanup() {
    ...
    rocket_iommu_domain_put(job->domain);
    ...
}

rocket_iommu_domain_put() {
    kref_put(&domain->kref, rocket_iommu_domain_destroy);
}

The helper directly dereferences the pointer without checking if it is NULL,
which would cause a kernel panic.

[Severity: High]
This is a pre-existing issue, but is the reference count of the IOMMU group
leaked in rocket_job_handle_irq()?

rocket_job_handle_irq() {
    ...
            iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

iommu_group_get() increments the reference count of the IOMMU group, but
iommu_detach_group() does not consume it. Because there is no matching
iommu_group_put(), this causes a reference count leak on every job completi=
on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817140110.1488=
73-1-89897892+HMTCT@users.noreply.github.com?part=3D1
