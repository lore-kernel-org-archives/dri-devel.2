Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFF606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFWEemnx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A76210E224;
	Sat, 14 Nov 2026 08:57:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F3510E224
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:57:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33C5560018;
 Sat, 14 Nov 2026 08:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B34D1F000C4;
 Sat, 14 Nov 2026 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794646626;
 bh=MZox2pRWIENv/s9zAOJTjcTJIyoHBUrlN5uU47Q2loM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GFWEemnxqh++Bq2/pxni48YmT9EHqBbQfV5+YCL4N9XI83leh7SRyf5tQ0ngIa/1y
 ei7RC71P9ujpI5Cl5dpwJAFZuv/mtyAtn344q51cBc3zIAcx/YpXbc7FVyU8GvSs7c
 mAGEOXNMBwf0ck6qh77DJ24OF/y3sFZBcdm7AemD7yIpL4glPp1lRkxPoYFFHz/zbc
 Ey5xy/7Mef1FusEMrDkQs1TmvPCyIrpMAeaLo/3/Mpw4hAGLk69QCk/SGV2p2SN9B7
 Y0X0ginMnhMAIBaj2pQ9C6Xqvm2sqMsQx9jQsE/EIVFYuVS/ghOLPt1ei5wpsZdyid
 Uv7ux92tuQ34Q==
Message-ID: <sashiko-outbox-214313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/msm: Release the pins and ops of a VM_BIND
 job that never ran
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114081902.1669-2-arpe1618@gmail.com>
References: <20261114081902.1669-1-arpe1618@gmail.com>
 <20261114081902.1669-2-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 08:57:05 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm: premature and out-of-order unmap in msm_vma_job_free()
- [Medium] drm/msm: missed vm_unusable and leaks when vm_ops is empty on
  error
--

commit 0f3c8ad1bd8ea2fee6f4303606106da6e7c317d4
Author: Jiwoo Kim <arpe1618@gmail.com>

drm/msm: Release the pins and ops of a VM_BIND job that never ran

This commit factors pgtable update execution out of msm_vma_job_run() into
vm_bind_job_apply_ops() and calls it from msm_vma_job_free() along with BO
unpinning so that aborted or killed VM_BIND jobs apply pending unmaps,
drop GEM object references, mark the VM unusable, and release BO pins.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 8b702422030af..a6f106d0cdef5 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -700,16 +700,16 @@ static const struct drm_gpuvm_ops msm_gpuvm_ops =3D=
 {
>  	.sm_step_unmap =3D msm_gem_vm_sm_step_unmap,
>  };
> =20
> -static struct dma_fence *
> -msm_vma_job_run(struct drm_sched_job *_job)
> +/*
> + * Apply the pgtable updates queued for a job, and drop the references t=
hat
> + * the ops hold.  If ret is an error, or one occurs, the remaining maps =
are
> + * skipped, but the unmaps are still applied, as the pages they unmap mu=
st
> + * not be freed while they are still mapped.
> + */
> +static int
> +vm_bind_job_apply_ops(struct msm_vm_bind_job *job, int ret)
>  {
> -	struct msm_vm_bind_job *job =3D to_msm_vm_bind_job(_job);
> -	struct drm_device *dev =3D job->vm->drm;
>  	struct msm_gem_vm *vm =3D to_msm_vm(job->vm);
> -	struct drm_gem_object *obj;
> -	int ret =3D vm->unusable ? -EINVAL : 0;
> -
> -	vm_dbg("");
> =20
>  	mutex_lock(&vm->mmu_lock);
>  	vm->mmu->prealloc =3D &job->prealloc;
> @@ -740,6 +740,22 @@ msm_vma_job_run(struct drm_sched_job *_job)
>  	vm->mmu->prealloc =3D NULL;
>  	mutex_unlock(&vm->mmu_lock);
> =20
> +	return ret;
> +}
> +
> +static struct dma_fence *
> +msm_vma_job_run(struct drm_sched_job *_job)
> +{
> +	struct msm_vm_bind_job *job =3D to_msm_vm_bind_job(_job);
> +	struct drm_device *dev =3D job->vm->drm;
> +	struct msm_gem_vm *vm =3D to_msm_vm(job->vm);
> +	struct drm_gem_object *obj;
> +	int ret;
> +
> +	vm_dbg("");
> +
> +	ret =3D vm_bind_job_apply_ops(job, vm->unusable ? -EINVAL : 0);

[ ... ]

> @@ -766,26 +784,41 @@ msm_vma_job_free(struct drm_sched_job *_job)
>  	struct msm_gem_vm *vm =3D to_msm_vm(job->vm);
>  	struct drm_gem_object *obj;
> =20
> +	/*
> +	 * In error paths, and if the job was killed before it ran, we could
> +	 * have unexecuted ops.  Their changes were already made to the VM, so
> +	 * apply the unmaps, and give up on the VM.
> +	 */
> +	if (!list_empty(&job->vm_ops)) {
> +		vm_bind_job_apply_ops(job, -ECANCELED);

[Severity: High]
When msm_ioctl_vm_bind() fails after vm_bind_job_prepare() has queued an
MSM_VM_OP_UNMAP (for example on a later op in the same ioctl or when
sync_file_create() fails), does calling vm_bind_job_apply_ops() directly
from msm_vma_job_free() execute unmaps before the job's fence dependencies
and earlier scheduled VM_BIND jobs have completed?

Unlike drm_sched_entity_kill(), which waits for entity->last_scheduled and
every fence in job->base.dependencies before invoking free_job(), the
synchronous failure path in msm_ioctl_vm_bind() calls msm_vma_job_free()
immediately after drm_exec_fini() and mutex_unlock(&queue->lock).
vm_bind_job_apply_ops() then runs vm_unmap_op() and
drm_gem_object_put(op->obj) while in-flight GPU work guarded by
job->base.dependencies may still be accessing those mappings and backing
pages.

Running vm_bind_job_apply_ops() here can also reorder an unmap ahead of an
earlier pending job's map of the same IOVA range:

CPU0 (scheduler: job1 map X)      CPU1 (ioctl error: job2 unmap X)
msm_vma_job_run(job1)
  vm->unusable is false
                                  vm_bind_job_prepare(job2)
                                    msm_gem_vma_close()
                                  ...
                                  msm_vma_job_free(job2)
                                    vm_bind_job_apply_ops(job2, -ECANCELED)
                                      mutex_lock(&vm->mmu_lock)
                                      vm_unmap_op(X)
                                      mutex_unlock(&vm->mmu_lock)
  vm_bind_job_apply_ops(job1, 0)
    mutex_lock(&vm->mmu_lock)
    vm_map_op(X)
    drm_gem_object_put(op->obj)   <-- mapped in IOMMU, untracked in job->vm
    mutex_unlock(&vm->mmu_lock)
                                    msm_gem_vm_unusable(job->vm)

Because job2 already closed the drm_gpuva in job->vm, job1's mapping is
never torn down when the VM is closed, leaving freed pages mapped in the
IOMMU.  In addition, because msm_ioctl_vm_bind() drops the VM lock and
queue->lock before msm_vma_job_free() sets vm->unusable, another thread
can enter msm_ioctl_vm_bind() and pass the vm->unusable check while the VM
is already partially modified.

> +		msm_gem_vm_unusable(job->vm);
> +	}

[Severity: Medium]
Can vm_bind_job_prepare() modify job->vm and fail while job->vm_ops is
still empty, leaving the VM usable in an inconsistent state?

In msm_gem_vm_sm_step_map(), vma_from_op() inserts the new VMA into
job->vm with to_msm_vma(vma)->mapped =3D false before calling
vm_op_enqueue():

drivers/gpu/drm/msm/msm_gem_vma.c:msm_gem_vm_sm_step_map() {
    ...
	vma =3D vma_from_op(arg, &op->map);
	if (WARN_ON(IS_ERR(vma)))
		return PTR_ERR(vma);
    ...
	ret =3D vm_op_enqueue(arg, (struct msm_vm_op){
    ...
	});

	if (ret)
		return ret;

	vma->flags =3D ((struct op_arg *)arg)->flags;
	to_msm_vma(vma)->mapped =3D true;
}

If vm_op_enqueue() fails with -ENOMEM on the first step of op 0, job->vm_ops
is empty and i =3D=3D 0, so neither vm_bind_job_prepare() nor
msm_vma_job_free() calls msm_gem_vm_unusable().  If that op was
MSM_VM_BIND_OP_MAP_NULL, the VMA stays in job->vm with vm_bo =3D=3D NULL and
mapped =3D=3D false, and a subsequent ioctl that remaps it will call
drm_gpuvm_bo_evict(NULL, true) in msm_gem_vm_sm_step_remap() and
dereference a NULL pointer:

drivers/gpu/drm/msm/msm_gem_vma.c:msm_gem_vm_sm_step_remap() {
    ...
	if (vm_bo)
		drm_gpuvm_bo_get(vm_bo);
    ...
	if (op->remap.prev) {
		prev_vma =3D vma_from_op(arg, op->remap.prev);
		if (WARN_ON(IS_ERR(prev_vma)))
			return PTR_ERR(prev_vma);
    ...
	if (!mapped)
		drm_gpuvm_bo_evict(vm_bo, true);
}

Unmapping or remapping an unmapped VMA or updating VMA flags in place also
modifies job->vm without queueing to job->vm_ops; if a later step of op 0
or sync_file_create() fails, job->vm_ops is still empty and the VM is not
marked unusable.  Also, msm_gem_vm_sm_step_remap() leaks the
drm_gpuvm_bo_get(vm_bo) reference if vma_from_op() returns an error, and
when vm_bind_job_prepare() fails at i > 0 with non-empty job->vm_ops, both
vm_bind_job_prepare() and msm_vma_job_free() call msm_gem_vm_unusable(),
dumping the VM log twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114081902.1669=
-1-arpe1618@gmail.com?part=3D1
