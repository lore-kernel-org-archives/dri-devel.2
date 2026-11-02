Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD4606E015
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20260822 header.b=8JSw4sOf;
	dkim=pass (2048-bit key, unprotected) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20260822 header.b=VaAfcPcV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A35410E6B5;
	Mon,  2 Nov 2026 16:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="8JSw4sOf";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="VaAfcPcV";
	dkim-atps=neutral
X-Greylist: delayed 438 seconds by postgrey-1.36 at gabe;
 Mon, 02 Nov 2026 16:52:29 UTC
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D960A10F0B1;
 Mon,  2 Nov 2026 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793637861; bh=Vr/5Tqrz3OWDeBJbvl6KzaT
 gxGktRWN6yNqSXjKtQ5Q=; b=8JSw4sOfTUeEmaFCOaZbWwQOx9/LUwCUqL330GkXk/SKBThyjR
 E4+l81NktQzreFNNgypVqQDqd58PZjpnFmAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1793637861; bh=Vr/5Tqrz3OWDeBJbvl6KzaT
 gxGktRWN6yNqSXjKtQ5Q=; b=VaAfcPcVykMOVUGpQIvRJ72P0f4Gx6C1QI+GK8u4A15HdwLOZp
 MV3wawm0wIY1+XcPjZSVYDzEPI63iB6sgh2JbDHglMt5VkB6Ya/Vl3zh/YHMHSDrCypO5i+/mh9
 oUfOP+b3Dghzk0vxbrLK6CUGxXPX8RiHDggCazqjDec4PhuQaiBIQb6RlzFrmcnc1TjUFb0dcgn
 J2P/MMcwhP2EQCAvTH+/mu3+dJzlrUTCZZwjcjJP8olEJ9+ZKiJWdOa6SIfp1UlWjDHAm8JFg0i
 fnExBGB+JejaSkGpUJLp5HVsKQQQ+9IaxSWBgt/tx8VGc95Rw0MXEX3Ytpzjz2ZIdVA==;
Message-Instance: m=1; h=sha256:iYeykNVW/2K6aNnbB1HFzSnkX9WrQ/yCBWk31E8a
 mtc=:MqUaZlUkANUUkOw9mzqbeW7o+wR+wmuJ+Ke39lDEbM8=;
DKIM2-Signature: i=1; m=1; t=1793637861; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PGNocmlzdGlhbi5r
 b2VuaWdAYW1kLmNvbT4=,PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+,PHBpZXJyZS1lcmljLnBl
 bGxvdXgtcHJheWVyQGFtZC5jb20+,PHNpbW9uYUBmZndsbC5jaD4=,PGFpcmxpZWRAZ21haWwu
 Y29tPg==,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==,PGRyaS1kZXZlbEBsaXN0
 cy5mcmVlZGVza3RvcC5vcmc+,PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+; s=
 v2-ed25519-20260822:ed25519-sha256:nBYszhuqQc1MDKi4DQmrW7HB7oQ5R2jSrDuHIexY
 CtHj3zPC8RKoPNdChbXm2GuqlTzg7oh45ECh7d+Jmu9+Dw==,v2-rsa-20260822:rsa-sha256
 :DkLm5nH/c7+sGLeEnVSb01sfyUr7CMO2TWViVMSRi/a7Mi7Em3zCF31IJAE+bbLYS4OQoAud
 TNoILzoR5Z5gcj0Dw0MsJJmcCb9OekXJd/E8MIzcRdF/9INBtGwSq70WaB9JU5lD9Dv0uueu
 Nduifrha3i2OitVGZn1gwLs5RRoUfgQb2pLUepad4kSyQX4aMuaySQMI79MPKhxrCjt0OfYt
 6s1/XYiCQsrmt/JiFQdqZ0PqvvOvY2kWsyMJf+JICTE1vjls61ptS5JlIifiMPBzzqC+kc8L
 J3qGJh5eAr7tNRb6jkK8q7IvyMj1bplBGUAOA/CV3CSW6dacKHVdCA==;
Message-ID: <5d224d9e-514b-4d24-a272-8bf8c1267116@damsy.net>
Date: Mon, 2 Nov 2026 17:44:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
 <0c8f89c5-b02b-491b-99a5-f881ea82a804@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <0c8f89c5-b02b-491b-99a5-f881ea82a804@amd.com>
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 02/11/2026 à 16:44, Christian König a écrit :
> On 10/29/26 16:19, Pierre-Eric Pelloux-Prayer wrote:
>> When a job times out the kernel tries to reset the GPU to get
>> the system back to a normal state.
>> Sometimes it's useful to disable this process - for instance to
>> be able to inspect the hardware state at the time of the hang.
>> Since leaving fence unsignalled might affect the system's
>> stability, this commit enables the drm wedge framework for amdgpu.
>>
>> When a hang condition is detected, the GPU isn't reset but all
>> the pending fences are signalled and the hung GPU cannot receive
>> new work. For KFD it's implemented by making
>> kfd_process_device_data_by_id return NULL if the requested GPU
>> is wedged.
>>
>> When the user is done, it's possible to trigger a GPU
>> reset.
>>
>> The auto-recovery is still enabled by default, and to use this
>> feature one has to either:
>> * boot with amdgpu.gpu_recovery=0: not recommended as it disables
>>    recovery for all GPUs
>> * write 0 to /sys/kernel/debug/dri/X/amdgpu_gpu_recover to disable
>>    auto-recovery for one GPU only
>>
>> Runtime power management is disabled when the device is wedged
>> (because we can't submit any work to the GPU).
>>
>> Assisted-by: LLM
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Looks mostly reasonable to me.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 ++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++-
>>   8 files changed, 83 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 34bbb30b6f0c..cd4959486c94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -989,6 +989,13 @@ struct amdgpu_device {
>>   	 */
>>   	bool gpu_recovery_enabled;
>>   
>> +	/* Set to 1 when the device has been declared wedged following a
>> +	 * hang: it no longer accepts new work and pending fences have been
>> +	 * force-signalled. Reset to 0 once the device is reset back to a
>> +	 * working state.
>> +	 */
>> +	atomic_t wedge_status;
>> +
>>   	/* KFD
>>   	 * Must be last --ends in a flexible-array member.
>>   	 */
>> @@ -1374,4 +1381,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
>>   			   uint64_t uid);
>>   uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
>>   			       enum amdgpu_uid_type type, uint8_t inst);
>> +
>> +static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
>> +{
>> +	return atomic_read(&adev->wedge_status);
>> +}
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index fa301c71b782..d119de477284 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1465,6 +1465,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   	if (!adev->accel_working)
>>   		return -EBUSY;
>>   
>> +	if (amdgpu_device_is_wedged(adev))
>> +		return -ENODEV;
>> +
>>   	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>   
>>   	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ec2514079919..641b7fe24951 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4110,6 +4110,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	}
>>   
>>   	adev->gpu_recovery_enabled = true;
>> +	atomic_set(&adev->wedge_status, 0);
>>   
>>   fence_driver_init:
>>   	/* Fence driver */
>> @@ -4362,6 +4363,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>   		amdgpu_sync_free(&adev->isolation[i].prev);
>>   	}
>>   
>> +	if (atomic_xchg(&adev->wedge_status, 0))
>> +		pm_runtime_put_autosuspend(adev->dev);
>> +
>>   	amdgpu_reset_fini(adev);
>>   
>>   	/* free i2c buses */
>> @@ -5155,6 +5159,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>>   	r = 0;
>>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>   		amdgpu_set_init_level(tmp_adev, init_level);
>> +
>> +		if (atomic_xchg(&tmp_adev->wedge_status, 0))
>> +			pm_runtime_put_autosuspend(tmp_adev->dev);
>> +
>>   		if (full_reset) {
>>   			/* post card */
>>   			amdgpu_reset_set_dpc_status(tmp_adev, false);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index fb60a99f43c1..617d4eec4e26 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -459,6 +459,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>   	uint32_t handle, initial_domain;
>>   	int r;
>>   
>> +	if (amdgpu_device_is_wedged(adev))
>> +		return -ENODEV;
>> +
>>   	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>   
>>   	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>> @@ -961,6 +964,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   		abo = NULL;
>>   	}
>>   
>> +	if (amdgpu_device_is_wedged(adev)) {
>> +		r = -ENODEV;
>> +		goto error_put_gobj;
>> +	}
>> +
>>   	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>>   
>>   	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 4204c3c750a8..53fa9fa83ae7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -730,6 +730,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>   	struct amdgpu_job *job;
>>   	int r;
>>   
>> +	if (amdgpu_device_is_wedged(adev))
>> +		return;
>> +
>>   	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>   
>>   	if (!hub->sdma_invalidation_workaround || vmid ||
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 0b8d0a79dd45..f72c9c690c3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/kthread.h>
>>   #include <linux/wait.h>
>>   #include <linux/sched.h>
>> +#include <linux/pm_runtime.h>
>>   
>>   #include <drm/drm_drv.h>
>>   
>> @@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   		if (r)
>>   			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>>   	} else {
>> -		drm_sched_suspend_timeout(&ring->sched);
>> -		if (amdgpu_sriov_vf(adev))
>> +		if (amdgpu_sriov_vf(adev)) {
>> +			drm_sched_suspend_timeout(&ring->sched);
>>   			adev->virt.tdr_debug = true;
> 
> I think we should just completely drop the tdr_debug approach from the VF handling under SRIOV.


Can this be done in a follow up patchset?

Pierre-Eric

> 
> The wedge event approach should be completely sufficient to handle all of that.
> 
> Regards,
> Christian.
> 
>> +		} else {
>> +			struct drm_gpu_scheduler *sched;
>> +			struct amdgpu_fence *guilty_fence;
>> +
>> +			/* Declare the device as wedged if it's not already. */
>> +			if (!atomic_xchg(&adev->wedge_status, 1)) {
>> +				/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
>> +				pm_runtime_get_noresume(adev->dev);
>> +
>> +				pci_clear_master(adev->pdev);
>> +
>> +				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
>> +			}
>> +
>> +			guilty_fence = to_amdgpu_job(s_job)->hw_fence;
>> +
>> +			sched = &ring->sched;
>> +
>> +			/* Prevent anybody else from touching the ring buffer. */
>> +			drm_sched_wqueue_stop(sched);
>> +
>> +			amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
>> +
>> +			/* Start the scheduler again */
>> +			drm_sched_wqueue_start(sched);
>> +		}
>>   	}
>>   
>>   exit:
>> @@ -439,7 +466,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>>   
>>   	/* Skip job if VRAM is lost and never resubmit gangs */
>>   	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
>> -	    (job->job_run_counter && job->gang_submit))
>> +	    (job->job_run_counter && job->gang_submit) ||
>> +	    amdgpu_device_is_wedged(adev))
>>   		dma_fence_set_error(finished, -ECANCELED);
>>   
>>   	if (finished->error < 0) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 14a72a406d37..2393cad36ac0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -781,6 +781,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>>   	}
>>   	case AMDGPU_INFO_TIMESTAMP: {
>> +		if (amdgpu_device_is_wedged(adev))
>> +			return -ENODEV;
>> +
>>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>   
>>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> @@ -913,6 +916,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		if (info->read_mmr_reg.count > 128)
>>   			return -EINVAL;
>>   
>> +		if (amdgpu_device_is_wedged(adev))
>> +			return -ENODEV;
>> +
>>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>   
>>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> @@ -953,6 +959,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		uint64_t vm_size;
>>   		uint32_t pcie_gen_mask, pcie_width_mask;
>>   
>> +		if (amdgpu_device_is_wedged(adev))
>> +			return -ENODEV;
>> +
>>   		/* The clock limits are only available while the SMU is up. */
>>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>   
>> @@ -1187,6 +1196,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   		}
>>   	}
>>   	case AMDGPU_INFO_SENSOR: {
>> +		if (amdgpu_device_is_wedged(adev))
>> +			return -ENODEV;
>> +
>>   		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>>   
>>   		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ac18c2be6ecb..b95dddeaccc5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
>>   		for (i = 0; i < p->n_pdds; i++) {
>>   			struct kfd_process_device *pdd = p->pdds[i];
>>   
>> -			if (pdd->user_gpu_id == gpu_id)
>> +			if (pdd->user_gpu_id == gpu_id) {
>> +				if (amdgpu_device_is_wedged(pdd->dev->adev))
>> +					return NULL;
>> +
>>   				return pdd;
>> +			}
>>   		}
>>   	}
>>   	return NULL;
> 

