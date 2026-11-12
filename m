Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF4606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cwT8wYSK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777D2112195;
	Thu, 12 Nov 2026 15:38:00 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BB2112162;
 Thu, 12 Nov 2026 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=IyenNfTn35QAlDuaurUhdJEkInjbRyAHP3Qk1Ps3q+Q=; t=1794497874; x=2109857874; 
 b=cwT8wYSKuGRUrpqao3zaY2XhU6opTgqcD9VwL6BbwKWvebsZMKJX/ZvXtjw4kOCYQdpVBd8aKXz
 Z956/ddytI63YJ6u51DcZDbUSfPohfuK3yG4yPSbNJvufJ6rDV9Yu35a6d7NKUxBE/mti+maVxTsF
 BEUwCoq2xbnl9MB+mlOhoghUdxC62Usi3EmwaNf1Q5ZoY6LY+I/PeNZgb+5j5Ryt2c+LNxeoLl5u0
 dNgwHYXRV/z8bIbQWXMEiNtR9iSZ7jtY+m+AL6Qd8WxcH+R/3Z4F5lRs5wTJwoDrH0o/vvYjMUWJg
 mdFU75YnvfZGU7TN5PohdRw6jq06Rvj7yjgg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRWs3-009bk7-D5; Thu, 12 Nov 2026 16:37:51 +0100
Message-ID: <6d89e4a9-ce29-4c8f-80c8-75b713b3ac61@igalia.com>
Date: Thu, 12 Nov 2026 15:37:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/sched: Replace the SPSC queue with a list and a
 spinlock
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
 <c3e0decc799da64c09689b85c3db49b0b0a437b4.camel@mailbox.org>
 <f5e91cef-a9af-4839-b7b7-45351d59d881@igalia.com>
 <019c8094079a02f582804e735fd73058d5189225.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <019c8094079a02f582804e735fd73058d5189225.camel@mailbox.org>
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12/11/2026 14:09, Philipp Stanner wrote:
> On Thu, 2026-11-12 at 12:59 +0000, Tvrtko Ursulin wrote:
>> Since this is a lock inversion site we cannot lock
> 
> Which deadlock-circumvention strategies have you tried?
> 
> Pseudocode:
> 
> bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
> 			 struct drm_sched_entity *entity)
> {
> 	struct drm_sched_job *s_job;
> 
> +	lockdep_assert_held(&entity->lock)
> 
> 	s_job = drm_sched_entity_queue_peek(entity);
> 
> 
> drm_sched_rq_select_entity(…)
> {
> retry:
> 	spin_lock(&rq->lock);
> 	
> 	walk_tree(…) {
> 		if (!spin_trylock(&entity->lock) {
> 			spin_unlock(&rq-lock);
> 			udelay(20);
> 			goto retry;
> 		}
> 		ready = !list_empty(&entity->job_list);
> 	}
> }
> 
> 
> It appears very undesirable for someone to re-walk that tree, I get
> that. But do we even know whether that would be a measurable problem in
> practice? How often would it occur?

Problem there is adding trylock+backoff to achieve MPMC which the 
scheduler is designed not to be. Without changing the whole design to 
truly be MPMC, making the locking MPMC is just overhead. Do you see a 
route to achieve full MPMC? Do you plan to pursue it?

> Alternatively, all the other paths that do entity_lock -> rq_lock could
> be tested with trylock-patterns. They might be less impacted.
> 
> In drm_sched_entity_push_job(), for example, only occasionally are both
> locks actually needed, when a job is the first job.
> 
>>   but truly have to have an unlocked solution.
> 
> How do you know that?

Please don't cut too much context. I guess you were in a way alluding 
again to your trylock proposal.

>> This is effectively replacing one unlocked read (spsc_queue_peek) with a
>> different one (READ_ONCE(entity->job_credits)). Something unlocked is
>> unavoidable here and I think this is more elegant and simple.
> 
> Code full of ACCESS_ONCE and RCU that is not RCU is most certainly not
> elegant.
> 
> This is elegant:
> 
> spin_lock()
> list_del()
> spin_unlock()
> 
> 
> With ACCESS_ONCE, manual barriers etc. pp. no one ever knows what's
> accessed where with what ordering and why. It would then be better to
> have the problem remain centralized in spsc_queue.h
> 
> As you say yourself, this here replaces the half-locked hard to reason
> about spsc queue (we don't even know whether that thing is formally
> correct) with a half-locked "locked" linked list.
> 
> It's no improvement in any way regarding our shared goal, which is a
> consistently locked codebase that finally rids us of the race
> conditions which are plagueing this system for >10 years

How it is not an improvement in _any_ way if in your own words we can 
remove the hand rolled single kernel user spsc which we don't even know 
is formally correct?

> There is really no other way than either redesigning drm_sched so that
> the lock inversion disappears altogether, or to address the inversion
> with strategies well established in CS.
> 
>>
>> And because it is an unlocked read it has to be annotated with
>> READ_ONCE(). Which means the write side, even though it is done under
>> the lock, is paired up and marked with WRITE_ONCE().
>>
>> 2. drm_sched_entity_pop_job()
>>
>> This is not a lock inversion site but needs to call sleepable things
>> while considering the head of the job queue (->prepare_job()).
>>
>> This one is the only remaining reason I used list_add_tail_rcu and
>> list_del_rcu, just so from here we can safely touch the first entry
>> while elsewhere more are being added.
>>
>> It is possible to do it, as you suggest, by dropping and re-acquiring
>> the lock. Note however that too would need a big fat comment why it is
>> safe.
> 
> Sure, one can write code comments. No big deal. The job is not in the
> list anymore. The list is lock-protected. No one can race it.
> 
> There's only one worker popping. This must always be that way, the
> entire drm_sched design is founded on that principle.

That was my point. :) Same comment applies to both patterns. The rest is 
just implementation details. Then what remains is the question of what 
is the least bad pattern, is it trylock+back-off & re-locking, or is it 
list_add_tail_rcu & remove the need to access the queue in most places 
to begin with.

Anyway, it seems to two main points of view you expressed is to either 
do it with trylock+backoff or to redesign the whole scheduler to 
eliminate entity and run-queue locking need/order. Latter I thought it 
was agreed is not feasible and that instead a new scheduler will be 
written for new and firmware drivers so they can migrate to it. Equally 
as attempts to split the current one into frontend/backend parts was 
rejected. So I honestly don't know what is the plan any more.

Regards,

Tvrtko

> 
>>   At which point, since both cases have a big fat comment explaining
>> the same thing apart from the implementation details, I do not see the
>> advantage of pointless lock cycling. READ_ONCE and WRITE_ONCE you
>> dislike would still remain.
>>
>> As a side note it would be really good to eliminate the prepare_job
>> callback
> 
> Yes, the user should prepare everything needed before even submitting a
> job. Maybe we can begin by marking it as deprecated.
> 
> 
> 
> 
> P.

