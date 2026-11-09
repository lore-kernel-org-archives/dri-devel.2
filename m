Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51273606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nw/HUTT2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7904210E068;
	Mon,  9 Nov 2026 17:47:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A74910E068
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:47:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E937563367;
 Mon,  9 Nov 2026 17:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFB1F008BD;
 Mon,  9 Nov 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794246464;
 bh=ZFf4NGsCGZwL04Wk2qb9grYnZap0Wi2NHw3zEVlCvU4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nw/HUTT2kDDXOIQu7L2n++9FbqmS5FcEiSzCvif2tNM5OYscbYPE5QmI91C/wNCbU
 SivyTvMk6ZKlYBzeJUCDV8IQe+/eeLdfsDf97L1hfEq0INHFp55adgV5TLexMnQPZu
 A0n9/M5FftGzWk78qRRpvsHajWXxPoQNalRaOR4PilrJxAuG5DONt9eayGv/HBMnqA
 NUeoWLgbOvhkoSV8bHo6LqP7WoANjN7lxa4xaTnKUdjWRGcwlwUxAB/PJ9v71BNAmQ
 MBXB4LNwqzGMxVunbJIphizFrYLr4wATypWa0d92q0mxNV1T91T5IoEScRHWPyvETj
 d6/00o7pHgcmw==
Message-ID: <sashiko-outbox-205340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/amdgpu: introduce amdgpu_dev_enter / exit
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109171333.4329-6-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-6-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:47:44 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] drm/amdgpu: UAF and leaks in amdgpu_drm_release() when device
  is wedged
- [High] drm/amdgpu: stale PTEs and broken open when wedged in GART/VM
  helpers
- [High] drm/amdgpu: uninitialized saved_bo copied to VRAM on reset of
  wedged GPU
- [High] drm/amdgpu: SR-IOV and Mode-2 resets fail to clear wedge_status
- [High] drm/amdgpu: NULL pointer dereference in amdgpu_vm_init() when
  wedged
- [High] drm/amdgpu: dangling entry->bo in amdgpu_vm_pt_alloc() when
  wedged
- [Medium] drm/amdgpu: WC memtype and MTRR leak in amdgpu_bo_fini() when
  wedged
- [Medium] drm/amdgpu: unplug deadlock in amdgpu_gmc_flush_gpu_tlb() on
  fence wait
- [Medium] drm/amdgpu: amdgpu_vram_mgr_dmem_reclaim() misses
  amdgpu_dev_enter()
--

commit 0d8a6bc2888d88350480e40fc5320cb5adf242ad
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: introduce amdgpu_dev_enter / exit

This commit introduces amdgpu_dev_enter() and amdgpu_dev_exit() wrappers
that check whether the device is wedged before calling drm_dev_enter(), and
converts existing drm_dev_enter() and drm_dev_exit() call sites across
amdgpu.

Link: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pel=
loux-prayer@amd.com?part=3D5

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 45680878aa5a1..4ba1772d9eb62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
[ ... ]
> @@ -1384,4 +1385,17 @@ static inline bool amdgpu_device_is_wedged(struct =
amdgpu_device *adev)
>  	return atomic_read(&adev->wedge_status);
>  }
> =20
> +static inline bool amdgpu_dev_enter(struct amdgpu_device *adev, int *idx)
> +{
> +	if (amdgpu_device_is_wedged(adev))
> +		return false;
> +
> +	return drm_dev_enter(adev_to_drm(adev), idx);
> +}
> +
> +static inline void amdgpu_dev_exit(struct amdgpu_device *adev, int idx)
> +{
> +	drm_dev_exit(idx);
> +}
> +
>  #endif

[Severity: Medium]
Should amdgpu_vram_mgr_dmem_reclaim() also use amdgpu_dev_enter() and
amdgpu_dev_exit()?

It still calls drm_dev_enter().  When dmem cgroup reclaim runs on a wedged
GPU, ttm_resource_manager_dmem_reclaim() -> amdgpu_bo_move() ->
amdgpu_move_blit() submits an SDMA copy job whose fence amdgpu_job_run()
immediately cancels and signals without copying, causing
ttm_bo_move_accel_cleanup() to free the source VRAM resource and lose the
BO contents.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3e5634de077f1..4c3aa4e4d4c95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3030,13 +3030,13 @@ static int amdgpu_drm_release(struct inode *inode=
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

[Severity: High]
Does skipping userq_mgr and evf_mgr teardown when the device is wedged
cause a use-after-free on fpriv?

When a process closes its DRM fd while the GPU is wedged,
amdgpu_dev_enter() returns false and skips tearing down fpriv->userq_mgr
and fpriv->evf_mgr, after which drm_release() ->
amdgpu_driver_postclose_kms() unconditionally frees fpriv.  Any usermode
queues remain in adev->userq_doorbell_xa with queue->userq_mgr pointing
into the freed fpriv, which is dereferenced during GPU reset or suspend:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:amdgpu_userq_mgr_cancel_reset_wor=
k() {
	...
	xa_for_each(xa, queue_id, queue) {
		cancel_delayed_work(&queue->hang_detect_work);
		cancel_work(&queue->userq_mgr->reset_work);
	}
}

Skipping teardown also leaves fpriv->evf_mgr.suspend_work,
fpriv->userq_mgr.resume_work and fpriv->userq_mgr.reset_work uncanceled,
and leaves unsignaled eviction fences on BOs with ev_fence->evf_mgr
pointing into the freed fpriv when amdgpu_eviction_fence_enable_signaling()
schedules suspend_work.

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
> =20
>  	t =3D offset / AMDGPU_GPU_PAGE_SIZE;
> @@ -335,7 +335,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, u=
int64_t offset,
>  	}
>  	amdgpu_gart_invalidate_tlb(adev);
> =20
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }

[Severity: High]
Does returning early from amdgpu_gart_unbind() when wedged leave stale GART
PTEs pointing to freed system pages across a subsequent GPU reset?

When a GTT BO is unbound while wedged, amdgpu_ttm_backend_unbind() marks
gtt->bound =3D false, TTM frees the backing system pages, and
amdgpu_gtt_mgr_del() frees the drm_mm_node without clearing the PTEs in
adev->gart.ptr to dummy_page_addr.  If the GPU later recovers via reset,
amdgpu_gtt_mgr_recover() only rewrites PTEs for still-allocated nodes in
mgr->mm, leaving the unallocated slots mapped to the freed pages when
adev->gart.ptr is in system RAM or preserved VRAM.

Similarly, returning -ENODEV when wedged from amdgpu_vm_update_range(),
amdgpu_vm_update_pdes() and amdgpu_vm_pt_clear() causes
amdgpu_vm_clear_freed() to drop mappings from vm->freed without clearing
their PTEs, logs dev_err in amdgpu_gem_object_close() on every closed BO,
and causes amdgpu_driver_open_kms() to fail with -ENODEV when opening the
DRM device node.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index b9afcbab02f9d..e435cb0c9d7f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -728,9 +728,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *a=
dev, uint32_t vmid,
>  	struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>  	struct dma_fence *fence;
>  	struct amdgpu_job *job;
> -	int r;
> +	int r, idx;
> =20
> -	if (amdgpu_device_is_wedged(adev))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
[ ... ]
> @@ -782,11 +785,13 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device =
*adev, uint32_t vmid,
> =20
>  	dma_fence_wait(fence, false);
>  	dma_fence_put(fence);
> +	amdgpu_dev_exit(adev, idx);
> =20
>  	return;

[Severity: Medium]
Can holding amdgpu_dev_enter() across dma_fence_wait() deadlock with
drm_dev_unplug() on hot-unplug?

CPU0                              CPU1
amdgpu_gmc_flush_gpu_tlb()
  amdgpu_dev_enter()
  fence =3D amdgpu_job_submit(job)
                                  amdgpu_pci_remove()
                                    drm_dev_unplug()
                                      dev->unplugged =3D true
                                      synchronize_srcu(&drm_unplug_srcu)
  dma_fence_wait(fence, false)
                                  amdgpu_job_timedout()
                                    drm_dev_enter() -> false
                                    return DRM_GPU_SCHED_STAT_ENODEV
                                      <-- fence is never signaled

When hub->sdma_invalidation_workaround is used, amdgpu_job_timedout() bails
out once dev->unplugged is set without force-completing the job fence, and
amdgpu_pci_remove() cannot reach amdgpu_fence_driver_hw_fini() until
synchronize_srcu(&drm_unplug_srcu) completes.

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
Does amdgpu_bo_fini() leak adev->gmc.vram_mtrr and the aperture WC memtype
reservation when tearing down a wedged device?

In amdgpu_device_fini_sw(), amdgpu_device_ip_fini() runs amdgpu_bo_fini()
before atomic_xchg(&adev->wedge_status, 0) clears wedge_status, so
amdgpu_dev_enter() returns false and skips arch_phys_wc_del() and
arch_io_free_memtype_wc() on a connected PCI device.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e1..703f41b350aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
[ ... ]
> @@ -5155,19 +5155,19 @@ int psp_copy_fw(struct psp_context *psp, uint8_t =
*start_addr, uint32_t bin_size)
>  {
>  	int idx;
> =20
> -	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
> +	if (!amdgpu_dev_enter(psp->adev, &idx))
>  		return -ENODEV;
> =20
>  	if (!bin_size || bin_size > PSP_1_MEG) {
>  		dev_err(psp->adev->dev, "PSP firmware is invalid\n");
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(psp->adev, idx);
>  		return -EINVAL;
>  	}
> =20
>  	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
>  	memcpy(psp->fw_pri_buf, start_addr, bin_size);
> =20
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(psp->adev, idx);
>  	return 0;
>  }

[Severity: High]
Does converting psp_copy_fw() and amdgpu_gmc_init_pdb0() to
amdgpu_dev_enter() break SR-IOV and Mode-2 GPU reset recovery when the
device is wedged?

adev->wedge_status is only cleared during reset in
amdgpu_device_reinit_after_reset().  However, SR-IOV reset in
amdgpu_device_reset_sriov() and custom Mode-2 reset handlers in
amdgpu_do_asic_reset() never call amdgpu_device_reinit_after_reset().
During amdgpu_device_reset_sriov(), psp_copy_fw() fails with -ENODEV and
amdgpu_gmc_init_pdb0() silently skips PDB0 initialization because
wedge_status is still 1, and both reset paths leave the device wedged after
reset completes.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..7477aed52eb1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -352,9 +352,9 @@ static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu=
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
> @@ -403,9 +403,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int=
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
When resetting a wedged GPU, does this overwrite the VCPU buffer in VRAM
with uninitialized kernel memory?

During a reset of a wedged device, amdgpu_device_pre_asic_reset() runs
amdgpu_device_ip_suspend() while adev->wedge_status is still 1.
amdgpu_vcn_save_vcpu_bo_inst() allocates saved_bo with kvmalloc() and skips
memcpy_fromio() because amdgpu_dev_enter() returns false.  Then
amdgpu_device_reinit_after_reset() clears wedge_status to 0 and calls
amdgpu_vcn_resume(), where amdgpu_dev_enter() succeeds and memcpy_toio()
copies the uninitialized saved_bo into the VCPU BO.  The same pattern
occurs in amdgpu_uvd_prepare_suspend() / amdgpu_uvd_resume() and
vce_v4_0_suspend() / vce_v4_0_resume().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e26..9d1fbddcdd7c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -387,7 +387,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>  	if (r)
>  		return r;
> =20
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
> =20
>  	r =3D vm->update_funcs->map_table(vmbo);

[Severity: High]
Does failing amdgpu_vm_pt_clear() when wedged trigger a NULL pointer
dereference in amdgpu_vm_init() whenever the DRM device is opened?

When a process opens the DRM device while wedged, amdgpu_driver_open_kms()
calls amdgpu_vm_init(), which calls amdgpu_vm_pt_clear() and jumps to
error_free_root on -ENODEV:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_init() {
	...
error_free_root:
	amdgpu_vm_pt_free_root(adev, vm);
	amdgpu_bo_unreserve(vm->root.bo);
	amdgpu_bo_unref(&root_bo);
}

amdgpu_vm_pt_free_root() calls amdgpu_vm_pt_free(&vm->root), which sets
vm->root.bo =3D NULL before amdgpu_bo_unreserve(vm->root.bo) dereferences i=
t.

[Severity: High]
Can a -ENODEV return from amdgpu_vm_pt_clear() also leave a dangling
entry->bo pointer in amdgpu_vm_pt_alloc()?

In amdgpu_vm_pt_alloc(), vm->eviction_lock is dropped across
amdgpu_vm_pt_create(), during which a concurrent timeout can wedge the
device.  amdgpu_vm_pt_alloc() then initializes entry with pt_bo before
calling amdgpu_vm_pt_clear():

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:amdgpu_vm_pt_alloc() {
	...
	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
	if (r)
		goto error_unpin;

	return 0;

error_unpin:
	if (p->vm->is_npa)
		amdgpu_bo_unpin(pt_bo);
	amdgpu_bo_unref(&pt_bo);
	return r;
}

When amdgpu_vm_pt_clear() returns -ENODEV, error_unpin frees pt_bo without
calling amdgpu_vm_pt_free(entry), leaving entry->bo pointing to freed
memory and entry->vm_status linked on the VM status list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109171333.4329=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D6
