Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E3606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Bx1g+nBC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80DA10E5B9;
	Thu, 12 Nov 2026 12:35:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EA010E5B9
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=wilOJvfpKILyF1h2Z/6XvBYJ42qNGOOL5OEmJbWZLlQ=; t=1794486914; x=2109846914; 
 b=Bx1g+nBCwK2xJ1EPLYyvm7CXua2SoLQybSuVklR5RJVR+A5vsY7RzJ5P22OYPsZXoc04DDKCp+N
 9LdWvPOLU+Hg3z9l8vGIMkkgVXf8e7VOGhPszGlcih+t90xPXVvyLKoSmY6RwH244DXJ1oMFI38U9
 C38WvzdhBZZvVrz5kxaOk4QduL6Cti0Ls7JFJQ92yY60tVkRGPYq0Qh/eCP648w8k6aS3cRSQ57vO
 MFG6lkDsN7BRH0ktOK+QWHZtkvPhp0RVt7VSjJKxAJci90LUcRgFEuSlGTo6OedVEVo2LX23ALRk0
 7awUm6zgaxLjvavwohAACkZLPwyHd+Qt3NMw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRU1H-009XQH-Uy; Thu, 12 Nov 2026 13:35:12 +0100
Message-ID: <bcd960d8-42f2-4d37-81eb-42634a2a7681@igalia.com>
Date: Thu, 12 Nov 2026 12:35:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Do not overaccount job runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Gary Guo <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20261111105921.38710-1-tvrtko.ursulin@igalia.com>
 <71ad23bcb3d48f771ce74270dbe4dfcf39827031.camel@mailbox.org>
 <0ff2a53b-377e-4839-88da-1c2b3c25b3eb@igalia.com>
 <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6f2f8ff3738152b50521e0cad88978e2ffdb5feb.camel@mailbox.org>
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


On 12/11/2026 08:48, Philipp Stanner wrote:
> On Wed, 2026-11-11 at 15:05 +0000, Tvrtko Ursulin wrote:
>> jobs. It did not feel worth explicitly putting cc: stable on the patch.
> 
> OK.
> 
>>> This is the *next* job's scheduled fence, so this sounds suspiciously
>>> racy. Testing the bit and overwriting the timestamp, can't that race?
>>
>> I have a feeling the code was assuming the default ordered workqueue
>> ensures either run_job or free_job runs at a time. So seeing timestamped
>> next fence guarantees free_job has exclusive right to the timestamp write.
>>
>> That is not true though for the three drivers which use own unordered
>> workqueues - pvr, nouveau and panthor.
>>
>> If we look at the drm_sched_run_job_work():
>> ...
>> 	drm_sched_job_begin(sched_job);
>>    -> puts on a pending_list for free job to find
>> ...
>> drm_sched_fence_scheduled(s_fence, fence);
>>    -> signals the scheduled fence
>> ...
>>
>> If free_job interleaves in the middle, so it sees the next job but it
>> looks unscheduled it will skip the correction.
> 
> I'm not even sure why this is done here. We just overwrite the fence's
> timestamp. Why?

It is essential for accurate GPU time accounting for all drivers where 
drm_sched_init_args.credit_limit > 1. Otherwise N jobs can be submitted 
to the hardware at the ~same time, and have a ~same scheduled timestamp, 
while in reality the execute serially one after another.

> The fence gets marked (signaled) as scheduled in
> drm_sched_run_job_work(). Hence, that should be the relevant point in
> time. Why should free_job() have anything to do with that?

Indeed it would be nicer, in theory, if it could be done in for example 
drm_sched_job_done_cb. I *think* I tried it couple years back or so but 
now from the top of my head I don't remember what was the gotcha. 
Probably either lock inversions or job lifetime issues.

> Looks very suspicious. As if there are two redundant mechanisms here.
> 
>> Yes I think you are right. As said I think there is no real bug due race
>> with unordered workqueues, but for formal correctness it would require a
>> memory barrier after test_bit, or full blown locking.
> 
> Is it guaranteed that this fence is signaled and, thus, has a
> timestamp, or is it not? If it's guaranteed, the test_bit() is actually
> unnecessary. If it is not guaranteed, then there can be misordering
> between the two operations and it's UB and, thus, a bug.

As I wrote yesterday, for formal correctness I agree a barrier or lock 
is missing. But in practice, unless my analysis was wrong, there is no 
actual problem stemming from that omission due false negative meaning 
next fence's scheduled timestamp hasn't been timestamped in the past so 
it doesn't need correcting.

> That said, I'm OK with your patch here being merged since you did not
> cause that chaos / problem, but a second patch with a FIXME about the
> issue that links this mail-thread would be good.

Great, thanks, and no problem, I am marking this as TODO and will send a 
patch once this one is in the tree.

Regards,

Tvrtko

