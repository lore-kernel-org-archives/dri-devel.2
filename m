Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAB6082626
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XU5aQqys
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD57410EF4D;
	Mon,  2 Nov 2026 14:47:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381E310EF42;
 Mon,  2 Nov 2026 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=jQw5ix+gEQdGpmFbBmDqsmFBc8+v6QKH8bqPjj6E844=; t=1793630828; x=2108990828; 
 b=XU5aQqysDhgmhLJb9QDp7WmUddMchEZ18ec24Ge2Q/dO6NBk1Sg+8zBeZdzh8V3aonup1vDR5Zj
 hP6a2WAQpR1XcSWF0R76GhTXC5OnQim5wkHQE8rwGOfZ+yV480VW2NvFn+eG0iS6m1UCUvarSfzl3
 tAOHVGy3Ur9P05b/Gi7U3sDIfWSG8LmWSOspcZgRb9Iyp74LcXxiqmfah5RFBjFp0cNEXnsEqo5wP
 GpbwhsoCXUe6RO2q/9OE+zTX3MAsbOzT0yCTKOt2nYLqTiEMmiTAIzlrvwrIfimS/COjuHzgEEu19
 Z3feTW/PSIDLD82vj8gtoF5laWN24ekNUhmQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xNtJR-000DtQ-LI; Mon, 02 Nov 2026 15:47:05 +0100
Message-ID: <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
Date: Mon, 2 Nov 2026 14:47:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority
 at runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 02/11/2026 10:42, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 10:42 +0100, Tvrtko Ursulin wrote:
>> Another consequence of the recent revert of
>> 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
>> is that after the revert we need to adjust entity->rq_priority when
>> runtime priority changes are requested.
>>
>> Only amdgpu does that so the impact is minimal.
>>   Also considering dynamic
>> priority changes are largely broken there, due currently broken entity
>> scheduler list handling where the special case of a single scheduler can
>> never change it's run-queue. And coupled with the fact for the rest a two-
>> tier approach of drm_sched_entity_set_priority() and
>> drm_sched_entity_modify_sched() is used, where later directly maps to
>> different hardware queue priority by replacing the set of schedulers
>> completely.
>>
>> Hence the regression is limited to rings which have multiple instances
>> other than compute and graphics, which would be SDMA only, for which I am
>> not sure any userspace actually does dynamic priority changes in the first
>> place.
> 
> I can't fully grasp what the bug actually is. So is it that we forgot
> to adjust the priority in the CFS series, or is it that the partial
> revert made this necessary?

Partial revert makes this necessary, albeit mostly on paper. In reality 
it is complicated. Only amdgpu calls it, plus, for single scheduler IP 
blocks there is not bug because of the "single scheduler special case" 
run-queue cannot change at all (bug I am trying to address in that 
different patch, and which also got re-uncovered due the partial revert 
of the fair series), while in the multiple scheduler case there is no 
bug because amdgpu pairs drm_sched_entity_set_priority() with 
drm_sched_entity_modify_sched(), which actually changes the priority in 
the driver. This leaves SDMA as the only potential place where there can 
be a regression, and there I am not sure those do dynamic priority 
changes from the userspace side in the first place. But theorethicaly, 
from the UAPI point of view, it could be a regression so needs to be fixed.

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: <stable@vger.kernel.org> # v7.2+
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index e12709b7bd0c..03e68b4102d5 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -456,6 +456,8 @@ void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
>>   {
>>   	spin_lock(&entity->lock);
>>   	entity->priority = priority;
>> +	if (drm_sched_policy != DRM_SCHED_POLICY_FAIR)
>> +		entity->rq_priority = priority;
>>   	spin_unlock(&entity->lock);
> 
> So is there always a bug, or only for FAIR?

With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if* 
there exists userspace which does dynamic priority changes (calls 
DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on 
entities using those SDMA engines directly. All clear now? :))

Regards,

Tvrtko

> 
> 
>>   }
>>   EXPORT_SYMBOL(drm_sched_entity_set_priority);

