Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01360606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20261120 header.b=GrvnzDMV;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20261120 header.b=mSModElg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F5A10EE68;
	Mon, 23 Nov 2026 14:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="GrvnzDMV";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="mSModElg";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D35610EE60;
 Mon, 23 Nov 2026 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=To:From:Subject:Date:Message-ID; t=1795443954; bh=m6ZL85qDqROHfBDfZHmJj5m
 2T7lX+dzbBLT7Mr6s8d8=; b=GrvnzDMVzHwTJENHhl9YF4IuojoumiLhMNufzSbu8zAlydwVYe
 GloICIIT5seY5WDl6u7td5nduFvJS0K3HVAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=To:From:Subject:Date:Message-ID; t=1795443954; bh=m6ZL85qDqROHfBDfZHmJj5m
 2T7lX+dzbBLT7Mr6s8d8=; b=mSModElgg2F1e8cl1Rh+mTh2gc6lLfTbNYI1II+1jTN1NidMRG
 iIy2cGPuEFdezL2fhpQD9cSjRDBNnWCLzevEMp+GEOQGCM1wGaWwLjnSM9FYOkS0bWHLhJa0SX6
 bgTzK6xqggPhjSbigyj2RMFs1nnR9MMjeovkUzN7d3SV0cYPukGunzWhzMepy/FA/Cr2QEbhmv2
 Tw80LT4ZlPktD6qrk42hbOwz1GkB8PzOR7+PLxyXwLvhQkOMi+s6xcuo2DJ6VjrKbSqXxThh2pD
 0F3iF7/sjweCtIMKJsnqhDZwGCcMekFJIIj5VwONCFK1nBEQqH+v8OKMFuoO5kxIwqA==;
Message-Instance: m=1; h=sha256:oqxWSmzAOv6kdpoKFPJBXAgVUsge4LBZ4FtcBMJk
 11M=:NhUOUUa9jR1dBGRdmqoEk5p0nGV2nkUxGi33JXGM9qk=;
DKIM2-Signature: i=1; m=1; t=1795443954; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PGNocmlzdGlhbi5r
 b2VuaWdAYW1kLmNvbT4=,PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+,PHBpZXJyZS1lcmljLnBl
 bGxvdXgtcHJheWVyQGFtZC5jb20+,PHNpbW9uYUBmZndsbC5jaD4=,PGFpcmxpZWRAZ21haWwu
 Y29tPg==,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg==,PGRyaS1kZXZlbEBsaXN0
 cy5mcmVlZGVza3RvcC5vcmc+,PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+; s=
 v2-mldsa44-20261103:mldsa44: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
 AAAAAAAAABAoNkc=|v2-ed25519-20261120:ed25519-sha256:8bH7LoI7NgAb/qa7rP+z
 y7/zGxtsxC6PF7bfoMb2nuZ+lJ3dgm2/yoI8THjO3+JH8GTBNZcZ2LbC3IOSESNxCA==|
 v2-rsa-20261120:rsa-sha256:e17Fh/Dmr99Em+ueQt5Ljxpj3O8K+qQcb9jLvET4yWRY/E42
 4qXsq/mmy7mUDsR3wUOmlAREGxm3HcoPj225lmKE4jvKy/epX5nrXbY95rbwy5/8Jh5tVBTf
 aDyjDBJdqLmgTCE8H/fr2r2d1LpyWOyVaimG4RbMORsxGavNqB51m0LgJwXjvVMou/cKpkSE
 wKhZym4AzxiXWJ+rn1jVqsQHuaXzR6+o6S7lR3WBkBWONTCwjQX9SPfw+oz+lrKbGuqlIgth
 DgN2kS3x3f92OU2oc1eTbCO519qo3TOpF4AyljVuDhhQQWVuUzC782ckkAmFt7epImcbpRUL
 vozqSA==;
Message-ID: <60f901b7-018c-485d-9e9a-42e73adcd4f7@damsy.net>
Date: Mon, 23 Nov 2026 15:25:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/amdgpu: handle gpu_recovery per device
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
 <21061e43-992f-42e4-a030-a2bf243ee70e@amd.com>
 <41db4e73-7b1f-434c-b6f7-ccf51596ecb4@damsy.net>
Content-Language: fr
In-Reply-To: <41db4e73-7b1f-434c-b6f7-ccf51596ecb4@damsy.net>
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



Le 10/11/2026 à 14:02, Pierre-Eric Pelloux-Prayer a écrit :
> 
> 
> Le 10/11/2026 à 10:07, Christian König a écrit :
>> On 11/9/26 18:13, Pierre-Eric Pelloux-Prayer wrote:
>>> Instead of having a module wide parameter, store gpu_recovery
>>> in amdgpu_device. Its initial value is based on the boot param
>>> and it can be overridden by writing to the existing
>>> amdgpu_gpu_recover debugfs file, so a single device can have
>>> auto-recovery disabled without affecting every other GPU in the
>>> system.
>>>
>>> amdgpu_device_should_recover_gpu() now only consider this param.
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux- 
>>> prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 92 +++++++++----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 21 ++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  6 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
>>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>>>   10 files changed, 81 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/ 
>>> amd/amdgpu/amdgpu.h
>>> index 5a32b54b1e9b..a486ac746a5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -982,6 +982,9 @@ struct amdgpu_device {
>>>       struct amdgpu_uma_carveout_info uma_info;
>>> +    /* Per device gpu_recovery setting. 0 means disabled. */
>>> +    unsigned int gpu_recovery;
>>> +
>>>       /* KFD
>>>        * Must be last --ends in a flexible-array member.
>>>        */
>>> @@ -1195,7 +1198,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>>>   /* Common functions */
>>>   bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>>> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
>>>   int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>                     struct amdgpu_job *job,
>>>                     struct amdgpu_reset_context *reset_context);
>>> @@ -1323,9 +1325,14 @@ int amdgpu_device_set_cg_state(struct 
>>> amdgpu_device *adev,
>>>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>>>                      enum amd_powergating_state state);
>>> +static inline bool amdgpu_device_should_recover_gpu(struct 
>>> amdgpu_device *adev)
>>> +{
>>> +    return adev->gpu_recovery != 0;
>>> +}
>>> +
>>>   static inline bool amdgpu_device_has_timeouts_enabled(struct 
>>> amdgpu_device *adev)
>>>   {
>>> -    return amdgpu_gpu_recovery != 0 &&
>>> +    return amdgpu_device_should_recover_gpu(adev) &&
>>>           adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
>>>           adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
>>>           adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>> gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 730e9e93d078..a812551b353f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3762,6 +3762,45 @@ 
>>> amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, 
>>> bool px)
>>>                  apple_gmux_detect(NULL, NULL)));
>>>   }
>>> +static void amdgpu_device_init_gpu_recovery(struct amdgpu_device *adev)
>>> +{
>>> +    adev->gpu_recovery = 0;
>>> +
>>> +    if (amdgpu_gpu_recovery == 0)
>>> +        return;
>>> +
>>> +    /* Skip soft reset check in fatal error mode */
>>> +    if (!amdgpu_ras_is_poison_mode_supported(adev) ||
>>> +        amdgpu_sriov_vf(adev)) {
>>> +        adev->gpu_recovery = adev->gpu_recovery > 0 ?
>>> +            adev->gpu_recovery :-1;
>>> +    } else if (amdgpu_gpu_recovery == -1) {
>>> +        switch (adev->asic_type) {
>>> +#ifdef CONFIG_DRM_AMDGPU_SI
>>> +        case CHIP_VERDE:
>>> +        case CHIP_TAHITI:
>>> +        case CHIP_PITCAIRN:
>>> +        case CHIP_OLAND:
>>> +        case CHIP_HAINAN:
>>> +#endif
>>> +#ifdef CONFIG_DRM_AMDGPU_CIK
>>> +        case CHIP_KAVERI:
>>> +        case CHIP_KABINI:
>>> +        case CHIP_MULLINS:
>>> +#endif
>>> +        case CHIP_CARRIZO:
>>> +        case CHIP_STONEY:
>>> +        case CHIP_CYAN_SKILLFISH:
>>> +            return;
>>
>>
>> Hui? We have recovery disabled by default for those devices?
> 
> Yes, this commit doesn't change the existing logic.

Christian: are there any further changes I should implement?


> 
>>
>>> +        default:
>>> +            adev->gpu_recovery = 1;
>>> +            break;
>>> +        }
>>> +    } else {
>>> +        adev->gpu_recovery = amdgpu_gpu_recovery;
>>> +    }
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_init - initialize the driver
>>>    *
>>> @@ -4109,6 +4148,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>           }
>>>       }
>>> +    amdgpu_device_init_gpu_recovery(adev);
>>> +
>>>   fence_driver_init:
>>>       /* Fence driver */
>>>       r = amdgpu_fence_driver_sw_init(adev);
>>> @@ -4894,57 +4935,6 @@ bool amdgpu_device_has_job_running(struct 
>>> amdgpu_device *adev)
>>>       return false;
>>>   }
>>> -/**
>>> - * amdgpu_device_should_recover_gpu - check if we should try GPU 
>>> recovery
>>> - *
>>> - * @adev: amdgpu_device pointer
>>> - *
>>> - * Check amdgpu_gpu_recovery and SRIOV status to see if we should 
>>> try to recover
>>> - * a hung GPU.
>>> - */
>>> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>> -{
>>> -
>>> -    if (amdgpu_gpu_recovery == 0)
>>> -        goto disabled;
>>> -
>>> -    /* Skip soft reset check in fatal error mode */
>>> -    if (!amdgpu_ras_is_poison_mode_supported(adev))
>>> -        return true;
>>> -
>>> -    if (amdgpu_sriov_vf(adev))
>>> -        return true;
>>> -
>>> -    if (amdgpu_gpu_recovery == -1) {
>>> -        switch (adev->asic_type) {
>>> -#ifdef CONFIG_DRM_AMDGPU_SI
>>> -        case CHIP_VERDE:
>>> -        case CHIP_TAHITI:
>>> -        case CHIP_PITCAIRN:
>>> -        case CHIP_OLAND:
>>> -        case CHIP_HAINAN:
>>> -#endif
>>> -#ifdef CONFIG_DRM_AMDGPU_CIK
>>> -        case CHIP_KAVERI:
>>> -        case CHIP_KABINI:
>>> -        case CHIP_MULLINS:
>>> -#endif
>>> -        case CHIP_CARRIZO:
>>> -        case CHIP_STONEY:
>>> -        case CHIP_CYAN_SKILLFISH:
>>> -            goto disabled;
>>> -        default:
>>> -            break;
>>> -        }
>>> -    }
>>> -
>>> -    return true;
>>> -
>>> -disabled:
>>> -        dev_info(adev->dev, "GPU recovery disabled.\n");
>>> -        return false;
>>> -}
>>> -
>>>   int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>>   {
>>>       u32 i;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_fence.c
>>> index bff2d38f3571..a8e23f4e8113 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -980,9 +980,13 @@ static int amdgpu_debugfs_fence_info_show(struct 
>>> seq_file *m, void *unused)
>>>   }
>>>   /*
>>> - * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
>>> + * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover,
>>> + * and control whether this device is allowed to auto-recover from a 
>>> hang.
>>>    *
>>> - * Manually trigger a gpu reset at the next fence wait.
>>> + * Read triggers a gpu reset at the next fence wait.
>>> + *
>>> + * Write 0/1 to disable/enable auto GPU recovery for this device
>>> + * (equivalent to amdgpu.gpu_recovery=0, but scoped to this device 
>>> only).
>>>    */
>>>   static int gpu_recover_get(void *data, u64 *val)
>>>   {
>>> @@ -1006,8 +1010,17 @@ static int gpu_recover_get(void *data, u64 *val)
>>>       return 0;
>>>   }
>>> +static int gpu_recover_set(void *data, u64 val)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>> +
>>> +    adev->gpu_recovery = !!val;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
>>> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, 
>>> gpu_recover_get, NULL,
>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, 
>>> gpu_recover_get, gpu_recover_set,
>>>                "%lld\n");
>>>   static void amdgpu_debugfs_reset_work(struct work_struct *work)
>>> @@ -1042,7 +1055,7 @@ void amdgpu_debugfs_fence_init(struct 
>>> amdgpu_device *adev)
>>>       if (!amdgpu_sriov_vf(adev)) {
>>>           INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
>>> -        debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
>>> +        debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
>>>                       &amdgpu_debugfs_gpu_recover_fops);
>>
>> You can also use debugfs_create_bool() here and drop the extra recover 
>> fops.
> 
> We need a custom getter because it triggers the GPU recovery so 
> debugfs_create_bool won't work.
> 

Christian: same question?

Thanks,
Pierre-Eric

> 
> Pierre-Erioc
> 
>>
>> Apart from that looks good to me,
>> Christian.
>>
>>>       }
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_gfx.c
>>> index 0ae6e990c310..28f9048f806c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -2299,7 +2299,7 @@ static int 
>>> amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>>   {
>>>       int r = 0;
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return r;
>>>       if (adev->gfx.num_gfx_rings) {
>>> @@ -2319,7 +2319,7 @@ static int 
>>> amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>>>   static void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device 
>>> *adev)
>>>   {
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return;
>>>       if (adev->gfx.num_gfx_rings)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_job.c
>>> index 4d363bcfb6a5..16391cc2b9a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -111,7 +111,7 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>       if (!amdgpu_sriov_vf(adev))
>>>           amdgpu_job_core_dump(adev, job);
>>> -    if (amdgpu_gpu_recovery &&
>>> +    if (amdgpu_device_should_recover_gpu(adev) &&
>>>           amdgpu_ring_is_reset_type_supported(ring, 
>>> AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
>>>           amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence- 
>>> >parent)) {
>>>           dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
>>> @@ -130,7 +130,7 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>       }
>>>       /* attempt a per ring reset */
>>> -    if (amdgpu_gpu_recovery &&
>>> +    if (amdgpu_device_should_recover_gpu(adev) &&
>>>           amdgpu_ring_is_reset_type_supported(ring, 
>>> AMDGPU_RESET_TYPE_PER_QUEUE) &&
>>>           ring->funcs->reset) {
>>>           dev_err(adev->dev, "Starting %s ring reset\n",
>>> @@ -152,7 +152,7 @@ static enum drm_gpu_sched_stat 
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>       }
>>>       /* Attempt an IP block soft reset, if supported. */
>>> -    if (amdgpu_gpu_recovery &&
>>> +    if (amdgpu_device_should_recover_gpu(adev) &&
>>>           amdgpu_ring_is_reset_type_supported(ring, 
>>> AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
>>>           r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
>>>           if (!r) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_sdma.c
>>> index 87ecbd429f95..8da7c8e91e25 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> @@ -454,7 +454,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct 
>>> amdgpu_device *adev)
>>>   {
>>>       int r = 0;
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return r;
>>>       if (adev->sdma.num_instances) {
>>> @@ -468,7 +468,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct 
>>> amdgpu_device *adev)
>>>   void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>>   {
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return;
>>>       if (adev->dev->kobj.sd) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_userq.c
>>> index 1a2aa85c504e..64fb04ff2098 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -101,7 +101,7 @@ static void amdgpu_userq_mgr_reset_work(struct 
>>> work_struct *work)
>>>        * If GPU recovery feature is disabled system-wide,
>>>        * skip all reset detection logic
>>>        */
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return;
>>>       memset(&reset_context, 0, sizeof(reset_context));
>>> @@ -137,7 +137,7 @@ static void amdgpu_userq_hang_detect_work(struct 
>>> work_struct *work)
>>>        * If GPU recovery feature is disabled system-wide,
>>>        * skip all reset detection logic
>>>        */
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return;
>>>       if (queue->vm && queue->vm->pasid) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/ 
>>> amd/amdgpu/mxgpu_vi.c
>>> index c3293e5a658c..907f18b195ba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>> @@ -550,7 +550,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct 
>>> amdgpu_device *adev,
>>>       int r;
>>>       /* trigger gpu-reset by hypervisor only if TDR disabled */
>>> -    if (!amdgpu_gpu_recovery) {
>>> +    if (!amdgpu_device_should_recover_gpu(adev)) {
>>>           /* see what event we get */
>>>           r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/ 
>>> amd/amdgpu/soc15.c
>>> index b2024d05aa5f..b35622e65981 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -570,7 +570,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>>>            */
>>>           if (adev->pcie_reset_ctx.in_link_reset)
>>>               return AMD_RESET_METHOD_LINK;
>>> -        if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
>>> +        if (adev->gpu_recovery == 4 || adev->gpu_recovery == 5)
>>>               return AMD_RESET_METHOD_MODE2;
>>>           else if (!(adev->flags & AMD_IS_APU))
>>>               return AMD_RESET_METHOD_MODE1;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/ 
>>> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index ce67e56efa8c..18fa7c8cc210 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -336,7 +336,7 @@ static int 
>>> remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>>       /* remove_hw_queue failure indicates a queue hang. reset the 
>>> queue */
>>>       r = reset_queues_mes(dqm, q);
>>> -    if (r && amdgpu_gpu_recovery) {
>>> +    if (r && amdgpu_device_should_recover_gpu(adev)) {
>>>           dev_err(adev->dev, "failed to remove queue from MES, 
>>> doorbell=0x%x\n",
>>>               q->properties.doorbell_off);
>>>           dev_err(adev->dev, "MES might be in unrecoverable state, 
>>> issue a GPU reset\n");
>>> @@ -494,7 +494,7 @@ static int reset_queues_mes(struct 
>>> device_queue_manager *dqm, struct queue *q)
>>>       if (WARN_ON(dqm->detect_hang_count > 0))
>>>           return 0;
>>> -    if (!amdgpu_gpu_recovery) {
>>> +    if (!amdgpu_device_should_recover_gpu(adev)) {
>>>           r = -ENOTRECOVERABLE;
>>>           goto fail;
>>>       }
>>> @@ -2806,7 +2806,7 @@ static int reset_queues_on_hws_hang(struct 
>>> device_queue_manager *dqm, bool is_sd
>>>           return -EPERM;
>>>       }
>>> -    if (!amdgpu_gpu_recovery)
>>> +    if (!amdgpu_device_should_recover_gpu(adev))
>>>           return -ENOTRECOVERABLE;
>>>       return is_sdma ? reset_hung_queues_sdma(dqm) : 
>>> reset_hung_queues(dqm);
>>
> 

