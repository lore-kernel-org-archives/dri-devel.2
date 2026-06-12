Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C3CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE4A10F5E0;
	Fri, 12 Jun 2026 17:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MRPN57Xw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7917A10F5E0;
 Fri, 12 Jun 2026 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EC9PNED+qzKYvQ6SG2+BThbNalrGmHsztVrJ0GJAMt8=; b=MRPN57XwN0B09UE7Rg8SarsHLX
 XVF/C9kj2VrNtXZt9u18fkip9c94xz5G+ufhXdplczMe3vC8wUC+9jDj1kYF5bf2MRXG/DpDPVMvg
 JTnusGdh6BwFLhhGueqyAgYG/c0r8E6jr6meBt9MRvaKLZ2XQw638IMDtDh/Bo7cuO12cm0Rgk5CL
 UhEQHlFgHmXg6+HsQHTGp9QvTXo1TzQSDw/mornAs3P/zAQWBqp3hmzAknwXir6zWMnKnqXX/izNJ
 M3n3eae7pFBRpLb6NnlQfHdoojApzjhe/rcdIE7skU3e0ehkTYr6Gze6CiYlS/KihRTx+UlKIEf1G
 McHj3d0Q==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wY5he-00GhxI-IO; Fri, 12 Jun 2026 19:29:58 +0200
Message-ID: <5893be40-3704-44cc-b7c8-9b51fb4c7a92@igalia.com>
Date: Fri, 12 Jun 2026 18:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Simplify nouveau_cli_work
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <6f929f2e1c55f7945b41593eea44f28d3b93abf7.camel@mailbox.org>
 <e6e016bc-cddf-43f4-830d-cf047183a9bf@igalia.com>
Content-Language: en-GB
In-Reply-To: <e6e016bc-cddf-43f4-830d-cf047183a9bf@igalia.com>
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


On 12/06/2026 18:18, Tvrtko Ursulin wrote:
> 
> On 12/06/2026 18:14, Philipp Stanner wrote:
>> On Fri, 2026-06-12 at 17:54 +0100, Tvrtko Ursulin wrote:
>>> I don't claim this fixes anything but the code certainly was a bit
>>> roundabout and this at least cleans it up.
>>>
>>> The only semantic difference is releasing the fence reference after
>>> the work callback is called. Which kind of make sense anyway.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Philipp Stanner <phasta@kernel.org>
>>> Cc: Lyude Paul <lyude@redhat.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: nouveau@lists.freedesktop.org
>>> ---
>>>   drivers/gpu/drm/nouveau/nouveau_drm.c | 19 ++-----------------
>>>   1 file changed, 2 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/ 
>>> nouveau/nouveau_drm.c
>>> index 42a81166f3a9..7de174537fc7 100644
>>> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
>>> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
>>> @@ -153,22 +153,6 @@ nouveau_name(struct drm_device *dev)
>>>           return nouveau_platform_name(to_platform_device(dev->dev));
>>>   }
>>> -static inline bool
>>> -nouveau_cli_work_ready(struct dma_fence *fence)
>>> -{
>>> -    unsigned long flags;
>>> -    bool ret = true;
>>> -
>>> -    dma_fence_lock_irqsave(fence, flags);
>>> -    if (!dma_fence_is_signaled_locked(fence))
>>> -        ret = false;
>>> -    dma_fence_unlock_irqrestore(fence, flags);
>>> -
>>> -    if (ret == true)
>>> -        dma_fence_put(fence);
>>> -    return ret;
>>> -}
>>> -
>>>   static void
>>>   nouveau_cli_work(struct work_struct *w)
>>>   {
>>> @@ -176,9 +160,10 @@ nouveau_cli_work(struct work_struct *w)
>>>       struct nouveau_cli_work *work, *wtmp;
>>>       mutex_lock(&cli->lock);
>>>       list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
>>> -        if (!work->fence || nouveau_cli_work_ready(work->fence)) {
>>> +        if (!work->fence || dma_fence_is_signaled(work->fence)) {
>>>               list_del(&work->head);
>>>               work->func(work);
>>> +            dma_fence_put(work->fence);
>>
>> Dave had addressed a UAF with that patch.
>>
>> So if this would fix it, then the claim would be that work->func(work)
>> was the user of that fence, and not some other party elsewhere.
>>
>> I don't know whether that's the case.
> 
> Me neither. I say in the commit I don't claim to fix anything. But it is 
> more logical and avoids the silly games with ret and all.
> 
> What I missed though is that work->func(work) frees the work.
> 
> So patch needs to cache the fence... v2 incoming..

Ah sorry and I forgot the lock cycling hack we discussed.. ie. the whole 
point of the race. Nevermind then, confusing.

Regards,

Tvrtko

