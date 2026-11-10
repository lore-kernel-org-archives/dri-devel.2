Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED36606BFE3
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20260822 header.b=K4toiUJm;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20260822 header.b=aed70L83
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D3810F6A5;
	Tue, 10 Nov 2026 13:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="K4toiUJm";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="aed70L83";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C40F10F6A7;
 Tue, 10 Nov 2026 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794315760; bh=PFrwJLp98HkXX8DyGAQI8jv
 M55jpxluzsAoiY/S20ZE=; b=K4toiUJmqHdmWBhFRq1GwgfczSl8w8rjootdpBWcRMSMcTqpiI
 cPZS6I20KnYQ7LW682zmTJ9wXuv35MwwZZBA==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260822; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1794315760; bh=PFrwJLp98HkXX8DyGAQI8jv
 M55jpxluzsAoiY/S20ZE=; b=aed70L83te+Mdy2fKW6jNLz3hTqtFGTx5e0L7rO84UyEazR6lx
 I96HVs2zORDm69/akWqEvUX1mSYaLynWNkg/3V8GE30BIls7dQW/Tsd0ry8ocjSANZ2RUNAEg4Z
 O7UhLdgGA8aWcnCDY7lqqBlscO71USpzFlLlIfDCaQkF16m9Q4nk+38m2n5o1FAfxCDsMEo4BQu
 8HoNVK/D9IjPYxqQXEeCZA2yluHEtwvLdz1er0/izsW5Ck37OS6iJ4zssDsHZmOa8i8Nc9in/zn
 xMw8XPxxSjAlGZX4njojPALZBZqmlhcmeWuBg+SpkbAF4kyg9K8plFkIc4sMKDxEFyQ==;
Message-Instance: m=1; h=sha256:sXAhbi3w8Ao10UDLh8VUuD54BBhN157+cZMpGtT8
 tPs=:mHp98h+mRNvkPXsSzE7oQhtWIReo43WcOp05RDVMS2Q=;
DKIM2-Signature: i=1; m=1; t=1794315760; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PGNocmlzdGlhbi5r
 b2VuaWdAYW1kLmNvbT4=,PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+,PHBpZXJyZS1lcmljLnBl
 bGxvdXgtcHJheWVyQGFtZC5jb20+,PHNpbW9uYUBmZndsbC5jaD4=,PGFpcmxpZWRAZ21haWwu
 Y29tPg==,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==,PGRyaS1kZXZlbEBsaXN0
 cy5mcmVlZGVza3RvcC5vcmc+,PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+; s=
 v2-ed25519-20260822:ed25519-sha256:1ejHVsAIoFzkCLH3svQbcdgX0uTvTAnrtA/as/7J
 5YUXllgUDX6sZf5bnORRpmOOPwAaADm9d9V4KF5Z8I7GAw==|v2-rsa-20260822:rsa-sha256
 :MdPmQZwN3WPzQNCetvoW1nYsxUM3Aejxqgcx2NLW5PEowpt0GFQIPH6kdbSmvPRCNdYjFVm/
 70XJqmOYLhhvGKhfolytQ5cRi0d9WeOg5G4P72IRC9KsTmyDNHJWKCHiNKEEB5ZHNPzhpPeR
 6YgM9nKckKp26eeIjfDBhNgfY7CQ+2Suiq6Nb6HelF5V/mGDeb/+VyuS+b44jKJIOZe8nJF6
 QIuDfgxf+3GNPfh+/bVU6e81attupAr7+4hE8V/6UFmAL5TTQVNospfBm1ft5+Qdf3TVtR70
 jwLY7fHgbCr5+YfaL5GGgFfRsvS+4v41W7LvWht8RvpnwZsW/ySRJQ==|
 v2-mldsa44-20261103:mldsa44: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
 AAAAAAAAABAjNkk=;
Message-ID: <41db4e73-7b1f-434c-b6f7-ccf51596ecb4@damsy.net>
Date: Tue, 10 Nov 2026 14:02:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/amdgpu: handle gpu_recovery per device
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
 <21061e43-992f-42e4-a030-a2bf243ee70e@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <21061e43-992f-42e4-a030-a2bf243ee70e@amd.com>
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



Le 10/11/2026 à 10:07, Christian König a écrit :
> On 11/9/26 18:13, Pierre-Eric Pelloux-Prayer wrote:
>> Instead of having a module wide parameter, store gpu_recovery
>> in amdgpu_device. Its initial value is based on the boot param
>> and it can be overridden by writing to the existing
>> amdgpu_gpu_recover debugfs file, so a single device can have
>> auto-recovery disabled without affecting every other GPU in the
>> system.
>>
>> amdgpu_device_should_recover_gpu() now only consider this param.
>>
>> Assisted-by: LLM
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 92 +++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 21 ++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>>   10 files changed, 81 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5a32b54b1e9b..a486ac746a5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -982,6 +982,9 @@ struct amdgpu_device {
>>   
>>   	struct amdgpu_uma_carveout_info uma_info;
>>   
>> +	/* Per device gpu_recovery setting. 0 means disabled. */
>> +	unsigned int gpu_recovery;
>> +
>>   	/* KFD
>>   	 * Must be last --ends in a flexible-array member.
>>   	 */
>> @@ -1195,7 +1198,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>>   
>>   /* Common functions */
>>   bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
>>   int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   			      struct amdgpu_job *job,
>>   			      struct amdgpu_reset_context *reset_context);
>> @@ -1323,9 +1325,14 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>>   			       enum amd_powergating_state state);
>>   
>> +static inline bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>> +{
>> +	return adev->gpu_recovery != 0;
>> +}
>> +
>>   static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
>>   {
>> -	return amdgpu_gpu_recovery != 0 &&
>> +	return amdgpu_device_should_recover_gpu(adev) &&
>>   		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
>>   		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
>>   		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 730e9e93d078..a812551b353f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3762,6 +3762,45 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
>>   		       apple_gmux_detect(NULL, NULL)));
>>   }
>>   
>> +static void amdgpu_device_init_gpu_recovery(struct amdgpu_device *adev)
>> +{
>> +	adev->gpu_recovery = 0;
>> +
>> +	if (amdgpu_gpu_recovery == 0)
>> +		return;
>> +
>> +	/* Skip soft reset check in fatal error mode */
>> +	if (!amdgpu_ras_is_poison_mode_supported(adev) ||
>> +	    amdgpu_sriov_vf(adev)) {
>> +		adev->gpu_recovery = adev->gpu_recovery > 0 ?
>> +			adev->gpu_recovery :-1;
>> +	} else if (amdgpu_gpu_recovery == -1) {
>> +		switch (adev->asic_type) {
>> +#ifdef CONFIG_DRM_AMDGPU_SI
>> +		case CHIP_VERDE:
>> +		case CHIP_TAHITI:
>> +		case CHIP_PITCAIRN:
>> +		case CHIP_OLAND:
>> +		case CHIP_HAINAN:
>> +#endif
>> +#ifdef CONFIG_DRM_AMDGPU_CIK
>> +		case CHIP_KAVERI:
>> +		case CHIP_KABINI:
>> +		case CHIP_MULLINS:
>> +#endif
>> +		case CHIP_CARRIZO:
>> +		case CHIP_STONEY:
>> +		case CHIP_CYAN_SKILLFISH:
>> +			return;
> 
> 
> Hui? We have recovery disabled by default for those devices?

Yes, this commit doesn't change the existing logic.

> 
>> +		default:
>> +			adev->gpu_recovery = 1;
>> +			break;
>> +		}
>> +	} else {
>> +		adev->gpu_recovery = amdgpu_gpu_recovery;
>> +	}
>> +}
>> +
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -4109,6 +4148,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   		}
>>   	}
>>   
>> +	amdgpu_device_init_gpu_recovery(adev);
>> +
>>   fence_driver_init:
>>   	/* Fence driver */
>>   	r = amdgpu_fence_driver_sw_init(adev);
>> @@ -4894,57 +4935,6 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>>   	return false;
>>   }
>>   
>> -/**
>> - * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>> - *
>> - * @adev: amdgpu_device pointer
>> - *
>> - * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
>> - * a hung GPU.
>> - */
>> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>> -{
>> -
>> -	if (amdgpu_gpu_recovery == 0)
>> -		goto disabled;
>> -
>> -	/* Skip soft reset check in fatal error mode */
>> -	if (!amdgpu_ras_is_poison_mode_supported(adev))
>> -		return true;
>> -
>> -	if (amdgpu_sriov_vf(adev))
>> -		return true;
>> -
>> -	if (amdgpu_gpu_recovery == -1) {
>> -		switch (adev->asic_type) {
>> -#ifdef CONFIG_DRM_AMDGPU_SI
>> -		case CHIP_VERDE:
>> -		case CHIP_TAHITI:
>> -		case CHIP_PITCAIRN:
>> -		case CHIP_OLAND:
>> -		case CHIP_HAINAN:
>> -#endif
>> -#ifdef CONFIG_DRM_AMDGPU_CIK
>> -		case CHIP_KAVERI:
>> -		case CHIP_KABINI:
>> -		case CHIP_MULLINS:
>> -#endif
>> -		case CHIP_CARRIZO:
>> -		case CHIP_STONEY:
>> -		case CHIP_CYAN_SKILLFISH:
>> -			goto disabled;
>> -		default:
>> -			break;
>> -		}
>> -	}
>> -
>> -	return true;
>> -
>> -disabled:
>> -		dev_info(adev->dev, "GPU recovery disabled.\n");
>> -		return false;
>> -}
>> -
>>   int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>   {
>>   	u32 i;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index bff2d38f3571..a8e23f4e8113 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -980,9 +980,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>>   }
>>   
>>   /*
>> - * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
>> + * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover,
>> + * and control whether this device is allowed to auto-recover from a hang.
>>    *
>> - * Manually trigger a gpu reset at the next fence wait.
>> + * Read triggers a gpu reset at the next fence wait.
>> + *
>> + * Write 0/1 to disable/enable auto GPU recovery for this device
>> + * (equivalent to amdgpu.gpu_recovery=0, but scoped to this device only).
>>    */
>>   static int gpu_recover_get(void *data, u64 *val)
>>   {
>> @@ -1006,8 +1010,17 @@ static int gpu_recover_get(void *data, u64 *val)
>>   	return 0;
>>   }
>>   
>> +static int gpu_recover_set(void *data, u64 val)
>> +{
>> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>> +
>> +	adev->gpu_recovery = !!val;
>> +
>> +	return 0;
>> +}
>> +
>>   DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
>> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, gpu_recover_set,
>>   			 "%lld\n");
>>   
>>   static void amdgpu_debugfs_reset_work(struct work_struct *work)
>> @@ -1042,7 +1055,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>>   	if (!amdgpu_sriov_vf(adev)) {
>>   
>>   		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
>> -		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
>> +		debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
>>   				    &amdgpu_debugfs_gpu_recover_fops);
> 
> You can also use debugfs_create_bool() here and drop the extra recover fops.

We need a custom getter because it triggers the GPU recovery so 
debugfs_create_bool won't work.


Pierre-Erioc

> 
> Apart from that looks good to me,
> Christian.
> 
>>   	}
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 0ae6e990c310..28f9048f806c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -2299,7 +2299,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>   {
>>   	int r = 0;
>>   
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return r;
>>   
>>   	if (adev->gfx.num_gfx_rings) {
>> @@ -2319,7 +2319,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>   
>>   static void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   {
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return;
>>   
>>   	if (adev->gfx.num_gfx_rings)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 4d363bcfb6a5..16391cc2b9a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -111,7 +111,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   	if (!amdgpu_sriov_vf(adev))
>>   		amdgpu_job_core_dump(adev, job);
>>   
>> -	if (amdgpu_gpu_recovery &&
>> +	if (amdgpu_device_should_recover_gpu(adev) &&
>>   	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
>>   	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>>   		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
>> @@ -130,7 +130,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   	}
>>   
>>   	/* attempt a per ring reset */
>> -	if (amdgpu_gpu_recovery &&
>> +	if (amdgpu_device_should_recover_gpu(adev) &&
>>   	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
>>   	    ring->funcs->reset) {
>>   		dev_err(adev->dev, "Starting %s ring reset\n",
>> @@ -152,7 +152,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   	}
>>   
>>   	/* Attempt an IP block soft reset, if supported. */
>> -	if (amdgpu_gpu_recovery &&
>> +	if (amdgpu_device_should_recover_gpu(adev) &&
>>   	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
>>   		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
>>   		if (!r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 87ecbd429f95..8da7c8e91e25 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -454,7 +454,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>   {
>>   	int r = 0;
>>   
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return r;
>>   
>>   	if (adev->sdma.num_instances) {
>> @@ -468,7 +468,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>   
>>   void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   {
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return;
>>   
>>   	if (adev->dev->kobj.sd) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 1a2aa85c504e..64fb04ff2098 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -101,7 +101,7 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>>   	 * If GPU recovery feature is disabled system-wide,
>>   	 * skip all reset detection logic
>>   	 */
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return;
>>   
>>   	memset(&reset_context, 0, sizeof(reset_context));
>> @@ -137,7 +137,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>>   	 * If GPU recovery feature is disabled system-wide,
>>   	 * skip all reset detection logic
>>   	 */
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return;
>>   
>>   	if (queue->vm && queue->vm->pasid) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> index c3293e5a658c..907f18b195ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>> @@ -550,7 +550,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
>>   	int r;
>>   
>>   	/* trigger gpu-reset by hypervisor only if TDR disabled */
>> -	if (!amdgpu_gpu_recovery) {
>> +	if (!amdgpu_device_should_recover_gpu(adev)) {
>>   		/* see what event we get */
>>   		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index b2024d05aa5f..b35622e65981 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -570,7 +570,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>>   		 */
>>   		if (adev->pcie_reset_ctx.in_link_reset)
>>   			return AMD_RESET_METHOD_LINK;
>> -		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
>> +		if (adev->gpu_recovery == 4 || adev->gpu_recovery == 5)
>>   			return AMD_RESET_METHOD_MODE2;
>>   		else if (!(adev->flags & AMD_IS_APU))
>>   			return AMD_RESET_METHOD_MODE1;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index ce67e56efa8c..18fa7c8cc210 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -336,7 +336,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>   
>>   	/* remove_hw_queue failure indicates a queue hang. reset the queue */
>>   	r = reset_queues_mes(dqm, q);
>> -	if (r && amdgpu_gpu_recovery) {
>> +	if (r && amdgpu_device_should_recover_gpu(adev)) {
>>   		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
>>   			q->properties.doorbell_off);
>>   		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>> @@ -494,7 +494,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>>   	if (WARN_ON(dqm->detect_hang_count > 0))
>>   		return 0;
>>   
>> -	if (!amdgpu_gpu_recovery) {
>> +	if (!amdgpu_device_should_recover_gpu(adev)) {
>>   		r = -ENOTRECOVERABLE;
>>   		goto fail;
>>   	}
>> @@ -2806,7 +2806,7 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sd
>>   
>>   		return -EPERM;
>>   	}
>> -	if (!amdgpu_gpu_recovery)
>> +	if (!amdgpu_device_should_recover_gpu(adev))
>>   		return -ENOTRECOVERABLE;
>>   
>>   	return is_sdma ? reset_hung_queues_sdma(dqm) : reset_hung_queues(dqm);
> 

