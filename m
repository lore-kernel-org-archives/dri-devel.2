Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB0606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL0OjnIS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B79A10EFCE;
	Mon, 16 Nov 2026 12:12:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413D010EFCC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:12:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E02DE436C8;
 Mon, 16 Nov 2026 12:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1311F000C4;
 Mon, 16 Nov 2026 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794831164;
 bh=Uf6oRvL7/BFxhZPhj+dk4ATJyNXI2lJDOr4wWmMXHsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FL0OjnISpIdyLXk2gy+lcygf3Cz37kY22ww+AlG3enVOWaUyOn3SKBAW3HAOyJi2w
 6xp6WA2DxP4rW/9Z6bEL1BjG3WezCAgZF243VDkyPsz+4Smg+/qOy4Kkzw+Rupullh
 HGYWFCMaw+exOfhPcewSZpNsV9wHtY6irr2pwuCWP5rhTOXgdhdQinlRA71vfTBMaK
 fFRzgCy0BgNn3KA9klhdK4qR2tU9wanYx6ccSayN4KtwSsFTpJ2b77nWsl8kqZQxTJ
 w5YlnYclFMSioojsf+ZyfsLVA3G6jz2KCZuKkbWDnHXnWzLZ7EB7M208tFfScjIcJm
 E93CwKtbcHALw==
Message-ID: <sashiko-outbox-216993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] drm/panthor: Add support for entering and
 exiting protected mode
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261116112601.3483649-6-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
 <20261116112601.3483649-6-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:12:44 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 16 potential
issues to consider:
- [Critical] drm/panthor: wrong page order get_order(size) * 2 in
  alloc_pt() and free_pt()
- [High] drm/panthor: missing sched->lock and CS slot reset in
  handle_protm_fault()
- [High] drm/panthor: deadlock in tick_ctx_apply() stopping VM under
  protm.lock
- [High] drm/panthor: race between handle_as_fault_locked() and dormant
  VM updates
- [High] drm/panthor: missing protm sync in
  panthor_vm_evict_bo_mappings_locked()
- [High] drm/panthor: protm_fault reset in panthor_gpu_soft_reset()
  skipped on v14
- [High] drm/panthor: signal in panthor_fw_protm_exit_wait() breaks VM
  teardown
- [High] drm/panthor: preempt_protm_group() ignores runnable groups
  bound to CSG slots
- [High] drm/panthor: missing active_group cleanup on unplug, suspend,
  and VM destroy
- [High] drm/panthor: stale protm_pending_queues across CS reset and
  early ack before resume
- [Medium] drm/panthor: skipped reset cleanup and active_group race in
  handle_protm_fault()
- [Medium] drm/panthor: missing rollback and return on
  panthor_fw_protm_enter() error
- [Medium] drm/panthor: race on GLB_PING between panthor_fw_protm_exit()
  and ping_work
- [Medium] drm/panthor: panthor_sched_protm_block_timeout() waits under
  protm.lock
- [Low] drm/panthor: panthor_vm_exec_op() mixes scoped_cond_guard() and
  goto
- [Low] drm/panthor: inverted comment for
  panthor_scheduler::protm.active_group
--

commit 692a26958a72ddf6fd6351559d386fc6e296f3d5
Author: Florent Tomasin <florent.tomasin@arm.com>

drm/panthor: Add support for entering and exiting protected mode

This commit adds support for entering and exiting hardware protected mode
across the Panthor firmware interface, GPU interrupt handler, MMU, and CSG
scheduler.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 5f9f7a92c56a8..e639ffeac7a32 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c

[ ... ]

> @@ -1476,6 +1481,93 @@ static void panthor_fw_ping_work(struct work_struc=
t *work)

[ ... ]

> +int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout=
_ms)
> +{
> +	unsigned long deadline =3D jiffies + msecs_to_jiffies(timeout_ms);
> +
> +	do {
> +		if (!(panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE))
> +			return 0;
> +
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +
> +		usleep_range_state(100, 200, TASK_INTERRUPTIBLE);
> +	} while (!time_after_eq(jiffies, deadline));
> +
> +	if (!(panthor_gpu_status(ptdev) & GPU_STATUS_PROTM_ACTIVE))
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}

[Severity: High]
Does returning -ERESTARTSYS here on a pending signal break non-restartable
teardown paths such as panthor_vm_destroy() and
panthor_kernel_bo_destroy()?

When a process is killed with SIGKILL while a group is in protected mode,
signal_pending(current) remains true during exit teardown.  In
panthor_sched_protm_block_timeout(), the initial 5 ms
panthor_fw_protm_exit_wait() immediately returns -ERESTARTSYS, which is
treated as a timeout: it calls panthor_fw_protm_exit(), sends GLB_PING to
preempt protected mode, and calls panthor_fw_protm_exit_wait() a second
time, which again fails immediately without waiting for the GPU to exit
protected mode.  scoped_cond_guard(protm_block_timeout, ret =3D -ETIMEDOUT,
vm) then turns that into -ETIMEDOUT and skips the unmap in
panthor_vm_exec_op().

In panthor_vm_destroy(), panthor_sched_prepare_for_vm_destruction() only
flushes tick_work once, and that first tick_work run only requests
protected mode exit without clearing sched->protm.active_group or
unbinding the group.  The subsequent panthor_vm_unmap_range() therefore
hits this path, fails with drm_WARN_ON(), and leaks the VM, its VMAs, page
tables, and mapped BOs.  In panthor_kernel_bo_destroy(), the failed unmap
is ignored while the VA range and backing pages are freed with the page
table mappings still present.

> +
> +int panthor_fw_protm_exit(struct panthor_device *ptdev, u32 timeout_ms)
> +{
> +	struct panthor_fw_global_iface *glb_iface =3D
> +		panthor_fw_get_glb_iface(ptdev);
> +
> +	/* Send PING request to force an exit */
> +	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
> +
> +	return panthor_fw_protm_exit_wait(ptdev, timeout_ms);
> +}

[Severity: Medium]
Can toggling GLB_PING here race with panthor_fw_ping_work() and trigger a
spurious GPU reset?

CPU0 (reset.wq)                   CPU1
panthor_fw_ping_work()
  panthor_fw_toggle_reqs(..., GLB_PING)
  panthor_fw_glb_wait_acks(..., GLB_PING, ...)
    req =3D READ_ONCE(*req_ptr) & GLB_PING
    /* MCU acks first ping: *ack_ptr =3D=3D req */
                                  panthor_fw_protm_exit()
                                    panthor_fw_toggle_reqs(..., GLB_PING)
                                    /* flips *req_ptr and MCU flips *ack_pt=
r */
    wait_event_timeout(..., (*ack_ptr & GLB_PING) =3D=3D req, ...)
      --> times out (-ETIMEDOUT)
  panthor_device_schedule_reset(ptdev)

panthor_fw_wait_acks() snapshots the expected GLB_PING bit in req before
sleeping on req_waitqueue.  If panthor_fw_protm_exit() toggles GLB_PING
again after the MCU acknowledges panthor_fw_ping_work()'s ping but before
panthor_fw_ping_work() wakes up and re-reads *ack_ptr, the ack bit is
flipped to the opposite polarity and panthor_fw_ping_work() times out and
schedules a reset.

> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index b8df5663f04e4..5fcfdba08deff 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c

[ ... ]

> @@ -431,6 +468,9 @@ int panthor_gpu_soft_reset(struct panthor_device *ptd=
ev)
>  		return -ETIMEDOUT;
>  	}
> =20
> +	atomic_set(&ptdev->gpu->protm_fault, 0);
> +	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_IRQ_PROTM_FAULT);
> +
>  	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
>  		ptdev->gpu->pending_reqs =3D 0;
>  	}

[Severity: High]
Does clearing protm_fault and re-enabling GPU_IRQ_PROTM_FAULT only in
panthor_gpu_soft_reset() leave protected mode permanently broken after a
fault on Arch v14 GPUs?

panthor_device_reset_work() calls panthor_hw_soft_reset(ptdev), which on
Arch v14 dispatches to panthor_pwr_reset_soft() rather than
panthor_gpu_soft_reset().  On those GPUs (and on v10-v13 if a pending
reset is coalesced into a suspend/resume cycle where fast suspend skips
panthor_hw_soft_reset()), ptdev->gpu->protm_fault stays 1 and
GPU_IRQ_PROTM_FAULT stays masked forever, causing
panthor_gpu_protm_fault_pending() to always return true and
sched_process_protm_exit_event_locked() to ignore all subsequent
GLB_PROTM_EXIT events.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 838753db95151..47e7d570683a6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -475,9 +554,10 @@ static void *alloc_pt(void *cookie, size_t size, gfp=
_t gfp)
> =20
>  		drm_WARN_ON(&vm->ptdev->base, vm->op_ctx);
>  		p =3D alloc_pages_node(dev_to_node(vm->ptdev->base.dev),
> -				     gfp | __GFP_ZERO, get_order(size));
> +				     gfp | __GFP_ZERO, get_order(size) * 2);
>  		page =3D p ? page_address(p) : NULL;
>  		vm->root_page_table =3D page;
> +		vm->empty_transtab_offset =3D size;
>  		return page;
>  	}

[Severity: Critical]
Doesn't get_order(size) * 2 evaluate to 0 when size is SZ_4K, allocating
only a single page while setting vm->empty_transtab_offset =3D size?

When size is PAGE_SIZE, get_order(size) is 0, so alloc_pages_node()
allocates one page, and cfg->arm_lpae_s1_cfg.ttbr +
vm->empty_transtab_offset in panthor_mmu_set_empty_pt() points one page
past the allocation into unrelated physical memory that the GPU MMU then
walks as its root page table.

In addition:
- free_pt() still calls free_pages((unsigned long)data, get_order(size)),
  which does not match a doubled allocation order (get_order(size) + 1).
- panthor_mmu_set_empty_pt() and handle_as_fault_locked() only write the
  lower 32 bits of AS_TRANSTAB via gpu_write() instead of gpu_write64(),
  which can truncate the address if ttbr + vm->empty_transtab_offset
  crosses a 4 GB boundary.
- On non-coherent devices (!ptdev->coherent), __arm_lpae_cfg_alloc() only
  DMA-maps/flushes the first size bytes of the root table, leaving the
  zeroed second half at empty_transtab_offset unflushed in CPU caches.

> @@ -1847,6 +1927,79 @@ static void panthor_vm_unlock_region(struct pantho=
r_vm *vm)
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  }
> =20
> +static bool handle_as_fault_locked(struct panthor_device *ptdev, u32 as)
> +{
> +	struct panthor_mmu *mmu =3D ptdev->mmu;
> +	struct panthor_vm *vm =3D mmu->as.slots[as].vm;
> +	struct io_pgtable_cfg *cfg;
> +	u64 actual_transtab;
> +	u32 empty_transtab_low;
> +	u32 cur_transtab_low;
> +	int ret;
> +
> +	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
> +
> +	if (!vm)
> +		return false;
> +
> +	cfg =3D &io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg;
> +	actual_transtab =3D cfg->arm_lpae_s1_cfg.ttbr;
> +	empty_transtab_low =3D (u32)(actual_transtab + vm->empty_transtab_offse=
t);
> +	cur_transtab_low =3D gpu_read(mmu->iomem, AS_TRANSTAB(as));
> +
> +	if (cur_transtab_low !=3D empty_transtab_low)
> +		return false;
> +
> +	gpu_write(mmu->iomem, AS_TRANSTAB(as), (u32)actual_transtab);
> +	ret =3D as_send_cmd_and_wait(ptdev, as, AS_COMMAND_UPDATE);
> +
> +	return ret ? false : true;
> +}

[Severity: High]
Can handle_as_fault_locked() restore actual_transtab while a dormant VM's
page tables are still being modified on another CPU?

CPU0                              CPU1 (MMU IRQ thread)
panthor_vm_exec_op(vm)
  /* holds vm->op_lock and
   * down_read(&sched->protm.lock) */
  protm_block_timeout(vm)
    panthor_mmu_set_empty_pt(vm)
      /* sets empty_transtab_low,
       * drops mmu->as.slots_lock */
  panthor_vm_lock_region(vm)
    /* AS_COMMAND_LOCK ignored in protm,
     * drops mmu->as.slots_lock */
  drm_gpuvm_sm_map() / sm_unmap()
    /* modifying actual_transtab */
                                  /* GPU finishes protm job, resumes
                                   * normal CSG on as, faults on
                                   * empty_transtab_low */
                                  panthor_mmu_irq_handler()
                                    mutex_lock(&mmu->as.slots_lock)
                                    handle_as_fault_locked()
                                      gpu_write(..., AS_TRANSTAB(as),
                                                actual_transtab)
                                      as_send_cmd_and_wait(...,
                                                AS_COMMAND_UPDATE)
                                      <-- MMU walks partially updated PTs

Holding sched->protm.lock in read mode does not stop the GPU from
completing its protected mode work and automatically resuming normal-mode
CSGs on other slots.  Because handle_as_fault_locked() only takes
mmu->as.slots_lock and does not synchronize with vm->op_lock, it can
switch AS_TRANSTAB(as) back to actual_transtab while the page table walk
structures are being modified in place without an active hardware region
lock.

Conversely, if the GPU already exited protected mode before
panthor_sched_protm_block_timeout() ran (before tick_work() cleared
sched->protm.active_group), panthor_mmu_set_empty_pt() installs
empty_transtab_low while in normal mode; if that VM then enters protected
mode before taking a normal-mode page fault, AS_TRANSTAB still points to
the empty table and triggers a fatal GPU_IRQ_PROTM_FAULT.

[ ... ]

> @@ -2563,12 +2680,55 @@ static struct panthor_vma *select_evicted_vma(str=
uct drm_gpuvm_bo *vm_bo,
>  	return first_evicted_vma;
>  }
> =20
> +static int remap_evicted_vma_locked(struct panthor_vm *vm,
> +				    struct panthor_vma *evicted_vma,
> +				    struct panthor_vm_op_ctx *op_ctx)
> +{
> +	struct panthor_gem_object *bo =3D
> +		to_panthor_bo(evicted_vma->base.gem.obj);
> +	int ret;
> +
> +	lockdep_assert_held(&vm->op_lock);
> +
> +	scoped_cond_guard(protm_block_timeout, ret =3D -ETIMEDOUT, vm)
> +	{
> +		vm->op_ctx =3D op_ctx;

[Severity: High]
While remap_evicted_vma_locked() blocks protected mode here, what protects
panthor_vm_evict_bo_mappings_locked() in the shrinker eviction path just
above?

drivers/gpu/drm/panthor/panthor_mmu.c:panthor_vm_evict_bo_mappings_locked()=
 {
    ...
			ret =3D panthor_vm_lock_region(vm, va->va.addr, va->va.range);
			if (ret)
				break;

			panthor_vm_unmap_pages(vm, va->va.addr, va->va.range);
			panthor_vm_unlock_region(vm);
			vma->evicted =3D true;
    ...
}

A VM whose BOs are being evicted can still hold an active AS slot
(vm->as.id >=3D 0), either on mmu->as.lru_list or bound to an idle CSG slot.
If eviction runs while the GPU is in protected mode, AS_COMMAND_LOCK, the
cache flush, and AS_COMMAND_UNLOCK are ignored by the MMU and
panthor_mmu_set_empty_pt() is never called, leaving stale GPU TLB entries
pointing to physical pages that panthor_gem_evict_locked() immediately
frees.  If eviction instead races with protected mode entry, the GPU can
enter protected mode with AS_COMMAND_LOCK still pending on that AS.

[ ... ]

> @@ -2716,39 +2857,42 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct =
panthor_vm_op_ctx *op,
>  	mutex_lock(&vm->op_lock);
>  	vm->op_ctx =3D op;
> =20
> -	ret =3D panthor_vm_lock_region(vm, op->va.addr, op->va.range);
> -	if (ret)
> -		goto out;
> -
> -	switch (op_type) {
> -	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
> -		const struct drm_gpuvm_map_req map_req =3D {
> -			.map.va.addr =3D op->va.addr,
> -			.map.va.range =3D op->va.range,
> -			.map.gem.obj =3D op->map.vm_bo->obj,
> -			.map.gem.offset =3D op->map.bo_offset,
> -		};
> -
> -		if (vm->unusable) {
> -			ret =3D -EINVAL;
> +	scoped_cond_guard(protm_block_timeout, ret =3D -ETIMEDOUT, vm) {
> +		ret =3D panthor_vm_lock_region(vm, op->va.addr, op->va.range);
> +		if (ret)
> +			goto out;

[Severity: Low]
This isn't a bug, but jumping out of scoped_cond_guard() with goto out
mixes cleanup helpers with goto-based error handling in the same function;
splitting out a locked helper like remap_evicted_vma_locked() would avoid
mixing the two styles.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index e67fd0fe20144..ca6aa6a55661a 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -307,6 +307,44 @@ struct panthor_scheduler {

[ ... ]

> +		/**
> +		 * @protm.active_group: The active protected group.
> +		 *
> +		 * We only allow one protected group to run at the same time,
> +		 * as it makes it easier to handle faults in protected mode.
> +		 *
> +		 * If the active_group member is set, then the scheduler
> +		 * believes the GPU is in protected mode. If not set, then the
> +		 * GPU is for sure not in normal mode.
> +		 */
> +		struct panthor_group *active_group;
> +	} protm;
>  };

[Severity: Low]
The last sentence of this comment says "not in normal mode" where "in
normal mode" (or "not in protected mode") was meant.

[ ... ]

> @@ -1983,6 +2083,66 @@ group_unbind_locked(struct panthor_group *group)
>  	return 0;
>  }
> =20
> +static void handle_protm_fault(struct panthor_device *ptdev)
> +{
> +	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +	u32 csg_id;
> +	struct panthor_group *protm_group;
> +
> +	protm_group =3D sched->protm.active_group;
> +
> +	if (!protm_group || !panthor_gpu_protm_fault_pending(ptdev))
> +		return;

[Severity: Medium]
What happens if a GPU reset is scheduled while in protected mode without
GPU_IRQ_PROTM_FAULT being raised, such as when panthor_fw_protm_exit()
times out during preemption in tick_work() or a protected job hits a queue
timeout?

Because panthor_gpu_protm_fault_pending(ptdev) is false,
handle_protm_fault() returns early without exiting protected mode or
unbinding CSGs.  panthor_sched_suspend() then issues CSG_STATE_SUSPEND
while the GPU is still stuck in protected mode, timing out and terminating
innocent normal-mode groups bound to the other CSG slots.

Conversely, when a fault raises both GPU_IRQ_PROTM_FAULT and
GLB_PROTM_EXIT, sched_process_protm_exit_event_locked() increments
protm_exit_count before returning.  If a queued tick_work() runs before
panthor_gpu_irq_handler() sets reset.pending, tick_work() sees
protm_exit_count =3D=3D protm_enter_count and clears sched->protm.active_gr=
oup
without checking panthor_gpu_protm_fault_pending(), so
handle_protm_fault() sees !protm_group and never marks
protm_group->fatal_queues.

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
> +	 */
> +	for (csg_id =3D 0; csg_id < sched->csg_slot_count; csg_id++) {
> +		struct panthor_group *group =3D sched->csg_slots[csg_id].group;
> +
> +		if (!group)
> +			continue;
> +
> +		group_get(group);
> +
> +		group->state =3D PANTHOR_CS_GROUP_SUSPENDED;
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

[Severity: High]
Isn't handle_protm_fault() calling group_unbind_locked() and modifying
sched->groups.idle and group->wait_node without holding sched->lock?

panthor_sched_pre_reset() calls handle_protm_fault() while holding only
sched->reset.lock, before panthor_sched_suspend() acquires sched->lock and
before panthor_group_stop() stops the per-queue scheduler workers.  This
trips lockdep_assert_held(&ptdev->scheduler->lock) inside
group_unbind_locked() and races with paths that only take sched->lock,
such as queue_run_job() (which can read queue->doorbell_id =3D=3D -1 after
group_unbind_locked() clears it and perform an out-of-bounds MMIO write in
panthor_fw_ring_doorbell()).

In addition, setting group->state =3D PANTHOR_CS_GROUP_SUSPENDED directly
from PANTHOR_CS_GROUP_ACTIVE skips cs_slot_reset_locked() and
queue_suspend_timeout(queue).  When panthor_group_stop() then calls
disable_delayed_work_sync(&queue->timeout.work) on the surviving groups,
queue->timeout.remaining stays at MAX_SCHEDULE_TIMEOUT, so
queue_resume_timeout() never restarts their job timeout timers after the
reset.

[ ... ]

> @@ -2292,6 +2474,55 @@ static void group_term_work(struct work_struct *wo=
rk)
>  	group_put(group);
>  }
> =20
> +enum protm_block_result
> +panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
> +				  struct panthor_vm *vm)
> +{
> +	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +	int ret;
> +
> +	if (!sched)
> +		return PROTM_BLOCK_NORMAL;
> +
> +	down_read(&sched->protm.lock);
> +
> +	if (!sched->protm.active_group)
> +		return PROTM_BLOCK_NORMAL; /* All good, we are in normal mode */
> +
> +	/* We will only exit protected mode for the passed vm and the MCU VM.
> +	 * Other VMs have no active CSG work, so MMU updates can proceed,
> +	 * although with special caution (delayed updates)!
> +	 */
> +	if (sched->protm.active_group->vm !=3D vm && !panthor_vm_for_mcu(vm))
> +		return PROTM_BLOCK_DORMANT; /* Specified VM can proceed, with caution.=
 */
> +
> +	/* Give GPU a chance to finish ongoing protm work by itself */
> +	ret =3D panthor_fw_protm_exit_wait(ptdev, 5);
> +	if (!ret)
> +		return PROTM_BLOCK_NORMAL; /* All good, we are back to normal mode */
> +
> +	/* We do not want this function to fail, because that can lead to
> +	 * innocent processes failing. That is why we wait up to 2x the job
> +	 * timeout for GPU to exit protm here. This shall cover the worst case
> +	 * where protm work hangs and we must rely on job timeout to recover.
> +	 */
> +	ret =3D panthor_fw_protm_exit(ptdev, JOB_TIMEOUT_MS << 1);
> +	if (ret)
> +		up_read(&sched->protm.lock);
> +
> +	return ret ? PROTM_BLOCK_ERROR : PROTM_BLOCK_NORMAL;
> +}

[Severity: Medium]
As reported by Boris Brezillon on v3 [1], waiting for protected mode exit
here while holding sched->protm.lock in read mode still races with GPU
reset.

If a thread is blocked in panthor_fw_protm_exit_wait() or
panthor_fw_protm_exit() (for example from a synchronous VM_BIND,
remap_evicted_vma_locked(), or a kernel BO map/unmap on the MCU VM) when
panthor_device_reset_work() runs, panthor_hw_soft_reset() clears
GPU_STATUS_PROTM_ACTIVE in GPU_STATUS before panthor_mmu_post_reset() and
panthor_sched_post_reset() execute.  panthor_fw_protm_exit_wait() then
sees GPU_STATUS_PROTM_ACTIVE cleared and returns 0 (PROTM_BLOCK_NORMAL)
mid-reset while vm->as.id is still set, allowing the caller to issue
AS_COMMAND_LOCK, cache flushes, and AS_COMMAND_UNLOCK concurrently with
panthor_hw_l2_power_on(), panthor_mmu_post_reset(), and
panthor_fw_post_reset() before panthor_sched_post_reset() can take
down_write(&sched->protm.lock).

[ ... ]

> @@ -2419,6 +2650,41 @@ tick_ctx_schedule_group(struct panthor_scheduler *=
sched,
>  	return 0;
>  }
> =20
> +static void
> +tick_ctx_handle_protm_group(struct panthor_scheduler *sched,
> +			    struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			    struct panthor_group *group)
> +{
> +	struct panthor_device *ptdev =3D sched->ptdev;
> +	struct panthor_fw_csg_iface *csg_iface =3D
> +		panthor_fw_get_csg_iface(ptdev, group->csg_id);
> +	u32 q;
> +
> +	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0))
> +		return;
> +
> +	guard(spinlock)(&sched->events_lock);
> +
> +	for (q =3D 0; q < group->queue_count; q++) {
> +		struct panthor_fw_cs_iface *cs_iface =3D
> +			panthor_fw_get_cs_iface(ptdev, group->csg_id, q);
> +
> +		/* Ack any pending CS_PROTM_PENDING so it can run in protm */
> +		if ((cs_iface->output->ack ^ cs_iface->input->req) &
> +		    CS_PROTM_PENDING)
> +			panthor_fw_update_reqs(cs_iface, req,
> +					       cs_iface->output->ack,
> +					       CS_PROTM_PENDING);
> +	}
> +
> +	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack,
> +			       GENMASK(group->queue_count - 1, 0));
> +
> +	csgs_upd_ctx_ring_doorbell(upd_ctx, group->csg_id);
> +
> +	atomic_set(&group->protm_pending_queues, 0);
> +}

[Severity: High]
What happens if a group that raised CS_PROTM_PENDING is suspended or
evicted before it can enter protected mode, and is later resumed as the
highest-priority group?

When the group is suspended, cs_slot_reset_locked() acknowledges
CS_PROTM_PENDING on cs_iface, but group->protm_pending_queues is never
cleared (unlike group->tiler_oom in group_unbind_locked()).  When the
suspended group is later picked first, tick_ctx_apply() calls
tick_ctx_handle_protm_group() before csgs_upd_ctx_apply_locked() sends
CSG_STATE_RESUME to the firmware.  Because the group has not been resumed
yet, CS_PROTM_PENDING is not asserted on the newly bound CS slot when
tick_ctx_handle_protm_group() checks it and clears
group->protm_pending_queues.  Once csgs_upd_ctx_apply_locked() resumes the
group and tick_ctx_apply() immediately calls panthor_fw_protm_enter(), the
firmware re-asserts CS_PROTM_PENDING unacknowledged and blocks the queue,
causing panthor_fw_protm_enter() to time out and trigger a GPU reset.

Also, panthor_fw_get_csg_iface(ptdev, group->csg_id) at the top of
tick_ctx_handle_protm_group() indexes ptdev->fw->iface.csgs[] with
group->csg_id before checking group->csg_id < 0.

> @@ -2488,6 +2754,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, str=
uct panthor_sched_tick_ctx *c
>  		}
>  	}
> =20
> +	if (ctx->protm_group)
> +		tick_ctx_handle_protm_group(sched, &upd_ctx, ctx->protm_group);
> +
>  	ret =3D csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
> @@ -2495,6 +2764,23 @@ tick_ctx_apply(struct panthor_scheduler *sched, st=
ruct panthor_sched_tick_ctx *c
>  		return;
>  	}
> =20
> +	if (ctx->protm_group) {
> +		down_write(&sched->protm.lock);
> +
> +		sched->protm.active_group =3D ctx->protm_group;
> +		group_get(sched->protm.active_group);
> +
> +		panthor_vm_protm_enter(ctx->protm_group->vm);

[Severity: High]
Can calling panthor_vm_protm_enter() while holding sched->protm.lock in
write mode ABBA deadlock with an asynchronous VM_BIND job on the same VM?

CPU0 (sched->wq)                  CPU1 (vm->sched.work_run_job)
----------------                  -----------------------------
down_write(&sched->protm.lock)
                                  /* inside dma_fence_begin_signalling() */
                                  down_read(&sched->protm.lock)
panthor_vm_protm_enter(vm)
  panthor_vm_stop(vm)
    drm_sched_stop(&vm->sched, NULL)
      cancel_work_sync(&vm->sched.work_run_job)

 *** DEADLOCK ***

CPU0: tick_work() -> tick_ctx_apply() -> panthor_vm_protm_enter()
CPU1: drm_sched_run_job_work() -> panthor_vm_bind_run_job() ->
      panthor_vm_exec_op() -> protm_block_timeout() ->
      panthor_sched_protm_block_timeout()

If vm->sched.work_run_job is already running when tick_ctx_apply() takes
down_write(&sched->protm.lock), panthor_vm_bind_run_job() blocks on
down_read(&sched->protm.lock) while drm_sched_stop() waits in
cancel_work_sync(&vm->sched.work_run_job) for it to finish.  Taking
sched->protm.lock inside panthor_vm_bind_run_job() also sleeps inside a
dma_fence_begin_signalling() critical section.

> +
> +		ret =3D panthor_fw_protm_enter(ptdev);
> +		if (ret) {
> +			panthor_device_schedule_reset(ptdev);
> +			ctx->csg_upd_failed_mask =3D U32_MAX;
> +		}
> +
> +		up_write(&sched->protm.lock);
> +	}

[Severity: Medium]
If panthor_fw_protm_enter() fails here, doesn't this leave
sched->protm.active_group set, its reference leaked, and the VM scheduler
stopped even though the GPU never entered protected mode?

Unlike the other failure paths in tick_ctx_apply(), this branch also falls
through instead of returning early, so ctx->groups[] and ctx->old_groups[]
are drained while tick_work() sees ctx.csg_upd_failed_mask !=3D 0 and jumps
over the pm_runtime_get() block without acquiring sched->pm.has_ref for
the newly bound CSG slots.

[ ... ]

> @@ -2552,6 +2838,38 @@ tick_ctx_update_resched_target(struct panthor_sche=
duler *sched,
>  	return U64_MAX;
>  }
> =20
> +static bool preempt_protm_group(struct panthor_group *group, bool full_t=
ick)
> +{
> +	struct panthor_device *ptdev =3D group->ptdev;
> +	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +	bool groups_waiting;
> +
> +	/* If the protm group can not run, then preempt! */
> +	if (!group_can_run(group))
> +		return true;
> +
> +	/* If we have RT groups waiting and we are not RT, then preempt! */
> +	groups_waiting =3D
> +		!list_empty(&sched->groups.runnable[PANTHOR_CSG_PRIORITY_RT]);
> +	if (groups_waiting && group->priority < PANTHOR_CSG_PRIORITY_RT)
> +		return true;
> +
> +	/* The below conditions for preempting are only valid for full ticks */
> +	if (!full_tick)
> +		return false;
> +
> +	for (int pri =3D PANTHOR_CSG_PRIORITY_RT - 1;
> +	     pri >=3D sched->protm.active_group->priority; pri--) {
> +		if (!list_empty(&sched->groups.runnable[pri])) {
> +			groups_waiting =3D true;
> +			break;
> +		}
> +	}
> +
> +	return groups_waiting;
> +
> +}

[Severity: High]
Does preempt_protm_group() miss runnable normal-mode groups that are
already bound to other CSG slots?

When a group enters protected mode, tick_work() still binds other runnable
and idle groups to the remaining CSG slots, and tick_ctx_apply() removes
those bound groups from sched->groups.runnable[].  While the GPU is in
protected mode, the hardware blocks normal-mode queues on those other CSG
slots from executing even though their per-queue drm_sched timeout timers
are running.  Because preempt_protm_group() only checks
sched->groups.runnable[] and never checks sched->csg_slots[] for non-idle
bound groups, it returns false on the next full tick when all runnable
groups fit in the CSG slots, and tick_update_resched_target(sched,
full_tick) stops the tick timer, starving the bound normal-mode groups
until their jobs time out and trigger a GPU reset.

[ ... ]

> @@ -3094,6 +3478,13 @@ void panthor_sched_post_reset(struct panthor_devic=
e *ptdev, bool reset_failed)
> =20
>  	mutex_lock(&sched->reset.lock);
> =20
> +	down_write(&sched->protm.lock);
> +	if (sched->protm.active_group) {
> +		group_put(sched->protm.active_group);
> +		sched->protm.active_group =3D NULL;
> +	}
> +	up_write(&sched->protm.lock);

[Severity: High]
What cleans up sched->protm.active_group and restarts its VM scheduler on
reset, suspend, and device unplug?

Here in panthor_sched_post_reset(), clearing sched->protm.active_group
does not call panthor_vm_protm_exit(sched->protm.active_group->vm),
leaving the VM's drm_gpu_scheduler permanently stopped after a reset.

Neither panthor_sched_unplug() nor panthor_sched_suspend() exits protected
mode or clears sched->protm.active_group either.  If the device is
unplugged while sched->protm.active_group is set, panthor_fw_unplug() ->
panthor_kernel_bo_destroy() unmaps the vmap backing glb_iface and then
calls panthor_vm_unmap_range(fw->vm, ...), which enters
panthor_sched_protm_block_timeout() -> panthor_fw_protm_exit() and
dereferences the already-unmapped glb_iface->input/output pointers, while
also leaking the active_group reference.  Likewise, if the device is
suspended while sched->protm.active_group is set, active_group remains
non-NULL while the GPU is powered off, so any VM operation on
active_group->vm while suspended calls panthor_fw_protm_exit_wait() ->
panthor_gpu_status() and reads MMIO with clocks disabled.

[1] https://lore.kernel.org/r/20260914150325.44150a29@fedora-21.home

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116112601.3483=
649-1-ketil.johnsen@arm.com?part=3D5
