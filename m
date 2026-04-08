Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0B21073CBE
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B0D10E669;
	Wed,  8 Apr 2026 13:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iQJUhPIO";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8657F10E669
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 13:46:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372AC1477
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:46:30 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 BDD303F641
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775655995; bh=VPeUmPFpteb4N6Wv4WsBHZdFN79rVW+9WXeSgrwjIog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iQJUhPIOvvHLxYGMSDsG95FCwDpA5yi4MrK4qAtSkJ8dRHVnVm69Mpfe20QRRDgfg
 2c4EaeI9ztqa3SyDsuLOj9uvuMy9tVBXCrNks9N7g3KhBUWd/pvkmZqsSutmSK3JFQ
 /jTxiJGT4l8KJLp7eeejKG6YccO4oz7vRZnXzOm0=
Date: Wed, 8 Apr 2026 14:46:32 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yicong Hui <yiconghui@gmail.com>
Subject: Re: [PATCH] drm/panthor: Fix kernel-doc in panthor_sched.c so it's
 visible
Message-ID: <adZcOLGBNWUQVhoj@e142607>
References: <20260408091242.799074-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408091242.799074-1-steven.price@arm.com>
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

On Wed, Apr 08, 2026 at 10:12:42AM +0100, Steven Price wrote:
> Various substructures defined in panthor_sched.c have kernel-doc which
> is silently ignored because it doesn't include the full path to the
> member. Fix these issues so that the kernel-doc text is actually output
> by including the name of the parent.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 72 ++++++++++++-------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 3bb1cb5a2656..b255354553df 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -221,7 +221,7 @@ struct panthor_scheduler {
>  	/** @groups: Various lists used to classify groups. */
>  	struct {
>  		/**
> -		 * @runnable: Runnable group lists.
> +		 * @groups.runnable: Runnable group lists.
>  		 *
>  		 * When a group has queues that want to execute something,
>  		 * its panthor_group::run_node should be inserted here.
> @@ -231,7 +231,7 @@ struct panthor_scheduler {
>  		struct list_head runnable[PANTHOR_CSG_PRIORITY_COUNT];
>  
>  		/**
> -		 * @idle: Idle group lists.
> +		 * @groups.idle: Idle group lists.
>  		 *
>  		 * When all queues of a group are idle (either because they
>  		 * have nothing to execute, or because they are blocked), the
> @@ -242,7 +242,7 @@ struct panthor_scheduler {
>  		struct list_head idle[PANTHOR_CSG_PRIORITY_COUNT];
>  
>  		/**
> -		 * @waiting: List of groups whose queues are blocked on a
> +		 * @groups.waiting: List of groups whose queues are blocked on a
>  		 * synchronization object.
>  		 *
>  		 * Insert panthor_group::wait_node here when a group is waiting
> @@ -283,17 +283,17 @@ struct panthor_scheduler {
>  
>  	/** @pm: Power management related fields. */
>  	struct {
> -		/** @has_ref: True if the scheduler owns a runtime PM reference. */
> +		/** @pm.has_ref: True if the scheduler owns a runtime PM reference. */
>  		bool has_ref;
>  	} pm;
>  
>  	/** @reset: Reset related fields. */
>  	struct {
> -		/** @lock: Lock protecting the other reset fields. */
> +		/** @reset.lock: Lock protecting the other reset fields. */
>  		struct mutex lock;
>  
>  		/**
> -		 * @in_progress: True if a reset is in progress.
> +		 * @reset.in_progress: True if a reset is in progress.
>  		 *
>  		 * Set to true in panthor_sched_pre_reset() and back to false in
>  		 * panthor_sched_post_reset().
> @@ -301,7 +301,7 @@ struct panthor_scheduler {
>  		atomic_t in_progress;
>  
>  		/**
> -		 * @stopped_groups: List containing all groups that were stopped
> +		 * @reset.stopped_groups: List containing all groups that were stopped
>  		 * before a reset.
>  		 *
>  		 * Insert panthor_group::run_node in the pre_reset path.
> @@ -395,19 +395,19 @@ struct panthor_queue {
>  
>  	/** @iface: Firmware interface. */
>  	struct {
> -		/** @mem: FW memory allocated for this interface. */
> +		/** @iface.mem: FW memory allocated for this interface. */
>  		struct panthor_kernel_bo *mem;
>  
> -		/** @input: Input interface. */
> +		/** @iface.input: Input interface. */
>  		struct panthor_fw_ringbuf_input_iface *input;
>  
> -		/** @output: Output interface. */
> +		/** @iface.output: Output interface. */
>  		const struct panthor_fw_ringbuf_output_iface *output;
>  
> -		/** @input_fw_va: FW virtual address of the input interface buffer. */
> +		/** @iface.input_fw_va: FW virtual address of the input interface buffer. */
>  		u32 input_fw_va;
>  
> -		/** @output_fw_va: FW virtual address of the output interface buffer. */
> +		/** @iface.output_fw_va: FW virtual address of the output interface buffer. */
>  		u32 output_fw_va;
>  	} iface;
>  
> @@ -416,26 +416,26 @@ struct panthor_queue {
>  	 * queue is waiting on.
>  	 */
>  	struct {
> -		/** @gpu_va: GPU address of the synchronization object. */
> +		/** @syncwait.gpu_va: GPU address of the synchronization object. */
>  		u64 gpu_va;
>  
> -		/** @ref: Reference value to compare against. */
> +		/** @syncwait.ref: Reference value to compare against. */
>  		u64 ref;
>  
> -		/** @gt: True if this is a greater-than test. */
> +		/** @syncwait.gt: True if this is a greater-than test. */
>  		bool gt;
>  
> -		/** @sync64: True if this is a 64-bit sync object. */
> +		/** @synwait.sync64: True if this is a 64-bit sync object. */
>  		bool sync64;
>  
> -		/** @bo: Buffer object holding the synchronization object. */
> +		/** @syncwait.obj: Buffer object holding the synchronization object. */
>  		struct drm_gem_object *obj;
>  
> -		/** @offset: Offset of the synchronization object inside @bo. */
> +		/** @syncwait.offset: Offset of the synchronization object inside @bo. */
>  		u64 offset;
>  
>  		/**
> -		 * @kmap: Kernel mapping of the buffer object holding the
> +		 * @syncwait.kmap: Kernel mapping of the buffer object holding the
>  		 * synchronization object.
>  		 */
>  		void *kmap;
> @@ -443,21 +443,21 @@ struct panthor_queue {
>  
>  	/** @fence_ctx: Fence context fields. */
>  	struct {
> -		/** @lock: Used to protect access to all fences allocated by this context. */
> +		/** @fence_ctx.lock: Used to protect access to all fences allocated by this context. */
>  		spinlock_t lock;
>  
>  		/**
> -		 * @id: Fence context ID.
> +		 * @fence_ctx.id: Fence context ID.
>  		 *
>  		 * Allocated with dma_fence_context_alloc().
>  		 */
>  		u64 id;
>  
> -		/** @seqno: Sequence number of the last initialized fence. */
> +		/** @fence_ctx.seqno: Sequence number of the last initialized fence. */
>  		atomic64_t seqno;
>  
>  		/**
> -		 * @last_fence: Fence of the last submitted job.
> +		 * @fence_ctx.last_fence: Fence of the last submitted job.
>  		 *
>  		 * We return this fence when we get an empty command stream.
>  		 * This way, we are guaranteed that all earlier jobs have completed
> @@ -467,7 +467,7 @@ struct panthor_queue {
>  		struct dma_fence *last_fence;
>  
>  		/**
> -		 * @in_flight_jobs: List containing all in-flight jobs.
> +		 * @fence_ctx.in_flight_jobs: List containing all in-flight jobs.
>  		 *
>  		 * Used to keep track and signal panthor_job::done_fence when the
>  		 * synchronization object attached to the queue is signaled.
> @@ -477,13 +477,13 @@ struct panthor_queue {
>  
>  	/** @profiling: Job profiling data slots and access information. */
>  	struct {
> -		/** @slots: Kernel BO holding the slots. */
> +		/** @profiling.slots: Kernel BO holding the slots. */
>  		struct panthor_kernel_bo *slots;
>  
> -		/** @slot_count: Number of jobs ringbuffer can hold at once. */
> +		/** @profiling.slot_count: Number of jobs ringbuffer can hold at once. */
>  		u32 slot_count;
>  
> -		/** @seqno: Index of the next available profiling information slot. */
> +		/** @profiling.seqno: Index of the next available profiling information slot. */
>  		u32 seqno;
>  	} profiling;
>  };
> @@ -627,7 +627,7 @@ struct panthor_group {
>  
>  	/** @fdinfo: Per-file info exposed through /proc/<process>/fdinfo */
>  	struct {
> -		/** @data: Total sampled values for jobs in queues from this group. */
> +		/** @fdinfo.data: Total sampled values for jobs in queues from this group. */
>  		struct panthor_gpu_usage data;
>  
>  		/**
> @@ -805,15 +805,15 @@ struct panthor_job {
>  
>  	/** @call_info: Information about the userspace command stream call. */
>  	struct {
> -		/** @start: GPU address of the userspace command stream. */
> +		/** @call_info.start: GPU address of the userspace command stream. */
>  		u64 start;
>  
> -		/** @size: Size of the userspace command stream. */
> +		/** @call_info.size: Size of the userspace command stream. */
>  		u32 size;
>  
>  		/**
> -		 * @latest_flush: Flush ID at the time the userspace command
> -		 * stream was built.
> +		 * @call_info.latest_flush: Flush ID at the time the userspace
> +		 * command stream was built.
>  		 *
>  		 * Needed for the flush reduction mechanism.
>  		 */
> @@ -822,10 +822,10 @@ struct panthor_job {
>  
>  	/** @ringbuf: Position of this job is in the ring buffer. */
>  	struct {
> -		/** @start: Start offset. */
> +		/** @ringbuf.start: Start offset. */
>  		u64 start;
>  
> -		/** @end: End offset. */
> +		/** @ringbuf.end: End offset. */
>  		u64 end;
>  	} ringbuf;
>  
> @@ -840,10 +840,10 @@ struct panthor_job {
>  
>  	/** @profiling: Job profiling information. */
>  	struct {
> -		/** @mask: Current device job profiling enablement bitmask. */
> +		/** @profiling.mask: Current device job profiling enablement bitmask. */
>  		u32 mask;
>  
> -		/** @slot: Job index in the profiling slots BO. */
> +		/** @profiling.slot: Job index in the profiling slots BO. */
>  		u32 slot;
>  	} profiling;
>  };
> -- 
> 2.39.5
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
