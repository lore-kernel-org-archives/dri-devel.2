Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5DCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B0010EE38;
	Wed, 24 Jun 2026 09:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CAES1pj8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F06910EE41;
 Wed, 24 Jun 2026 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+J2oQzqC2jj+FW8//CA9WRu/dAekWzukpLDd4t1goM=; b=CAES1pj83FfriYSvDUddOG8MOt
 tzM2/pLpS8F7s40TOrTBrPoybrwx9HCtOXvztiZbgoCaOEsWALrDyFdmSd9ivUUpsvFpvwZ7WonSc
 S6JGCkRDPCGZvKKsEKmBRMIZ2eYGDtEB9mNgi6hJ86cxA7BQCguaBPqmYzjzED3TbBdiamgfJaOG1
 iiFdYjb0UbjWwRsIEMrX5B5AhPueoBNgcNSk/wZ/gUhr2eteseR+bS/DxJlXv5DvZgSL1P1t38KA1
 y3W5Wwpz3JOFPbPBVbWFVfWF7vczDbLTO2QR1RwSm599fkDrrQVMihqw8tbxw+yZP8RPyeNvjJ0ax
 Db62nLug==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wcJus-004Xa2-EP; Wed, 24 Jun 2026 11:29:06 +0200
Message-ID: <3a2f1a1d-ed26-46de-8a99-c5e5ad3ed1b3@igalia.com>
Date: Wed, 24 Jun 2026 10:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/sched: Replace completion with a flush
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
 <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
 <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
 <e9b876bea7a2ef33d5e4ca103721135400c875be.camel@mailbox.org>
 <d505d14d-f62b-4f71-9990-c82411381f48@igalia.com>
 <ddd953feb2a326ce77851405252a8010c3b23235.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ddd953feb2a326ce77851405252a8010c3b23235.camel@mailbox.org>
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


On 23/06/2026 15:48, Philipp Stanner wrote:
> On Tue, 2026-06-23 at 15:05 +0100, Tvrtko Ursulin wrote:
>>>> There we have this sequence:
>>>>
>>>>      spin_lock(&entity->lock);
>>>>      entity->stopped = true;
>>>>      sched = drm_sched_rq_remove_entity(entity->rq, entity);
>>>>      spin_unlock(&entity->lock);
>>>>
>>>>      if (sched)
>>>>      	drm_sched_flush_run_work(sched);
>>>>
>>>> That is, without that check, in theory, an evil driver could race
>>>> drm_sched_entity_select_rq() (via drm_sched_job_arm()) and
>>>> drm_sched_entity_kill(). I am not sure if any driver can actually do
>>>> that at the moment but it felt sensible to express it in code.
>>>
>>> The devil is in the "at the moment".
>>>
>>> AFAICS and as your explanation sounds, this is an existing problem that
>>> is unrelated to the Flush RFC. So I suppose that this should be a
>>> separate patch (independent from this one) which precisely focusses on
>>> this robustness work.
>>
>> Catch is, and why I thought it is justified to do this it in this patch,
>> is because before completion was in the entity so whats happening with
>> entity->rq->sched after entity is stopped was irrelevant. With this
>> patch is it relevant on paper so I considered it prudent to express that
>> in the code as well as the comment.
> 
> I'm not sure if I can fully follow, but it seems that the stopped
> boolean + spinlock now protects the scheduler pointer?
> 
> 
> IDK, I don't feel comfortable right now.. New docu says
> 
> drm_sched_rq_add_entity(struct drm_sched_entity *entity)
>    * @entity: scheduler entity
>    *
>    * Removes a scheduler entity from the run queue.
> + *
> + * Return: DRM scheduler selected to handle this entity or NULL if entity has
> + * already been removed.
>    */
> 
> 
> Isn't a removed entity by definition stopped since drm_sched can't
> access it anymore? Or do we have race there, too?
> 
> If so, then stopped and entity->rq->sched == NULL represent the same
> state. IOW, the locked bool must be redundant with something.
> 
> Right?

No, they are separate things. Removed entity is a normal transitional 
state that happens at runtime. Before any jobs have yet been submitted, 
or when drm_sched_entity_select_rq() changes the selected scheduler it 
removes the entity from the old run queue.

Regards,

Tvrtko

>> Acceptable or unacceptable?
> 
> In any case such changes should, wherever possible, be a separate
> patch. For the fact alone that the distinct commit message and
> especially the position / order of the patch within the series helps
> the reviewer greatly in understanding what that particular change
> enables and thus why it's necessary.
> 
> 
> P.

