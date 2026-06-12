Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC7CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FCF10F5DF;
	Fri, 12 Jun 2026 17:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SxMRnvNI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8916E10F5DF;
 Fri, 12 Jun 2026 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YUUTaHVRoPtS1HtgR3Iw4hFLtlpzPkDp4HslgQlS3ng=; b=SxMRnvNI921FmkddfLNMjHNeAm
 6ReigP5W2YwGQo+yXPGE1gNon8BB8a1KGm/MjeRQPcYfXF+uP0bT1jOGKKmX7AKnTpDzxy/q6gO0s
 C22dvKPQaWLaD4wtFzQPliezHutSd6K+nS7BuovPtjg4bNxQS5oTMDS2FkYt53g88KxZso/8/L/0Q
 Q2hLFucX4qlVMIOHnb0pF0nIz9TuI7A4d+5czlID5GV/hH92lLN064PintaFAgzur2LuJgy0XtSqt
 xjdIKFj8I6SzPac7bpQsmK3e6G2RVL3ZXdCMNp4dP1QSWadmfR2TVZvHmTclH/RIepLUsVBxKFePn
 yF4IuN4A==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wY5Wu-00Ghg9-NS; Fri, 12 Jun 2026 19:18:52 +0200
Message-ID: <e6e016bc-cddf-43f4-830d-cf047183a9bf@igalia.com>
Date: Fri, 12 Jun 2026 18:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Simplify nouveau_cli_work
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <6f929f2e1c55f7945b41593eea44f28d3b93abf7.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6f929f2e1c55f7945b41593eea44f28d3b93abf7.camel@mailbox.org>
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


On 12/06/2026 18:14, Philipp Stanner wrote:
> On Fri, 2026-06-12 at 17:54 +0100, Tvrtko Ursulin wrote:
>> I don't claim this fixes anything but the code certainly was a bit
>> roundabout and this at least cleans it up.
>>
>> The only semantic difference is releasing the fence reference after
>> the work callback is called. Which kind of make sense anyway.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: nouveau@lists.freedesktop.org
>> ---
>>   drivers/gpu/drm/nouveau/nouveau_drm.c | 19 ++-----------------
>>   1 file changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> index 42a81166f3a9..7de174537fc7 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
>> @@ -153,22 +153,6 @@ nouveau_name(struct drm_device *dev)
>>   		return nouveau_platform_name(to_platform_device(dev->dev));
>>   }
>>   
>> -static inline bool
>> -nouveau_cli_work_ready(struct dma_fence *fence)
>> -{
>> -	unsigned long flags;
>> -	bool ret = true;
>> -
>> -	dma_fence_lock_irqsave(fence, flags);
>> -	if (!dma_fence_is_signaled_locked(fence))
>> -		ret = false;
>> -	dma_fence_unlock_irqrestore(fence, flags);
>> -
>> -	if (ret == true)
>> -		dma_fence_put(fence);
>> -	return ret;
>> -}
>> -
>>   static void
>>   nouveau_cli_work(struct work_struct *w)
>>   {
>> @@ -176,9 +160,10 @@ nouveau_cli_work(struct work_struct *w)
>>   	struct nouveau_cli_work *work, *wtmp;
>>   	mutex_lock(&cli->lock);
>>   	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
>> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
>> +		if (!work->fence || dma_fence_is_signaled(work->fence)) {
>>   			list_del(&work->head);
>>   			work->func(work);
>> +			dma_fence_put(work->fence);
> 
> Dave had addressed a UAF with that patch.
> 
> So if this would fix it, then the claim would be that work->func(work)
> was the user of that fence, and not some other party elsewhere.
> 
> I don't know whether that's the case.

Me neither. I say in the commit I don't claim to fix anything. But it is 
more logical and avoids the silly games with ret and all.

What I missed though is that work->func(work) frees the work.

So patch needs to cache the fence... v2 incoming..

Regards,

Tvrtko

> 
> 
> P.
> 
>>   		}
>>   	}
>>   	mutex_unlock(&cli->lock);

