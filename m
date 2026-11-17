Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aOoCCTf6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E03910F69A;
	Tue, 17 Nov 2026 12:11:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F2710F695;
 Tue, 17 Nov 2026 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=kM8/1+TsiIiqOZGDw6fdukO4y7KiLnEy3WUqktZlqYA=; t=1794917484; x=2110277484; 
 b=aOoCCTf6TOqIox1hpH2LZo8/ExHT9EWPzIT/fllLHXCuYBzq3Ocn8Jq4+suxCl56+mXOYyTYtwn
 yaWDKZvZ0aQ/2QzuE2ylJ0vGPSF6LMWbfvymWz0yP61EAQNjZ28HEcunDASbLtYTFm1/v16lvKsJr
 63bCreSHJeSWhif+59CviXenQpwF8rwz4i1upMPVL0iCE8rKiJhD29uZQW/FnfIlOVHPriQzP3KBu
 OM1khvTFGgS4I6IvVKGtAE2uL9/mJ+KWP1LuAiYNals8pCu4Z5NIJZGQhZjoN3Ne3pXV3xeIewNQH
 ET19BcXQzl8Ip0kDKIi0BklffqisOttg5SEA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTI1y-00000000Zws-2ZVu; Tue, 17 Nov 2026 13:11:22 +0100
Message-ID: <689e5654-2dbd-4580-88b4-75d31d853d60@igalia.com>
Date: Tue, 17 Nov 2026 12:11:21 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-2-tvrtko.ursulin@igalia.com>
 <sashiko-outbox-218670@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <sashiko-outbox-218670@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


+ Christian

Please see below:

On 17/11/2026 10:46, sashiko-bot@kernel.org wrote:

>> @@ -192,7 +192,15 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>>   				    struct drm_gpu_scheduler **sched_list,
>>   				    unsigned int num_sched_list)
>>   {
>> -	WARN_ON(!num_sched_list || !sched_list);
>> +	unsigned int i;
>> +
>> +	if (WARN_ON(!num_sched_list || !sched_list))
>> +		return;
>> +
>> +	for (i = 0; i < num_sched_list; i++) {
>> +		if (WARN_ON(!sched_list[i] || !sched_list[i]->sched_rq))
>> +			return;
>> +	}
> 
> [Severity: Medium]
> Can vcn_v3_0_limit_sched() hit this WARN_ON() when VCN0 decode is disabled
> by the hypervisor under SR-IOV?
> 
> During vcn_v3_0_sw_init(), amdgpu_ring_init() places &inst[0].ring_dec.sched
> into adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC][AMDGPU_RING_PRIO_DEFAULT].sched[0].
> Later, vcn_v3_0_hw_init() sets ring->no_scheduler = true when the hypervisor
> has disabled VCN0 decode, which causes amdgpu_device_init_schedulers() to
> skip drm_sched_init() and leave sched[0]->sched_rq NULL:
> 
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_hw_init() {
>      ...
> 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
> 				ring->sched.ready = false;
> 				ring->no_scheduler = true;
> 				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> 			}
>      ...
> }
> 
> Because vcn_v3_0_early_init() sets adev->vcn.harvest_config = 0 on SR-IOV,
> an AV1 decode submission on VCN1 reaches vcn_v3_0_limit_sched(), passes the
> AMDGPU_VCN_HARVEST_VCN0 check, and passes that uninitialized sched[0] to
> drm_sched_entity_modify_sched():
> 
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:vcn_v3_0_limit_sched() {
> 	struct drm_gpu_scheduler **scheds;
> 
> 	/* The create msg must be in the first IB submitted */
> 	if (atomic_read(&job->base.entity->fence_seq))
> 		return -EINVAL;
> 
> 	/* if VCN0 is harvested, we can't support AV1 */
> 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
> 		return -EINVAL;
> 
> 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
> 		[AMDGPU_RING_PRIO_DEFAULT].sched;
> 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> 	return 0;
> }
> 
> An unprivileged guest user submitting an AV1 decode job can trigger the
> WARN_ON(), and the early return leaves the unsupported AV1 job scheduled on
> VCN1.

If this is true then without this patch on SR-IOV, calling 
drm_sched_entity_modify_sched() with an un-initialized scheduler leaves 
entity->rq as NULL which surely explodes badly. At least I cannot see 
that it is gracefully handled anywhere.

In any case perhaps we should add this to vcn 3 and 4:

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2f7d5d562cb4..adcb94041274 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1895,6 +1895,7 @@ static const struct amdgpu_ring_funcs 
vcn_v3_0_dec_sw_ring_vm_funcs = {
  static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
                                 struct amdgpu_job *job)
  {
+       struct amdgpu_ring *ring = amdgpu_job_ring(job);
         struct drm_gpu_scheduler **scheds;
         struct dma_fence *fence;

@@ -1902,6 +1903,10 @@ static int vcn_v3_0_limit_sched(struct 
amdgpu_cs_parser *p,
         if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
                 return -EINVAL;

+       /* If VCN0 is disabled we also cannot support AV1. */
+       if (ring->no_scheduler)
+               return -EINVAL;
+
         /* wait for all jobs to finish before switching to instance 0 */
         fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
         if (fence) {

This way submission fails explicitly and -EINVAL trickles out all the 
way to cs ioctl. Thoughts?

Regards,

Tvrtko

