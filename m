Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E7607408E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WEuHiMof
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B0410E9C0;
	Mon, 19 Oct 2026 15:42:13 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1BB10E9C0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792424525;
 bh=9SYUPA29Depy26fMYMQfLIdt1Nw9Lt93MRy58VvOflo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WEuHiMofR6iCPYzMzOhSJ8CThFh2CRLYTnipclAJUfBUQChpVlxal/piFSr3GDMoh
 IuyvzsaC7tCnU0UqE5i0g32nymgZi6afLXnzjSl/Yo7HAUrqgAUAWxkKmRs3pqZqbo
 msUi33jYqaopxn86EAruVoIiHqikE1/58omUYlIt98j23/b0Q232dYwpRip8n8mDWo
 ydLygSh648CIQooCPWWixAeRbYyfxDIuB3Jqqm0jNJH2MCkAHMfj5Z22DNPS+Jjnlj
 mRcRNKB7jNWSM8X87j4ZRiP9UH2573vQlC1eDQ1PzbfTT2T7wQpWXvJQ0qZDVuCJlT
 gNNOQGSq9Nq1w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BCD4917E02EB;
 Mon, 19 Oct 2026 17:42:04 +0200 (CEST)
Date: Mon, 19 Oct 2026 17:41:59 +0200
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
Subject: Re: [PATCH v4 05/12] drm/panthor: Add support for entering and
 exiting protected mode
Message-ID: <20261019174159.20771c0d@fedora-21.home>
In-Reply-To: <20261012125940.3291951-6-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-6-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ketil,

On Mon, 12 Oct 2026 14:59:33 +0200
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
> Note that the submission of protected mode jobs are done
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

[...]

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 3e5f20768d545..38e9986416dd9 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -77,6 +77,12 @@ struct panthor_mmu {
>  		/** @as.faulty_mask: Bitmask encoding the faulty slots. */
>  		unsigned long faulty_mask;
>  
> +		/** @as.delay_update_mask: Bitmask encoding slots which must use delayed updates */
> +		u32 delay_update_mask;
> +
> +		/** @as.delayed_update_mask: Bitmask encoding slots with pending delayed updates */
> +		u32 delayed_update_mask;

The naming is a bit confusing, because the only thing being
postponed is the GPU cache flush, not the PT update.

> +
>  		/** @as.slots: VMs currently bound to the AS slots. */
>  		struct panthor_as_slot slots[MAX_AS_SLOTS];
>  

[...]

> +void panthor_mmu_protm_enter_event(struct panthor_device *ptdev,
> +				   struct panthor_vm *vm)
> +{
> +	/* Scheduler is entering protm mode with specified VM (AS).
> +	 * Scheduler now promises it will not run any work using any other VM
> +	 * than the provided vm and the FW VM until further notice.
> +	 * This means we can do page table updates for all the other VMs, even
> +	 * in protected mode, as long as we do the necessary cache operations
> +	 * before normal scheduling is resumed. This is done on protm exit,
> +	 * see panthor_mmu_protm_exit_event().
> +	 */
> +	if (drm_WARN_ON(&ptdev->base, !vm))
> +		return;
> +
> +	if (drm_WARN_ON(&ptdev->base, vm->as.id < 0))
> +		return;
> +
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	drm_WARN_ON(&ptdev->base, ptdev->mmu->as.delay_update_mask);
> +
> +	ptdev->mmu->as.delay_update_mask = ~(BIT(0) | BIT(vm->as.id));

We should really stop the drm_gpu_scheduler attached to the VM entering
PROTM before returning so we don't end up with asynchronous VM binds
interfering with the PROTM jobs. I know the 5ms-before-interrrupting +
2x-job-timeout-before-failure is supposed to cover for this, but that's
not how ::run_job() is supposed to work. When ::run_job() is called,
it's assumed that all the deps are met, and any lock that are supposed
to be taken in this path are only briefly waited on. The PROTM is
implemented here breaks this assumption.

> +}
> +
> +void panthor_mmu_protm_exit_event(struct panthor_device *ptdev)
> +{
> +	/* We left protected mode and scheduler is about to resume normal
> +	 * scheduling. Do the necessary cache operation so any page table
> +	 * updates we might have done during protm is correctly visible
> +	 * to the GPU.
> +	 */
> +	int ret;
> +
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	ptdev->mmu->as.delay_update_mask = 0;
> +
> +	if (!ptdev->mmu->as.delayed_update_mask)
> +		return;
> +
> +	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> +				       CACHE_CLEAN | CACHE_INV, CACHE_INV);

We've noticed a flush elimination bug on v13 that prevents full-flushes
from the host [1], so let's just drop the other-inval request.

> +	if (ret)
> +		panthor_device_schedule_reset(ptdev);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index e262fe2303f6c..9f9d690953ead 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -106,6 +106,12 @@ void panthor_vm_update_resvs(struct panthor_vm *vm, struct drm_exec *exec,
>  int panthor_mmu_pt_cache_init(void);
>  void panthor_mmu_pt_cache_fini(void);
>  
> +bool panthor_vm_for_mcu(struct panthor_vm *vm);
> +
> +void panthor_mmu_protm_enter_event(struct panthor_device *ptdev,
> +				   struct panthor_vm *vm);
> +void panthor_mmu_protm_exit_event(struct panthor_device *ptdev);
> +
>  #ifdef CONFIG_DEBUG_FS
>  void panthor_mmu_debugfs_init(struct drm_minor *minor);
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index db801705f0d27..fff805fd794a5 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -307,6 +307,50 @@ struct panthor_scheduler {
>  		 */
>  		struct list_head stopped_groups;
>  	} reset;
> +
> +	/** @protm: Protected mode related fields. */
> +	struct {
> +		/**
> +		 * @lock: Lock for the protected mode state (active_group)
> +		 *
> +		 * This lock is used to manage current protected mode state,
> +		 * as represented by the member active_group.
> +		 *
> +		 * Knowing this state is critical for MMU operations, because:
> +		 * - The MMU will silently ignore commands issued when the GPU
> +		 *   is in protected mode.
> +		 * - There can not be any pending MMU LOCKS in place when
> +		 *   entering protected mode.
> +		 *
> +		 * Code which interacts with the MMU, typically by calling
> +		 * panthor_vm_lock_region(), should therefore ensure the
> +		 * scheduler is not in and will not enter protected mode first.
> +		 * This is done by calling either
> +		 * - panthor_sched_protm_block_timeout(), or
> +		 * - panthor_sched_protm_try_block()
> +		 *
> +		 * Once the MMU operations have completed, call
> +		 * panthor_sched_protm_unblock() to tell the scheduler that
> +		 * it is safe to enter protected mode again.
> +		 */
> +		struct rw_semaphore lock;
> +
> +		/**
> +		 * @active_group: The active protected group.
> +		 *
> +		 * We only allow one protected group to run at the same time,
> +		 * as it makes it easier to handle faults in protected mode.
> +		 *
> +		 * If the active_group member is set, then the scheduler
> +		 * believes the GPU is in protected mode. If not set, then the
> +		 * GPU is for sure not in normal mode.
> +

Missing

		*

here.

> +		 * Changes are done with both panthor_scheduler::lock and
> +		 * panthor_scheduler::protm::lock held as writer.
> +		 * This means you only need to hold one of these locks for read.
> +		 */
> +		struct panthor_group *active_group;
> +	} protm;
>  };
>  
>  /**
> @@ -571,6 +615,16 @@ struct panthor_group {
>  	 */
>  	atomic_t fatal_queues;
>  
> +	/**
> +	 * @protm_pending_queues: Bitmask reflecting the queues that have raised
> +	 *                        a CS_PROTM_PENDING.
> +	 *
> +	 * The GPU will set the bit associated to the queue pending protected
> +	 * mode when a PROT_REGION command is executing or when trying to resume
> +	 * previously suspended protected mode jobs.
> +	 */
> +	atomic_t protm_pending_queues;
> +
>  	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
>  	atomic_t tiler_oom;
>  
> @@ -1154,8 +1208,9 @@ cs_slot_reset_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
>  	lockdep_assert_held(&ptdev->scheduler->lock);
>  
>  	panthor_fw_update_reqs(cs_iface, req,
> -			       CS_STATE_STOP,
> -			       CS_STATE_MASK);
> +			       CS_STATE_STOP | (cs_iface->output->ack &
> +						CS_PROTM_PENDING),

			       CS_STATE_STOP |
			       (cs_iface->output->ack & CS_PROTM_PENDING),

> +			       CS_STATE_MASK | CS_PROTM_PENDING);
>  
>  	queue_suspend_timeout(queue);
>  

[...]

>  static void
>  cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
>  				   u32 csg_id, u32 cs_id)
> @@ -1642,6 +1718,10 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
>  	if (events & CS_TILER_OOM)
>  		cs_slot_process_tiler_oom_event_locked(ptdev, csg_id, cs_id);
>  
> +	if (events & CS_PROTM_PENDING)
> +		cs_slot_process_protm_pending_event_locked(ptdev, csg_id,
> +							   cs_id);

Limit has been bumped to 100 lines a while ago, so let's not introduce
unnecessary multi-line function calls. Beside, I'd to keep the curly
braces when a multi-line statement is under an if/else branch.

> +
>  	/* We don't acknowledge the TILER_OOM event since its handling is
>  	 * deferred to a separate work.
>  	 */
> @@ -1856,6 +1936,30 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
>  	sched_queue_delayed_work(ptdev->scheduler, tick, 0);
>  }
>  

[...]

>  
>  /**
> @@ -1983,6 +2090,69 @@ group_unbind_locked(struct panthor_group *group)
>  	return 0;
>  }
>  
> +static void handle_protm_fault(struct panthor_device *ptdev)
> +{
> +	struct panthor_scheduler *sched = ptdev->scheduler;
> +	u32 csg_id;
> +	struct panthor_group *protm_group;
> +
> +	guard(mutex)(&sched->lock);
> +
> +	protm_group = sched->protm.active_group;
> +
> +	if (!protm_group || !panthor_gpu_protm_fault_pending(ptdev))
> +		return;
> +
> +	atomic_set(&protm_group->fatal_queues,
> +		   GENMASK(protm_group->queue_count - 1, 0));
> +
> +	/* Different kinds of faults during protected mode can give different
> +	 * behavior/state.
> +	 * Case 1) The fault keeps the GPU in protected mode.
> +	 *         In this case, the request to exit protected mode below will
> +	 *         fail and we need to take some further action.
> +	 * Case 2) The fault do not keep the GPU in protected mode.
> +	 *         In this case, the request to exit protected
> +	 *         mode below will succeed, and we don't need to take any
> +	 *         further action right here.
> +	 */
> +	if (!panthor_fw_protm_exit(ptdev, 500))
> +		return;
> +
> +	/* GPU failed to exit protected mode.
> +	 * Mark all CSGs as suspended and unbind them, so that they are
> +	 * unaffected by the GPU reset itself.
> +	 * We can not suspend the groups in this case, because we are stuck
> +	 * in protected mode. That is also the reason it is safe to unbind
> +	 * without suspending first (the groups are already "suspended").
> +	 * The failing protected group will be scheduled for termination.

Question is, why are those groups considered bound in the first place if
they are not resident. I doubt writing to the CSG/CS iface is what takes
time, so I'd make sure those groups are suspended/unbound in the tick when
the scheduler decides to pick a single group to execute in PROTM rather than
doing it here.

> +	 */
> +

Drop the extra blank line.

> +	for (csg_id = 0; csg_id < sched->csg_slot_count; csg_id++) {
> +		struct panthor_group *group = sched->csg_slots[csg_id].group;
> +
> +		if (!group)
> +			continue;
> +
> +		group_get(group);
> +
> +		group->state = PANTHOR_CS_GROUP_SUSPENDED;
> +		group_unbind_locked(group);
> +
> +		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));
> +
> +		if (group_can_run(group)) {
> +			list_add(&group->run_node,
> +				 &sched->groups.idle[group->priority]);
> +		} else {
> +			list_del_init(&group->wait_node);
> +			group_queue_work(group, term);
> +		}
> +
> +		group_put(group);
> +	}
> +}
> +

[...]

>  
> +bool panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
> +				      struct panthor_vm *vm)
> +{
> +	struct panthor_scheduler *sched = ptdev->scheduler;
> +	int ret;
> +
> +	if (!sched)
> +		return true;
> +
> +	down_read(&sched->protm.lock);
> +
> +	if (!sched->protm.active_group)
> +		return true; /* All good, we are in normal mode */
> +
> +	/* We will only exit protected mode for the passed vm and the MCU VM.
> +	 * Other VMs have no active CSG work, so MMU updates can proceed,
> +	 * although with special caution (delayed updates)!
> +	 */
> +	if (sched->protm.active_group->vm != vm && !panthor_vm_for_mcu(vm))
> +		return true; /* Specified VM can proceed, with caution. */
> +
> +	/* Give GPU a chance to finish ongoing protm work by itself */
> +	ret = panthor_fw_protm_exit_wait(ptdev, 5);
> +	if (!ret)
> +		return true; /* All good, we are back to normal mode */

Sorry, but I'm still not convinced this is where this timeout should
live. I'd rather have a shorter tick period in the scheduler (or a separate
delayed work) when a group enters PROTM so we can re-evaluate if we should
exit PROTM more often. If we do that, we can make
panthor_sched_protm_block() non-fallible and let the reset logic unblock
things if we're really stuck in PROTM for some reason.

> +
> +	/* We do not want this function to fail, because that can lead to
> +	 * innocent processes failing. That is why we wait up to 2x the job
> +	 * timeout for GPU to exit protm here. This shall cover the worst case
> +	 * where protm work hangs and we must rely on job timeout to recover.
> +	 */
> +	ret = panthor_fw_protm_exit(ptdev, JOB_TIMEOUT_MS << 1);
> +	if (ret)
> +		up_read(&sched->protm.lock);

Same here. We really want the per-queue timeout to handle that for us.
And this is where waiting with the protm lock held gets messy, because
I suspect the reset logic will need to reset the PROTM state, and that
can only be done with this lock held in write mode.

Overall, I'm worried we're adding a lot of complex inter-locking
situations with this PROTM implementation, and rw_sem+state-machine
doesn't look like the right tool to solve that.
dma_resv sounds like a better fit, because each party can request
access to the VM (exclusive or shared) and wait for any previously
recorded access to land before proceeding. It also integrates well
with reclaim and async VM_BIND, but not so much with the ability to
randomly request exclusive VM access from a tick (because we're not
supposed to allocate or lock resv objects from this path). I'm sorry
the only answer I can give you now is "doesn't sounds right, but I
don't know how to do it properly". I'll try to sleep on it, and see
if I can come up with something simpler.

> +
> +	return ret ? false : true;
> +}
> +
> +bool panthor_sched_protm_try_block(struct panthor_device *ptdev)
> +{
> +	struct panthor_scheduler *sched = ptdev->scheduler;
> +	int ret;
> +
> +	if (!sched)
> +		return false;
> +
> +	ret = down_read_trylock(&sched->protm.lock);
> +	if (ret) {
> +		/* Unlike panthor_sched_protm_block_timeout(), we don't bother
> +		 * checking against a particular vm. It is not that important
> +		 * to succeed in this use case.
> +		 */
> +		if (sched->protm.active_group) {
> +			up_read(&sched->protm.lock);

Hm, are we sure we want to skip reclaim on idle and inactive VMs? Feels
a bit too conservative to me.

> +			return false;
> +		}
> +
> +		return true;
> +	}
> +
> +	return false;
> +}

Stopping here for now. I'll try to get back to you with more useful
insight shortly.

Regards,

Boris

[1]https://lore.kernel.org/dri-devel/20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com/
