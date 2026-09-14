Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B740AC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0073010E4EA;
	Mon, 14 Sep 2026 13:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XigczSoi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B05E10E4EA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789391016;
 bh=Zs4BNHtc9YX9asjU6AU9e0WegnRumv5dFKR2zMKnYPM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XigczSoiw5AvsXHu0V8MKhIYSxuujGcWn6CXd5bw3GjIk374+3214hL0aiOoxOOej
 QpfbWTz1pLfsNmtT4+rXuyDXAG2ANcFziW/Qe/tC7Flu1Aq+U8jSM/AxCmSotupDMY
 i/HRO6agzDvkcfy0qi0tC4w8M76MrSY1LXwx+oKFfCRaXfbHeWhqVIRpBqPubkRqKE
 INliOlquzh1htaLXqOJZpcPHLcTdV+7+S+GOSBQ2k0OrHmn4KkUgbZLdtYjRzJhvFf
 nAjxphWq9JPUYqeNJSdQOeuG0xXG2q5JGTtfl3J7koeVnPe+2vdhGNBNSWgLHfrKsI
 pCtGmQBJuEg2A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 280E217E0074;
 Mon, 14 Sep 2026 15:03:36 +0200 (CEST)
Date: Mon, 14 Sep 2026 15:03:25 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Florent
 Tomasin <florent.tomasin@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>
Subject: Re: [PATCH v3 5/6] drm/panthor: Add support for entering and
 exiting protected mode
Message-ID: <20260914150325.44150a29@fedora-21.home>
In-Reply-To: <20260911114014.79139-6-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
 <20260911114014.79139-6-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Ketil,

On Fri, 11 Sep 2026 13:40:13 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Florent Tomasin <florent.tomasin@arm.com>
> 
> This patch modifies the Panthor driver code to allow handling
> of the GPU HW protected mode enter and exit.
> 
> The logic added by this patch includes:
> - the mechanisms needed for entering and exiting protected mode.
> - the handling of protected mode IRQs and FW interactions.
> - the scheduler changes needed to decide when to enter
>   protected mode based on CSG scheduling.
> - GPU fault handling during protected mode execution.
> 
> Note that the submission of a protected mode jobs are done

			   of protected mode jobs

> from the user space.
> 
> The following is a summary of how protected mode is entered
> and exited:
> - When the GPU detects a protected mode job needs to be
>   executed, an IRQ is sent to the CPU to notify the kernel
>   driver that the job is blocked until the GPU has entered
>   protected mode. The entering of protected mode is controlled
>   by the kernel driver.
> - The Mali Panthor CSF driver will schedule a tick and evaluate
>   which CS in the CSG to schedule on slot needs protected mode.
>   If the priority of the CSG is not sufficiently high, the
>   protected mode job will not progress until the CSG is
>   scheduled at top priority.
> - The Panthor scheduler notifies the GPU that the blocked
>   protected jobs will soon be able to progress.
> - Once all CSG and CS slots are updated, the scheduler
>   requests the GPU to enter protected mode and waits for
>   it to be acknowledged.
> - If successful, all protected mode jobs will resume execution
>   while normal mode jobs block until the GPU exits
>   protected mode, or the kernel driver rotates the CSGs
>   and forces the GPU to exit protected mode.
> - If unsuccessful, the scheduler will request a GPU reset.
> - Faults during protected mode are reported GPU wide, and not as
>   CSG/CS errors. We allow only one CSG to run in protected mode at a
>   time so we know which CSG to blame for the fault.
> - All faults during protected mode are handled with a GPU reset.
> - When a protected mode job is suspended as a result of
>   the CSGs rotation, the GPU will send an IRQ to the CPU
>   to notify that the protected mode job needs to resume.
> 
> This sequence will continue so long the user space is
> submitting protected mode jobs.
> 
> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> Co-developed-by: Paul Toadere <paul.toadere@arm.com>
> Signed-off-by: Paul Toadere <paul.toadere@arm.com>
> Co-developed-by: Samuel Percival <samuel.percival@arm.com>
> Signed-off-by: Samuel Percival <samuel.percival@arm.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> 
> ---


> +	/** @protm: Protected mode related data. */
> +	struct {
> +		/**
> +		 * @lock: Lock to prevent MMU operations during protected mode.
> +		 *
> +		 * The MMU HW will silently ignore commands issued when the
> +		 * GPU is in protected mode. It is important that we handle this
> +		 * for some of the MMU HW interactions.
> +		 *
> +		 * Code which interacts with the MMU, typically by calling
> +		 * panthor_vm_lock_region(), should therefore ensure the
> +		 * scheduler is not in and will not enter protected mode first.
> +		 * This is done by calling either
> +		 * - panthor_sched_protm_block(), or
> +		 * - panthor_sched_protm_try_block()
> +		 *
> +		 * Once the MMU operations have completed, call
> +		 * panthor_sched_protm_unblock() to tell the scheduler that
> +		 * it is safe to enter protected mode again.
> +		 *
> +		 * The block/unblock for MMU operations take this as reader.
> +		 * The scheduler holds this as writer when switching into protm.
> +		 */
> +		struct rw_semaphore lock;
> +
> +		/** @protm_enter_count: Number of times entered protm. */
							^ we entered ?
> +		atomic64_t protm_enter_count;
> +
> +		/** @protm_exit_count: Number of times exited protm. */

						       ^ we exited ?

> +		atomic64_t protm_exit_count;
> +	} protm;
>  };
>  

[...]

> @@ -1281,6 +1283,9 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		return ret;
>  	}
>  
> +	atomic64_set(&ptdev->protm.protm_enter_count, 0);
> +	atomic64_set(&ptdev->protm.protm_exit_count, 0);
> +
>  	/* We must re-initialize the global interface even on fast-reset. */
>  	panthor_fw_init_global_iface(ptdev);
>  	return 0;
> @@ -1476,6 +1481,91 @@ static void panthor_fw_ping_work(struct work_struct *work)
>  	}
>  }
>  
> +static bool wait_protm_enter(struct panthor_device *ptdev,
> +			     long long enter_count)

Let's use s64 instead of long long and rename this argument
protm_session_seqno.

> +{
> +	return (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) ||
> +	       (atomic64_read(&ptdev->protm.protm_exit_count) >= enter_count);
> +}
> +
> +int panthor_fw_protm_enter(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface =
> +		panthor_fw_get_glb_iface(ptdev);
> +	u32 acked;
> +	int ret;
> +	long long enter_count;

	s64 protm_session_seqno;

> +
> +	/* Restart the watchdog timer, so it doesn't hit immediately
> +	 * after entering protected mode, since this will cause GPU
> +	 * to exit protected mode to respond to the ping request.
> +	 */
> +	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
> +			 msecs_to_jiffies(PING_INTERVAL_MS));
> +
> +	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PROTM_ENTER);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
> +
> +	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PROTM_ENTER, &acked, 250);
> +	if (ret) {
> +		drm_err(&ptdev->base,
> +			"Wait for FW protected mode acknowledge timed out");
> +		return ret;
> +	}
> +
> +	enter_count = atomic64_inc_return(&ptdev->protm.protm_enter_count);
> +
> +	/* Poll for the entry of protected mode.
> +	 * It is possible that GPU_STATUS_PROTM_ACTIVE is set and cleared
> +	 * before we check it below, so we must also check for GLB_PROTM_EXIT.
> +	 * GLB_PROTM_EXIT can not be checked directly, because this could also
> +	 * be handled and clear before we check below. We count number of
> +	 * protm enters and exits to safely handle that case.
> +	 */
> +	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
> +				 wait_protm_enter(ptdev, enter_count),
> +				 msecs_to_jiffies(500));
> +	if (!ret) {
> +		drm_err(&ptdev->base,
> +			"Wait for GPU protected mode enter timed out");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

[...]


> @@ -2633,9 +2643,12 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *vm_bo,
>  			panthor_vm_unlock_region(vm);
>  		}
>  
> +		panthor_sched_protm_unblock(vm->ptdev);
> +
>  		vm->op_ctx = NULL;
>  	}
>  
> +out_unlock:
>  	mutex_unlock(&vm->op_lock);
>  
>  out_cleanup:
> @@ -2726,9 +2739,13 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
>  	mutex_lock(&vm->op_lock);
>  	vm->op_ctx = op;
>  
> +	ret = panthor_sched_protm_block(vm->ptdev);
> +	if (ret)
> +		goto out_unlock;

I'm not happy with the fact failing to exit an unrelated PROTM session
on a different VM/group will make this VM unusable (in case we're
executing an async VM_BIND). It feels to me that
panthor_sched_protm_block() should not be allowed to fail. I also think
the timeout should be on the PROTM session itself, not in
panthor_sched_protm_block(), and that protm_exit() failures should be
sorted out with a SOFT_RESET.

Honestly, I wish there was a solution that didn't involve having this
big lock. Ideally, we'd have a sync mechanism between the host and
the FW. Before every VM update the host would set as_updated[x] to
true. Before entering PROTM, the FW would reset as_updated[0..N] to
false, and just after rebooting in the PROTM_EXIT, it would check the
values again and raise an interrupt if anything changed, waiting for
the host to acknowledge this event. When such an event is detected, the
host would walk the bitset and do an AS_DISABLE/AS_ENABLE cycle for
each AS which has its as_updated bit set. When done, it would ack the
event and let the FW proceed with the rest of the PROTM_EXIT procedure.

> +
>  	ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
>  	if (ret)
> -		goto out;
> +		goto out_unblock;
>  
>  	switch (op_type) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
> @@ -2759,10 +2776,13 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
>  
>  	panthor_vm_unlock_region(vm);
>  
> -out:
> +out_unblock:
> +	panthor_sched_protm_unblock(vm->ptdev);
> +
>  	if (ret && flag_vm_unusable_on_failure)
>  		panthor_vm_declare_unusable(vm);
>  
> +out_unlock:
>  	vm->op_ctx = NULL;
>  	mutex_unlock(&vm->op_lock);
>  

[...]

> +static void sched_process_protm_exit_event_locked(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface =
> +		panthor_fw_get_glb_iface(ptdev);
> +	struct panthor_scheduler *sched = ptdev->scheduler;
> +
> +	lockdep_assert_held(&sched->events_lock);
> +
> +	atomic64_inc(&ptdev->protm.protm_exit_count);

I only see protm_exit_count incremented here. What happens if the GPU
hangs while in PROTM, and a SOFT_RESET is issued to unblock the
situation. Won't we end up with unbalanced enter/exit count thus
defeating the second checks in wait_protm_enter().

> +
> +	/* Acknowledge the protm exit */
> +	panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack,
> +			       GLB_PROTM_EXIT);
> +
> +	/* If there are pending fault from protected mode execution, then early
> +	 * out here. The GPU_IRQ_PROTM_FAULT handling will trigger the propper
> +	 * error recovery via a GPU reset.
> +	 */
> +	if (panthor_gpu_protm_fault_pending(ptdev))
> +		return;
> +
> +	/* Protected mode exited successfully. Clear protm.active_group so that
> +	 * tick_work() is unblocked to schedule new work.
> +	 */
> +	if (sched->protm.active_group) {
> +		group_put(sched->protm.active_group);
> +		sched->protm.active_group = NULL;
> +	}
> +
> +	sched_queue_delayed_work(sched, tick, 0);
> +}
> +

[...]

> @@ -2133,6 +2294,11 @@ tick_ctx_pick_groups_from_list(const struct panthor_scheduler *sched,
>  		if (!owned_by_tick_ctx)
>  			group_get(group);
>  
> +		/* Only the first pick is allowed to request switch to protm */
> +		if (ctx->group_count == 0 &&
> +		    atomic_read(&group->protm_pending_queues))
> +			ctx->protm_group = group;
> +
>  		ctx->group_count++;
>  
>  		/* If we have more than one active group with the same priority,
> @@ -2291,6 +2457,48 @@ static void group_term_work(struct work_struct *work)
>  	group_put(group);
>  }
>  
> +int panthor_sched_protm_block(struct panthor_device *ptdev)

This sounds like an infallible lock helper, but in practice it can
fail/timeout. I think we want a _timeout() suffix to reflect that.

> +{
> +	int ret;
> +
> +	down_read(&ptdev->protm.lock);
> +
> +	/* First, wait a little bit for FW to exit protected mode on its own.
> +	 * Only if that fails do we request a protected mode exit.
> +	 */
> +

nit: You can drop the blank line.

> +	ret = panthor_fw_protm_exit_wait(ptdev, 5);
> +	if (ret) {
> +		ret = panthor_fw_protm_exit(ptdev, 2000);

Given how big the timeout is (2secs), we should at least ensure this is
interruptible with a wait_event_interruptible_timeout() in
panthor_fw_protm_exit() and panthor_fw_protm_exit_wait().

> +		if (ret)
> +			up_read(&ptdev->protm.lock);
> +	}
> +
> +	return ret;
> +}
> +
> +int panthor_sched_protm_try_block(struct panthor_device *ptdev)
> +{
> +	int ret;
> +
> +	ret = down_read_trylock(&ptdev->protm.lock);
> +	if (ret) {
> +		if (panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE) {
> +			up_read(&ptdev->protm.lock);
> +			return -EAGAIN;
> +		}
> +
> +		return 0;
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +void panthor_sched_protm_unblock(struct panthor_device *ptdev)
> +{
> +	up_read(&ptdev->protm.lock);
> +}

While at it, can you add DEFINE_GUARD[_COND]() for these?

I'm stopping here for now because I'm still skeptical about the
protm_block/unblock pattern proposed in this patch, and I'd like to
sort it out before commenting on the rest of the PROTM implementation
since it's likely to impact other aspects of the implementation.

Regards,

Boris
