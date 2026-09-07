Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16ACC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC98110E1BE;
	Mon,  7 Sep 2026 10:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="W8lLh0nB";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444C010E1BE
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 10:28:13 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so543067566b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788776892; x=1789381692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ABEcogDwsawzeRdmBozIgKVzjqJVU/2yTKqGiwVKefE=;
 b=W8lLh0nBKdx0eSlgvgmggUm4B95FayIpQeTmHvaIBxZhMs4k7Rk/2FloC/tUrdF1Wg
 VVA55ikKjzbu/I+YGNWbZf0gnU/HbSxO7jAK/XJLQE86WK+SUd+EVlmv8j9O18+1MUrX
 wZxJdkl7+7ROS1FTadkgekQrT1kGyt4ArWXKyyBT8gW6oRKi7Aj92ABAuRVFM7ykyk0J
 MmrOJW5ATf3AEANHjPs8VaotoJ6HQpPcYOh+QTW0VTWRYJHRlvilE8LYVmnsmISqbofc
 PEuA399Pa4v3fP3p3xsRjt6w2fIeLxtY1jiXVBCo2PgpenlzfQfXX1Kou6LNU9Dc5QWj
 p3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788776892; x=1789381692;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ABEcogDwsawzeRdmBozIgKVzjqJVU/2yTKqGiwVKefE=;
 b=WbsX69JqHNucf3H2W1fHIQy7ZcW4v1/JTSTs+oVvzkDrmsz+qYEp0NmP7FZw0VmW7A
 Xbxn8+PQb3iYoUJhckjSMNUOHPftzadV+/8K4GVK/HjAQADZlh6IpmSHQx+KwD558dkr
 IN1XoLvhhiYqnGTtVzuW5CSS0I3q1URoL7wm2aav5SDlBCwlAFkfeXs+ZzJYsryNDxOs
 YtNW99cw1Vgj63IgoawlxoOeG1KRF/D/MMGrkJ9ed2/mzhoGU376g2f3y8yhPsAiW0qI
 9Jt3/p9QePUz89auFGlwnKHFle7N4qwI8460CPIsF5x2P2INVOifqE67krZ8juNAgriY
 tGHw==
X-Gm-Message-State: AFuF++n9XgKscKmPosWLbVQ34t89clweSff8AQZUdDnuIomX6DjwDSxW
 F/ZfHBrmCeBYGrIuqKZ9PXZvqqJQEbR53iUQBXFCjPK7RldqvuYSAJn1CCaKJKpvHBE=
X-Gm-Gg: AYBFou2vf/32mhxFJRsWgpaCP+mPfTUS85FrWugQY/bIDMNUQjg09PqVMxES/UaKRMa
 DOfoPhQUpwjtNWiKyPMj1pFb+gUFM+1PdO8vwXQO6TDXEw4qjLiU3lKUJu/LaqBbvO7sR/z4e/7
 tFG0qIq6NF6jLlXIFLuPkrfaZB+8/6rx+W4CxoGp+Ho7abTkJt/MWNCSKwGE0IQdeTak1NUh9dz
 T7+GeqlEzM4fuJDMgh0Sm0ze0nAVEazMNy84Idw+oNis/CvPTqYQsqtw0b6NCA6cBVCRm7Z1f9x
 4bkJCJ77gwcy23HcSeqvtPt8m7dyXCP+eBhlGqX4YDKNoeRr4B50nTIJ++WCwNaqLit5KFcvrb3
 wG3UeAxODCc4x3IvsLiFgFL+aCCgqF+3B08qZK7ub95Os5bEtesDB/jkBYmNrFCTDxEQXDFaVoh
 7bL217lHIBHc/SSIAoPRAIgSlfJMS5Amh38/oYvM9ARggsPRYlp0It+R7u6gK4a8H1XpatIqQdc
 LyVT4Uur9MQI8o=
X-Received: by 2002:a17:907:d11:b0:c24:e1e9:69c with SMTP id
 a640c23a62f3a-c260c3f93a7mr886509866b.0.1788776891620; 
 Mon, 07 Sep 2026 03:28:11 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d53c37csm439345766b.32.2026.09.07.03.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 03:28:11 -0700 (PDT)
Message-ID: <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
Date: Mon, 7 Sep 2026 11:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
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
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 07/09/2026 10:42, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 10:15 +0100, Tvrtko Ursulin wrote:
>>
>>
>> On 04/09/2026 20:06, Philipp Stanner wrote:
>>
>> 8><
>>
>>> If you can think of a stupid and simple solution, shoot. The only thing
>>> I can think of is moving the string into the dma_fence, as a hard copy
>>> :)
>>>
>>>
>>> In the mean time, my proposal is to keep aiming for removing
>>> sched_fence->ops->release and fixing pvr and amdgpu.
>>
>> Fixing the drivers sounds like an obvious thing to try indeed. Along the
>> same lines as it was done for xe and panthor. It is an already
>> established and well understood approach so shouldn't be controversial.
>> After that we can discuss in leisurely pace if something better is
>> possible in the scheduler core.
>>
>> I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is
>> it significantly more complicated than it was for panthor and xe?
> 
> How did the others fix that?

Combination of kfree_rcu, synchronize_rcu and storing the name in an 
object protected by those:

6bd90e700b42 ("drm/xe: Make dma-fences compliant with the safe access 
rules")
299bc6d50b1b ("drm/xe/guc: Keep scheduler timeline name alive")
efe24898485c ("drm/panthor: fix for dma-fence safe access rules")

Not too complicated on the overall. Simply ensure RCU grace period 
between signaling the hw fence and freeing the ops, scheduler, name, all 
that it is in the externally accessible dereference chain.

> If we look at nouveau:
> 
> static void
> nouveau_sched_fini(struct nouveau_sched *sched)
> {
>   struct drm_gpu_scheduler *drm_sched = &sched->base;
>   struct drm_sched_entity *entity = &sched->entity;
> 
>   wait_event(sched->job.wq, nouveau_sched_job_list_empty(sched));
> 
>   drm_sched_entity_fini(entity);
>   drm_sched_fini(drm_sched);
> 
>   /* Destroy workqueue after scheduler tear down, otherwise it might still
>   * be in use.
>   */
>   if (sched->wq)
>   destroy_workqueue(sched->wq);
> }
> 
> 
> We see that it
>     1. stops accepting jobs from userspace (not visible here)
>     2. waits until all hardware fences in this ring are signaled
>     3. only then tears down drm_sched

I cannot do a very deep dive into nouveau at the moment. I see fence 
itself is already freed with kfree_rcu so that's good. What is reachable 
via the timeline name callback:

	struct nouveau_fence *fence = to_nouveau_fence(f);
	struct nouveau_fence_chan *fctx = nouveau_fctx(fence);

	return !fctx->dead ? fctx->name : "dead channel";

Fence is presumably the fence so channel. Chagning to kfree_rcu in 
nouveau_fence_context_put() there might be enough for that one.

For the scheduler (nouveau_sched_destroy()) the same, kfree_rcu.

That makes scheduler timeline name vfunc safe:

static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
{
	struct drm_sched_fence *fence = to_drm_sched_fence(f);
	return (const char *)fence->sched->name;

sched is then RCU protected. sched->name is already static so not a concern.

As you say nouveau_sched_fini() only tears down the scheduler after 
fences have been signaled it seems adding two new kfree_rcu make is safe.

Regards,

Tvrtko

