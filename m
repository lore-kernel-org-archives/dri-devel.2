Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D648C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37D910E34E;
	Mon,  6 Jul 2026 12:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AMWE4v6L";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81A510E34E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yv+3Se6Ry52Y90BPie/lrSR5SXEj2DMLidHFu1iA6SY=; b=AMWE4v6LuwrSZKR0VIESNXOn/1
 ovNxodnPFillU9Js4NmaqeAWnjpJBHyats8F1mjCBsRaN2MeQQDBBv0Kj1NQZr6h0Yn+gSdxN9DWf
 lru3IH98UWApmOuOTcfK5vuCHACoGECvz4ORc7z7OmrAAV2YWcdDxEm8FIIV5FCPtoiiQXtCAXxP3
 S0ElbNKBGP42Rl7ytv0rpg8fUIsRsKhWCurO5bsMl3QhImAWEn46F0av+/btDkHnjRIJkL+nDDE3I
 PTFyqAWPMyQMTFdau5wqz1ifKf05dUgx8ijJfIHnht/WdtboRfRtpA267ajmGoxf+kpz6csV/IP+Q
 +4eb2RQw==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgiQN-009jN3-Iv; Mon, 06 Jul 2026 14:27:47 +0200
Message-ID: <e15d223d-21d8-42f1-a37b-52f515d1e86f@igalia.com>
Date: Mon, 6 Jul 2026 13:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/8] drm/xe: Convert to per gt scheduler workers
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
 <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
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



On 03/07/2026 10:06, Matthew Brost wrote:
> On Thu, Jul 02, 2026 at 03:37:41PM +0100, Tvrtko Ursulin wrote:
>> As the submission side of xe is serialized by the global GuC CT lock, we
>> can easily afford to create our own per gt work queues. Whereas before
>> kernel could create up to the number of CPUs threads, we now create one
>> per GT.
>>
> 
> This breaks down for any execution queue that waits in a scheduler work
> item for any reason. Long-running preemption queues do this for
> time-slicing, multi-queue registration, and possibly a few other cases.
> 
> I've looked at this before and rough divide is this works for 3D but not
> long running.

Hmmm curious. Could you expand a bit more on this?

Where do those wait, in run job or prepare job? And on what ie. where is 
the cross-dependency?

Is it related to the alien work items xe "injects" onto the scheduler 
workers?

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_gt.c         |  7 +++++++
>>   drivers/gpu/drm/xe/xe_gt_types.h   |  3 +++
>>   drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++----
>>   3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
>> index 783eb6d631b5..fb2db9eff341 100644
>> --- a/drivers/gpu/drm/xe/xe_gt.c
>> +++ b/drivers/gpu/drm/xe/xe_gt.c
>> @@ -706,6 +706,8 @@ static void xe_gt_fini(void *arg)
>>   	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
>>   		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
>>   
>> +	destroy_workqueue(gt->submit_wq);
>> +
>>   	xe_gt_disable_host_l2_vram(gt);
>>   }
>>   
>> @@ -716,6 +718,11 @@ int xe_gt_init(struct xe_gt *gt)
>>   
>>   	INIT_WORK(&gt->reset.worker, gt_reset_worker);
>>   
>> +	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
>> +						WQ_MEM_RECLAIM, gt->info.id);
>> +	if (IS_ERR(gt->submit_wq))
>> +		return PTR_ERR(gt->submit_wq);
>> +
>>   	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
>>   		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
>>   		xe_hw_fence_irq_init(&gt->fence_irq[i]);
>> diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
>> index e5588c88800a..175c42672546 100644
>> --- a/drivers/gpu/drm/xe/xe_gt_types.h
>> +++ b/drivers/gpu/drm/xe/xe_gt_types.h
>> @@ -248,6 +248,9 @@ struct xe_gt {
>>   	/** @exec_queue_ops: submission backend exec queue operations */
>>   	const struct xe_exec_queue_ops *exec_queue_ops;
>>   
>> +	/** @submit_wq: ... */
>> +	struct workqueue_struct *submit_wq;
>> +
>>   	/**
>>   	 * @ring_ops: ring operations for this hw engine (1 per engine class)
>>   	 */
>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>> index 9458bf477fa6..858f84dc8fed 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>> @@ -1928,11 +1928,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
>>   	struct xe_gpu_scheduler *sched;
>>   	struct xe_guc *guc = exec_queue_to_guc(q);
>>   	struct workqueue_struct *submit_wq = NULL;
>> +	struct xe_gt *gt = guc_to_gt(guc);
>>   	struct xe_guc_exec_queue *ge;
>>   	long timeout;
>>   	int err, i;
>>   
>> -	xe_gt_assert(guc_to_gt(guc), xe_device_uc_enabled(guc_to_xe(guc)));
>> +	xe_gt_assert(gt, xe_device_uc_enabled(guc_to_xe(guc)));
>>   
>>   	ge = kzalloc_obj(*ge);
>>   	if (!ge)
>> @@ -1964,12 +1965,14 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
>>   		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
>>   
>>   		submit_wq = primary->guc->sched.base.submit_wq;
>> +	} else {
>> +		submit_wq = gt->submit_wq;
>>   	}
>>   
>>   	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
>> -			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
>> -			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
>> -			    q->name, gt_to_xe(q->gt)->drm.dev);
>> +			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
>> +			    64, timeout, gt->ordered_wq, NULL, q->name,
>> +			    gt_to_xe(gt)->drm.dev);
>>   	if (err)
>>   		goto err_release_id;
>>   
>> -- 
>> 2.54.0
>>

