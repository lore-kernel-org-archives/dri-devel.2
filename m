Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDC606A323
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/cN9V+s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5661123E8;
	Thu, 29 Oct 2026 15:46:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6F1123E8
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:46:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7BA6600E4;
 Thu, 29 Oct 2026 15:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CBF1F01816;
 Thu, 29 Oct 2026 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793288799;
 bh=mWSCGWOHzZRQHZLP5E9ZGw6qJmIPmtBUrWvfaGYqUGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f/cN9V+swWJBu+evYkGR1PNBK9OIB3q2b5WY71FyB2vSVgxfLHxd5yGvoaV0dq0Mr
 N1WMqdM4sT2EBwLmcWCgHlf6TCMuOy0un22xeQ5T8jwI/DFw9lTXD1r60/j1Vm/qa9
 4uCFDhXI16uVSbyAUQW5K/+FU7qOeSJYJUcoRDgKaiXGuv3gvFZ0epjucH9g76Qhap
 z/xlpIeEwLKVz4iMjHMpPmWOWp+4hIfDflN4s/317a50fOb1lwh8Xm+FZas99wzgeb
 zs1cEO3JczJTtlVgOQO7fsIle43EXB3bsZwOXLiOrDkcZiYCwIz/ixyZHEtxQI3QhI
 hfCOZR9pyqkjA==
Message-ID: <sashiko-outbox-189639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:46:39 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] drm/amdgpu: goto in amdgpu_gem_va_ioctl() skips cleanup guard =
init
- [High] drm/amdgpu: wedge_status and rpm ref leaked or cleared early on re=
set
- [High] drm/amdgpu: pci_clear_master() in amdgpu_job_timedout() breaks res=
et
- [High] drm/amdgpu: amdgpu_job_timedout() leaves other rings fences unsign=
aled
- [High] drm/amdkfd: NULL dereference in kfd_profiler_pmc() when GPU wedges
- [High] drm/amdkfd: kfd_process_device_data_by_id() breaks unmap/free on w=
edge
--

commit 567ed14b8d61a592e7054bc4f4ee30c73a041c70
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: add wedge event implementation

This commit adds DRM wedge event support to amdgpu when GPU auto-recovery is
disabled. On a job timeout without recovery, pending fences on the ring are
force-signalled, runtime PM is held, and new work submissions and KFD looku=
ps
are rejected until the GPU is reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3658e46141ada..c48a3c44e2545 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -4405,6 +4406,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
>  		amdgpu_sync_free(&adev->isolation[i].prev);
>  	}
> =20
> +	if (atomic_xchg(&adev->wedge_status, 0))
> +		pm_runtime_put_autosuspend(adev->dev);
> +
>  	amdgpu_reset_fini(adev);
> =20
>  	/* free i2c buses */
> @@ -5212,6 +5216,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
_reset_context *reset_context)
>  	r =3D 0;
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>  		amdgpu_set_init_level(tmp_adev, init_level);
> +
> +		if (atomic_xchg(&tmp_adev->wedge_status, 0))
> +			pm_runtime_put_autosuspend(tmp_adev->dev);
> +
>  		if (full_reset) {
>  			/* post card */
>  			amdgpu_reset_set_dpc_status(tmp_adev, false);

[Severity: High]
Can this leave adev->wedge_status set and leak the runtime PM reference on
ASICs that use reset_cntl handlers, or clear wedge_status too early during
reset?

In drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, amdgpu_do_asic_reset() calls
amdgpu_reset_perform_reset() first and returns before reaching
amdgpu_device_reinit_after_reset() whenever a reset handler is implemented:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_do_asic_reset() {
	...
	reset_context->reset_device_list =3D device_list_handle;
	r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
	/* If reset handler not implemented, continue; otherwise return */
	if (r =3D=3D -EOPNOTSUPP)
		r =3D 0;
	else
		return r;
	...
}

For all ASICs that register adev->reset_cntl in amdgpu_reset_init()
(aldebaran, sienna_cichlid, smu_v13_0_10, and soc_v1_0), their
restore_hwcontext callbacks never call amdgpu_device_reinit_after_reset().
As a result, triggering a reset after a wedge leaves adev->wedge_status set=
 to
1 (causing amdgpu_gmc_flush_gpu_tlb() during GART enable to skip TLB
invalidation, amdgpu_job_run() to cancel all jobs with -ECANCELED, and ioct=
ls
and KFD lookups to fail) and leaks the runtime PM reference until driver
unload.

Even on ASICs that do reach amdgpu_device_reinit_after_reset(), clearing
tmp_adev->wedge_status and calling pm_runtime_put_autosuspend() at the start
of the loop happens before amdgpu_device_asic_init(), IP resume phases, and
amdgpu_ib_ring_tests() succeed. Concurrent ioctls that do not acquire
reset_domain->sem can observe wedge_status =3D=3D 0 while the hardware is
mid-reset, and if reset fails, wedge_status remains 0 with the runtime PM
reference already dropped.

Additionally, on driver unbind (for example via DRM_WEDGE_RECOVERY_REBIND),
amdgpu_device_fini_sw() only runs from drm_driver.release when the last open
DRM file descriptor is closed, rather than synchronously in
amdgpu_pci_remove() -> amdgpu_device_fini_hw(). If a userspace process keeps
an fd open across unbind/rebind, won't the runtime PM reference on adev->dev
stay held across the unbind and be dropped later on the newly bound device?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 2145211b25e7e..85406b0b0125c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
[ ... ]
> @@ -948,6 +951,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void=
 *data,
>  		abo =3D NULL;
>  	}
> =20
> +	if (amdgpu_device_is_wedged(adev)) {
> +		r =3D -ENODEV;
> +		goto error_put_gobj;
> +	}
> +
>  	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> =20
>  	r =3D PM_RUNTIME_ACQUIRE_ERR(&lock);

[Severity: Critical]
Does this goto in amdgpu_gem_va_ioctl() jump over the initialization of the
cleanup-managed lock variable?

In drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c,
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock) declares lock with
__cleanup(class_pm_runtime_active_auto_try_enabled_destructor). Jumping to
error_put_gobj from before that macro enters the scope of lock without
initializing it:

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:amdgpu_gem_va_ioctl() {
	...
	if (amdgpu_device_is_wedged(adev)) {
		r =3D -ENODEV;
		goto error_put_gobj;
	}

	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
	...
error_put_gobj:
	drm_gem_object_put(gobj);
	return r;
}

Aside from breaking the build under Clang (-Werror=3Djump-misses-init), whe=
n the
GPU is wedged and userspace calls DRM_IOCTL_AMDGPU_GEM_VA, returning from
error_put_gobj invokes class_pm_runtime_active_auto_try_enabled_destructor()
on the uninitialized stack variable lock, passing uninitialized stack conte=
nts
to pm_runtime_put_autosuspend().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 70a9a7d4650fb..e6172a9684cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
[ ... ]
> @@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>  		if (r)
>  			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>  	} else {
> -		drm_sched_suspend_timeout(&ring->sched);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_vf(adev)) {
> +			drm_sched_suspend_timeout(&ring->sched);
>  			adev->virt.tdr_debug =3D true;
> +		} else {
> +			struct drm_gpu_scheduler *sched;
> +			struct amdgpu_fence *guilty_fence;
> +
> +			/* Declare the device as wedged if it's not already. */
> +			if (!atomic_xchg(&adev->wedge_status, 1)) {
> +				/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
> +				pm_runtime_get_noresume(adev->dev);
> +
> +				pci_clear_master(adev->pdev);

[Severity: High]
Does calling pci_clear_master(adev->pdev) here in amdgpu_job_timedout() bre=
ak
subsequent GPU resets when the user later triggers recovery?

When a Mode 1 reset runs later via amdgpu_device_mode1_reset() in
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, it caches the current PCI
configuration space before clearing bus master itself:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_mode1_reset() {
	...
	/* Cache the state before bus master disable. The saved config space
	 * values are used in other cases like restore after mode-2 reset.
	 */
	amdgpu_device_cache_pci_state(adev->pdev);

	/* disable BM */
	pci_clear_master(adev->pdev);
	...
	amdgpu_device_load_pci_state(adev->pdev);
	...
}

Because amdgpu_job_timedout() already cleared PCI_COMMAND_MASTER,
amdgpu_device_cache_pci_state() overwrites adev->pci_state with bus masteri=
ng
disabled, and amdgpu_device_load_pci_state() restores it without bus
mastering enabled during ASIC init, phase 1 resume, and PSP firmware loadin=
g.

In addition, amdgpu_device_pre_asic_reset() -> amdgpu_device_ip_suspend()
runs with bus mastering disabled (affecting DMA during suspend, such as
psp_suspend()), and Mode 2 reset paths that only resume GFX, MES, and SDMA
without resuming IH:

drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c:smu_v13_0_10_mode2_restore_ip() {
	...
	for (i =3D 0; i < adev->num_ip_blocks; i++) {
		if (!(adev->ip_blocks[i].version->type =3D=3D
			      AMD_IP_BLOCK_TYPE_GFX ||
		      adev->ip_blocks[i].version->type =3D=3D
			      AMD_IP_BLOCK_TYPE_MES ||
		      adev->ip_blocks[i].version->type =3D=3D
			      AMD_IP_BLOCK_TYPE_SDMA))
			continue;
		r =3D amdgpu_ip_block_resume(&adev->ip_blocks[i]);
	...
}

never re-enable PCI bus mastering at all after reset.

> +
> +				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
> +			}
> +
> +			guilty_fence =3D to_amdgpu_job(s_job)->hw_fence;
> +
> +			sched =3D &ring->sched;
> +
> +			/* Prevent anybody else from touching the ring buffer. */
> +			drm_sched_wqueue_stop(sched);
> +
> +			amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
> +
> +			/* Start the scheduler again */
> +			drm_sched_wqueue_start(sched);
> +		}
>  	}

[Severity: High]
What happens to in-flight fences on other rings when amdgpu_job_timedout()
clears bus mastering for the whole device, and is drm_dev_wedged_event() se=
nt
before fences are signalled?

In drivers/gpu/drm/amd/amdgpu/amdgpu_job.c, amdgpu_job_timedout() calls
pci_clear_master(adev->pdev) and emits drm_dev_wedged_event() before stoppi=
ng
the scheduler or calling amdgpu_fence_driver_force_completion(), and only
force-completes fences on the single timed-out ring.

Once pci_clear_master() disables DMA writebacks and MSI interrupts across t=
he
entire PCI function:

1. In-flight fences on rings without a finite scheduler timeout (such as
   compute rings when lockup_timeout is 0, or KIQ/MES polling rings) cannot
   signal via hardware writeback and are never force-completed, leaving fen=
ce
   waiters blocked indefinitely.
2. In-flight jobs on other rings with finite timeouts are forced into
   secondary TDR timeouts, which unconditionally call amdgpu_job_core_dump()
   at the top of amdgpu_job_timedout() and overwrite the original hang's IP
   state dump.
3. Calling drm_dev_wedged_event() beforeamdgpu_fence_driver_force_completio=
n()
   notifies userspace before pending fences on the wedged device have been
   signalled.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index ac18c2be6ecb6..b95dddeaccc51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data=
_by_id(struct kfd_process *p,
>  		for (i =3D 0; i < p->n_pdds; i++) {
>  			struct kfd_process_device *pdd =3D p->pdds[i];
> =20
> -			if (pdd->user_gpu_id =3D=3D gpu_id)
> +			if (pdd->user_gpu_id =3D=3D gpu_id) {
> +				if (amdgpu_device_is_wedged(pdd->dev->adev))
> +					return NULL;
> +
>  				return pdd;
> +			}
>  		}
>  	}
>  	return NULL;

[Severity: High]
Can returning NULL from kfd_process_device_data_by_id() when the device wed=
ges
cause a NULL pointer dereference in kfd_profiler_pmc()?

In drivers/gpu/drm/amd/amdkfd/kfd_chardev.c, kfd_profiler_pmc() first calls
profile_lock_device(), which looks up pdd under p->mutex and then drops
p->mutex. Afterward, kfd_profiler_pmc() re-acquires p->mutex and calls
kfd_process_device_data_by_id() a second time without checking for NULL:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_profiler_pmc() {
	...
	retval =3D profile_lock_device(p, args->gpu_id, args->lock);
	if (retval < 0)
		return retval;

	/* Enable/disable perfcount if requested */
	mutex_lock(&p->mutex);\n	pdd =3D kfd_process_device_data_by_id(p, args->gp=
u_id);
	dqm =3D pdd->dev->dqm;
	mutex_unlock(&p->mutex);
	...
}

Because adev->wedge_status is set asynchronously in amdgpu_job_timedout(), =
if
the GPU becomes wedged between the lookup in profile_lock_device() and the
lookup in kfd_profiler_pmc(), pdd is NULL and pdd->dev->dqm dereferences NU=
LL.
Furthermore, if a process already locked the device for profiling before the
wedge, subsequent calls to profile_lock_device() with op =3D=3D 0 or
kfd_profiler_ptl_control() will fail with -EINVAL and be unable to release
kfd->profiler_process or the PTL disable reference.

[Severity: High]
Does returning NULL from kfd_process_device_data_by_id() also break KFD mem=
ory
unmap, free, and SVM eviction paths when a GPU becomes wedged?

Several KFD paths rely on kfd_process_device_data_by_id() to look up an
existing pdd during cleanup or after waiting on fences:

1. In drivers/gpu/drm/amd/amdkfd/kfd_chardev.c,
   kfd_ioctl_unmap_memory_from_gpu() and kfd_ioctl_map_memory_to_gpu() look=
 up
   peer_pdd in a first loop, wait in amdgpu_amdkfd_gpuvm_sync_memory(), and
   then look up peer_pdd again in a second loop:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_unmap_memory_from_gpu() {
	...
	/* Flush TLBs after waiting for the page table updates to complete */
	for (i =3D 0; i < args->n_devices; i++) {
		peer_pdd =3D kfd_process_device_data_by_id(p, devices_arr[i]);
		if (WARN_ON_ONCE(!peer_pdd))
			continue;
		if (flush_tlb)
			kfd_flush_tlb(peer_pdd);

		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
		err =3D amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
	...
}

   If the GPU wedges while waiting in amdgpu_amdkfd_gpuvm_sync_memory() (wh=
ich
   returns 0 once the fences are force-completed), the second lookup returns
   NULL, triggering WARN_ON_ONCE(!peer_pdd) and skipping
   amdgpu_amdkfd_gpuvm_dmaunmap_mem().
2. Once wedged, kfd_ioctl_free_memory_of_gpu() and
   kfd_ioctl_unmap_memory_from_gpu() fail with -EINVAL because
   kfd_process_device_data_by_id() returns NULL, preventing userspace from
   unmapping or freeing BOs on the wedged GPU (or freeing BOs on healthy GP=
Us
   that were peer-mapped to the wedged GPU).
3. In drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_node_by_id() calls
   kfd_process_device_data_by_id(). When a GPU is wedged,
   svm_range_best_prefetch_location() triggers WARN_ONCE(1, "failed to get
   valid kfd node at id%x\n", best_loc), and TTM eviction in
   svm_range_evict_svm_bo() -> svm_migrate_vram_to_ram() fails with -ENODEV
   after prange has already been unlinked from svm_bo->range_list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029152000.2200=
1-1-pierre-eric.pelloux-prayer@amd.com?part=3D4
