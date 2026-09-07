Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6222CC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3330F10E00E;
	Mon,  7 Sep 2026 15:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a8eQ7oit";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7564F10E00E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=KnHe4i/m2Vvv2xQTwe4xjSIe48lVUKEdemumaiQoLrQ=; b=a8eQ7oitvlrLxQnCgxbfMW6U9O
 gVDUKTJPDH286V8t7rzIPNOuDe+7I1BQrOmfSCz4nwmtiZGVRqVjIHX+UVDVGymLhWW2U65B4KnB7
 tbpvb1wN2T4rPnsPOS/NnuMgLUakL4F4qGw2vJ5Irho1gZkk8pdKutMYpsjLby7Ph53Jdlcsa+HRk
 HdAnpBUeEooA+qkha1PZMi0mLR41jfTwwCsOl0awIyvi2pgobsmWS4c7fidYn5UXP5uKDYBvTq4ud
 0YC7vB+B00+TbNrwtuq/t0KFaHo8Y9DVX2/noc9NhCpdc5jrkiLtTVOlP0N75lNBr7QfHe2orIjn0
 bUUPsS2w==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x3aq0-00G5rW-SC; Mon, 07 Sep 2026 17:00:48 +0200
Message-ID: <8b0ea995-8299-4f68-9c06-2350a1d8fa2e@igalia.com>
Date: Mon, 7 Sep 2026 16:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 1/2] workqueue: Add support for real-time workers
To: Tejun Heo <tj@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Breno Leitao <leitao@debian.org>
References: <20260804101925.55414-1-tvrtko.ursulin@igalia.com>
 <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
 <aoILFR3SNYBbMOOz@slm.duckdns.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <aoILFR3SNYBbMOOz@slm.duckdns.org>
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


On 16/08/2026 20:10, Tejun Heo wrote:
> (cc'ing Breno as he has been working in the area)
> 
> Hello,
> 
> Sorry about the delay.

Same here so no worries, summer holidays.. :)

> On Tue, Aug 04, 2026 at 11:19:24AM +0100, Tvrtko Ursulin wrote:
>>   struct workqueue_attrs {
>>   	/**
>> -	 * @nice: nice level
>> +	 * @prio: priority level
>> +	 */
>> +	enum wq_priority prio;
>> +
>> +	/**
>> +	 * @nice: nice level for WQ_PRIO_HIGH
>>   	 */
>>   	int nice;
> 
> I find this rather confusing. We're scattering the same internal state
> across multiple fields. If you look at scheduler code, rt and normal nice
> values are encoded into a single prio value, maybe we can do the same?

I thought it was more elegant to split the policy from the priority 
within a policy for call sites which only look up the policy. I can 
change it to encode all in a single integer or something. Alternative 
will be to call some helpers here and there which answers the "is this a 
rt policy" based on a range checks. At which point it felt one word in 
the struct is nicer than conditionals across the code. Your call what 
you prefer.

>>   static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>>   {
>> -	bool highpri = wq->flags & WQ_HIGHPRI;
>> -	int cpu, ret;
>> +	int prio, cpu, ret;
>>   
>>   	lockdep_assert_held(&wq_pool_mutex);
>>   
>> +	if (wq->flags & WQ_RTPRI)
>> +		prio = WQ_PRIO_RT;
>> +	else if (wq->flags & WQ_HIGHPRI)
>> +		prio = WQ_PRIO_HIGH;
>> +	else
>> +		prio = WQ_PRIO_NORMAL;
>> +
>>   	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
>>   	if (!wq->cpu_pwq)
>>   		goto enomem;
>> @@ -5622,7 +5637,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>>   			struct pool_workqueue **pwq_p;
>>   			struct worker_pool *pool;
>>   
>> -			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
>> +			pool = &(per_cpu_ptr(pools, cpu)[prio]);
> 
> And this looks a bit confusing too because there's no per-cpu counterpart
> but it looks like there should be.

I did not quite manage to follow you here. Was this not the per cpu 
part, with unbound and ordered down lower? You have to excuse me I am 
new in this code.

> I wonder whether this would look better after the percpu and unbound pool
> unification that Breno is working on.

I suppose this landed by now? I can see some changes so once we clarify 
the above opens I will rebase and adjust.

Regards,

Tvrtko

