Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dCAeWmSC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2B710EFDC;
	Tue, 10 Nov 2026 11:41:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFB510F126
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794310902; x=1825846902;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=iM7IWakVCcIz8WMJVolWHC/3np93vJAPlCV71FNMb/w=;
 b=dCAeWmSCd0ng+r8cEGuJ8gV3iklFmnXrhwjE5QqJggvY/xY275IyuCcV
 xwT7cZyRSszgQxHoE1j3bXfEDGs1PHPhkl5WykcvwbkxM1P8JYAahXzzg
 R8lhYtp2w/ggYNsjhLkBOZYtylud7U90o2Er7XRH6bA9sjmSdOSkNzJ8p
 bvln4wchOiN0yKZCB/a2h/7J9kGQPG3FTLGJ2PbC1HcPeoIQ1Dx+9cc/E
 bADPc3GXh3k6zDcBF+45NY3govWORB6MW+qXVx3WQVHSW5fkpqF9Y5C0P
 g9lfxQEd7jeb5G3R3X2u5/Q0Cq+g1Zu5s8pDTCEJ5llUziQhQUtskn8GS A==;
X-CSE-ConnectionGUID: QMTR5aJDTiiHLKiDKjo7DA==
X-CSE-MsgGUID: FV3T0PlgQEWKxkeUfHzPPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3053407"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3053407"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 03:41:42 -0800
X-CSE-ConnectionGUID: j5tlAoxkRQy/q3wZA0e94g==
X-CSE-MsgGUID: ushUxuIbTTi204rlZvcNdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8281806"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 03:41:42 -0800
Message-ID: <413a803a-0978-467f-ace4-1121140418f6@linux.intel.com>
Date: Tue, 10 Nov 2026 12:41:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
 <sashiko-outbox-206716@kernel.org>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <sashiko-outbox-206716@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-Nov-26 10:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] accel/ivpu: race in ivpu_pm_enable() queues recovery_work
>    twice
> --
> 
> commit 53feec71cd6cb0035da92ea965a242f974fa21d7
> Author: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> accel/ivpu: Defer recovery until probe completes
> 
> This commit disables recovery_work in ivpu_pm_init() and re-enables and
> flushes it in ivpu_pm_enable() to prevent recovery from running during
> probe before device initialization finishes.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
>> index aa813262253e4..7aee728b19ef1 100644
>> --- a/drivers/accel/ivpu/ivpu_pm.c
>> +++ b/drivers/accel/ivpu/ivpu_pm.c
>> @@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>>   	atomic_set(&pm->engine_reset_counter, 0);
>>   
>>   	INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
>> +	disable_work(&pm->recovery_work);
>>   	INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
>>   
>>   	if (ivpu_disable_recovery)
>> @@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>>   {
>>   	struct device *dev = vdev->drm.dev;
>>   
>> +	enable_work(&vdev->pm->recovery_work);
>> +	if (atomic_read(&vdev->pm->reset_pending)) {
>> +		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
>> +		flush_work(&vdev->pm->recovery_work);
>> +	}
> 
> [Severity: Medium]
> Can ivpu_pm_enable() race with ivpu_pm_trigger_recovery() and queue
> recovery_work twice for a single fault?
> 
> In ivpu_pm_trigger_recovery(), reset_pending is set to 1 before
> ivpu_hw_diagnose_failure(), ivpu_hw_irq_disable(), and queue_work():
> 
> drivers/accel/ivpu/ivpu_pm.c:ivpu_pm_trigger_recovery() {
> 	...
> 	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
> 		ivpu_hw_diagnose_failure(vdev);
> 		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
> 		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
> 	}
> }
> 
> And reset_pending stays 1 until ivpu_pm_reset_complete() finishes, while
> the workqueue clears WORK_STRUCT_PENDING_BIT as soon as a worker dequeues
> recovery_work:
> 
> CPU0                              CPU1                        kworker
> ivpu_pm_trigger_recovery()
>    atomic_cmpxchg(reset_pending, 0, 1)
>    ivpu_hw_diagnose_failure()
>                                    ivpu_pm_enable()
>                                      enable_work(&recovery_work)
>                                      if (atomic_read(reset_pending))
>                                        queue_work(&recovery_work)
>                                        flush_work(&recovery_work)
>                                                                ivpu_pm_recovery_work()
>    ivpu_hw_irq_disable()
>    queue_work(&recovery_work)  <-- queued a second time
> 
> The same double queueing happens if ivpu_pm_trigger_recovery() runs right
> after enable_work() and a worker starts ivpu_pm_recovery_work() before
> ivpu_pm_enable() checks reset_pending.
> 
> In the first interleaving, ivpu_pm_recovery_work() runs concurrently with
> ivpu_hw_diagnose_failure() and ivpu_hw_irq_disable(), and flush_work()
> only waits for the first execution.  The second queued recovery_work then
> runs after flush_work() returns, performing a second full NPU reset
> concurrently with pm_runtime_allow() and pm_runtime_put_autosuspend() and
> reintroducing the race where recovery disables runtime PM during the
> initial autosuspend request.
> 

I'll send V3 that addresses recovery that leaves the device in D0.

Karol

