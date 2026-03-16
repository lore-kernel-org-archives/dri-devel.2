Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F67F46435
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8401410E2D8;
	Mon, 16 Mar 2026 09:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="BU1xPM65";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DF510E2D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:31:41 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-485392de558so26029835e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773653500; x=1774258300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+j0v98M3c9Yt88UPpiN3BaLxthOV1CMBTj730pi0KW0=;
 b=BU1xPM65pm8tL+2ijkazEqPXanw81U0T3/kvs8WUvTaFwMz56wNZ41IaiPKmKTaoaQ
 aefokOrEisci8s8YudnI2vWV7Fh0Hsg8oFSx4pXfGeemIP/b1HMtjJn4lecJ8c8WXmHg
 0ir9GDJ60d1pHOMgGXXVMZ4jGP1w9lPirLTXPr8TfzT2qcoLWDsFAm384dzaKjvpo+Em
 Bt5SMs2PyGjSjGkkvypZ0K3ZuwZC83vkAsO/187uPGB5vFVKMr3n/DGILihuzRh2O8f1
 Zcc4HF6XjPDFQ9W6i4bjB2RMlBk/7cpGPYflCVG4hh5sUmhTth5J6tWo9/QliTOAxKYr
 IE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773653500; x=1774258300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+j0v98M3c9Yt88UPpiN3BaLxthOV1CMBTj730pi0KW0=;
 b=a2qsmVwQ9b6ZgT3ac7RVNhaBnXcf0be8pbxvYo8f+eDuZmZdz7+WlboZiMhm+CVF1p
 3OT9NgKlZREc6ESlGPRL1BPKRycgBgDPRsq4Qkvb2tLJBTskKouLqR/cvnvXXIuJQy2w
 qynlo5hsAzg9U3Oon6Mxw1svrqm4LuRoOq0sGIdKm8tWXUdX34RuCl0JxFf7yUTtIbbh
 ZYvDdp7V/AEDeAmtKQLqUWpaHLQgzOMuVfnRIoy4kvnNiE/wivaMc9Yt/oLaflvYEIpf
 CkCvLiAD1GDKCjv0ekcpukEk2wnOL7MpBNlmBJMUHcas9cfo3DGV3Q/cTnM5bedY2okZ
 gqAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuHCyjQUyJqzZnRsXRGrHedv7uG5gYkfdw5ad2MpuUcIp0NHQ82N+5W+XkCKxq5k0stLG9rrkWGVw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzCifl/CAvnAhKQzdKjSBNaI/mYYZx/rqGR/pEDBR9nv1/z3AH
 7+1WoCoqh2g5Gglx/UlAjVmuMhTPNLPpdfQEpQ9/deWIgelKok7gOCFRYkF0gbU9SVw=
X-Gm-Gg: ATEYQzyVIgCejvH+K9WG78tlPbQm0ATQ5TRwP6Qd+r79PtVJU+WIZOUIT1YgwEKSCj9
 pWyu+4GgStan/6DY59/nY21LVwGKLWwfbXzmJG7h+5i9y3WQPnQ1g7zqouvU6vet/Gdjs/wqKc4
 S1ExyGHOQ6ljzachENJjJqyG/d1aduX5+xzdae12uXYGLPLA1WV8D1D/5J4rUa88S7QA3n7DFeW
 mt+T5DFzSEYERkeUXTIU9eM4pLzHQO25FdkpSj8GSZsQsxVuZTYwYZiprqz5561pFZD5MoHiA/+
 oLfTnjTlJDSCCGX6MgVCAzr2D6w5jv20k25tUbI5tQZXOLS31fS/CQ2o6T+OrgoW2/hpZWj9CDg
 SAZ6a+kTHkkgmUCUKyXdax1V1jd1Z7pvnY2yi7zV97A41hOF5BJAD0ONrY8T7SokEXv5/IKmKdS
 L0fmAsDhEDr7z3ZupA79n5mBprpbrjtlm1rEuP1eZoWKb6
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-485566ca967mr198323625e9.3.1773653499446; 
 Mon, 16 Mar 2026 02:31:39 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm871878505e9.10.2026.03.16.02.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 02:31:39 -0700 (PDT)
Message-ID: <a965580a-568a-4d68-a2ad-53c962ec06b9@ursulin.net>
Date: Mon, 16 Mar 2026 09:31:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
 <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
 <792705f1-e50e-48f8-ae06-95b6da0bb0f1@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <792705f1-e50e-48f8-ae06-95b6da0bb0f1@gmx.de>
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


On 16/03/2026 09:05, Natalie Vock wrote:
> On 3/13/26 15:11, Tvrtko Ursulin wrote:
>>
>> On 13/03/2026 11:40, Natalie Vock wrote:
>>> When checking whether to skip certain buffers because they're protected
>>> by dmem.low, we're checking the effective protection of the evictee's
>>> cgroup, but depending on how the evictor's cgroup relates to the
>>> evictee's, the semantics of effective protection values change.
>>>
>>> When testing against cgroups from different subtrees, page_counter's
>>> recursive protection propagates memory protection afforded to a parent
>>> down to the child cgroups, even if the children were not explicitly
>>> protected. This prevents cgroups whose parents were afforded no
>>> protection from stealing memory from cgroups whose parents were afforded
>>> more protection, without users having to explicitly propagate this
>>> protection.
>>>
>>> However, if we always calculate protection from the root cgroup, this
>>> breaks prioritization of sibling cgroups: If one cgroup was explicitly
>>> protected and its siblings were not, the protected cgroup should get
>>> higher priority, i.e. the protected cgroup should be able to steal from
>>> unprotected siblings. This only works if we restrict the protection
>>> calculation to the subtree shared by evictor and evictee.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo.c | 43 +++++++++++++++++++++++++++++++++ 
>>> + ++++++---
>>>   1 file changed, 40 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index 7300b91b77dd3..df4f4633a3a53 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk 
>>> *walk, struct ttm_buffer_object *
>>>   {
>>>       struct ttm_bo_evict_walk *evict_walk =
>>>           container_of(walk, typeof(*evict_walk), walk);
>>> +    struct dmem_cgroup_pool_state *limit_pool, *ancestor = NULL;
>>> +    bool evict_valuable;
>>>       s64 lret;
>>> -    if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state- 
>>> >limit_pool,
>>> -                          bo->resource->css, evict_walk->try_low,
>>> -                          &evict_walk->hit_low))
>>> +    /*
>>> +     * If may_try_low is not set, then we're trying to evict 
>>> unprotected
>>> +     * buffers in favor of a protected allocation for charge_pool. 
>>> Explicitly skip
>>> +     * buffers belonging to the same cgroup here - that cgroup is 
>>> definitely protected,
>>> +     * even though dmem_cgroup_state_evict_valuable would allow the 
>>> eviction because a
>>> +     * cgroup is always allowed to evict from itself even if it is 
>>> protected.
>>> +     */
>>> +    if (!evict_walk->alloc_state->may_try_low &&
>>> +            bo->resource->css == evict_walk->alloc_state->charge_pool)
>>> +        return 0;
>>
>> Hm.. should this hunk go into the previous patch?
> 
> Hm. Maybe, I can move it there in a v7.

Do you see it as logically belonging to 5/6, or not?

>>> +
>>> +    limit_pool = evict_walk->alloc_state->limit_pool;
>>> +    /*
>>> +     * If there is no explicit limit pool, find the root of the 
>>> shared subtree between
>>> +     * evictor and evictee. This is important so that recursive 
>>> protection rules can
>>> +     * apply properly: Recursive protection distributes cgroup 
>>> protection afforded
>>> +     * to a parent cgroup but not used explicitly by a child cgroup 
>>> between all child
>>> +     * cgroups (see docs of effective_protection in mm/ 
>>> page_counter.c). However, when
>>> +     * direct siblings compete for memory, siblings that were 
>>> explicitly protected
>>> +     * should get prioritized over siblings that weren't. This only 
>>> happens correctly
>>> +     * when the root of the shared subtree is passed to
>>> +     * dmem_cgroup_state_evict_valuable. Otherwise, the effective- 
>>> protection
>>> +     * calculation cannot distinguish direct siblings from unrelated 
>>> subtrees and the
>>> +     * calculated protection ends up wrong.
>>> +     */
>>> +    if (!limit_pool) {
>>> +        ancestor = dmem_cgroup_get_common_ancestor(bo->resource->css,
>>> +                               evict_walk->alloc_state->charge_pool);
>>> +        limit_pool = ancestor;
>>> +    }
>>> +
>>> +    evict_valuable = dmem_cgroup_state_evict_valuable(limit_pool, 
>>> bo- >resource->css,
>>> +                              evict_walk->try_low,
>>> +                              &evict_walk->hit_low);
>>> +    if (ancestor)
>>> +        dmem_cgroup_pool_state_put(ancestor);
>>> +
>>> +    if (!evict_valuable)
>>
>> This part is probably better reviewed by someone more familiar with 
>> the dmem controller. One question I have though is whether this patch 
>> is independent from the rest of the series or it really makes sense 
>> for it to be last?
> 
> It depends on patch 2/6 (cgroup,cgroup/dmem: Add 
> (dmem_)cgroup_common_ancestor helper). I could potentially reorder it, 
> though then there's likely going to be quite a few rebase conflicts.

I will not insist on it, ordering is probably not that critical in this 
case. It just looked to me the added condition is an independent fix 
from the charge accounting and unprotected eviction changes. Up to you 
for what I am concerned at least.

Regards,

Tvrtko
