Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBA4C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1870110E4DE;
	Fri, 14 Aug 2026 03:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q6x1P98k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793A910E4DE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:22:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C225600AD;
 Fri, 14 Aug 2026 03:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F81F1F000E9;
 Fri, 14 Aug 2026 03:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786677746;
 bh=/dv54h72AOVCE3AUHNkP+cCQJmibgQwERHNSlwvNKvc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q6x1P98kg4hsB4dqiMSKcHqGw3ayYvwho++/ccwa4ssKu3kqryS2kEx9I1i+cZj5d
 uPvnfqs5dalvALKtFYixJ/5vENd6GwVfHaf2g17XaLVNJApzf+sVOe72iCKYMKjDQE
 /WdyEs2Y4aVV9Yo79FKfhAYwrB7JR03CC0MjZe2PgpqW8GQ13eq8QL3p38iq1KouHX
 iolbYCyxrQU9C1bXFCNLgRuERGY0ucLMBLtp5PACKZ7VHG5qgI4wn+piPJ80+46W4k
 om6oqHLNj/6yQGQpCQge5aLeVdHDe5bBBzbG3z+E8jQa6jkukdXMVG+pUrEsjnrlwS
 SVr5RaZ3TDKJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] accel/rocket: Fix the panic in
 rocket_iommu_domain_put when the domain is NULL
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814022453.437-3-kernel@airkyi.com>
References: <20260814022453.437-1-kernel@airkyi.com>
 <20260814022453.437-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:22:25 +0000
Message-Id: <20260814032226.0F81F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

New issues:
- [Medium] The commit message describes a factually incorrect premise regar=
ding `domain` initialization.

Pre-existing issues:
- [Critical] GEM objects exported via PRIME can outlive their originating D=
RM file descriptor, causing a use-after-free in `rocket_gem_bo_free`.
- [Critical] Partial IOMMU mappings bypass the unmap error path in `rocket_=
ioctl_create_bo()`, leaking the mapping.
- [High] An IOMMU group reference is leaked on every interrupt handling due=
 to an unbalanced `iommu_group_get()` call.
- [High] Calling `drm_sched_job_cleanup()` on an armed job corrupts the GPU=
 scheduler timeline.
- [High] The loop in `rocket_ioctl_submit()` completely ignores the return =
value of `rocket_ioctl_submit_job()`.
- [High] Calling `memcpy` with a NULL pointer as the source when `job->in_b=
o_count` is 0.
- [High] The `scheds` array is leaked in `rocket_job_open`.
- [High] Incorrect teardown order in `rocket_job_fini` leads to Use-After-F=
ree of the scheduler.
- [High] Incorrect teardown order in `rocket_core_fini` causes NULL pointer=
 dereferences for concurrent jobs.
--

--- Patch [2]: [PATCH 2/4] accel/rocket: Fix the panic in rocket_iommu_doma=
in_put when the domain is NULL ---
commit 30af1c047db9952f07dbaa552d86ca1a67f4701b
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

accel/rocket: Fix the panic in rocket_iommu_domain_put when the domain is N=
ULL

This commit adds a null check in rocket_iommu_domain_put() to prevent
a panic when cleaning up a job that failed early in submission. The=20
commit message states this is necessary because the domain is assigned
last in rocket_ioctl_submit_job().

> In rocket_ioctl_submit_job(), since the domain is assigned last, an
> error before that triggers rocket_job_put() -> rocket_job_cleanup()
> -> rocket_iommu_domain_put() with the domain still NULL,
> causing a panic in that function.

[Severity: Medium]
This isn't a bug introduced by this patch, but the commit message describes
a premise that doesn't match the code.

Looking at rocket_ioctl_submit_job(), the domain is actually assigned
immediately after allocation:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
...
	rjob =3D kzalloc_obj(*rjob);
	if (!rjob)
		return -ENOMEM;

	kref_init(&rjob->refcount);

	rjob->rdev =3D rdev;
	rjob->domain =3D rocket_iommu_domain_get(file_priv);
...
}

Because the domain is assigned before any operations that could fail, the
panic described in the commit message appears impossible in this specific
path.

Could the commit message be updated to clarify the exact failure path being
fixed?

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594883e..77cd2ecce001e 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -65,7 +65,8 @@ rocket_iommu_domain_get(struct rocket_file_priv *rocket=
_priv)
>  void
>  rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
>  {
> -	kref_put(&domain->kref, rocket_iommu_domain_destroy);
> +	if (domain)
> +		kref_put(&domain->kref, rocket_iommu_domain_destroy);
>  }
> =20
>  static int

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free
with GEM objects and PRIME.

If a user exports a GEM buffer via dma-buf and closes the DRM file
descriptor, rocket_postclose() unconditionally frees rocket_priv:

drivers/accel/rocket/rocket_drv.c:rocket_postclose() {
...
	rocket_iommu_domain_put(rocket_priv->domain);
	kfree(rocket_priv);
...
}

Later, when the dma-buf is finally closed, rocket_gem_bo_free() will
dereference the freed rocket_priv:

drivers/accel/rocket/rocket_gem.c:rocket_gem_bo_free() {
...
	struct rocket_file_priv *rocket_priv =3D bo->driver_priv;
...
	mutex_lock(&rocket_priv->mm_lock);
...
}

Does this code need to reference count rocket_priv or tie its lifetime to
the GEM objects rather than the DRM file?


[Severity: Critical]
This is a pre-existing issue, but there is a potential IOMMU mapping leak
in the BO creation path:

drivers/accel/rocket/rocket_gem.c:rocket_ioctl_create_bo() {
...
	ret =3D iommu_map_sgtable(rocket_priv->domain->domain,
				rkt_obj->mm.start,
				shmem_obj->sgt,
				IOMMU_READ | IOMMU_WRITE);
	if (ret < 0 || ret < args->size) {
		drm_err(dev, "failed to map buffer: size=3D%d request_size=3D%u\n",
			ret, args->size);
		ret =3D -ENOMEM;
		goto err_remove_node;
	}
...
}

If iommu_map_sgtable() returns a partial mapping where ret > 0 but
ret < args->size, the code jumps directly to err_remove_node, bypassing
err_unmap.

Won't the successfully mapped pages remain in the IOMMU while the GEM pages
are freed, allowing potential use-after-free corruption?


[Severity: High]
This is a pre-existing issue, but calling drm_sched_job_cleanup() on an
armed job might corrupt the scheduler timeline.

drivers/accel/rocket/rocket_job.c:rocket_job_push() {
...
		drm_sched_job_arm(&job->base);
...
		ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job-=
>base, false);
		if (ret)
			goto err_unlock;
...
}

If an error occurs after drm_sched_job_arm(), the code jumps to
out_cleanup_job and cleans it up:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&rjob->base);
...
}

According to DRM scheduler rules, once a job is armed, it must be pushed to
the entity.

Doesn't cleaning it up directly leave a missing sequence number in the
fence timeline?


[Severity: High]
This is a pre-existing issue, but there appears to be a reference leak
in the interrupt handler:

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
...
		iommu_detach_group(NULL, iommu_group_get(core->dev));
...
}

The call to iommu_group_get() increments the reference count, but
iommu_detach_group() does not consume it.

Won't this leak a reference on every handled interrupt, eventually pinning
the group permanently?


[Severity: High]
This is a pre-existing issue, but the job submission loop ignores errors:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit() {
...
	for (i =3D 0; i < args->job_count; i++)
		rocket_ioctl_submit_job(dev, file, &jobs[i]);

exit:
	kvfree(jobs);

	return ret;
}

If rocket_ioctl_submit_job() fails with an error like -ENOMEM, the loop
ignores the return value and continues. The ioctl will eventually return 0
for success.

Should this code check the return value and notify userspace of failures
to prevent hangs when waiting on fences that will never be signaled?


[Severity: High]
This is a pre-existing issue, but there is a risk of undefined behavior
when copying job buffers:

drivers/accel/rocket/rocket_job.c:rocket_job_push() {
...
	bos =3D kvmalloc_array(bo_count, sizeof(*bos), GFP_KERNEL);
	if (!bos)
		return -ENOMEM;
	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
...
}

If a job is submitted with in_bo_count =3D 0 but out_bo_count > 0,
job->in_bos remains null. This leads to memcpy() being called with a null
source pointer, which is undefined behavior.

Should this code check if in_bo_count is greater than 0 before the copy?


[Severity: High]
This is a pre-existing issue, but the scheduler array appears to be leaked:

drivers/accel/rocket/rocket_job.c:rocket_job_open() {
...
	struct drm_gpu_scheduler **scheds =3D kmalloc_objs(*scheds,
							 rdev->num_cores);
...
	ret =3D drm_sched_entity_init(&rocket_priv->sched_entity,
				    DRM_SCHED_PRIORITY_NORMAL,
				    scheds,
				    rdev->num_cores, NULL);
...
}

If drm_sched_entity_init() fails, it returns early without freeing scheds.
Additionally, if rdev->num_cores is 1, drm_sched_entity_init() might not
take ownership of the array, meaning the allocation is orphaned and cannot
be freed in rocket_job_close().

Does this array need to be freed if it's not consumed or if an error
occurs?


[Severity: High]
This is a pre-existing issue, but there seems to be a teardown ordering
problem in the job destruction path:

drivers/accel/rocket/rocket_job.c:rocket_job_fini() {
	drm_sched_fini(&core->sched);

	cancel_work_sync(&core->reset.work);
...
}

drm_sched_fini() is called before the background reset work is canceled.

If the reset work runs concurrently, rocket_reset() might invoke
drm_sched_stop() and drm_sched_start() on a destroyed scheduler.

Should the background work be canceled before the scheduler is torn down?


[Severity: High]
This is a pre-existing issue, but I noticed another teardown ordering
problem in the core destruction path:

drivers/accel/rocket/rocket_core.c:rocket_core_fini() {
...
	iommu_group_put(core->iommu_group);
	core->iommu_group =3D NULL;
	rocket_job_fini(core);
}

Critical resources like core->iommu_group are torn down before stopping
the DRM scheduler in rocket_job_fini().

If the scheduler dispatches a job concurrently, won't rocket_job_run()
attempt to use a null iommu_group?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814022453.437-=
1-kernel@airkyi.com?part=3D2
