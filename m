Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD8C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EA610E8C9;
	Mon,  6 Jul 2026 10:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cIeUf+72";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D920510E370
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZJoxLXbBFInuBRIgEp6vSOmCAY0GKp91Nz1MsnjS+Ec=; b=cIeUf+72RjbqJ5oE5oxo0NGSFT
 C5BTemsq66N2D1T6UjUHwhE+g74dchGlAlDqaVZjg66Aqlp9l2KotbodIsJLfgF7Qt0zus8j8QAN2
 z0sQiSHirOnP1SpRTHavzS091EysJuQI+jgKZShfz+/+eWmIm//0eZLSpMAxC/T0btUxmvT4iFQhf
 qexggOzHn+/zvVJP19OxSK1RA3PTMYZjl5RYHAmH6sjs2dhAcLrZEmJv8mqV+Ukm4Syn/wui8Gn8W
 J2BGBl0UP6UE0lWEVnY6YmRpzm2IXurcNQImFN90aOhk42/r55jViLZqR4jrFsKOH2UxnZbIE0TCW
 ZosmOfOA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgh2e-009hAL-3I; Mon, 06 Jul 2026 12:59:12 +0200
Message-ID: <441ad8f8-3618-4c53-995a-2b81f283ab16@igalia.com>
Date: Mon, 6 Jul 2026 11:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/sched: Protect entity->last_scheduled with
 spinlock
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marco Pagani
 <marco.pagani@linux.dev>, Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-3-phasta@kernel.org>
 <a4091099-1931-4ca2-a81a-9c3321b123a8@ursulin.net>
 <51fbde808bd059510d667d130afae179626303be.camel@mailbox.org>
 <ce33edbb-11dd-4722-bb87-d16155f35a75@igalia.com>
 <0af946b7bef6958f103598083919bbf933423676.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <0af946b7bef6958f103598083919bbf933423676.camel@mailbox.org>
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


On 06/07/2026 10:42, Philipp Stanner wrote:
> On Mon, 2026-07-06 at 09:45 +0100, Tvrtko Ursulin wrote:
>> On 03/07/2026 15:47, Philipp Stanner wrote:
>>>
>>>
>>> I think it can detail which functions will now be locked; but
>>> mentioning the users would be overkill and is uncommon for API reworks.
>>
>> Here I disagree quite strongly. Given the patch is making strong claims
>> that the lockless access was added for no obvious reason, and that we
>> have now established the lockless helper is in fact used on the
>> submission paths, it is really required that those strong claims are
>> backed by a concrete analysis instead of just saying "not performance
>> critical in any way".
> 
> This is a strong case for the reversal of the burden of proof.

I did not want us to discourse into side philosophical arguments about 
how and why the code base got to where it is. The story at hand is much 
simpler and narrower so excuse me for skipping the majority of the below.

Put in a different wording, what I was trying to express is this: Lets 
not write a poor commit message because the original one was poor. Aka 
two wrongs do not make a right.

Also, I am not putting a burden of proof on you, in fact, I offered to 
test your series.

As to your closing question to what I suggest commit message needs to 
add, that is simple, and yes, the first bullet point you list is what I 
have already asked for in one of the previous replies. So say something 
along the lines of:

"""
drm_sched_entity_error(), which is significantly used from various 
stages of the amdgpu job submit path, either directly or via 
amdgpu_vm_generation(), is changed from lockless to taking the 
entity->lock. As performance was not listed as a reason the lockless 
approach was chosen in the above referenced commit, although it is 
suspected that might have been the motivation, it is now thought that 
the new lock cycles to those paths will not add any measurable overhead.

For other drivers no new lock cycles are added to the submit path, given 
drm_sched_entity_select_rq() via the job arm path already bails out 
early due all drivers apart from AMD only passing a single scheduler 
list to the entity.
"""

Bonus point if you can spend the time to count how many extra 
lock-unlock cycles it is adding between it's CS submit, prepare job and 
run job entry points.

For me, that is not the burden of proof but some minimum standard of a 
commit message which shows some due diligence was done.

Regards,

Tvrtko

> The entire code base of drm_sched has been designed on the computer
> science premise of locks being evil. That's why literally all
> synchronization primitives except for locks have been used where
> possible, including undefined behavior. The designers tried as hard as
> they could to avoid locks.
> 
> That is clearly proven by the fact that in all original data type
> definitions, the only components that were locked were always lists,
> since those are the structures where you really cannot avoid a lock in
> most cases.
> 
> The aversion to locking was so great that they designed spsc_queue,
> which uses at least as many as expensive instructions as a lock + list
> would have needed, and its correctness is not proven, nor are its
> behavior and rules neither documented or proven.
> 
> It's not up to the faction who wants to use correct locking and phase
> out UB to prove that the locklessness is bad, but to whomever added the
> locklessness to prove why it is good, i.e., necessary – which was not
> done here, neither in comments nor commit message. So the reasonable
> assumption is that it's simply a leftover from a flawed, broken design.
> 
> And the kernel-workflow is that things are always on-list for a while
> before being merged is that parties who do have concerns and who can
> point out problems have time to do so. Which is of course open to you:
> do you see a performance-regression problem with this patch, and if so,
> where?
> 
> Anyways:
>   * Correct me if I'm wrong, but it would seem the only driver-usage
>     which could see a *new* lock in its path is
>     drm_sched_entity_error(), for which you yourself agree that it's
>     irrelevant performance-wise. Should we still list the user's of that
>     function?
>   * The other relevant user path, drm_sched_job_arm() via
>     drm_sched_entity_select_rq(), must already be called under a common
>     driver lock for drm_sched_entity_push_job(), and _select_rq()
>     already takes the entity lock. So any significant regression here is
>     hyper unlikely.
>   * The only other contender is the job pull path, which runs serially,
>     by 1 work item at one point in time.
>   * drm_sched_entity_kill() / _fini() are used in user context teardown
>     path. Performance irrelevant.
> 
> I can offer to add the list above for the justification of why removing
> the half-undefined behavior is good.
> 
> Or what exactly would you want to see documented? "amdgpu uses
> drm_sched_job_arm() and now sees a lock-critical section longer by 3
> instructions. etnaviv uses drm_sched_job_arm() and now…"?
> 
> 
> 
> 
> P.

