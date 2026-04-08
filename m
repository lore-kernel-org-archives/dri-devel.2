Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC2FD5F8E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A03910E57F;
	Wed,  8 Apr 2026 08:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="UK8hRRsz";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="2fa4ChEc";
	dkim-atps=neutral
X-Greylist: delayed 328 seconds by postgrey-1.36 at gabe;
 Wed, 08 Apr 2026 08:31:54 UTC
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EA510E57F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636979;
 bh=pvfZj2+eVPtfs1js2GotRxC
 kYu85hhSVeTubrUUypLk=; b=UK8hRRsz54+jRyMwgT4RxMlmWIc0eq1v9u1FgSZR59Mw+k6sUT
 ARmTM0YyZc7dr4mEHz/wOxRZMZ2WoSu5UI1isGvLD8bh8WfJL7EMa3nv2C9UU6JPvC/6zw8UkMN
 YpEcPIwktWSgEBlawFDrD7+Ccjejo0JrAtuP6qdFs8T0AFFzT8oW3PkoAzMpdu4PLvyZ4mGM/eI
 eIsongHUm6zEndIU4OkxXOjV58zmviRUHME9qwh9TOVztTFOR+CXEuG1yC3btSgV0H8vCVmUBuT
 4OtXpA+5ggnlB1IdqbB/cRva+AHIizBm7pxHoTGqcwjf/vcspzasItQIMvGwL+9HeyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636979; bh=pvfZj2+eVPtfs1js2GotRxC
 kYu85hhSVeTubrUUypLk=; b=2fa4ChEcv7Y29g1p6I9LWBo/fxcJcESSjAm0SjaqNXds7nh+LD
 WdCMstGlsUWv1Zz7tCK8FuikeB/Q0XmIzuBA==;
Message-ID: <723485fd-f3c9-47bf-93ad-c9073f8b4ed5@damsy.net>
Date: Wed, 8 Apr 2026 10:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_NwbqrJAmrBKsG_BgGGtYCpM=MGc+Bpyvwr0hdVbmMYHA@mail.gmail.com>
 <d8d6741c-31dc-445e-ba05-7d8e6b3ea586@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <d8d6741c-31dc-445e-ba05-7d8e6b3ea586@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



Le 07/04/2026 à 10:07, Christian König a écrit :
> On 4/3/26 17:08, Alex Deucher wrote:
>> On Fri, Apr 3, 2026 at 4:36 AM Pierre-Eric Pelloux-Prayer
>> <pierre-eric.pelloux-prayer@amd.com> wrote:
>>>
>>> This will allow the use of all of them for clear/fill buffer
>>> operations.
>>> Since drm_sched_entity_init requires a scheduler array, we
>>> store schedulers rather than rings. For the few places that need
>>> access to a ring, we can get it from the sched using container_of.
>>>
>>> Since the code is the same for all sdma versions, add a new
>>> helper amdgpu_sdma_set_buffer_funcs_scheds to set buffer_funcs_scheds
>>> based on the number of sdma instances.
>>>
>>> Note: the new sched array is identical to the amdgpu_vm_manager one.
>>> These 2 could be merged.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 32 ++++++++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++----
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
>>>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
>>>   17 files changed, 48 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 49e7881750fa..e3a8701f0b27 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1467,6 +1467,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>>>   ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>>>   void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
>>>                                     const struct amdgpu_vm_pte_funcs *vm_pte_funcs);
>>> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>>> +                                        const struct amdgpu_buffer_funcs *buffer_funcs);
>>>
>>>   /* atpx handler */
>>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 0c0489395edf..4da8de34be3d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3700,7 +3700,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>          adev->num_rings = 0;
>>>          RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>>>          adev->mman.buffer_funcs = NULL;
>>> -       adev->mman.buffer_funcs_ring = NULL;
>>> +       adev->mman.num_buffer_funcs_scheds = 0;
>>>          adev->vm_manager.vm_pte_funcs = NULL;
>>>          adev->vm_manager.vm_pte_num_scheds = 0;
>>>          adev->gmc.gmc_funcs = NULL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index e9e53c7c37d0..1a253e4257ff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -708,12 +708,14 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>>>   void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>>                                uint32_t vmhub, uint32_t flush_type)
>>>   {
>>> -       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>> +       struct amdgpu_ring *ring;
>>>          struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>          struct dma_fence *fence;
>>>          struct amdgpu_job *job;
>>>          int r;
>>>
>>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>> +
>>>          if (!hub->sdma_invalidation_workaround || vmid ||
>>>              !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
>>>              !ring->sched.ready) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 3c63f87832e4..4ba7321b75e3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -168,7 +168,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>>>   {
>>>          struct amdgpu_ring *ring;
>>>
>>> -       ring = adev->mman.buffer_funcs_ring;
>>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>>          amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>>>          WARN_ON(job->ibs[0].length_dw > num_dw);
>>>
>>> @@ -2349,18 +2349,17 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>                  return;
>>>
>>>          if (enable) {
>>> -               struct amdgpu_ring *ring;
>>>                  struct drm_gpu_scheduler *sched;
>>>
>>> -               if (!adev->mman.buffer_funcs_ring || !adev->mman.buffer_funcs_ring->sched.ready) {
>>> +               if (!adev->mman.num_buffer_funcs_scheds ||
>>> +                   !adev->mman.buffer_funcs_scheds[0]->ready) {
>>>                          dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>>>                          return;
>>>                  }
>>>
>>>                  num_clear_entities = 1;
>>>                  num_move_entities = 1;
>>> -               ring = adev->mman.buffer_funcs_ring;
>>> -               sched = &ring->sched;
>>> +               sched = adev->mman.buffer_funcs_scheds[0];
>>>                  r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>>>                                                    &adev->mman.default_entity,
>>>                                                    DRM_SCHED_PRIORITY_KERNEL,
>>> @@ -2497,7 +2496,7 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>>>          unsigned int i;
>>>          int r;
>>>
>>> -       ring = adev->mman.buffer_funcs_ring;
>>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>>
>>>          if (!ring->sched.ready) {
>>>                  dev_err(adev->dev,
>>> @@ -2730,6 +2729,27 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
>>>          return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>>>   }
>>>
>>> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>>> +                                        const struct amdgpu_buffer_funcs *buffer_funcs)
>>> +{
>>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>>
>> Only gfx9 and newer have multiple hubs.  Additionally, sdma 4.x is
>> attached to mmhub.  sdma 5.x is attached to gfxhub.  Might be worth a
>> comment here that this is just for the sdma_invalidation_workaround
>> check so it's only relevant for specific chips that have that set in
>> case someone attempts to do something else here in the future.
> 
> IIRC this workaround only applies to Navi 1x and there the SDMA is connected to the gfxhub.
> 
> But I agree that this really needs at least a comment explaining why we do this.

I added a comment to v6 of this patch, thanks.

Pierre-Eric


> 
> Christian.
> 
>>
>> Alex
>>
>>> +       struct drm_gpu_scheduler *sched;
>>> +       int i;
>>> +
>>> +       adev->mman.buffer_funcs = buffer_funcs;
>>> +
>>> +       for (i = 0; i < adev->sdma.num_instances; i++) {
>>> +               if (adev->sdma.has_page_queue)
>>> +                       sched = &adev->sdma.instance[i].page.sched;
>>> +               else
>>> +                       sched = &adev->sdma.instance[i].ring.sched;
>>> +               adev->mman.buffer_funcs_scheds[i] = sched;
>>> +       }
>>> +
>>> +       adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
>>> +               1 : adev->sdma.num_instances;
>>> +}
>>> +
>>>   #if defined(CONFIG_DEBUG_FS)
>>>
>>>   static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 3b1973611446..a6249252948b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -67,7 +67,8 @@ struct amdgpu_mman {
>>>
>>>          /* buffer handling */
>>>          const struct amdgpu_buffer_funcs        *buffer_funcs;
>>> -       struct amdgpu_ring                      *buffer_funcs_ring;
>>> +       struct drm_gpu_scheduler                *buffer_funcs_scheds[AMDGPU_MAX_RINGS];
>>> +       u32                                     num_buffer_funcs_scheds;
>>>          bool                                    buffer_funcs_enabled;
>>>
>>>          /* @default_entity: for workarounds, has no gart windows */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> index 22780c09177d..26276dcfd458 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -1340,8 +1340,7 @@ static const struct amdgpu_buffer_funcs cik_sdma_buffer_funcs = {
>>>
>>>   static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &cik_sdma_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &cik_sdma_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version cik_sdma_ip_block =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> index 0090ace49024..c6a059ca59e5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -1235,8 +1235,7 @@ static const struct amdgpu_buffer_funcs sdma_v2_4_buffer_funcs = {
>>>
>>>   static void sdma_v2_4_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v2_4_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v2_4_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v2_4_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> index 2526d393162a..cb516a25210d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -1677,8 +1677,7 @@ static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
>>>
>>>   static void sdma_v3_0_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v3_0_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v3_0_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v3_0_ip_block =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index 44f0f23e1148..d56be26f216b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -2626,13 +2626,9 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
>>>   static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>>          if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
>>> -               adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
>>> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_buffer_funcs);
>>>          else
>>> -               adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
>>> -       if (adev->sdma.has_page_queue)
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
>>> -       else
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_0_buffer_funcs);
>>>   }
>>>
>>>   static void sdma_v4_0_get_ras_error_count(uint32_t value,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 78bdfed0a7fd..67e9697301b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -2316,11 +2316,7 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
>>>
>>>   static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v4_4_2_buffer_funcs;
>>> -       if (adev->sdma.has_page_queue)
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
>>> -       else
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_2_buffer_funcs);
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index 52f4e9e099cb..86f5eb784d57 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -2052,10 +2052,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
>>>
>>>   static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       if (adev->mman.buffer_funcs == NULL) {
>>> -               adev->mman.buffer_funcs = &sdma_v5_0_buffer_funcs;
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> -       }
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_0_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v5_0_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index b4fb90cc8f7d..3fec838374b2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -2056,10 +2056,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
>>>
>>>   static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       if (adev->mman.buffer_funcs == NULL) {
>>> -               adev->mman.buffer_funcs = &sdma_v5_2_buffer_funcs;
>>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> -       }
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_2_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v5_2_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index b005672f2f96..064508cecd11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1895,8 +1895,7 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
>>>
>>>   static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v6_0_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v6_0_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v6_0_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> index 5679a94d0815..60447729271e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> @@ -1845,8 +1845,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
>>>
>>>   static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v7_0_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_0_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v7_0_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>>> index f20e0fc3fc74..c3428d2731dc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>>> @@ -1764,8 +1764,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_1_buffer_funcs = {
>>>
>>>   static void sdma_v7_1_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &sdma_v7_1_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_1_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version sdma_v7_1_ip_block = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> index 3e58feb2d5e4..155067c20a0e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> @@ -833,8 +833,7 @@ static const struct amdgpu_buffer_funcs si_dma_buffer_funcs = {
>>>
>>>   static void si_dma_set_buffer_funcs(struct amdgpu_device *adev)
>>>   {
>>> -       adev->mman.buffer_funcs = &si_dma_buffer_funcs;
>>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &si_dma_buffer_funcs);
>>>   }
>>>
>>>   const struct amdgpu_ip_block_version si_dma_ip_block =
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index 964efa325908..28dc6886c1ff 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -129,13 +129,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>>>                               struct dma_fence **mfence)
>>>   {
>>>          const u64 GTT_MAX_PAGES = AMDGPU_GTT_MAX_TRANSFER_SIZE;
>>> -       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>> +       struct amdgpu_ring *ring;
>>>          struct amdgpu_ttm_buffer_entity *entity;
>>>          u64 gart_s, gart_d;
>>>          struct dma_fence *next;
>>>          u64 size;
>>>          int r;
>>>
>>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>>          entity = &adev->mman.move_entities[0];
>>>
>>>          mutex_lock(&entity->lock);
>>> --
>>> 2.43.0
>>>
