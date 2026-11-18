Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448A60A3822
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LuKDo0WH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A485A10E804;
	Wed, 18 Nov 2026 15:37:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480D710E7DE;
 Wed, 18 Nov 2026 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=eY9qhFWJf11t5D9qXg2Yo4cDi5/aU4sWpduUVMVeEUE=; t=1795016268; x=2110376268; 
 b=LuKDo0WHf5GYLltv9i+vNAoSUqoN9tsQXMJ0kSO5LiDv3lMySlDi3rmy6mlm0MqKyOtNMRGffYn
 uu//B9Zq31v8jMMvYSnBWqyWo1LcauoQkSCsOB3a8C0q21Jf635TVGgZzPO+UkXhut/znkWtB5+/2
 FSgrEcwFkDyIgI7DkSAgLvxbehvAu8MSQuQklLu4a0jexxv4qlHauBAYug4elb2QJVXeRSCyBstSI
 JD6bYoxzrKzfckZ8fecuME5x9XNif9JBEAHmxZW72udKTQ7GCv10ZyzcjcO0QJouHeX+umBn2h2/G
 nxgzqF+dJixA0/lqstPh/Hd8ywLziBD2rVyQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xThjF-000000014YA-1wTA; Wed, 18 Nov 2026 16:37:45 +0100
Message-ID: <09e267c6-9ce9-4b24-831d-e78c066eea14@igalia.com>
Date: Wed, 18 Nov 2026 15:37:44 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/sched: Remove the single scheduler special case
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 "Cc: Tomeu Vizoso" <tomeu@tomeuvizoso.net>,
 Sidong Yang <sidong.yang@furiosa.ai>
References: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
 <20261117100654.8593-4-tvrtko.ursulin@igalia.com>
 <be7d801d2affa69a758a6b825b4481073fc5354b.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <be7d801d2affa69a758a6b825b4481073fc5354b.camel@mailbox.org>
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
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 18/11/2026 12:00, Philipp Stanner wrote:
> Why do you call "single scheduler" a special case? That seems to be
> quite a common case.

Special case a) in the code:

drm_sched_entity_init
{
...
	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;


drm_sched_entity_select_rq
{
...
	if (entity->num_sched_list == 1)
		entity->sched_list = NULL;

And b) in the API contract, where when:

1)
drm_sched_entity_init num_sched_list == 1

Caller can pass in a stack sched_list container (as many if not all 
current callers do) ie. does not have to keep it valid for the lifetime 
of the entity;

and 2)
drm_sched_entity_init num_sched_list > 1

Caller MUST ensure the sched_list containers remains valid for the 
lifetime of the entity.

> On Tue, 2026-11-17 at 10:06 +0000, Tvrtko Ursulin wrote:
>> In order to untangle all this lets make this area behave consistently and
>> store the single scheduler case directly in the entity. We can do that
>> easily by creating an union between the current pointer to a list of
>> schedulers, and a new pointer to the single scheduler.
>>
>> This allows removal of the special cases which artificially cleared
>> entity->sched_list for a single scheduler case and fixes the amdgpu
>> dynamic priority changes for the single IP instances.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: b3ac17667f11 ("drm/scheduler: rework entity creation")
> 
> Can you describe what the actual bug is?

It's explained in the commit message, but in short:

1)
drm_sched_entity_init calling convention (sched_list ownership rules) is 
dangerous and undocumented.

2)
drm_sched_entity_set_priority is broken when num_sched_list == 1 due 
above listed special casing.

Furthermore, the special casing, from the analysis presented in the 
commit message, appears to be a kludge to work around the UAF due 
unclear sched_list ownership/lifetime rules.

>> References: 8c23056bdc7a ("drm/scheduler: do not keep a copy of sched list")
>> References: 977f7e1068be ("drm/amdgpu: allocate entities on demand")
>> References: 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx priority override")
>> References: ac4eb83ab255 ("drm/sched: select new rq even if there is only one v3")
>> References: 981b04d96856 ("drm/sched: improve docs around drm_sched_entity")
>> References: 77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
> 
> This commit has been reverted.

It is stil a valid reference since with that commit the broken 
drm_sched_entity_set_priority() was fixed in a different way.

> Recently, I often end up a confused by your series'. Is this here
> another RFC?

No, it's a fix.

I appreciate one needs to devote sufficient time to stay on top of them. 
Recently you kindly reviewed a series where all patches were about 
drm_sched_init. This series is all about drm_sched_entity_init.

> Is it a preparational patch for your CFS work?

Nope, it is a fix and clarification for drm_sched_entity_init().

>>    *
>> - * Note that the &sched_list must have at least one element to schedule the entity.
>> + * Note that the &sched_list must have exactly one element to schedule the
>> + * entity. Callers which pass more than one scheduler on the @sched_list must
>> + * ensure the list remains valid for the lifetime of the entity.
> 
> What does that even mean, "valid"? Like, not deallocated?

Yes.

> How does drm_sched_entity_modify_sched() play into that?

Same issue as drm_sched_entity_init because first job arm will clear the 
sched_list when num_sched_list == 1, which means run-queue cannot be 
change ever after.
>> -	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
>> +	if (entity->num_sched_list == 1)
>> +		sched = entity->sched;
>> +	else
>> +		sched = drm_sched_pick_best(entity->sched_list,
>> +					    entity->num_sched_list);
> 
> So what you want to achieve is that sched_list can never be NULL? How's
> that a bug?

Null sched_list prevent run-queue changes with FIFO and RR.

>> -	struct drm_gpu_scheduler        **sched_list;
>> +	union {
>> +		/**
>> +		 * @sched_list:
>> +		 *
>> +		 * A list of schedulers (struct drm_gpu_scheduler).  Jobs from
>> +		 * this entity can be scheduled on any scheduler on this list.
>> +		 *
>> +		 * This can be modified by calling
>> +		 * drm_sched_entity_modify_sched(). Locking is entirely up to
>> +		 * the driver, see the above function for more details.
>> +		 */
>> +		struct drm_gpu_scheduler        **sched_list;
>> +
>> +		/**
>> +		 * @sched:
>> +		 *
>> +		 * A single struct drm_gpu_scheduler jobs from this entity will
>> +		 * be scheduled on.
>> +		 *
>> +		 * This can be modified by calling
>> +		 * drm_sched_entity_modify_sched(). Locking is entirely up to
>> +		 * the driver, see the above function for more details.
>> +		 */
>> +		struct drm_gpu_scheduler        *sched;
>> +	};
> 
> So you now would have some mode where there is sometimes a list and
> sometimes a pointer, and what it is can change dynamically through
> drm_sched_entity_modify_sched()??
> 
> How would that untangle anything?

I hope it is clearer after this reply? Commit message is complicated for 
a reason - because the history of the num_sched_list == 1 special case 
is equally complicated and confused.

Tvrtko

