Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99769F34C4D
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B86C10E0D5;
	Mon, 13 Apr 2026 12:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PJbnMBF/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC3410E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ag/JUOaFdk9sxg+FZ/AmkquyB95znwr7N44nZeGTJSk=; b=PJbnMBF/sXGtPXVyWelfbjUF4u
 X/J2OnzphWXfM8zuP2BR/k4o0/tKQLU8eMROPE5ikA7yL7Qby9FKmB/aXpb2jgjx2EgkxrgMe6E9o
 GQJ8ClwGMQmXgnL4GUYtNQJNimx0CxE7Oi2eUEPZyb9Z4q8rZT+hn3moVJvYy4Cex2uf4Vo4T103j
 wg1HP88D1MSNHCXxU6CWoZmPjkPuDKJrgv0VIhTvOe1H4GUEiJTmrYBZqe2WyIXHe+u8/rxgyNkRK
 7Hw4cbz4Pb71huHwX3LxxsTXNBMizyfd5kXxuHCiolooRFqxEi/5Xv/TkoT/L1qCXIhbJPd8y0OBN
 63S/bhZQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wCGMh-00FOjp-7M; Mon, 13 Apr 2026 14:26:07 +0200
Message-ID: <7efae858-c074-4027-93df-d6efaeba236e@igalia.com>
Date: Mon, 13 Apr 2026 13:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-fence: Fix potential tracepoint null pointer
 dereferences
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260413100526.15729-1-tvrtko.ursulin@igalia.com>
 <20260413100526.15729-2-tvrtko.ursulin@igalia.com>
 <db5342f2-c098-4b27-9522-8b1f78fdc43a@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <db5342f2-c098-4b27-9522-8b1f78fdc43a@amd.com>
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


On 13/04/2026 12:32, Christian König wrote:
> On 4/13/26 12:05, Tvrtko Ursulin wrote:
>> Trace_dma_fence_signaled, trace_dma_fence_wait_end and
>> trace_dma_fence_destroy can all dereference a null fence->ops pointer
>> after it has been reset on fence signalling.
>>
>> Lets use the safe string getters for most tracepoints to a void this.
>>
>> But for the signalling tracepoint, we move it to before the fence->ops
>> is reset and special case its definition in order to avoid losing the
>> driver and timeline information.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: linux-media@vger.kernel.org
>> Cc: linaro-mm-sig@lists.linaro.org
>> ---
>>   drivers/dma-buf/dma-fence.c      |  3 ++-
>>   include/trace/events/dma_fence.h | 29 +++++++++++++++++++++++++++--
>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index a2aa82f4eedd..b3bfa6943a8e 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -363,6 +363,8 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>   				      &fence->flags)))
>>   		return;
>>   
>> +	trace_dma_fence_signaled(fence);
>> +
>>   	/*
>>   	 * When neither a release nor a wait operation is specified set the ops
>>   	 * pointer to NULL to allow the fence structure to become independent
>> @@ -377,7 +379,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>>   
>>   	fence->timestamp = timestamp;
>>   	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>> -	trace_dma_fence_signaled(fence);
>>   
>>   	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
>>   		INIT_LIST_HEAD(&cur->node);
>> diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
>> index 3abba45c0601..220bf71446e8 100644
>> --- a/include/trace/events/dma_fence.h
>> +++ b/include/trace/events/dma_fence.h
>> @@ -9,12 +9,37 @@
>>   
>>   struct dma_fence;
>>   
>> +DECLARE_EVENT_CLASS(dma_fence,
>> +
>> +	TP_PROTO(struct dma_fence *fence),
>> +
>> +	TP_ARGS(fence),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(driver, dma_fence_driver_name(fence))
>> +		__string(timeline, dma_fence_timeline_name(fence))
> 
> 
> That requires that we hold the RCU read side lock while doing the trace.

True, and actually 3/3 needs to be squashed in 2/3 and then it is all 
fine. Then all tracepoints which use dma_fence_*_name() helpers are 
inside rcu_read_lock, and ones which do not use the dma_fence_ops class 
where they are guaranteed to be be safe.

> Not sure if that can be done inside the DECLARE_EVENT_CLASS() macro.

No idea.

>> +		__field(unsigned int, context)
>> +		__field(unsigned int, seqno)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(driver);
>> +		__assign_str(timeline);
>> +		__entry->context = fence->context;
>> +		__entry->seqno = fence->seqno;
>> +	),
>> +
>> +	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
>> +		  __get_str(driver), __get_str(timeline), __entry->context,
>> +		  __entry->seqno)
>> +);
>> +
>>   /*
>>    * Safe only for call sites which are guaranteed to not race with fence
>>    * signaling,holding the fence->lock and having checked for not signaled, or the
>>    * signaling path itself.
>>    */
>> -DECLARE_EVENT_CLASS(dma_fence,
>> +DECLARE_EVENT_CLASS(dma_fence_ops,
>>   
>>   	TP_PROTO(struct dma_fence *fence),
>>   
>> @@ -67,7 +92,7 @@ DEFINE_EVENT(dma_fence, dma_fence_enable_signal,
>>   	TP_ARGS(fence)
>>   );
>>   
>> -DEFINE_EVENT(dma_fence, dma_fence_signaled,
>> +DEFINE_EVENT(dma_fence_ops, dma_fence_signaled,
> 
> The signal trace event is actually unproblematic. The question is more what to do with the release event.

Yes, unproblematic after fixed in this patch, or you mean something else?

trace_dma_fence_destroy is fine after this patch AFAICS and I did test it.

Regards,

Tvrtko

>>   	TP_PROTO(struct dma_fence *fence),
>>   
> 

