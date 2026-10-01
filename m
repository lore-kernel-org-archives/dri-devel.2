Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E8ACA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD76110E30D;
	Thu,  1 Oct 2026 09:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gJ1qlBvE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC4410E30D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=KAS9nccWQxy7wzoQ15glvxQifDTF+AyI7CQ7dcp9lhk=; b=gJ1qlBvEzACCa6Mdid844+KLcI
 fbNS6zt1QsyDfxRXycWA7N6VqIMZRSh+K81gKN1eoYwrSFwLI5ktpTXLlOPl/kT670yvhWovaSAZl
 bQvKPqOUJYzVTSjWqYMF/+xVe8RONhygONMkID81A7L44BRyBfk2Pb1AW8jKTzEfHaZH38pJXOmVd
 1DtjhjbnZdmfbu4TUt4j2r0gzs7XeEc/0TPvBeVxJCM7f286Xv72LghyelI4dozyWWbdTVYyUIQj1
 904MRMxQhYLnw01U2YZjmxRObfhlhJINepQsRVJaZgyZ2U/h8cM38iCu7BGBv07pbDHWeJfhktIZr
 icKv2n2g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCCzj-009p35-O7; Thu, 01 Oct 2026 11:22:27 +0200
Message-ID: <04153ee4-0d2a-4499-849d-e3a5ec87e863@igalia.com>
Date: Thu, 1 Oct 2026 10:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 2/3] workqueue: Add support for real-time workers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
 <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
 <3ff40909da4f1510419ac0e2f9f4e6a1@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <3ff40909da4f1510419ac0e2f9f4e6a1@kernel.org>
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


On 29/09/2026 01:00, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 23, 2026 at 05:12:50PM +0100, Tvrtko Ursulin wrote:
>> For use cases such as the DRM scheduler submitting work to the GPU on
>> behalf of low latency userspace applications, where latter have sufficient
>> privileges to have had successfully obtained realtime Vulkan global
>> priority, competing with random background CPU load can create large
>> latency spikes which gets in the way of a smooth user experience.
> 
> panthor's group_priority_permit() also allows realtime groups for DRM
> master without CAP_SYS_NICE. What's the usage model there? Should DRM
> master be enough to get RT workers?

Usage model is one active compositor per device with the logind 
orchestrating on switch. So I'd say yes, it makes sense to allow the 
compositor RT. I shall improve the commit text to mention this.

>> @@ -374,8 +374,9 @@ enum wq_flags {
>>   	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
>>   	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
>>   	WQ_HIGHPRI		= 1 << 4, /* high priority */
>> -	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
>> -	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
>> +	WQ_RTPRI		= 1 << 5, /* real-time priority, valid only with WQ_UNBOUND */
>> +	WQ_CPU_INTENSIVE	= 1 << 6, /* cpu intensive workqueue */
>> +	WQ_SYSFS		= 1 << 7, /* visible in sysfs, see workqueue_sysfs_register() */
> 
> Can we name it just WQ_RT? Also, I think WQ_RT is closer to WQ_BH. We can
> reorder the flags later if that helps but for now can you just put it in an
> empty slot?

Sure, I thought it makes sense to group the related features together 
but if you prefer a smaller diff I will do that.

> 
>> @@ -127,6 +127,7 @@ enum wq_internal_consts {
>>   	 */
>>   	RESCUER_NICE_LEVEL	= MIN_NICE,
>>   	HIGHPRI_NICE_LEVEL	= MIN_NICE,
>> +	RTPRI_NICE_LEVEL	= MIN_NICE - 1,
> 
> Can we match the scheduler's representation instead by replacing
> attrs->nice with attrs->prio which uses the same encoding as p->prio?
> Normal pools would be NICE_TO_PRIO(nice) and WQ_RT pools would be in the RT
> range. create_worker() would then do:
> 
> 	if (rt_prio(pool->attrs->prio))
> 		sched_set_fifo_low(worker->task);
> 	else
> 		set_user_nice(worker->task, PRIO_TO_NICE(pool->attrs->prio));

Ack.

>> @@ -7606,7 +7626,10 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
>>   	int written;
>>
>>   	mutex_lock(&wq->mutex);
>> -	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
>> +	if (wq->attrs->nice == RTPRI_NICE_LEVEL)
>> +		written = scnprintf(buf, PAGE_SIZE, "rt\n");
>> +	else
>> +		written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
> 
> Can you also show rt in pr_cont_pool_info() and tools/workqueue/wq_dump.py?
> 
> Thanks.

Of course, I wasn't aware of that tool. Do you prefer in the same patch 
or separate?

Regards,

Tvrtko

