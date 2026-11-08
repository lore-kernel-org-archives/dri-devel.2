Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D867606A31A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ2RuCjG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887B910EBF0;
	Sun,  8 Nov 2026 05:47:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7212510EBF0
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:47:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25BFC411AD;
 Sun,  8 Nov 2026 05:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78EC1F0089F;
 Sun,  8 Nov 2026 05:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794116871;
 bh=DUn5FKY5Ub8B9LK7VtVFz1OlZSz6jAfXOkGQ/TvaPcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CZ2RuCjGkiZRT6o/mVEFTrO6C9lkyTVct1M8lfceL4aMySGdAk7f9VtH1yzhKrud4
 //25MuajBCPoZ3c5OgSB6rhfAgNaQYrfNpdWvvtbjJB4xidrHYSz5vgjrCBduZPn7C
 YkQ2eZDC0jQkos6rL4JiQF/4i+4H6Xytzwzjzv87fG3fR32e+EmBj2HhE/DUHBMH34
 FhQDpRKrZI6TRHIFrxjmoUFZno2PE/Gfi9acG1U9/ygkc+yFDWYtN4azrUt7nl9HVV
 m0apv1/GZ9mg8vkRdnhMwa7SQYARtKoBUu23/Y3fV+2Z223YvpCRltq0cRDJ0IDnyP
 3/9WSD8xFwL7w==
Message-ID: <sashiko-outbox-203591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] drm/imagination: Add asynchronous VM_BIND
To: "Gyeyoung Baek" <gye976@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261108-pvr-vm-bind-v2-5-730103d2cc9a@gmail.com>
References: <20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com>
 <20261108-pvr-vm-bind-v2-5-730103d2cc9a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 05:47:50 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/imagination: use-after-free of vm_ctx->sched via exported
  bind fence
- [High] drm/imagination: KCCB slot leak in pvr_queue_run_job() on
  unusable VM
- [High] drm/imagination: paired fragment job hang in
  pvr_queue_run_job() on cancel
- [High] drm/imagination: vm_ctx reference cycle with queued jobs in
  pvr_vm_bind_async()
- [High] drm/imagination: dma_fence signalling violation in
  pvr_vm_bind_run_job()
- [High] drm/imagination: premature BO free via concurrent
  drm_gpuvm_bo_deferred_cleanup()
- [Medium] drm/imagination: unlocked arm and push in
  pvr_vm_bind_job_push()
--

commit 6a1b0d839030cd6b32797f1866d0043e0dd0721f
Author: Gyeyoung Baek <gye976@gmail.com>

drm/imagination: Add asynchronous VM_BIND

This commit adds DRM_PVR_VM_BIND_ASYNC to queue VM_BIND operations on a
per-VM-context drm_sched queue with sync_ops wait and signal support, and
marks the VM context unusable if an asynchronous bind fails.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 8203d5f081d5d..c35d437aef7f9 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c

[ ... ]

> @@ -1284,8 +1372,33 @@ pvr_ioctl_vm_bind(struct drm_device *drm_dev, void=
 *raw_args,
>  		goto err_put_vm_context;
>  	}
> =20
> -	err =3D pvr_vm_bind(vm_ctx, descs, args->ops.count);
> +	/* Empty in synchronous mode, rejected above otherwise. */
> +	err =3D pvr_vm_bind_syncs_from_uapi(&syncs, file, &args->sync_ops);
> +	if (err)
> +		goto err_descs_release;
> +
> +	if (args->flags & DRM_PVR_VM_BIND_ASYNC) {
> +		struct dma_fence *fence;
> +
> +		fence =3D pvr_vm_bind_async(vm_ctx, descs, args->ops.count,
> +					  syncs.waits, syncs.wait_count,
> +					  file->client_id);
> +		if (IS_ERR(fence)) {
> +			err =3D PTR_ERR(fence);
> +			goto err_syncs_release;
> +		}
> +
> +		pvr_sync_signal_array_set_fence(&syncs.signals, fence);
> +		pvr_sync_signal_array_push_fences(&syncs.signals);

[Severity: High]
Can exporting the bind job's finished fence into syncs.signals cause a
use-after-free of vm_ctx->sched?

pvr_vm_bind_async() returns &job->base.s_fence->finished, whose
sched_fence->sched points to &vm_ctx->sched embedded in struct
pvr_vm_context.  Because pvr_vm_bind_run_job() returns NULL (or an
ERR_PTR), s_fence->parent is NULL and s_fence holds no reference to
vm_ctx.  Once the bind job finishes and pvr_vm_bind_job_destroy() drops
job->vm_ctx, userspace can destroy the VM context while the fence remains
installed in a drm_syncobj.  A later DRM_IOCTL_PVR_SUBMIT_JOBS waiting on
that syncobj then dereferences the freed vm_ctx->sched:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_fence_is_native() {
	...
	if (sched_fence &&
	    sched_fence->sched->ops =3D=3D &pvr_queue_sched_ops)
		return true;
	...
}

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 24a8645aa9130..ac5862b1c52a5 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -759,6 +759,9 @@ static struct dma_fence *pvr_queue_run_job(struct drm=
_sched_job *sched_job)
>  		return dma_fence_get(job->done_fence);
>  	}
> =20
> +	if (pvr_vm_context_is_unusable(job->ctx->vm_ctx))
> +		return ERR_PTR(-ECANCELED);
> +

[Severity: High]
Does returning ERR_PTR(-ECANCELED) here leak a reserved KCCB slot?

Before pvr_queue_run_job() runs, pvr_queue_prepare_job() ->
pvr_queue_get_job_kccb_fence() calls pvr_kccb_reserve_slot() and sets
job->kccb_fence =3D NULL.  Returning early without calling
pvr_kccb_release_slot(pvr_dev) leaves pvr_dev->kccb.reserved_count
incremented; after pvr_kccb_capacity(pvr_dev) jobs fail this way, all KCCB
slots on the device are exhausted and further KCCB submissions deadlock.

[Severity: High]
Also, if a paired geometry job fails with -ECANCELED here, will its paired
fragment job hang the fragment queue?

During the geometry job's prepare_job(), pvr_queue_get_paired_frag_job_dep()
already initializes frag_job->done_fence->ops:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_get_paired_frag_job_dep()=
 {
	...
	/* Initialize the paired fragment job's done_fence, so we can signal it. */
	pvr_queue_job_fence_init(frag_job->done_fence, frag_queue);
	...
}

When the geometry job returns ERR_PTR(-ECANCELED) without submitting the
paired kick to the firmware, the fragment job is still scheduled onto
frag_queue.  In pvr_queue_run_job(), the fragment job hits the earlier
job->done_fence->ops check before pvr_vm_context_is_unusable() and returns
the unsignaled done_fence, hanging frag_queue until pvr_queue_timedout_job()
fires WARN_ON(atomic_read(&queue->in_flight_job_count) !=3D job_count).
Checking pvr_vm_context_is_unusable() before the paired fragment check (or
checking job->has_pm_ref instead of job->done_fence->ops) would avoid this.

> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 2f959cd5e9047..4e58ea8c50cfe 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c

[ ... ]

> @@ -618,6 +652,8 @@ pvr_vm_context_release(struct kref *ref_count)
>  	struct pvr_vm_context *vm_ctx =3D
>  		container_of(ref_count, struct pvr_vm_context, ref_count);
> =20
> +	pvr_vm_bind_sched_fini(vm_ctx);
> +
>  	if (vm_ctx->fw_mem_ctx_obj)
>  		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
> =20

[Severity: High]
Does calling pvr_vm_bind_sched_fini() only from pvr_vm_context_release()
create a reference cycle when bind jobs are queued?

Each queued pvr_vm_bind_job holds a reference on vm_ctx via
job->vm_ctx =3D pvr_vm_context_get(vm_ctx) until the job finishes or is
killed by drm_sched_entity_destroy(&vm_ctx->entity).  Because neither
pvr_ioctl_destroy_vm_context() nor pvr_destroy_vm_contexts_for_file()
destroys vm_ctx->entity, vm_ctx->ref_count cannot reach zero while any bind
job is waiting on an unsignaled dependency fence, leaking vm_ctx, the job,
and its pinned GEM objects if the process is killed.  On file close,
pvr_destroy_contexts_for_file() also calls pvr_vm_unmap_all(ctx->vm_ctx)
while pending async bind jobs on vm_ctx->entity can still run later and map
buffers back into the VM context.

[ ... ]

> +static void pvr_vm_bind_job_destroy(struct pvr_vm_bind_job *job)
> +{
> +	if (!job)
> +		return;
> +
> +	pvr_vm_bind_ops_free(job->bind_ops, job->bind_op_count);
> +
> +	if (job->vm_ctx) {
> +		drm_gpuvm_bo_deferred_cleanup(&job->vm_ctx->gpuvm_mgr);
> +		pvr_vm_context_put(job->vm_ctx);
> +	}
> +
> +	kfree(job);
> +}
> +
> +static void pvr_vm_bind_job_cleanup_work(struct work_struct *work)
> +{
> +	struct pvr_vm_bind_job *job =3D
> +		container_of(work, struct pvr_vm_bind_job, cleanup_work);
> +
> +	pvr_vm_bind_job_destroy(job);
> +}
> +
> +/*
> + * Runs in the dma-fence signalling path: nothing here may allocate or t=
ake a
> + * dma_resv. pvr_vm_bind_job_create() prepares everything beforehand.
> + */
> +static struct dma_fence *
> +pvr_vm_bind_run_job(struct drm_sched_job *sched_job)
> +{
> +	struct pvr_vm_bind_job *job =3D to_pvr_vm_bind_job(sched_job);
> +	struct pvr_vm_context *vm_ctx =3D job->vm_ctx;
> +	bool wait =3D false;
> +	int flush_err;
> +	int err =3D 0;
> +	bool cookie;
> +
> +	if (pvr_vm_context_is_unusable(vm_ctx))
> +		return ERR_PTR(-ECANCELED);
> +
> +	cookie =3D dma_fence_begin_signalling();
> +
> +	mutex_lock(&vm_ctx->lock);
> +
> +	/*
> +	 * Sync the page tables and flush the MMU before signalling, including
> +	 * tables a failed operation has already changed.
> +	 */
> +	for (u32 i =3D 0; i < job->bind_op_count; i++) {
> +		struct pvr_vm_bind_op *bind_op =3D &job->bind_ops[i];
> +
> +		err =3D pvr_vm_bind_op_exec(bind_op);
> +
> +		pvr_mmu_op_context_sync(bind_op->mmu_op_ctx);
> +		if (bind_op->type =3D=3D PVR_VM_BIND_TYPE_UNMAP)
> +			wait =3D true;
> +
> +		if (err)
> +			break;
> +	}
> +
> +	flush_err =3D pvr_mmu_flush_exec(vm_ctx->pvr_dev, wait);

[Severity: High]
Can calling pvr_mmu_flush_exec() inside dma_fence_begin_signalling()
violate dma_fence signalling rules?

If KCCB submission or completion fails in pvr_mmu_flush_exec(), its
err_reset_and_retry path calls pvr_power_reset(pvr_dev, true) ->
pvr_fw_hard_reset() -> pvr_fw_object_vmap() -> pvr_gem_object_vmap(), which
takes dma_resv_lock() and allocates virtual address space with GFP_KERNEL
via drm_gem_shmem_vmap_locked() while inside the dma_fence signalling
section and holding vm_ctx->lock.  Even on the normal path,
pvr_mmu_flush_exec() -> pvr_kccb_send_cmd() -> pvr_power_get() calls
pm_runtime_resume_and_get() inside the signalling section.

[Severity: High]
Can a concurrent drm_gpuvm_bo_deferred_cleanup() free an unmapped BO's
pages before pvr_vm_bind_run_job() flushes the MMU?

During pvr_vm_bind_op_exec(), pvr_vm_gpuva_unmap() and pvr_vm_gpuva_remap()
call drm_gpuva_unlink_defer(), queuing unlinked drm_gpuvm_bo entries onto
 the lockless vm_ctx->gpuvm_mgr.bo_defer list before pvr_mmu_op_context_syn=
c()
and pvr_mmu_flush_exec() complete:

kworker 0                         kworker 1
pvr_vm_bind_run_job()
  mutex_lock(&vm_ctx->lock)
  pvr_vm_bind_op_exec()
    ...
      drm_gpuva_unlink_defer()
                                  pvr_vm_bind_job_cleanup_work()
                                    pvr_vm_bind_job_destroy()
                                      drm_gpuvm_bo_deferred_cleanup()
                                        /* drops last BO ref, frees pages */
  pvr_mmu_op_context_sync()
  pvr_mmu_flush_exec()            <-- GPU TLB still cached freed pages

Because pvr_dev->sched_wq is an unbound multi-threaded workqueue and
drm_gpuvm_bo_deferred_cleanup() runs without vm_ctx->lock in
pvr_vm_bind_job_destroy() (as well as in pvr_vm_bind() and
pvr_vm_bind_ops_create()), the backing pages can be freed while the GPU MMU
can still access them.

[ ... ]

> +static struct dma_fence *pvr_vm_bind_job_push(struct pvr_vm_bind_job *jo=
b)
> +{
> +	struct dma_fence *fence;
> +
> +	drm_sched_job_arm(&job->base);
> +
> +	/* Pushing may free @job, so take the fence first. */
> +	fence =3D dma_fence_get(&job->base.s_fence->finished);
> +
> +	drm_sched_entity_push_job(&job->base);
> +
> +	return fence;
> +}

[Severity: Medium]
Should drm_sched_job_arm() and drm_sched_entity_push_job() be serialized by
a lock on vm_ctx?

Without a lock held across both calls, two concurrent DRM_PVR_VM_BIND_ASYNC
ioctls on the same vm_ctx can arm jobs in one order (assigning fence
seqnos N and N+1 on vm_ctx->entity) and push them to vm_ctx->entity in the
reverse order:

CPU0                              CPU1
pvr_vm_bind_job_push(jobA)        pvr_vm_bind_job_push(jobB)
  drm_sched_job_arm(jobA)
    /* gets seqno N */
                                    drm_sched_job_arm(jobB)
                                      /* gets seqno N+1 */
                                    drm_sched_entity_push_job(jobB)
  drm_sched_entity_push_job(jobA)   <-- seqno N+1 runs before seqno N

This breaks dma_fence seqno ordering on entity->fence_context and causes
drm_sched_job_add_dependency() to drop a dependency on unsignaled fence N
when deduplicating against fence N+1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-pvr-vm-bin=
d-v2-0-730103d2cc9a@gmail.com?part=3D5
