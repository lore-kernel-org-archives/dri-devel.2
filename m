Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50896EA3C59
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33E410E80B;
	Thu,  9 Apr 2026 13:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MSFlSKBh";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550D910E7F9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQyv2LnxUKMjBM+EOj064AVlbTpkbGhSbXBnBwtzWn0=; b=MSFlSKBh67kJ1UZ+jodufZmqM6
 ZRnMe7w4LtvMYi0/X4UYlmxBF11TKCKCpLGEdAw8azbovuId5HdABuuSoEEZ2sM2h4fCDKLwv3Ua0
 wClCrzN3+rQU1YwFUANnIu5Bk6qReZOvEvEKQ0xwx0iL0D4puHQgc4NQAByIOtLpIrCMdynQgcLru
 Kqtj0O4uaNEUG0Sf1fDtgFMyV8RviToihKGvmgDws89WpB5Rn8qYoJrxEHKWCWVFffq1Z/kTVtqL1
 kP10+umJ/hdDdIr9SQOrHKWs7JVHGLf05OMuWbxqZVovZuFPukMFxJJImIuwlu7OGivIN8mUWoldo
 YC+lFOng==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wApuB-00Dxtg-Um; Thu, 09 Apr 2026 15:58:47 +0200
Message-ID: <918805b0-2cb9-454a-9048-84cc5bfc8798@igalia.com>
Date: Thu, 9 Apr 2026 14:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Move signalling tracepoint to before ops detach
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260330133623.17704-1-tvrtko.ursulin@igalia.com>
 <20260331094944.772833c0@fedora>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260331094944.772833c0@fedora>
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


On 31/03/2026 08:49, Boris Brezillon wrote:
> On Mon, 30 Mar 2026 14:36:23 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> Move the signalling tracepoint to before fence->ops are reset otherwise
>> tracepoint will dereference a null pointer.
> 
> I suspect other trace points are impacted too
> (trace_dma_fence_destroy() is, at the very least).

Indeed. I wonder why that did not trigger for me, while the one I fix 
here was an insta-crash...

To fix trace_dma_fence_destroy I think we need a new tracepoint 
definition ie. move it away from the existing event class - make it just 
log the context and seqno.

Anyone has a better idea?

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: linux-media@vger.kernel.org
>> Cc: linaro-mm-sig@lists.linaro.org
>> ---
>>   drivers/dma-buf/dma-fence.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index 1826ba73094c..1c1eaecaf1b0 100644
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
> 

