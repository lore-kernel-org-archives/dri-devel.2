Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE80C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D192910E619;
	Wed,  8 Jul 2026 16:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MKLaZ66b";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83D710E636
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yhxuCIdZZBgy5GcAdlQfOUzgWUhuLo/6GzlP6447TvI=; b=MKLaZ66be899V54XZKN109m5yF
 0IH9Xg9lLzl5/POKtP78F6sGP8ymFQ6HmBxvPIG3RtVy8u08l54wg2xRT+Gq4+VQhA7t4n/JzHsM5
 aU6ouIRYFxL9vVNIE4AStHpV0UeE97okwnTcva1MRGLxUp6YCZwVew715oqqlvwad0WM/8fbt8uSv
 NnmTjkTLa9tDEJo2fttRMoDFW5wWxdBZN5MIKLyDuL/s4Z4noHWx3dTlSch9XXE9J9Wv3EU5kUQwB
 5JEkstj7y2HFx+X7nHHDFMnmU9ovSLXAYrF6qGdYg+rQDcUUJNTBYG3GZM/1uZ1mvPzy0JjQN1cZo
 iqFTPq/w==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whV4G-00BoKi-1Q; Wed, 08 Jul 2026 18:24:12 +0200
Message-ID: <fe9c5564-9a56-429d-a991-9b77f8a97d5b@igalia.com>
Date: Wed, 8 Jul 2026 17:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
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
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <akwD28ihbzn1FB-P@slm.duckdns.org>
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


On 06/07/2026 20:36, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 06, 2026 at 01:20:49PM +0100, Tvrtko Ursulin wrote:
> ...
>>> So the first question I would like to see considered is whether
>>> workqueue could be improved in any way to address said latency issues.
>>>
>>> Have you already considered that, Tvrtko?
>>
>> Yes, priority inheritance was justifiably rejected for generic workqueues.
>> There is WQ_HIGHPRI, but the idea here is to go one step further and allow
>> tracking realtime scheduling policies.
> 
> If deciding at work item boundaries is granular enough, it's not
> unconscionable to support RT worker pools. The main reason for resisting
> that is because it can be too easy to abuse. A couple RT threads may solve
> immediate problems but with a bunch of them you just don't have a working
> scheduler in the system. In general, it's pretty suspicious if there's
> intersection of "I need a bunch of worker threads in a flexible way" and "I
> want RT".

In this case I think the key will be fleshing out with individual driver 
owners how many workers their hardware actually needs. Setting the upper 
bound to the number of userspace contexts, capped by the cmwq system 
limit, sounds over the top for many GPUs as there isn't really any point 
to feed a single GPU with that many CPU threads.

So far the feedback is I went too aggressive by reducing panthor to one 
submission worker per device and xe to between one to two. Lets see if 
there is a middle ground, and assuming there is, and that it is some 
relatively small-ish number relative to the number of CPU cores, maybe 
then we talk about can we have a RT worker pool of a limited size.

Or if drivers will insist they need cmwq managed bound for the number of 
threads then we may need to go to plan B and either split the scheduler 
for the two use cases, or write a new one for firmware drivers.

> How big a hit is WQ_HIGHPRI vs. RT?

I can measure that tomorrow or so. But so far I am not very optimistic 
about MIN_NICE ability to make a difference.

Today I repeated the benchmarking Chia-I did originally, with the tweak 
of background load threads always being of normal priority and only 
varying the userspace Vulkan submit thread between normal, nice -1 and 
FIFO. Those three against three kernels - stock, this RFC capped to 
never go above MIN_NICE for the kthread_worker, and this RFC as is (so 
kthread_worker temporarily follows userspace FIFO).

The results are that only following to FIFO brings interesting gains.

	    STOCK           --RFC         Full RFC
	 .    N   RT    .     N    RT    .     N  RT
    M    28   32	  35   36    26    23   19    19  17	
  95%   211  537	  69  276   186   426  151   284  30
  98%   843  993	 804  942  1277  1842  982  1028  34

      STOCK = 7.1.0
      --RFC = This RFC, but kthread_worker capped and MIN_NICE
   Full RFC = RFC as is, kthread_worker goes up to FIFO

  M = Median

   . = Userspace submit thread SCHED_OTHER
   N = -||= nice -1
  RT = -||- FIFO 1

All numbers are latencies between job passed to DRM scheduler to DRM 
scheduler passing it to the GPU. In micro seconds.

I'll report back with WQ_HIGHPRI results as soon as possible.

Regards,

Tvrtko

