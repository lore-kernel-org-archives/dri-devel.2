Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921C6CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E6210F3AA;
	Thu, 18 Jun 2026 18:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d8gUgG2V";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F35610F3AA
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLhabi92uESEf5CbIvCLvsknhXB/GOnAq3LQWEaLDYo=; b=d8gUgG2V7AXxtEPsjukDFsErlu
 ut4scQRKTbLBrqCV4UHQyt8dFGInJ8sQ0DiGmEd7VR7p3OqQuT2ZVLD/1LSUQdfw7hPyr5LWZYX3n
 8c9i6hsOZC1BGfQU7NcVUAW/2/m5fwggli4+ABsmd+hsB/o9ClaXG9GC0qwWqo6oDpZEjHzuAWfC+
 tTOe1cMRIz1qL0EDf2RSQQzW9NXef3V26Qfd6MK698xsHBPcKB4jP2sTobJUt+GvLAd+XfY3BxQta
 8NsM6/OrXw3TC8sgBTDpvQJZGGZQp1Pq+dPCjnivljRWXdNRxdXfynF0PONB9uVpcFq/Dt/kTZqgJ
 WN8vciRA==;
Received: from [37.209.163.134] (helo=[172.16.30.123])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1waHVb-00230t-8X; Thu, 18 Jun 2026 20:30:35 +0200
Message-ID: <27f54324-94ac-4bbc-ba58-642a314197d7@igalia.com>
Date: Thu, 18 Jun 2026 20:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: use correct callback in
 dma_fence_timeline_name()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 kernel-team@android.com
References: <20260618-linux-drm_crtc_fix-v1-1-801f29c9853d@linaro.org>
 <099959fa-3a41-4166-8c10-4e5c2b9fdf19@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@igalia.com>
In-Reply-To: <099959fa-3a41-4166-8c10-4e5c2b9fdf19@amd.com>
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


On 18/06/2026 14:46, Christian König wrote:
> On 6/18/26 14:00, André Draszik wrote:
>> dma_fence_timeline_name() is a wrapper around
>> dma_fence_ops::get_timeline_name(). Since the blamed commit below, it
>> calls an incorrect callback.
>>
>> Update it to restore functionality by calling the intended callback.
>>
>> Fixes: 62918542b7bf ("dma-fence: Fix sparse warnings due __rcu annotations")
>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> I'm like 99% sure we had that already fixed weeks ago, but somehow it looks like that was never merged to drm-misc-fixes.
>
> Anyway Reviewed-by: Christian König <christian.koenig@amd.com>

I was also perplexed and took me some digging to realise what had happened.

The copy-and-paste bug was indeed originally fixed in:

commit 033559473dd3b55558b535aa37b8848c207b5cbb
Author:     Akash Goel <akash.goel@arm.com>
AuthorDate: Tue Oct 21 17:09:51 2025 +0100
Commit:     Tvrtko Ursulin <tursulin@ursulin.net>
CommitDate: Fri Oct 24 16:56:37 2025 +0100

     dma-fence: Fix safe access wrapper to call timeline name method


But waaay before that I sent a fix for something else which touched 
those lines not noticing the copy-and-paste, fixing a different issue. 
That one however was not merged until earlier this year:

commit 62918542b7bf08860a60ebbde7654486e0ac0776
Author:     Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
AuthorDate: Mon Jun 16 16:59:52 2025 +0100
Commit:     Christian König <christian.koenig@amd.com>
CommitDate: Mon Feb 9 14:05:20 2026 +0100

     dma-fence: Fix sparse warnings due __rcu annotations

Notice the authored vs commited dates.

I guess it was a silent conflict which overwrote the earlier fix and 
restore the copy-and-paste bug.

Regards,

Tvrtko

>
>> ---
>>   drivers/dma-buf/dma-fence.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index b3bfa6943a8e..5292d714419b 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -1202,7 +1202,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>>          /* RCU protection is required for safe access to returned string */
>>          ops = rcu_dereference(fence->ops);
>>          if (!dma_fence_test_signaled_flag(fence))
>> -               return (const char __rcu *)ops->get_driver_name(fence);
>> +               return (const char __rcu *)ops->get_timeline_name(fence);
>>          else
>>                  return (const char __rcu *)"signaled-timeline";
>>   }
>>
>> ---
>> base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
>> change-id: 20260618-linux-drm_crtc_fix-267655a1c89f
>>
>> Best regards,
>> --
>> André Draszik <andre.draszik@linaro.org>
>>

