Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1170C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021088953E;
	Mon,  6 Jul 2026 12:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jxa6k4Ys";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ECA9897D4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ybYwScqVWzmZjZIyud3bfDTcfHjIRhfVbjFroGryf0=; b=jxa6k4YsE433dznTkdLcXalRvs
 UXFjE1cjH0C29wxAxjXpS+dapkqBzMdzin2nzDEZjV5P2fsuOfnkvjsTlSzpo2Eu0GPsJndccc3mR
 TxTUSFHoid6rtiqS62B6wfTtpHxRI6bqJc78tNt5PEvUBKGzLjesqpxYJr+mmMKzEpmCJp9A/hfTM
 fxeXy5s8nhxYFdhDQ2Qcv7T7k0a0dMxcT0b3bokxmyiSYKNkL/oO1DExAk4QuJPW8FRVnrCSsteni
 wyYzDK7v05rhe2I161IFqWfxgxh2TVrAi1JI5D+D9agD3kZDgSzkQSzjd2ioXqXMJyCSoMy/ifj7c
 1qA6QzFA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wgidC-009jp4-PY; Mon, 06 Jul 2026 14:41:02 +0200
Message-ID: <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
Date: Mon, 6 Jul 2026 13:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
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


On 03/07/2026 10:22, Matthew Brost wrote:
> On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
>> The problem statement is explained quite well and succinctly at:
>> https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
>>
>> Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
>> high-priority DRM client gets latency injected into the GPU submission path due
>> to the DRM scheduler use of workqueues.
>>
>> This patch series proposes to replace the workqueues with kthread_work and
>> priority inheritance to solve this problem.
>>
>> In the above linked issue Chia-I benchmarked the submit latencies which
>> show a striking improvement:
>>
>> 		median	95%	99%
>>    before	41us	1.5ms	2.6ms
>>     after	15us	19us	24us
> 
> Can you give more information on these numbers? e.g., What you ran / how
> you measured these. It is hard to argue with numbers.

I believe Chia-I observed latency on some production hw/sw and then 
wrote a synthetic benchmark to test it more easily. Details are in the 
above linked issue.

>> This is obviously really good for preventing compositors from missing frames and
> 
> Modern compositors do not pass render-job fences to draw jobs as input
> dependencies. On Wayland, this functionality is provided by
> linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> later. SurfaceFlinger has also operated this way for quite some time.
> 
> The obvious solution for compositors is to submit work directly through
> the ioctl (i.e., bypass path in sched) when there are no input
> dependencies, which should be the common case. The main exception is
> when one of the BOs mapped into the compositor is migrating or otherwise
> busy (i.e., a BO has a fence in a kernel dma-resv slot).

You mean the direct submit RFC you floated some time ago? What was the 
verdict on that one, wasn't it rejected?

>> similar. Another good quote for the above issue, explaining the consequence of
>> CPU starvation of the submit path, is this:
>>
>> """
>> As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
>> gpu time.
>> """
> 
> More details here?

This just illustrates how long can the workqueue wait for it's slice on 
the CPU if the cores are loaded with other tasks. In other words, how 
long since job is runnable to it actually being passed to the GPU.

>> DRM scheduler was originally using kthreads but was converted workqueues due
>> desire by xe to create thousands of schedulers. This series also questions
>> whether that was needed, given how the submission is serialized by a device
>> global lock (per GT, so almost device global). Panthor has a similar situation;
>> hence the series contains two patches to move those two to a setup which matches
>> the design of those drivers.
>>
>> Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
>> scheduler as a hardware scheduler, where number of instances follow the number
>> of hardware blocks instead the number of userspace contexts, are completely
>> fine.
>>
>> There are use cases however which do currently track the number of userspace
>> contexts and which do allow for more parallelism. For those a straight
>> kthread_work conversion would be a problem due an explosion in number of
>> threads.
>>
>> The most direct example is panthor VM bind queue which creates a scheduler per
>> userspace context and relies on work queue concurrency management to keep the
>> number of threads in check.
>>
>> This creates a challenge for the kthread_work conversion. To solve which I for
>> now opted to create a trivial round-robin thread pool. For the RFC this is
>> limited to four CPU threads and is something which will need to be discussed.
> 
> 4 CPU threads per device, per drm sched module?

4 CPU threads per drm_sched_create_concurrent_worker(). So depends on 
the driver how it wants to use it. For xe there are no usages of that, 
albeit you say single thread is not workable, we can discuss that in the 
other sub-thread. For panthor this RFC uses that flavour of the worker 
for the VM bind queues and in that case it is 4 CPU threads per device 
which handle VM bind requests from all userspace clients.

Regards,

Tvrtko

> 
> I have more questions but let's get some clarification first.
> 
> Matt
> 
>> Ie. how much parallelsim those really need. The true answer is somewhere between
>> "at most the number of active userspace contexts and the number of CPU cores".
>> Or it could be less than that, since after all, VM BIND parallelism is
>> eventually going to choke on a narrower gate of actual GPU execution. We could
>> also allow drivers to pick their number.
>>
>> In terms of how I implemented priority inheritance, the most important
>> characteristic is that it is temporary. As many userspace clients may be
>> submitting to a single DRM scheduler instance, a generic solution is to only
>> elevate the submission worker priority while there are active high priority
>> submitters. The mechanism is light weight and has a hysteresis built in to avoid
>> frequent scheduler operations.
>>
>> That's pretty much it for now apart for an important detail that this RFC will
>> not build for all drivers! Out of those which directly use the DRM scheduler
>> APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
>> Others I have not tried to build.
>>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Chia-I Wu <olvaffe@gmail.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>>
>> Tvrtko Ursulin (8):
>>    drm/panthor: Remove redundant drm_sched_job_cleanup() from the
>>      .free_job callback
>>    drm/panthor: Use separate workqueue for DRM scheduler
>>    drm/sched: Use generic naming for workqueue helpers
>>    drm/xe: Convert to per gt scheduler workers
>>    drm: Wrap DRM scheduler worker in own abstraction
>>    drm/sched: Convert the scheduler job submission to kthread_worker
>>    drm/sched: Add ability to change drm_sched_worker priority
>>    drm/sched: Notify worker of the entity submission priority
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>   drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
>>   drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
>>   drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
>>   drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
>>   drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
>>   drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
>>   drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
>>   drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
>>   drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
>>   drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
>>   drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
>>   drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
>>   drivers/gpu/drm/xe/xe_gt.c                  |   7 +
>>   drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
>>   drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
>>   drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
>>   drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
>>   include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
>>   27 files changed, 551 insertions(+), 134 deletions(-)
>>
>> -- 
>> 2.54.0

