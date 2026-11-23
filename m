Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33690606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20261120 header.b=8vzZ/cNz;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20261120 header.b=Jb9PN2HC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4955E10EE6E;
	Mon, 23 Nov 2026 14:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="8vzZ/cNz";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="Jb9PN2HC";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FC310EE4E;
 Mon, 23 Nov 2026 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1795444093; bh=x1WFRG8J9RdoZrjAAfMMYi7
 iEabC7Wf6Sf1q2UPWOJI=; b=8vzZ/cNzGBPFNY+j4dGwlSagnztwXpbFAEEUkfVt7Jh8zsy35A
 q74pV91tD0ihm4yDoypyCHyfs5Cl3EnyCDAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1795444093; bh=x1WFRG8J9RdoZrjAAfMMYi7
 iEabC7Wf6Sf1q2UPWOJI=; b=Jb9PN2HCcp12U/L/061HzQJRoLaAqZuMvASNaeJdP/7oOJ7i91
 EuNjfH9tXqjkexVscdE5rV/f5Kt8WmLDeLYEERZH57/Mm/whY3RHvRYLGGCx2qSLtYk/8oaQiAz
 ElEPLyZ163hHc79qqAD9nDJtUkVMNjMKqElca1Mth8D1PeM+ETXpghZMbe9dMe6uRqWWxN5+i1Y
 FDgaMbtF0Nl/vu/sIwShx8ph8Pd27VhsZknmZVwKHuvAOaMpBVMFlKUkRP/WzfMThKgIZIv3+ge
 pJpv8rWSgxG305bbE2gK0LeGozNXTwzBumSO7jQl5bkGrAo8fuCBRT22Sqf9UAb0xbg==;
Message-Instance: m=1; h=sha256:dPG0uDf7AHuaMwtKUzamNmTRo6OYPxABepf4/KW8
 Ii0=:yFP/JueccURZtI8GVahipUQqyjsmaF8wvU7zsc5yOQU=;
DKIM2-Signature: i=1; m=1; t=1795444093; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PGNocmlzdGlhbi5r
 b2VuaWdAYW1kLmNvbT4=,PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+,PHBpZXJyZS1lcmljLnBl
 bGxvdXgtcHJheWVyQGFtZC5jb20+,PHNpbW9uYUBmZndsbC5jaD4=,PGFpcmxpZWRAZ21haWwu
 Y29tPg==,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==,PGRyaS1kZXZlbEBsaXN0
 cy5mcmVlZGVza3RvcC5vcmc+,PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+; s=
 v2-mldsa44-20261103:mldsa44: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
 AAAAAAAAABAaIzY=|v2-ed25519-20261120:ed25519-sha256:BoKsu3um9HitoPf8GMjr
 elJdfwhbWR+87rkYP6jR/9eSEGO6u0JLrdtywV5IASgGbSRIDTmgRSxp1/K3aQniBA==|
 v2-rsa-20261120:rsa-sha256:jMcD0hO4wtj9YT3N8r8q4vDndnwSWg1T40URdrB6MbO5WHYu
 2tPxTVWzQODdi8xRg5kfNNLiB2CTVXXJM87eaqKzIls51LiR8WNKgtw/C7BzL4IZETKANhPg
 QxpEXeXX4hMCdHl3Dw3vFmK5u7R2rv7lhzD+pGAvd749GLoVn3W57J4VKjQGqQs06+3yOR2p
 GUkE8HyL66Qp0YTBpJq28G90VbS7e69MLaXhc5YOIrI1f8TZ8tbEPYLpmj4RSRnJhD/7fR2t
 IB7kmsOsycVzcYthrGxo53bqMsxm6XxItmQgAAG4TH3t9KEkBvgZp2PBepLx2vEjiPJFyizs
 VAWYNg==;
Message-ID: <82f4a46c-5822-4f77-96ac-6e5b8b44d84f@damsy.net>
Date: Mon, 23 Nov 2026 15:28:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdgpu: add wedge event implementation
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20261109171333.4329-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian: v3 of this patch looked "mostly reasonable to [you]". This 
revision is similar, with your comment about tdr_debug addressed.

Could you update your review?

Thanks,
Pierre-Eric

Le 09/11/2026 à 18:13, Pierre-Eric Pelloux-Prayer a écrit :
> When a job times out the kernel tries to reset the GPU to get
> the system back to a normal state.
> Sometimes it's useful to disable this process - for instance to
> be able to inspect the hardware state at the time of the hang.
> Since leaving fence unsignalled might affect the system's
> stability, this commit enables the drm wedge framework for amdgpu.
> 
> When a hang condition is detected, the GPU isn't reset but all
> the pending fences are signalled and the hung GPU cannot receive
> new work. For KFD it's implemented by making
> kfd_process_device_data_by_id return NULL if the requested GPU
> is wedged.
> 
> When the user is done, it's possible to trigger a GPU
> reset.
> 
> The auto-recovery is still enabled by default, and to use this
> feature one has to either:
> * boot with amdgpu.gpu_recovery=0: not recommended as it disables
>    recovery for all GPUs
> * write 0 to /sys/kernel/debug/dri/X/amdgpu_gpu_recover to disable
>    auto-recovery for one GPU only
> 
> Runtime power management is disabled when the device is wedged
> (because we can't submit any work to the GPU).
> 
> Assisted-by: LLM
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 31 +++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ----
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 ++++-
>   10 files changed, 81 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a486ac746a5b..cfbb5ab5a2fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -985,6 +985,13 @@ struct amdgpu_device {
>   	/* Per device gpu_recovery setting. 0 means disabled. */
>   	unsigned int gpu_recovery;
>   
> +	/* Set to 1 when the device has been declared wedged following a
> +	 * hang: it no longer accepts new work and pending fences have been
> +	 * force-signalled. Reset to 0 once the device is reset back to a
> +	 * working state.
> +	 */
> +	atomic_t wedge_status;
> +
>   	/* KFD
>   	 * Must be last --ends in a flexible-array member.
>   	 */
> @@ -1374,4 +1381,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
>   			   uint64_t uid);
>   uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
>   			       enum amdgpu_uid_type type, uint8_t inst);
> +
> +static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
> +{
> +	return atomic_read(&adev->wedge_status);
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fa301c71b782..d119de477284 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1465,6 +1465,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	if (!adev->accel_working)
>   		return -EBUSY;
>   
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>   	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>   
>   	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a812551b353f..7335f9c4d86f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4149,6 +4149,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	}
>   
>   	amdgpu_device_init_gpu_recovery(adev);
> +	atomic_set(&adev->wedge_status, 0);
>   
>   fence_driver_init:
>   	/* Fence driver */
> @@ -4401,6 +4402,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   		amdgpu_sync_free(&adev->isolation[i].prev);
>   	}
>   
> +	if (atomic_xchg(&adev->wedge_status, 0))
> +		pm_runtime_put_autosuspend(adev->dev);
> +
>   	amdgpu_reset_fini(adev);
>   
>   	/* free i2c buses */
> @@ -5144,6 +5148,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>   	r = 0;
>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   		amdgpu_set_init_level(tmp_adev, init_level);
> +
> +		if (atomic_xchg(&tmp_adev->wedge_status, 0))
> +			pm_runtime_put_autosuspend(tmp_adev->dev);
> +
>   		if (full_reset) {
>   			/* post card */
>   			amdgpu_reset_set_dpc_status(tmp_adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index fb60a99f43c1..9b4c76f198f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -459,6 +459,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	uint32_t handle, initial_domain;
>   	int r;
>   
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>   	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>   
>   	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> @@ -967,6 +970,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	if (r)
>   		goto error_put_gobj;
>   
> +	if (amdgpu_device_is_wedged(adev)) {
> +		r = -ENODEV;
> +		goto error_put_gobj;
> +	}
> +
>   	/* Add input syncobj fences (if any) for synchronization. */
>   	r = amdgpu_gem_add_input_fence(filp,
>   				       args->input_fence_syncobj_handles,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4204c3c750a8..53fa9fa83ae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -730,6 +730,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	struct amdgpu_job *job;
>   	int r;
>   
> +	if (amdgpu_device_is_wedged(adev))
> +		return;
> +
>   	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>   
>   	if (!hub->sdma_invalidation_workaround || vmid ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 16391cc2b9a5..61e8f479556e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -24,6 +24,7 @@
>   #include <linux/kthread.h>
>   #include <linux/wait.h>
>   #include <linux/sched.h>
> +#include <linux/pm_runtime.h>
>   
>   #include <drm/drm_drv.h>
>   
> @@ -184,9 +185,30 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		if (r)
>   			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>   	} else {
> -		drm_sched_suspend_timeout(&ring->sched);
> -		if (amdgpu_sriov_vf(adev))
> -			adev->virt.tdr_debug = true;
> +		struct drm_gpu_scheduler *sched;
> +		struct amdgpu_fence *guilty_fence;
> +
> +		/* Declare the device as wedged if it's not already. */
> +		if (!atomic_xchg(&adev->wedge_status, 1)) {
> +			/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
> +			pm_runtime_get_noresume(adev->dev);
> +
> +			pci_clear_master(adev->pdev);
> +
> +			drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
> +		}
> +
> +		guilty_fence = to_amdgpu_job(s_job)->hw_fence;
> +
> +		sched = &ring->sched;
> +
> +		/* Prevent anybody else from touching the ring buffer. */
> +		drm_sched_wqueue_stop(sched);
> +
> +		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
> +
> +		/* Start the scheduler again */
> +		drm_sched_wqueue_start(sched);
>   	}
>   
>   exit:
> @@ -438,7 +460,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   
>   	/* Skip job if VRAM is lost and never resubmit gangs */
>   	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
> -	    (job->job_run_counter && job->gang_submit))
> +	    (job->job_run_counter && job->gang_submit) ||
> +	    amdgpu_device_is_wedged(adev))
>   		dma_fence_set_error(finished, -ECANCELED);
>   
>   	if (finished->error < 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..2393cad36ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -781,6 +781,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>   	}
>   	case AMDGPU_INFO_TIMESTAMP: {
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>   
>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> @@ -913,6 +916,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		if (info->read_mmr_reg.count > 128)
>   			return -EINVAL;
>   
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>   
>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> @@ -953,6 +959,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		uint64_t vm_size;
>   		uint32_t pcie_gen_mask, pcie_width_mask;
>   
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>   		/* The clock limits are only available while the SMU is up. */
>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>   
> @@ -1187,6 +1196,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		}
>   	}
>   	case AMDGPU_INFO_SENSOR: {
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>   
>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4b1b42fee6b4..6ffd9e45e3ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1255,12 +1255,12 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
>   
>   static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
>   {
> -	return amdgpu_sriov_is_debug(adev) ? true : false;
> +	return amdgpu_device_is_wedged(adev) ? true : false;
>   }
>   
>   static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
>   {
> -	return amdgpu_sriov_is_normal(adev) ? true : false;
> +	return !amdgpu_device_is_wedged(adev) ? true : false;
>   }
>   
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index a2c1aa838737..665d483de731 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -315,7 +315,6 @@ struct amdgpu_virt {
>   	uint32_t gim_feature;
>   	uint32_t reg_access_mode;
>   	int req_init_data_ver;
> -	bool tdr_debug;
>   	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
>   	bool ras_init_done;
>   	uint32_t reg_access;
> @@ -446,10 +445,6 @@ static inline bool is_virtual_machine(void)
>   	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
>   #define amdgpu_sriov_multi_vf_mode(adev) \
>   	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> -#define amdgpu_sriov_is_debug(adev) \
> -	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
> -#define amdgpu_sriov_is_normal(adev) \
> -	((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))
>   #define amdgpu_sriov_is_av1_support(adev) \
>   	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
>   #define amdgpu_sriov_is_vcn_rb_decouple(adev) \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac18c2be6ecb..b95dddeaccc5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
>   		for (i = 0; i < p->n_pdds; i++) {
>   			struct kfd_process_device *pdd = p->pdds[i];
>   
> -			if (pdd->user_gpu_id == gpu_id)
> +			if (pdd->user_gpu_id == gpu_id) {
> +				if (amdgpu_device_is_wedged(pdd->dev->adev))
> +					return NULL;
> +
>   				return pdd;
> +			}
>   		}
>   	}
>   	return NULL;

