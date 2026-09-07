Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA0C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C5810E498;
	Mon,  7 Sep 2026 10:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="uC42NDRJ";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2BB10E498
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:34:38 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c262f1186f0so183552266b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788777277; x=1789382077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B+Aa6ObNtsWuLVnK07xngOY/Mvint7kr6yr+j3fGmn0=;
 b=uC42NDRJTdL1jTp7AgSZy4OTfpkwCwRypo2YW8Qpi2JL0R3mgh7u2XeUcHTGfV083l
 J0wm7qVM0yi4/VxK5WabfyhWWBfTvF9hZ5Dvgcg3b2Ux1figldU+0rZgwQaW0ZPsP/am
 ft/GbM6p71uUf6QlG9TkBkAYZyw76w/K0vgbigUcikFv9ZUvPNz2haVDcnSsbslS1r/8
 Uk+wjlLErwbKJ10+y7Sj5oqrWpRzsDl8bd2ybG4jJ9CbmDvDBzvRDjxDI/5WuS8iO3xr
 Nudhuup3JhAl9qtfIoxuCsr2hlE9n8M9zII+PAAzUitojSQfnLXw1NfpAvhz8roFmHaA
 DL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788777277; x=1789382077;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+Aa6ObNtsWuLVnK07xngOY/Mvint7kr6yr+j3fGmn0=;
 b=CwoFxB00Stpyl47dMbs9k33l7h8QgzVr4qC9kX45qwxVa+BjF33My1CvENBzh4bJy1
 O5tv/v66tUxEr6USgmz5w6gaD6G9VxOZ0Rhpr7+Xp2fDksko4mdAmv15BkDdGVEO/XV4
 a243iHduD4LB4DUbKpvH+GmSqLpQszBALCyab2k3rAnWMVTQSOLJCVLXFYT4o2fZwygQ
 6Haku1/xTvo7W/X1IzF4YV+i8jNBZMaCqepi0Y8quG8NrawP6O9Kg8JQ5Xdk2IL5Hqtv
 bHhGA6AHveSN6uOWlQWVIEAh0fnFUTirEUgQEeTrOhhCr6nK0mBVViNWQ9G4GHhjDVFZ
 4Tpw==
X-Gm-Message-State: AFuF++ntqCHAtySDA38rzqCwYc805iB6MMcUNrokG5xWYxDCPKBkVyV+
 B4ATg+fC4vtHHjWqG60zgYj5ObbV1/NPket2aouyLwkwcQd0GiSgiW9NKhoJXcmI098=
X-Gm-Gg: AYBFou38zWj78LU+3zlIpX0O88Gg5W9fZnspZF4nMxT73Y27KhrKv8fOdbiY28cBR3w
 SlyZgcT6w9vIOkj2DqRd64nAT1yY8+cO0yWZ1O3laf/HbgTWwvNRow0DmIhPkryMwlbLnclnnpF
 KJjiBslMdYwWOO96A2rnXNaHSpnn+1tmzk03Iuw7CHH5ohPFjdMBz3j/ZyW9XUCz3Blk6s0HEzH
 I7QzLlqnUPKJhT2y7HrfRIlSbpk0ZeNiO2o/+v4BZNFpLjAkBLkpOMKhfuek6YBr33e7i7z1AbE
 HiSvjuVor6Xn3EJfHZSxhNefN2y/z5i8waULRg1b5MJLU+rYNrAHoL0CPe+dSzUKiAoFrDUQBZa
 1GofpBNoM9jpgAfYPoFw9OxtloxRKjmG5OaR92fkhY5uJHTHatbjq/KMc9ImZHwPfajiwT5ziZL
 N5orjiD27RdzYjEP9UBUaEK/F462HH8pZ3O+w0VhKs7J4Q0IcP4igS4qocEwij2DINuo8q5SyJJ
 XNb
X-Received: by 2002:a17:907:72c2:b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c260ca19c04mr1482747566b.16.1788777276733; 
 Mon, 07 Sep 2026 03:34:36 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5cfaa2sm450462066b.59.2026.09.07.03.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 03:34:36 -0700 (PDT)
Message-ID: <7e98c872-6eff-4eb5-b53b-aedaf0fcc7ff@ursulin.net>
Date: Mon, 7 Sep 2026 11:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
Content-Language: en-GB
In-Reply-To: <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
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


On 07/09/2026 11:28, Tvrtko Ursulin wrote:
> 
> On 07/09/2026 10:42, Philipp Stanner wrote:
>> On Mon, 2026-09-07 at 10:15 +0100, Tvrtko Ursulin wrote:
>>>
>>>
>>> On 04/09/2026 20:06, Philipp Stanner wrote:
>>>
>>> 8><
>>>
>>>> If you can think of a stupid and simple solution, shoot. The only thing
>>>> I can think of is moving the string into the dma_fence, as a hard copy
>>>> :)
>>>>
>>>>
>>>> In the mean time, my proposal is to keep aiming for removing
>>>> sched_fence->ops->release and fixing pvr and amdgpu.
>>>
>>> Fixing the drivers sounds like an obvious thing to try indeed. Along the
>>> same lines as it was done for xe and panthor. It is an already
>>> established and well understood approach so shouldn't be controversial.
>>> After that we can discuss in leisurely pace if something better is
>>> possible in the scheduler core.
>>>
>>> I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is
>>> it significantly more complicated than it was for panthor and xe?
>>
>> How did the others fix that?
> 
> Combination of kfree_rcu, synchronize_rcu and storing the name in an 
> object protected by those:
> 
> 6bd90e700b42 ("drm/xe: Make dma-fences compliant with the safe access 
> rules")
> 299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
> efe24898485c ("drm/panthor: fix for dma-fence safe access rules")
> 
> Not too complicated on the overall. Simply ensure RCU grace period 
> between signaling the hw fence and freeing the ops, scheduler, name, all 
> that it is in the externally accessible dereference chain.
> 
>> If we look at nouveau:
>>
>> static void
>> nouveau_sched_fini(struct nouveau_sched *sched)
>> {
>>   struct drm_gpu_scheduler *drm_sched = &sched->base;
>>   struct drm_sched_entity *entity = &sched->entity;
>>
>>   wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
>>
>>   drm_sched_entity_fini(entity);
>>   drm_sched_fini(drm_sched);
>>
>>   /* Destroy workqueue after scheduler tear down, otherwise it might 
>> still
>>   * be in use.
>>   */
>>   if (sched->wq)
>>   destroy_workqueue(sched->wq);
>> }
>>
>>
>> We see that it
>>     1. stops accepting jobs from userspace (not visible here)
>>     2. waits until all hardware fences in this ring are signaled
>>     3. only then tears down drm_sched
> 
> I cannot do a very deep dive into nouveau at the moment. I see fence 
> itself is already freed with kfree_rcu so that's good. What is reachable 
> via the timeline name callback:
> 
>      struct nouveau_fence *fence = to_nouveau_fence(f);
>      struct nouveau_fence_chan *fctx = nouveau_fctx(fence);
> 
>      return !fctx->dead ? fctx->name : "dead channel";
> 
> Fence is presumably the fence so channel. Chagning to kfree_rcu in 
> nouveau_fence_context_put() there might be enough for that one.
> 
> For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.
> 
> That makes scheduler timeline name vfunc safe:
> 
> static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
> {
>      struct drm_sched_fence *fence = to_drm_sched_fence(f);
>      return (const char *)fence->sched->name;
> 
> sched is then RCU protected. sched->name is already static so not a 
> concern.
> 
> As you say nouveau_sched_fini() only tears down the scheduler after 
> fences have been signaled it seems adding two new kfree_rcu make is safe.

P.S. Idea on how to test it from userspace:

https://patchwork.freedesktop.org/patch/642709/?series=146211&rev=2

But as nouveau does not export via sync_file you would need to adapt to 
export sync_file from syncobj.

Regards,

Tvrtko

