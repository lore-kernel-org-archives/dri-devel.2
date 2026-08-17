Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA8C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D238010E641;
	Mon, 17 Aug 2026 05:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uhmbzado";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD9910E641
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:53:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14D3D417A8;
 Mon, 17 Aug 2026 05:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AA41F000E9;
 Mon, 17 Aug 2026 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786945996;
 bh=BS3XMRMk7UL+jaG2DY0MDZsut4opiy8DhO3dXz6xBdE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UhmbzadornDcuwhxRU0C8hl0JJnUeBdEWflQbci+9bmBXhKuecrpYiHYxb641hSsV
 izbg2zPVBf77Znw0ZS/xX7K2o74g42rRjxuTrE2RmbVHMtPPdV1Pnk39a6slhnEtJC
 uP+yIqT1r7fukUFnXHIExikOHhcLPiXzHEc4XYmEpmyOrYZUKluJb/DZ5U4MPB5HVK
 dsMwNO1BdYD4NC9VJix+nf13+3SUbbC1Arh5ZK+vMgEPnqSHycWwRmeyIPgJi094BX
 SRYJfngDrAJyHJMcRigck5aZLsHlAIFTTkhFdLldWpvbrkNK+pjQxgBAMaff3e6U/n
 I5w1/rjX+0GPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817053949.819142-1-triet.hoang.dev@gmail.com>
References: <20260817053949.819142-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:53:15 +0000
Message-Id: <20260817055315.C9AA41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Unconditional call to rocket_iommu_domain_put() in the job cle=
anup path causes a NULL pointer dereference on early submission failures.
- [Critical] Double free of rjob->tasks when rocket_copy_tasks() fails.
- [High] Aborting a DRM scheduler job after calling drm_sched_job_arm() vio=
lates the DRM scheduler API contract and corrupts scheduler state.
- [High] The dynamically allocated scheds array leaks in rocket_job_open() =
on initialization errors and permanently leaks on single-core devices.
- [High] rocket_ioctl_submit() silently ignores errors returned by rocket_i=
octl_submit_job().
- [High] Reference count leak of iommu_group in the hardware IRQ handler.
- [High] The job's inference_done_fence is never attached to the input BOs,=
 allowing subsequent writers to corrupt memory.
- [High] PM runtime reference leak and unsignaled fence return on error pat=
hs in rocket_job_run().
--

--- Patch [1]: [PATCH] drm/rocket: Check allocations before use ---
commit e94d3a8b04e433fb70c776f865e1fd9a313aff5c
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Check allocations before use
   =20
Check the result of kvmalloc_array() in rocket_job_push() and
kmalloc_objs() in rocket_job_open() before using
the allocated buffer.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index ac51bff39833f..2fee21988d27c 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -192,6 +192,9 @@ static int rocket_job_push(struct rocket_job *job)
> =20
>  	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(voi=
d *),
>  			     GFP_KERNEL);
> +	if (!bos)
> +		return -ENOMEM;
> +
>  	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>  	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof=
(void *));
> =20

[Severity: High]
This is a pre-existing issue, but does aborting the submission after arming
the job violate the DRM scheduler API contract?

In rocket_job_push(), the job is armed before fallible operations:

		drm_sched_job_arm(&job->base);
		job->inference_done_fence =3D dma_fence_get(&job->base.s_fence->finished);
		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job-=
>base, false);
		if (ret)
			goto err_unlock;

If rocket_acquire_object_fences() fails, the submission is aborted. However,
drm_sched_job_arm() is documented as a point of no return. Can aborting here
throw away the assigned fence sequence number and break dependency tracking?

[Severity: High]
This is a pre-existing issue, but does this code leave the input BOs
unprotected from concurrent writers?

Later in rocket_job_push(), the completion fence is attached to the output =
BOs:

	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inferenc=
e_done_fence);

But it doesn't appear to attach the fence to the input BOs using
DMA_RESV_USAGE_READ. Does this allow a CPU or GPU write operation to the in=
put
BOs to execute concurrently and overwrite data during the NPU inference?

[ ... ]

> @@ -501,6 +504,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  	unsigned int core;
>  	int ret;
> =20
> +	if (!scheds)
> +		return -ENOMEM;
> +
>  	for (core =3D 0; core < rdev->num_cores; core++)
>  		scheds[core] =3D &rdev->cores[core].sched;

[Severity: High]
This is a pre-existing issue, but does this dynamically allocated scheds ar=
ray
leak on errors or on single-core devices?

In rocket_job_open():

	ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
				    DRM_SCHED_PRIORITY_NORMAL,
				    scheds,
				    rdev->num_cores, NULL);
	if (WARN_ON(ret))
		return ret;

The scheds array is not freed if drm_sched_entity_init() fails. Additionall=
y,
when only a single queue (single-core device) is provided, the DRM scheduler
entity does not take ownership of the scheds_list, so entity->sched_list may
not point to the allocated array. Since rocket_job_close() attempts to free
entity->sched_list, could the original scheds array be completely lost and
leaked per file-open?

[Severity: Critical]
This is a pre-existing issue, but could this unconditionally dereference a =
NULL
pointer on early submission failures?

If a job submission fails early (e.g., in rocket_copy_tasks or
drm_sched_job_init), the error path calls rocket_job_put(rjob). At this poi=
nt,
rjob->domain has not yet been initialized and is NULL.

In rocket_job_cleanup():

	rocket_iommu_domain_put(job->domain);

And in rocket_iommu_domain_put():

	kref_put(&domain->kref, rocket_iommu_domain_destroy);

Does evaluating &domain->kref when domain is NULL cause a kernel panic that=
 can
be trivially triggered by an unprivileged user through the DRM submit ioctl?

[Severity: Critical]
This is a pre-existing issue, but can this code cause a double free if
rocket_copy_tasks() fails?

In rocket_copy_tasks(), if validation fails:

fail:
	kvfree(rjob->tasks);
	return ret;

The array is freed, but the pointer is not cleared. If the error propagates=
 up
to rocket_ioctl_submit_job(), it jumps to out_cleanup_job, which calls
rocket_job_cleanup().

In rocket_job_cleanup():

	kvfree(job->tasks);

Could this unconditional call on the already-freed pointer cause memory
corruption exploitable by a maliciously crafted ioctl payload?

[Severity: High]
This is a pre-existing issue, but does rocket_ioctl_submit() silently ignore
errors from rocket_ioctl_submit_job()?

In rocket_ioctl_submit():

	for (i =3D 0; i < args->job_count; i++)
		rocket_ioctl_submit_job(dev, file, &jobs[i]);

The integer return value of rocket_ioctl_submit_job() is entirely discarded.
If a job fails to submit, userspace will receive a success (0) return value
anyway. Could this cause userspace to hang indefinitely waiting on a comple=
tion
fence for a job that was never queued?

[Severity: High]
This is a pre-existing issue, but does this hardware IRQ handler leak an IO=
MMU
group reference?

In rocket_job_handle_irq(), when a job finishes:

			iommu_detach_group(NULL, iommu_group_get(core->dev));

iommu_group_get() increments the reference count of the IOMMU group, but
iommu_detach_group() does not consume this reference. Because this executes
for every completed job, does this cause a severe resource leak that eventu=
ally
results in a refcount overflow or memory exhaustion?

[Severity: High]
This is a pre-existing issue, but does rocket_job_run() leak a power
management reference on error paths?

In rocket_job_run():

	ret =3D pm_runtime_get_sync(core->dev);
	if (ret < 0)
		return fence;

	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
	if (ret < 0)
		return fence;

If pm_runtime_get_sync() fails, it retains the reference, but the function
returns an unsignaled fence without dropping it. Furthermore, if
iommu_attach_group() fails, it also returns without releasing the PM refere=
nce
acquired just before it. Does this prevent the device from sleeping and sta=
ll
the DRM scheduler on an unsignaled fence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817053949.8191=
42-1-triet.hoang.dev@gmail.com?part=3D1
