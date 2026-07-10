Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6F2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6AC10E19F;
	Fri, 10 Jul 2026 12:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eoeTQzMS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AF810E19F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MWupdjszmJLGgx26nL+2J7v9U0vJg4WByP8f9XeGLZc=; b=eoeTQzMSGww7nTw5d4gwmDPnmk
 5IjEotTThP5oC8PykbQqjyUK9lsN4LnMXBuaNNi/VcCsYt8Dt1ImhaE0puvq0QIwAcgrYXjR6Boy5
 0ma3nux/KxG2xmd89z5+lQo6w8SpmZ6CDl3kNxaVDnM51cJeyqoQ/XyfhowVRtU1eOVJIWCPxr1m+
 RHTR+KmCImKXZ1QaTW7jN+Rw4/34G1Mui4KqGXFq4r0drZw1fAjQDVZvBBTPb/Mga/RTpObcjH6X6
 1V5+lB+9kbn9d9GBEVWZL1fUR/IakVwGBCn1vvYbwSPgxpS6ior7zMuCkBLu1i/x4fN6mLp7qrNoq
 1yrk7RcQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wiAM4-00Cg7n-DJ; Fri, 10 Jul 2026 14:29:20 +0200
Message-ID: <250bfc53-e91b-4c48-9401-bbe636d3400b@igalia.com>
Date: Fri, 10 Jul 2026 13:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: Tejun Heo <tj@kernel.org>
Cc: phasta@kernel.org, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <4eb23476ff56bee108578adfe131be38e8fc1476.camel@mailbox.org>
 <b76ea01c-ead3-4eaf-86a7-5bf91bfdb9cb@igalia.com>
 <akwD28ihbzn1FB-P@slm.duckdns.org>
 <fe9c5564-9a56-429d-a991-9b77f8a97d5b@igalia.com>
 <19f0c3fe-7395-492f-b016-7a7a507da4f6@igalia.com>
Content-Language: en-GB
In-Reply-To: <19f0c3fe-7395-492f-b016-7a7a507da4f6@igalia.com>
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


On 09/07/2026 09:28, Tvrtko Ursulin wrote:
> 
> On 08/07/2026 17:24, Tvrtko Ursulin wrote:
> 
> 8<>
> 
>>> How big a hit is WQ_HIGHPRI vs. RT?
>>
>> I can measure that tomorrow or so. But so far I am not very optimistic 
>> about MIN_NICE ability to make a difference.
>>
>> Today I repeated the benchmarking Chia-I did originally, with the 
>> tweak of background load threads always being of normal priority and 
>> only varying the userspace Vulkan submit thread between normal, nice 
>> -1 and FIFO. Those three against three kernels - stock, this RFC 
>> capped to never go above MIN_NICE for the kthread_worker, and this RFC 
>> as is (so kthread_worker temporarily follows userspace FIFO).
>>
>> The results are that only following to FIFO brings interesting gains.
>>
>>          STOCK           --RFC         Full RFC
>>       .    N   RT    .     N    RT    .     N  RT
>>     M    28   32      35   36    26    23   19    19  17
>>   95%   211  537      69  276   186   426  151   284  30
>>   98%   843  993     804  942  1277  1842  982  1028  34
>>
>>       STOCK = 7.1.0
>>       --RFC = This RFC, but kthread_worker capped and MIN_NICE
>>    Full RFC = RFC as is, kthread_worker goes up to FIFO
>>
>>   M = Median
>>
>>    . = Userspace submit thread SCHED_OTHER
>>    N = -||= nice -1
>>   RT = -||- FIFO 1
>>
>> All numbers are latencies between job passed to DRM scheduler to DRM 
>> scheduler passing it to the GPU. In micro seconds.
>>
>> I'll report back with WQ_HIGHPRI results as soon as possible.
> 
> I made panthor set WQ_HIGHPRI on stock 7.1 and tested normal, nice and 
> FIFO vulkan submit thread. As expected I do not see a clear improvement:
> 
>          .    N    RT
>     M   27   28    32
>   95%  163  246   809
>   98%  924  991  1882
> 
> This makes it seem that the 95-th percentile is perhaps better for 
> normal and re-niced userspace thread cases, but it may also be noise and 
> I would need to do many more and longer runs on each config to be sure. 
> 98-th percentile spikes are still there. Also, even if 95% would be a 
> real improvement they are still an order of magnitude above median so I 
> do not think it is worth spending much more time on benchmarking that 
> option.

To add another data point, today I did a quick WQ_RTPRI experiment.

That allows eliminating both the kthread_worker pool complications and 
priority inheritance from this series by allowing creation of SCHED_FIFO 
workqueues. It reduces the series to just two patches. One to add 
WQ_RTPRI and second to make panthor use it for realtime queues.

In the core code I capped max_active for those to num_online_cpus() / 2, 
although I am not sure Tejun if that is what you had in mind when you 
said it might be acceptable if the number of workers would be bound? I 
am also not sure if this will limit the system number or just for 
individual worker. If only the latter than further improvements will 
obviously be required.

On top of that, for the panthor use case we agreed that two threads is 
good enough so that is what the driver requests as the upper bound.

Overall flow is that when userspace requests 
VK_QUEUE_GLOBAL_PRIORITY_REALTIME (for which CAP_SYS_NICE is required 
btw), that queue goes to the DRM scheduler panthor created a WQ_RTPRI 
workqueue for. Lower priority Vulkan queues go to lower priority 
workqueues so there is no danger of normal priority clients over-using 
the RT queues.

Submit latency wise this is still completely effective. Median latency 
is 14us and 95 and 98-th percentiles are 23us and 25us respectively.

So the question is whether something like this is acceptable to 
workqueue core? If so, I can send it as a proper RFC and go from there.

Regards,

Tvrtko

P.S.
My WIP branch implementing this:
https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=wqrt-panthor

