Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1A9F459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAB110E0BB;
	Fri, 10 Apr 2026 15:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hWMWG3or";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD1E10E04F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mYNwM0J3f8E8VOY/oeiqgSWmb0DW6P+uM/hk330XqIM=; b=hWMWG3ors1UZ5eKQ2/SIpSFxVk
 h0uUCBaSDzzQzlQjYOKq6EW7yt8MVoU3or7rM9rHpTx63mte8larmy16ePf5MfGfiKfGbSUdAvqvf
 oBT6gT1O+Dw6CcrVCoWMNUykgiFdWop1gDUx9A4Z7mUN0bKBzixAequt6ebQhi97fnDtLgphQ2Ncq
 f0D4ymdRegDFnsAuJwFRUnIAh9IkrouxQGk+HX9HYZwW/avGC8bRIV31SQwBbtDD0tpU6MbpHDNIb
 ULJyH43alSLhZkRThMbOgPPuTt7eAxyXZ4tU2ewbpA0+P2EhtUChx1uXS8bY3ZPVk4GKRBynOVj9d
 R4o5XFDg==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wBDvN-00ESAa-QW; Fri, 10 Apr 2026 17:37:37 +0200
Message-ID: <601a78ea-74e7-4b20-afeb-d822a362484a@igalia.com>
Date: Fri, 10 Apr 2026 16:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
 <20260331094944.772833c0@fedora>
 <918805b0-2cb9-454a-9048-84cc5bfc8798@igalia.com>
 <2fae926b-a25b-42bc-ab63-caf36505b33d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <2fae926b-a25b-42bc-ab63-caf36505b33d@amd.com>
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


On 10/04/2026 09:58, Christian König wrote:
> On 4/9/26 15:58, Tvrtko Ursulin wrote:
>>
>> On 31/03/2026 08:49, Boris Brezillon wrote:
>>> On Mon, 30 Mar 2026 14:36:23 +0100
>>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>>
>>>> Move the signalling tracepoint to before fence->ops are reset otherwise
>>>> tracepoint will dereference a null pointer.
>>>
>>> I suspect other trace points are impacted too
>>> (trace_dma_fence_destroy() is, at the very least).
>>
>> Indeed. I wonder why that did not trigger for me, while the one I fix here was an insta-crash...
> 
> You need to actually enable the trace points and at least for the destroy one nobody is usually interested in that.

Right, but I was pretty sure I was enabling perf record -e 'dma_fence:*' 
when I hit this. Anyway, it doesn't matter, I could be misremembering.

>>
>> To fix trace_dma_fence_destroy I think we need a new tracepoint definition ie. move it away from the existing event class - make it just log the context and seqno.
>>
>> Anyone has a better idea?
> 
> The idea of tracing without accessing fence->ops sounds valid to me.
> 
> Alternatively we could call dma_fence_timeline_name() and dma_fence_driver_name() from the tracepoint as well, but that means the tracepoints now require a RCU read side lock.

We could possibly use the helpers. I am not sure if RCU annotation would 
have to be casted away to keep sparse happy, but more importantly, I 
think it would not be safe.

   thread A					thread B

   dma_fence_signal_timestamp_locked		dma_fence_timeline_name
     ..						ops = rcu_dereference(fence->ops);
						if (!dma_fence_test_signaled_flag(fence))
     test_and_set_bit
     ..
     RCU_INIT_POINTER(fence->ops, NULL);
     						return (const char __rcu *)ops->get_driver_name(fence); // OOPS!

Apologies for long line length, it did not fit otherwise.

Looks like we missed this. Or it is me who is missing something?
Regards,

Tvrtko

>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>>>> Cc: linux-media@vger.kernel.org
>>>> Cc: linaro-mm-sig@lists.linaro.org
>>>> ---
>>>>    drivers/dma-buf/dma-fence.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>>> index 1826ba73094c..1c1eaecaf1b0 100644
>>>> --- a/drivers/dma-buf/dma-fence.c
>>>> +++ b/drivers/dma-buf/dma-fence.c
>>>> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>>                          &fence->flags)))
>>>>            return;
>>>>    +    trace_dma_fence_signaled(fence);
>>>> +
>>>>        /*
>>>>         * When neither a release nor a wait operation is specified set the ops
>>>>         * pointer to NULL to allow the fence structure to become independent
>>>> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>>>          fence->timestamp = timestamp;
>>>>        set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>>>> -    trace_dma_fence_signaled(fence);
>>>>          list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>>>>            INIT_LIST_HEAD(&cur->node);
>>>
>>
> 

