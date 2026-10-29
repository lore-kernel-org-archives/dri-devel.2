Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACA606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVykdDrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2B2112403;
	Thu, 29 Oct 2026 15:54:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFC9112403
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62AFD43A7C;
 Thu, 29 Oct 2026 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1BE1F01816;
 Thu, 29 Oct 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793289259;
 bh=TVXTcLuARKVOHMqiaBaVGpSiv3XNFB9+H0TG5U87tHM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YVykdDrfOIFbQRvfPTFNHdzkdfYgdetQ7ozh3hUtbXuLUONku1btNGw27wuKKXozX
 h52JNeb+c4SsGE7XRAk3IOWF+SQ7UBJ0KTiXMqgTq+aKviNFNXsbh0Ucxr8FIacZIS
 P/OmSpyN2NX8dwBNw6JH+GdQe3wlSGchnwtv01L5OCOqIsGRuTTZ+HP0XOwZwrEnMW
 rVKnbm1fKbclUw+UVQUHKtYRZGOrGSIhxVPJn6SezcQv5aKHURbN53mRWZrqJ0Kjz0
 gexsWX5j1wBNWDKXrV+mjU2/2P4bRoUbb2ra99d49uJTABlers3mm8N5zn44Vol0TU
 bYB58+XQCGDAg==
Message-ID: <sashiko-outbox-189641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/amdgpu: introduce amdgpu_dev_enter / exit
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029152000.22001-5-pierre-eric.pelloux-prayer@amd.com>
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:54:18 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] drm/amdgpu: UAF and resource leaks in amdgpu_drm_release() whe=
n wedged
- [High] drm/amdgpu: lockdep assert failure in amdgpu_dev_enter() during GP=
U reset
- [High] drm/amdgpu: unsignaled fences and job leak in amdgpu_job_timedout()
- [High] drm/amdgpu: dangling stable_pstate_ctx pointer in amdgpu_ctx_fini()
- [High] drm/amdgpu: amdgpu_dev_enter() skips VCPU save during wedged GPU r=
eset
- [High] drm/amdgpu: kernel memory leak to userspace in amdgpu_device_mm_ac=
cess()
- [High] drm/amdgpu: stale GART PTEs after reset due to amdgpu_dev_enter() =
in amdgpu_gart_unbind()
- [Medium] drm/amdgpu: MTRR and PAT WC memtype leak in amdgpu_bo_fini()
--

commit 59cad41456cc693868134533055db79a86a51bc9
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: introduce amdgpu_dev_enter / exit

This commit introduces amdgpu_dev_enter() and amdgpu_dev_exit() wrappers
around drm_dev_enter() and drm_dev_exit() that also check
amdgpu_device_is_wedged() and amdgpu_device_skip_hw_access(), and converts
existing drm_dev_enter() callers across amdgpu to use them.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c6e882b8eac57..22f6b8e88ecd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>  #include <drm/ttm/ttm_placement.h>
> =20
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
> =20
> @@ -1388,4 +1389,20 @@ static inline bool amdgpu_device_is_wedged(struct =
amdgpu_device *adev)
>  	return atomic_read(&adev->wedge_status);
>  }
> =20
> +static inline bool amdgpu_dev_enter(struct amdgpu_device *adev, int *idx)
> +{
> +	if (amdgpu_device_is_wedged(adev))
> +		return false;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return false;
> +
> +	return drm_dev_enter(adev_to_drm(adev), idx);
> +}

[Severity: High]
Will calling amdgpu_device_skip_hw_access() unconditionally inside
amdgpu_dev_enter() trigger false-positive lockdep warnings when a GPU reset
is running concurrently?

In drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
amdgpu_device_skip_hw_access() checks:

	if (in_task()) {
		if (down_read_trylock(&adev->reset_domain->sem))
			up_read(&adev->reset_domain->sem);
		else
			lockdep_assert_held(&adev->reset_domain->sem);
	}

When a GPU reset thread holds the write lock on adev->reset_domain->sem
(for example in amdgpu_device_gpu_recover() or
amdgpu_device_ip_soft_reset()) while adev->no_hw_access is still false,
down_read_trylock() fails and lockdep_assert_held(&adev->reset_domain->sem)
fires for any task-context caller that does not already hold
reset_domain->sem.

Several task-context callers converted by this patch do not hold
reset_domain->sem when calling amdgpu_dev_enter(). For instance,
amdgpu_gmc_flush_gpu_tlb() in drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c and
amdgpu_gart_unbind() -> amdgpu_gart_invalidate_tlb() in
drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c call amdgpu_dev_enter() before
attempting down_read_trylock(&adev->reset_domain->sem) to bail out during an
ongoing reset:

	if (!amdgpu_dev_enter(adev, &idx))
		return;
	...
		if (!down_read_trylock(&adev->reset_domain->sem)) {
			amdgpu_dev_exit(adev, idx);
			return;
		}

Other task-context paths such as amdgpu_gem_fault(), amdgpu_drm_release(),
amdgpu_ctx_fini(), amdgpu_device_delay_enable_gfx_off(), amdgpu_gart_map(),
amdgpu_vm_update_pdes(), amdgpu_vm_update_range(), amdgpu_vm_pt_clear(), and
amdgpu_ttm_access_memory_sdma() also enter amdgpu_dev_enter() without
holding reset_domain->sem.

> +
> +static inline void amdgpu_dev_exit(struct amdgpu_device *adev, int idx)
> +{
> +	drm_dev_exit(idx);
> +}
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 2f03492336956..3f1295c834441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -426,14 +426,14 @@ void amdgpu_ctx_fini(struct kref *ref)
>  		}
>  	}
> =20
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>  		if (adev->pm.stable_pstate_ctx =3D=3D ctx) {
>  			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
>  			adev->pm.stable_pstate_ctx =3D NULL;
>  		}
>  		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
> =20
>  	kfree(ctx);

[Severity: High]
If the device is wedged when amdgpu_ctx_fini() runs, doesn't skipping this
block leave adev->pm.stable_pstate_ctx pointing to freed ctx memory after
kfree(ctx)?

If the GPU is later recovered and unwedged, __amdgpu_ctx_set_stable_pstate()
in drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c checks:

	current_ctx =3D adev->pm.stable_pstate_ctx;
	if (current_ctx && current_ctx !=3D ctx)
		return -EBUSY;

Because adev->pm.stable_pstate_ctx was never cleared to NULL, subsequent
attempts to set a stable pstate will either permanently fail with -EBUSY or
falsely match if a newly allocated struct amdgpu_ctx reuses the same slab
address.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c48a3c44e2545..066aaed3830e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -732,13 +732,13 @@ void amdgpu_device_mm_access(struct amdgpu_device *=
adev, loff_t pos,
>  	uint64_t last;
>  	int idx;
> =20
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;

[Severity: High]
Can returning early from amdgpu_device_mm_access() when the device is wedged
leak uninitialized kernel heap and stack memory to userspace and corrupt
devcoredumps?

Because amdgpu_device_mm_access() returns void, callers cannot tell that no
data was written into buf:

1. In amdgpu_ttm_vram_read() in drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c, an
uninitialized stack array is passed to amdgpu_device_vram_access() ->
amdgpu_device_mm_access() and then copied to userspace:

	while (size) {
		size_t bytes =3D min(size, AMDGPU_TTM_VRAM_MAX_DW_READ * 4);
		uint32_t value[AMDGPU_TTM_VRAM_MAX_DW_READ];

		amdgpu_device_vram_access(adev, *pos, value, bytes, false);
		if (copy_to_user(buf, value, bytes))
			return -EFAULT;

2. In amdgpu_ttm_access_memory() (wired to amdgpu_gem_vm_ops.access =3D
ttm_bo_vm_access), amdgpu_ttm_access_memory_sdma() now returns -ENODEV on a
wedged GPU and falls back to amdgpu_device_aper_access() and
amdgpu_ttm_vram_mm_access() -> amdgpu_device_mm_access(). For invisible VRAM
BOs, amdgpu_device_mm_access() returns without modifying buf while
amdgpu_ttm_access_memory() still returns the read length, causing
/proc/self/mem (mem_rw()) and ptrace(PTRACE_PEEKDATA)
(generic_ptrace_peekdata()) to copy uninitialized kernel heap or stack
memory to userspace.

3. In amdgpu_job_timedout(), amdgpu_job_core_dump() schedules
adev->coredump_work and then sets adev->wedge_status =3D 1 when recovery is
disabled. When amdgpu_devcoredump_print_ibs() in
drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c runs for
AMDGPU_GEM_CREATE_NO_CPU_ACCESS VRAM IBs, it allocates ib_content with
kvmalloc_array(..., GFP_KERNEL) without zeroing, calls
amdgpu_device_mm_access(), and formats the uninitialized ib_content buffer
into the devcoredump file.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 731fe8f9e9228..cb34ee6690c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3042,13 +3042,13 @@ static int amdgpu_drm_release(struct inode *inode=
, struct file *filp)
>  	struct drm_device *dev =3D file_priv->minor->dev;
>  	int idx;
> =20
> -	if (fpriv && drm_dev_enter(dev, &idx)) {
> +	if (fpriv && amdgpu_dev_enter(drm_to_adev(dev), &idx)) {
>  		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
>  		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(drm_to_adev(dev), idx);
>  	}
> =20
>  	return drm_release(inode, filp);

[Severity: Critical]
What happens when a process closes its DRM file descriptor while the GPU is
wedged?

When adev->wedge_status is non-zero, amdgpu_dev_enter() returns false in
amdgpu_drm_release(), skipping amdgpu_evf_mgr_shutdown(),
amdgpu_userq_mgr_cancel_resume(), amdgpu_evf_mgr_flush_suspend(),
amdgpu_userq_mgr_fini(), and amdgpu_evf_mgr_fini(). Immediately afterwards,
drm_release() invokes amdgpu_driver_postclose_kms() in
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c, which frees fpriv via kfree(fpriv).

Wouldn't skipping that teardown before kfree(fpriv) cause use-after-free and
leaks of the usermode queues and eviction fence manager resources?
Specifically:

- Pending work items (fpriv->evf_mgr.suspend_work,
  fpriv->userq_mgr.resume_work, and fpriv->userq_mgr.reset_work) are not
  cancelled or flushed before fpriv is freed.
- Active struct amdgpu_usermode_queue objects in fpriv->userq_mgr.userq_xa
  are not freed and remain registered in adev->userq_doorbell_xa with
  dangling queue->userq_mgr and queue->vm pointers into the freed fpriv,
  which are later dereferenced during GPU reset
  (amdgpu_userq_mgr_cancel_reset_work(), amdgpu_userq_pre_reset(),
  amdgpu_userq_post_reset()) or driver suspend/unbind
  (amdgpu_userq_suspend()).
- Pinned userq doorbell/MQD/proc_ctx_obj BOs, runtime PM references,
  fpriv->userq_mgr.userq_xa entries, and fpriv->evf_mgr.ev_fence are leaked.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index c4c21dbbbdbf8..62e98e50bf35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -318,7 +318,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>  	if (!adev->gart.ptr)
>  		return;
> =20
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;

[Severity: High]
Could skipping amdgpu_gart_unbind() when the device is wedged leave stale
valid GART PTEs pointing to freed system memory after a subsequent GPU
reset?

When a GTT BO is freed while adev->wedge_status is 1,
ttm_bo_cleanup_memtype_use() -> amdgpu_ttm_tt_unpopulate() ->
amdgpu_ttm_backend_unbind() calls amdgpu_gart_unbind() and sets
gtt->bound =3D false, after which the backing system RAM pages are unmapped
and freed and amdgpu_gtt_mgr_del() removes the drm_mm_node from
adev->mman.gtt_mgr.mm.

If amdgpu_gart_unbind() returns early because amdgpu_dev_enter() fails on a
wedged device, the PTEs in adev->gart.ptr are never cleared. When the GPU is
subsequently reset via amdgpu_device_gpu_recover(),
amdgpu_gtt_mgr_recover() in drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c only
iterates over currently allocated nodes in mgr->mm:

	spin_lock(&mgr->lock);
	drm_mm_for_each_node(mm_node, &mgr->mm) {
		if (mm_node->color =3D=3D GART_ENTRY_WITHOUT_BO_COLOR)
			continue;

		node =3D container_of(mm_node, typeof(*node), mm_nodes[0]);
		amdgpu_ttm_recover_gart(node->base.bo);
	}
	spin_unlock(&mgr->lock);

Any GART range that was freed while wedged is no longer in mgr->mm and its
PTEs in adev->gart.ptr are not cleared during recovery (and Mode2 reset
handlers do not call amdgpu_gtt_mgr_recover() at all), leaving valid PTEs
pointing to freed system pages whenever adev->gart.ptr contents survive the
reset.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index e6172a9684cad..ef33472b14d8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -96,7 +96,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)
>  	bool can_reset =3D amdgpu_gpu_recovery && adev->gpu_recovery_enabled;
>  	int idx, r;
> =20
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (!amdgpu_dev_enter(adev, &idx)) {
>  		dev_info(adev->dev, "%s - device unplugged skipping recovery on schedu=
ler:%s",
>  			 __func__, s_job->sched->name);
> =20

[Severity: High]
Won't replacing drm_dev_enter() with amdgpu_dev_enter() in
amdgpu_job_timedout() prevent fence force-completion and leak timed-out jobs
after the first ring timeout wedges the device?

When GPU recovery is disabled (!amdgpu_device_should_recover_gpu(ring->adev=
)),
the first timed-out job wedges the device and force-completes the fences on
that ring:

			/* Declare the device as wedged if it's not already. */
			if (!atomic_xchg(&adev->wedge_status, 1)) {
				/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
				pm_runtime_get_noresume(adev->dev);

				pci_clear_master(adev->pdev);

				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
			}

			guilty_fence =3D to_amdgpu_job(s_job)->hw_fence;

			sched =3D &ring->sched;

			/* Prevent anybody else from touching the ring buffer. */
			drm_sched_wqueue_stop(sched);

			amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);

Because adev->wedge_status is now 1, any subsequent timeout on another ring
(or on the same ring) will fail amdgpu_dev_enter() at the top of
amdgpu_job_timedout() and return DRM_GPU_SCHED_STAT_ENODEV instead of
reaching amdgpu_fence_driver_force_completion() and returning
DRM_GPU_SCHED_STAT_NO_HANG.

In addition to leaving the other rings' fences unsignaled,
drm_sched_job_timedout() in drivers/gpu/drm/scheduler/sched_main.c removes
the job from sched->pending_list before calling timedout_job(job), and only
reinserts it when status =3D=3D DRM_GPU_SCHED_STAT_NO_HANG:

		list_del_init(&job->list);
		spin_unlock(&sched->job_list_lock);

		status =3D job->sched->ops->timedout_job(job);

		if (sched->free_guilty) {
			job->sched->ops->free_job(job);
			sched->free_guilty =3D false;
		}

		if (status =3D=3D DRM_GPU_SCHED_STAT_NO_HANG)
			drm_sched_job_reinsert_on_false_timeout(sched, job);

Returning DRM_GPU_SCHED_STAT_ENODEV while the device is still present and
schedulers are not torn down leaves the timed-out struct drm_sched_job
unreferenced off pending_list and never freed.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aeaf..e0c1a876d76ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1144,12 +1144,12 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
> =20
>  	amdgpu_ttm_fini(adev);
> =20
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>  			arch_phys_wc_del(adev->gmc.vram_mtrr);
>  			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
>  		}
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  }

[Severity: Medium]
Does guarding arch_phys_wc_del() and arch_io_free_memtype_wc() with
amdgpu_dev_enter() in amdgpu_bo_fini() leak the CPU MTRR and PAT
write-combining reservation when unbinding a wedged device or rolling back a
failed probe?

In amdgpu_device_fini_sw() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
amdgpu_device_ip_fini(adev) (which calls gmc_v*_0_sw_fini() ->
amdgpu_bo_fini()) runs before adev->wedge_status is cleared:

	amdgpu_device_ip_fini(adev);
	...
	if (atomic_xchg(&adev->wedge_status, 0))
		pm_runtime_put_autosuspend(adev->dev);

Similarly, during probe failure rollback on SR-IOV when
amdgpu_virt_request_full_gpu() sets adev->no_hw_access =3D true,
amdgpu_dev_enter() will return false even though arch_phys_wc_del() and
arch_io_free_memtype_wc() only clean up host CPU MTRR/PAT state and do not
touch the GPU hardware.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index cd35ff7ca8642..8668684e8e42b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -456,14 +456,14 @@ int amdgpu_uvd_prepare_suspend(struct amdgpu_device=
 *adev)
>  		if (!adev->uvd.inst[j].saved_bo)
>  			return -ENOMEM;
> =20
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
>  			if (amdgpu_ras_intr_triggered())
>  				memset(adev->uvd.inst[j].saved_bo, 0, size);
>  			else
>  				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
> =20
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		}
>  	}
> =20
> @@ -495,9 +495,9 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  		ptr =3D adev->uvd.inst[i].cpu_addr;
> =20
>  		if (adev->uvd.inst[i].saved_bo !=3D NULL) {
> -			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +			if (amdgpu_dev_enter(adev, &idx)) {
>  				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  			}
>  			kvfree(adev->uvd.inst[i].saved_bo);
>  			adev->uvd.inst[i].saved_bo =3D NULL;

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea1..c286df7c6faf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -332,9 +332,9 @@ static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu=
_device *adev, int i)
>  	if (!adev->vcn.inst[i].saved_bo)
>  		return -ENOMEM;
> =20
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
> =20
>  	return 0;
> @@ -383,9 +383,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int=
 i)
>  	ptr =3D adev->vcn.inst[i].cpu_addr;
> =20
>  	if (adev->vcn.inst[i].saved_bo !=3D NULL) {
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		}
>  		kvfree(adev->vcn.inst[i].saved_bo);
>  		adev->vcn.inst[i].saved_bo =3D NULL;

[Severity: High]
When recovering a wedged GPU via amdgpu_device_gpu_recover(), won't
amdgpu_vcn_save_vcpu_bo_inst() and amdgpu_uvd_prepare_suspend() (as well as
vce_v4_0_suspend()) skip saving the VCPU buffer and then overwrite VRAM with
uninitialized memory on resume?

During a GPU reset of a wedged device, amdgpu_device_pre_asic_reset() calls
amdgpu_device_ip_suspend() while adev->wedge_status is still 1 (it is only
cleared later in amdgpu_device_reinit_after_reset()):

1. amdgpu_vcn_save_vcpu_bo_inst() and amdgpu_uvd_prepare_suspend() allocate
   saved_bo with kvmalloc(size, GFP_KERNEL) without __GFP_ZERO, and then
   call amdgpu_dev_enter(adev, &idx). Because adev->wedge_status is 1,
   amdgpu_dev_enter() returns false and skips memcpy_fromio(), leaving
   saved_bo non-NULL and filled with uninitialized kernel memory (and
   vce_v4_0_suspend() similarly skips saving into adev->vce.saved_bo).
2. Later in amdgpu_do_asic_reset(), amdgpu_device_reinit_after_reset()
   clears adev->wedge_status to 0 and runs amdgpu_device_ip_resume_phase2().
3. amdgpu_vcn_resume(), amdgpu_uvd_resume(), and vce_v4_0_resume() see
   saved_bo !=3D NULL and amdgpu_dev_enter(adev, &idx) =3D=3D true, and cop=
y the
   uninitialized saved_bo buffer into the VCPU BO in VRAM via memcpy_toio().

Furthermore, on ASICs that use Mode2 reset handlers where
amdgpu_do_asic_reset() returns directly from amdgpu_reset_perform_reset()
without calling amdgpu_device_reinit_after_reset(), adev->wedge_status
remains 1 during restore_hwcontext, causing amdgpu_dev_enter() to fail in
amdgpu_gart_map*() and amdgpu_gmc_flush_gpu_tlb() during IP resume and ring
tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152000.2200=
1-1-pierre-eric.pelloux-prayer@amd.com?part=3D5
