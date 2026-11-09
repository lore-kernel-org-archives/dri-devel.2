Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A47606A33C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKz9ku1e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C31610F4A2;
	Mon,  9 Nov 2026 17:56:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1251610E18A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C410601EF;
 Mon,  9 Nov 2026 17:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95A21F008A2;
 Mon,  9 Nov 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794246954;
 bh=B31zsg4ScaFheKgMRM1pnugJ/7Id1jGLT+hPJrbErbM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lKz9ku1eL+6l3dQ41Vy4dmCCWSJdpM7pTzATsZv/859E3pNP+RIbxbSQQGl9U04a4
 m2WPdxY5WrDIIa+8/6EcXGubPICFtE3a8K06oRbXqN7TgPvvDShND2iGsFdo5z+Czp
 50pNQ0+K8orLKFDj2wfk/QF7pEkiobNZbRaimSLY6z/KLpW9ozXxJiRQGZtqVODCuN
 jwr3IOHrgaNon/sJ/n/nc/zjlr2Pg1MTtlkT2fIYw13x60k1/kuDTjaRijymrxzUXA
 NVPm2Hk+q4mMqNOMLt3s/StRePcWIWDkOGYRT0C7NaQfub2T2Q3x7uFZZ4dqRIiCTV
 6zS/TppD5IHSw==
Message-ID: <sashiko-outbox-205354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/amdgpu: add wedge event implementation
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109171333.4329-5-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:55:52 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/amdgpu: wedge_status and runtime PM ref not reset on Mode-2
  or SR-IOV reset
- [High] drm/amdgpu: pci_clear_master() in amdgpu_job_timedout() breaks
  reset recovery
- [High] drm/amdgpu: amdgpu_job_timedout() only force-completes the
  timed-out ring
- [High] drm/amdkfd: returning NULL in kfd_process_device_data_by_id()
  breaks cleanup
- [Medium] drm/amdgpu: dropped amdgpu_in_reset() guard in SR-IOV debugfs
  access helpers
--

commit 0aba431562381113abbf37e2dd1f6f92109a2746
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: add wedge event implementation

This commit implements DRM wedge event support for amdgpu when GPU
recovery is disabled, force-completing fences on job timeout and
rejecting new work until a reset is triggered.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f284e433b72bf..24547ea842d49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -5152,6 +5156,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
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
Does clearing wedge_status and dropping the runtime PM reference only in
amdgpu_device_reinit_after_reset() leave the GPU permanently wedged and
leak the runtime PM reference on ASICs that use reset_cntl Mode-2 handlers
or SR-IOV reset?

In amdgpu_do_asic_reset(), amdgpu_reset_perform_reset() runs first and
returns early whenever a reset_cntl handler is registered (such as on
Aldebaran, Sienna Cichlid, SMU v13.0.10, and SOC v1.0), bypassing
amdgpu_device_reinit_after_reset() entirely:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_do_asic_reset() {
    ...
	r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
	/* If reset handler not implemented, continue; otherwise return */
	if (r =3D=3D -EOPNOTSUPP)
		r =3D 0;
	else
		return r;
    ...
}

SR-IOV VF resets also bypass amdgpu_do_asic_reset() via
amdgpu_device_reset_sriov().  On these paths, GART TLB flushes in
amdgpu_gmc_flush_gpu_tlb() are skipped during recovery, the runtime PM
reference from amdgpu_job_timedout() is leaked, and the device continues
rejecting CS, GEM, INFO, and KFD ioctls and canceling jobs after the reset
completes.

In addition, on paths that do reach amdgpu_device_reinit_after_reset(),
clearing wedge_status at the start of the loop exposes the device as
unwedged before ASIC init, firmware loading, IP resume, and IB ring tests
have succeeded.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index d01df35de11b2..1caae49f93369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
[ ... ]
> @@ -184,9 +185,30 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>  		if (r)
>  			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>  	} else {
> -		drm_sched_suspend_timeout(&ring->sched);
> -		if (amdgpu_sriov_vf(adev))
> -			adev->virt.tdr_debug =3D true;
> +		struct drm_gpu_scheduler *sched;
> +		struct amdgpu_fence *guilty_fence;
> +
> +		/* Declare the device as wedged if it's not already. */
> +		if (!atomic_xchg(&adev->wedge_status, 1)) {
> +			/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
> +			pm_runtime_get_noresume(adev->dev);
> +
> +			pci_clear_master(adev->pdev);

[Severity: High]
Does calling pci_clear_master() here break subsequent GPU reset recovery?

Clearing PCI_COMMAND_MASTER when wedging the device causes
amdgpu_device_mode1_reset() and nv_asic_mode2_reset() to cache
adev->pci_state with bus mastering disabled, so later calls to
amdgpu_device_load_pci_state() restore PCI_COMMAND without bus mastering:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_mode1_reset() {
    ...
	/* Cache the state before bus master disable. The saved config space
	 * values are used in other cases like restore after mode-2 reset.
	 */
	amdgpu_device_cache_pci_state(adev->pdev);

	/* disable BM */
	pci_clear_master(adev->pdev);
    ...
}

It also leaves bus mastering disabled during pre-reset IP suspend, during
post-reset PSP firmware loading in amdgpu_device_fw_loading() (which runs
before amdgpu_device_ip_resume_phase2() re-enables bus mastering via IH
resume), and permanently across Mode-2 resets such as
smu_v13_0_10_mode2_restore_ip() that only resume GFX, MES, and SDMA without
calling pci_set_master().  While wedged, disabling bus mastering also
prevents KIQ fence writebacks in amdgpu_kiq_rreg() and amdgpu_kiq_wreg()
from completing during debugfs register inspection.

> +
> +			drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
> +		}
> +
> +		guilty_fence =3D to_amdgpu_job(s_job)->hw_fence;
> +
> +		sched =3D &ring->sched;
> +
> +		/* Prevent anybody else from touching the ring buffer. */
> +		drm_sched_wqueue_stop(sched);
> +
> +		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
> +
> +		/* Start the scheduler again */
> +		drm_sched_wqueue_start(sched);
>  	}

[Severity: High]
What happens to in-flight fences on other rings when the device wedges?

pci_clear_master() disables DMA fence writebacks and interrupts across the
entire PCI device before drm_sched_wqueue_stop() stops even the timed-out
ring, and amdgpu_fence_driver_force_completion() is only called on that
single ring.  Pending fences on rings with infinite timeouts (such as
compute rings with MAX_SCHEDULE_TIMEOUT) or non-scheduler rings (KIQ and
MES) will never signal.  Other active scheduler rings will suffer secondary
timeouts that call amdgpu_job_core_dump() at the top of
amdgpu_job_timedout(), overwriting the initial hang's IP state dump and
marking their fences with -ETIME instead of -ECANCELED.

Also, because amdgpu_job_prepare_job() does not check
amdgpu_device_is_wedged(), restarting the scheduler queue allows queued
jobs on the wedged ring to block in amdgpu_job_prepare_job() on unsignaled
gang, isolation, or VMID fences from other rings instead of reaching
amdgpu_job_run() to be canceled.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 21a935d9d32dd..b6af5284f4466 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1255,12 +1255,12 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
> =20
>  static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *ade=
v)
>  {
> -	return amdgpu_sriov_is_debug(adev) ? true : false;
> +	return amdgpu_device_is_wedged(adev) ? true : false;
>  }
> =20
>  static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
>  {
> -	return amdgpu_sriov_is_normal(adev) ? true : false;
> +	return !amdgpu_device_is_wedged(adev) ? true : false;
>  }
> =20
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)

[Severity: Medium]
Should amdgpu_virt_access_debugfs_is_mmio() and
amdgpu_virt_access_debugfs_is_kiq() still check !amdgpu_in_reset(adev)?

Previously, amdgpu_sriov_is_debug() and amdgpu_sriov_is_normal() both
required !amdgpu_in_reset(adev), so amdgpu_virt_enable_access_debugfs()
returned -EPERM while an SR-IOV VF reset was in progress.  Without that
check, the two helpers are boolean complements, making the -EPERM branch in
amdgpu_virt_enable_access_debugfs() dead code and allowing debugfs register
reads during a VF reset to set AMDGPU_SRIOV_CAPS_RUNTIME via
amdgpu_virt_disable_access_debugfs() while the VF is in exclusive reset
mode.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6663718fb83ce..b83f6994394c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2449,8 +2449,12 @@ struct kfd_process_device *kfd_process_device_data=
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
Does returning NULL from kfd_process_device_data_by_id() when the GPU is
wedged break KFD resource cleanup, SVM eviction, and WARN invariants?

Several KFD paths use kfd_process_device_data_by_id() to tear down state or
complete multi-step operations on an existing process device:

1. In svm_range_set_attr(), svm_range_check_attr() validates the GPU ID via
kfd_process_gpuidx_from_gpuid() (which does not check
amdgpu_device_is_wedged()), and svm_range_best_prefetch_location() then
looks up the node via svm_range_get_node_by_id() ->
kfd_process_device_data_by_id(), hitting WARN_ONCE(1, "failed to get valid
kfd node at id%x\n", best_loc).

2. In kfd_ioctl_unmap_memory_from_gpu(), if the GPU wedges before the
post-sync loop, kfd_process_device_data_by_id() returns NULL, triggering
WARN_ON_ONCE(!peer_pdd) and skipping amdgpu_amdkfd_gpuvm_dmaunmap_mem().
Similarly, kfd_ioctl_free_memory_of_gpu() and
kfd_ioctl_unmap_memory_from_gpu() fail with -EINVAL, preventing userspace
from freeing BOs on the wedged GPU or unmapping and freeing BOs on healthy
peer GPUs that were mapped to the wedged GPU.

3. In svm_range_evict_svm_bo(), prange is unlinked from svm_bo->range_list
before calling svm_migrate_vram_to_ram(), which fails with -ENODEV when
kfd_process_device_data_by_id() returns NULL, leaving prange detached with
its svm_bo and VRAM node unreleased.

4. In profile_lock_device(), kfd_profiler_pmc(), and
kfd_profiler_ptl_control(), returning NULL prevents unlocking
kfd->profiler_process or releasing ptl->disable_ref on a wedged GPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109171333.4329=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D5
