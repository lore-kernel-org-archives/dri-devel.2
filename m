Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBDCC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1761A10F6C0;
	Fri, 11 Sep 2026 19:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="huJt7u+p";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC17610F6C0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789154116; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GHO+LWge46f1C/h2K2izRaDOFWh6A9wcgSwcDq+9BInZm3K1bvS3T/Z3xB06cUT9MxANAv6tJ259rUXWBs6At+GVz1LWMeJ/Dxwd1WaXQ5FKBu2hUw4hS9gADqFB/ynAaoDcXAGJ9q3DFexjMVbYOlp8hok5HXpDmLx3pGO9vdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789154116;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8GOqYwu7Av7pSfjPDhidMs9hHjsGQVaguMNs88c905c=; 
 b=k3VcvKeEXHwtNKeY76Xj/oGPaTCirnpBDmVVLzgxNbyoSd45uaUXwGzgbNwMOQYdouCtlvXHa64fLDe9deseHe/x5AOrgogPOAFdw/CBXnAPLy0VIYIHduL+R9XVNrhMSru7Xyr9X7UrnSmNaEgwUlmtccWWDNEPMSKQCOTRkc4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789154116; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=8GOqYwu7Av7pSfjPDhidMs9hHjsGQVaguMNs88c905c=;
 b=huJt7u+p+nGvS0i4cZx6lsonbb/2aAl9bvuMgJ5rogLXZloZaUwEu6PonfR7qwZH
 CN2ZcYn7Azi5J1NydODVKv/cwY0kCF/vQROVjXs447w6VeBBQFEcsg3prB+SK+go2L+
 k2SyBRYJX9x2n8Ko7vmB9l316m8luj4EGri75ZOc=
Received: by mx.zohomail.com with SMTPS id 1789154115230569.3363674477455;
 Fri, 11 Sep 2026 12:15:15 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:15:11 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/18] drm/panthor: Make the VM cleanup path more
 robust against UAF
Message-ID: <aqRKIArC82Q9sl2p@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-14-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-14-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 26.08.2026 16:56, Boris Brezillon wrote:
> The VM cleanup logic tries to gracefully evict the page table from its
> AS slot to make sure the HW doesn't have access to the memory anymore.
> But it might happen that the eviction fails because the HW hung, and
> in that case, we have no guarantee that the HW won't access the memory
> until we've properly reset the GPU.
> 
> Defer the cleanup of VMs after the reset is effective when this situation
> happens.
> 
> Note that this introduces a leak if the VM is released while being
> assigned an AS slot and the device was unplugged, because we don't
> clear the FORBID_UNMAP restriction in that case. It's just one more
> issue in an ocean of unplug bugs. These unplug issues will be addressed
> in an upcoming commit.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |   6 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c    | 308 +++++++++++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu.h    |   3 +-
>  3 files changed, 239 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 19d3669f5ec7..817312f598f3 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -522,9 +522,10 @@ static int panthor_device_resume_hw_components(struct panthor_device *ptdev)
>  	if (!ret)
>  		return 0;
>  
> -	panthor_mmu_suspend(ptdev);
> +	panthor_mmu_pre_suspend(ptdev);
>  	panthor_gpu_suspend(ptdev);
>  	panthor_pwr_suspend(ptdev);
> +	panthor_mmu_post_suspend(ptdev);
>  	return ret;
>  }
>  
> @@ -645,9 +646,10 @@ int panthor_device_suspend(struct device *dev)
>  		 */
>  		panthor_sched_suspend(ptdev);
>  		panthor_fw_suspend(ptdev);
> -		panthor_mmu_suspend(ptdev);
> +		panthor_mmu_pre_suspend(ptdev);
>  		panthor_gpu_suspend(ptdev);
>  		panthor_pwr_suspend(ptdev);
> +		panthor_mmu_post_suspend(ptdev);
>  		drm_dev_exit(cookie);
>  	}
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 11a9bbe87986..47c57b39bd12 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -102,6 +102,17 @@ struct panthor_mmu {
>  		 * TLB/cache flushes.
>  		 */
>  		struct list_head lru_list;
> +
> +		/**
> +		 * @cleanup_list: List containing VMs waiting for cleanup.
> +		 *
> +		 * This list is used to keep track of VMs that got released but
> +		 * couldn't be evicted from their AS slot because the HW hanged.
> +		 * In that case, we add the VM to the list, and wait for the next
> +		 * post_reset, at which point we're sure the HW is idle and the
> +		 * VM resources can go away.
> +		 */
> +		struct list_head cleanup_list;
>  	} as;
>  
>  	/** @vm: VMs management fields */
> @@ -117,6 +128,12 @@ struct panthor_mmu {
>  
>  		/** @vm.wq: Workqueue used for the VM_BIND queues. */
>  		struct workqueue_struct *wq;
> +
> +		/**
> +		 * @vm.cleanup_work: Used to cleanup the VMs that are in
> +		 * panthor_mmu::as::cleanup_list.
> +		 */
> +		struct work_struct cleanup_work;
>  	} vm;
>  };
>  
> @@ -1994,7 +2011,7 @@ static irqreturn_t panthor_mmu_irq_threaded_handler(int irq, void *data)
>  }
>  
>  /**
> - * panthor_mmu_suspend() - Suspend the MMU logic
> + * panthor_mmu_pre_suspend() - Prepare the MMU block for a suspend
>   * @ptdev: Device.
>   *
>   * All we do here is de-assign the AS slots on all active VMs, so things
> @@ -2003,16 +2020,27 @@ static irqreturn_t panthor_mmu_irq_threaded_handler(int irq, void *data)
>   *
>   * We also suspend the MMU IRQ.
>   */
> -void panthor_mmu_suspend(struct panthor_device *ptdev)
> +void panthor_mmu_pre_suspend(struct panthor_device *ptdev)
>  {
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
>  		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
> +		int ret;
>  
> -		if (as) {
> -			drm_WARN_ON(&ptdev->base,
> -				    panthor_mmu_as_disable(ptdev, i, false));
> +		if (!as)
> +			continue;
> +
> +		/* If the disable fails, leave the AS on its slot so we can
> +		 * properly evict it when we're sure the GPU is off.
> +		 */
> +		ret = panthor_mmu_as_disable(ptdev, i, false);
> +		if (!ret) {
>  			panthor_as_release_hw_slot_locked(as);
> +		} else {
> +			atomic_or(PANTHOR_AS_FORBID_USE |
> +				  PANTHOR_AS_FORBID_MAP |
> +				  PANTHOR_AS_FORBID_UNMAP,
> +				  &as->restrictions);
>  		}
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> @@ -2020,6 +2048,35 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
>  	panthor_irq_suspend(&ptdev->mmu->irq);
>  }
>  
> +static void mmu_post_reset_cleanup(struct panthor_device *ptdev)
> +{
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	/* Now that the reset is effective, we can assume that none of the
> +	 * AS slots are setup, and clear the faulty flags too.
> +	 */
> +	ptdev->mmu->as.alloc_mask = 0;
> +	ptdev->mmu->as.faulty_mask = 0;
> +
> +	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> +		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
> +
> +		if (!as)
> +			continue;
> +
> +		panthor_as_release_hw_slot_locked(as);
> +		atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
> +	}
> +
> +	if (!list_empty(&ptdev->mmu->as.cleanup_list))
> +		queue_work(ptdev->cleanup_wq, &ptdev->mmu->vm.cleanup_work);
> +}
> +
> +void panthor_mmu_post_suspend(struct panthor_device *ptdev)
> +{
> +	mmu_post_reset_cleanup(ptdev);
> +}
> +
>  /**
>   * panthor_mmu_resume() - Resume the MMU logic
>   * @ptdev: Device.
> @@ -2031,11 +2088,7 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
>   */
>  void panthor_mmu_resume(struct panthor_device *ptdev)
>  {
> -	mutex_lock(&ptdev->mmu->as.slots_lock);
> -	ptdev->mmu->as.alloc_mask = 0;
> -	ptdev->mmu->as.faulty_mask = 0;
> -	mutex_unlock(&ptdev->mmu->as.slots_lock);
> -
> +	mmu_post_reset_cleanup(ptdev);
>  	panthor_irq_resume(&ptdev->mmu->irq);
>  }
>  
> @@ -2073,22 +2126,7 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
>  {
>  	struct panthor_vm *vm;
>  
> -	mutex_lock(&ptdev->mmu->as.slots_lock);
> -
> -	/* Now that the reset is effective, we can assume that none of the
> -	 * AS slots are setup, and clear the faulty flags too.
> -	 */
> -	ptdev->mmu->as.alloc_mask = 0;
> -	ptdev->mmu->as.faulty_mask = 0;
> -
> -	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> -		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
> -
> -		if (as)
> -			panthor_as_release_hw_slot_locked(as);
> -	}
> -
> -	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +	mmu_post_reset_cleanup(ptdev);
>  
>  	panthor_irq_resume(&ptdev->mmu->irq);
>  
> @@ -2101,59 +2139,41 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
>  	mutex_unlock(&ptdev->mmu->vm.lock);
>  }
>  
> -static void panthor_vm_release(struct kref *kref)
> +static void vm_cleanup(struct panthor_vm *vm)
>  {
> -	struct panthor_vm *vm = container_of(kref, struct panthor_vm, refcount);
>  	struct panthor_as *as = vm->as;
>  	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
>  
> -	/* Make sure the page table behind this VM doesn't participate in reclaim
> -	 * after that point, since we're about to release everything anyway.
> +	if (!(atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP)) {
> +		/* Unmap everything in case some BOs were still mapped. */
> +		drm_WARN_ON(&ptdev->base,
> +			    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
> +	}
> +
> +	/* It's safe to destroy the heaps and return the dummy BO even if
> +	 * the FORBID_UNMAP restriction stands because this BO will be retained
> +	 * by the drm_gpuvm_bo held by the active drm_gpuva entries, which
> +	 * were preserved because the panthor_vm_unmap_range() was skipped.
> +	 * The drm_gpuvm object itself is retained by the live drm_gpuvas
> +	 * living there. So this is one of the rare occasions where we actually
> +	 * want the circular referencing to silently leak objects.
> +	 * Another side effect of this is that the drm_device is retained too,
> +	 * because drm_gpuvm holds a ref on this object. This is okay, because
> +	 * drm_dev_unregister() makes sure this device is no longer exposed
> +	 * to userspace, so it's basically a zombie drm_device.
> +	 *
> +	 * TLDR; the memory a rogue GPU might have its hands on is leaked,
> +	 * even though we explicitly destroy the objects owning these resources.
>  	 */
> -	mutex_lock(&ptdev->base.gem_lru_mutex);
> -	as->reclaim.skip = true;
> -	list_del_init(&as->reclaim.lru_node);
> -	mutex_unlock(&ptdev->base.gem_lru_mutex);
> -
> -	/* Unmap everything in case some BOs were still mapped. */
> -	drm_WARN_ON(&ptdev->base,
> -		    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
> -
> -	mutex_lock(&vm->heaps.lock);
> -	if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
> -		panthor_heap_pool_destroy(vm->heaps.pool);
> -	mutex_unlock(&vm->heaps.lock);
> +	scoped_guard(mutex, &vm->heaps.lock) {
> +		if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
> +			panthor_heap_pool_destroy(vm->heaps.pool);
> +	}
>  	mutex_destroy(&vm->heaps.lock);
>  
> -	mutex_lock(&ptdev->mmu->vm.lock);
> -	list_del(&vm->node);
> -	/* Restore the scheduler state so we can call drm_sched_entity_destroy()
> -	 * and drm_sched_fini(). If get there, that means we have no job left
> -	 * and no new jobs can be queued, so we can start the scheduler without
> -	 * risking interfering with the reset.
> -	 */
> -	if (ptdev->mmu->vm.reset_in_progress)
> -		panthor_vm_start(vm);
> -	mutex_unlock(&ptdev->mmu->vm.lock);
> -
>  	drm_sched_entity_destroy(&vm->entity);
>  	drm_sched_fini(&vm->sched);
>  
> -	mutex_lock(&vm->as->op_lock);
> -	mutex_lock(&ptdev->mmu->as.slots_lock);
> -	if (as->hw_slot.id >= 0) {
> -		int cookie;
> -
> -		if (drm_dev_enter(&ptdev->base, &cookie)) {
> -			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
> -			drm_dev_exit(cookie);
> -		}
> -
> -		panthor_as_release_hw_slot_locked(as);
> -	}
> -	mutex_unlock(&ptdev->mmu->as.slots_lock);
> -	mutex_unlock(&vm->as->op_lock);
> -
>  	if (vm->dummy)
>  		drm_gem_object_put(&vm->dummy->base);
>  
> @@ -2162,6 +2182,98 @@ static void panthor_vm_release(struct kref *kref)
>  	kfree(vm);
>  }
>  
> +static bool vm_prep_for_cleanup(struct panthor_vm *vm)
> +{
> +	struct panthor_as *as = vm->as;
> +	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
> +	bool ready_for_cleanup;
> +	int cookie, ret;
> +
> +	/* First we forbid any kind of use on the VM that's about to be
> +	 * released. UNMAP will be restored later if we manage to evict
> +	 * the page table from its AS slot.
> +	 */
> +	atomic_or(PANTHOR_AS_FORBID_USE |
> +		  PANTHOR_AS_FORBID_MAP |
> +		  PANTHOR_AS_FORBID_UNMAP,
> +		  &vm->as->restrictions);
> +
> +	/* Make sure the page table behind this VM doesn't participate in reclaim
> +	 * after that point, since we're about to release everything anyway.
> +	 */
> +	scoped_guard(mutex, &ptdev->base.gem_lru_mutex) {
> +		as->reclaim.skip = true;
> +		list_del_init(&as->reclaim.lru_node);
> +	}
> +
> +	scoped_guard(mutex, &ptdev->mmu->vm.lock) {
> +		/* Remove the VM from the list early, so it can't be seen by the VM list
> +		 * walkers after that point.
> +		 */
> +		list_del(&vm->node);
> +
> +		/* Restore the scheduler state so we can call drm_sched_entity_destroy()
> +		 * and drm_sched_fini(). If get there, that means we have no job left
> +		 * and no new jobs can be queued, so we can start the scheduler without
> +		 * risking interfering with the reset.
> +		 */
> +		if (ptdev->mmu->vm.reset_in_progress)
> +			panthor_vm_start(vm);
> +	}
> +
> +	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> +		guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +		/* If we're still on a slot after an unplug, it means
> +		 * drm_dev_unplug() has returned but the part in
> +		 * panthor_mmu_unplug() that evicts all resident AS has
> +		 * not been executed yet. In that case, we simply queue
> +		 * the VM to the cleanup list and wait for
> +		 * panthor_mmu_unplug() to do its job.
> +		 */
> +		if (as->hw_slot.id >= 0) {
> +			list_add_tail(&vm->node, &ptdev->mmu->as.cleanup_list);
> +			return false;
> +		}
> +
> +		/* If the page table is not resident, we can drop the
> +		 * FORBID_UNMAP restriction.
> +		 */
> +		atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
> +		return true;
> +	}
> +
> +	scoped_guard(mutex, &ptdev->mmu->as.slots_lock) {
> +		if (as->hw_slot.id >= 0) {
> +			ret = panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
> +			if (!ret) {
> +				panthor_as_release_hw_slot_locked(as);
> +			} else {
> +				list_add_tail(&vm->node, &ptdev->mmu->as.cleanup_list);
> +				panthor_device_schedule_reset(ptdev);
> +			}
> +		}
> +
> +		/* Page table is no longer resident, we can relax the no-unmap
> +		 * restriction.
> +		 */

Nit: I guess page table is only no longer resident if panthor_mmu_as_disable() succeeds. 

> +		ready_for_cleanup = as->hw_slot.id < 0;
> +		if (ready_for_cleanup)
> +			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
> +	}
> +
> +	drm_dev_exit(cookie);
> +	return ready_for_cleanup;
> +}
> +
> +static void panthor_vm_release(struct kref *kref)
> +{
> +	struct panthor_vm *vm = container_of(kref, struct panthor_vm, refcount);
> +
> +	if (vm_prep_for_cleanup(vm))
> +		vm_cleanup(vm);
> +}
> +
>  /**
>   * panthor_vm_put() - Release a reference on a VM
>   * @vm: VM to release the reference on. Can be NULL.
> @@ -2785,7 +2897,11 @@ static void panthor_as_free(struct drm_gpuvm *gpuvm)
>  {
>  	struct panthor_as *as = container_of(gpuvm, struct panthor_as, base);
>  
> -	if (as->pt.ops)
> +	/* If we get to that point and we're still not allowed to unmap,
> +	 * this means the HW is still running and has a access to the page
> +	 * table, so we just leak it to avoid UAF.
> +	 */
> +	if (as->pt.ops && !(atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP))
>  		free_io_pgtable_ops(as->pt.ops);
>  
>  	mutex_destroy(&as->op_lock);
> @@ -3493,15 +3609,34 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
>  		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
> +		int ret;
>  
> -		if (as) {
> -			drm_WARN_ON(&ptdev->base,
> -				    panthor_mmu_as_disable(ptdev, i, false));
> -			panthor_as_release_hw_slot_locked(as);
> -		}
> +		if (!as)
> +			continue;
> +
> +		ret = panthor_mmu_as_disable(ptdev, i, false);
> +		drm_WARN_ON(&ptdev->base, ret);
> +
> +		/* Drop the unmap restriction if the disabled worked, so we
> +		 * don't leak resources in the normal situation.
> +		 */
> +		if (!ret)
> +			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
> +
> +		panthor_as_release_hw_slot_locked(as);
>  	}
> +
> +	if (!list_empty(&ptdev->mmu->as.cleanup_list))
> +		queue_work(ptdev->cleanup_wq, &ptdev->mmu->vm.cleanup_work);
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> +	/* Make sure pending VM cleanups are processed before leaving. Those
> +	 * cleanups might schedule vm_bind_job cleanups, so keep this
> +	 * flush_work() before the final flush_workqueue(panthor_cleanup_wq).
> +	 */
> +	flush_work(&ptdev->mmu->vm.cleanup_work);
> +	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->as.cleanup_list));
> +
>  	/* Ensure any pending job cleanup work are executed before returning,
>  	 * otherwise those might access objects that are gone if the work is
>  	 * executed after other components are unplugged.
> @@ -3519,6 +3654,27 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
>  	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
>  }
>  
> +static void mmu_cleanup_vms_work(struct work_struct *work)
> +{
> +	struct panthor_mmu *mmu =
> +		container_of(work, struct panthor_mmu, vm.cleanup_work);
> +	struct panthor_vm *vm, *tmp;
> +	LIST_HEAD(cleanup_list);
> +
> +	/* Collect the VMs to cleanup first. */
> +	scoped_guard(mutex, &mmu->as.slots_lock) {
> +		list_for_each_entry_safe(vm, tmp, &mmu->as.cleanup_list, node) {
> +			if (vm->as->hw_slot.id < 0)
> +				list_move_tail(&vm->node, &cleanup_list);
> +		}
> +	}
> +
> +	list_for_each_entry_safe(vm, tmp, &cleanup_list, node) {
> +		list_del(&vm->node);
> +		vm_cleanup(vm);
> +	}
> +}
> +
>  static void free_pt_cache(struct drm_device *, void *pt_cache)
>  {
>  	kmem_cache_destroy(pt_cache);
> @@ -3542,7 +3698,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (!mmu)
>  		return -ENOMEM;
>  
> +	INIT_WORK(&mmu->vm.cleanup_work, mmu_cleanup_vms_work);
>  	INIT_LIST_HEAD(&mmu->as.lru_list);
> +	INIT_LIST_HEAD(&mmu->as.cleanup_list);
>  
>  	ret = drmm_mutex_init(&ptdev->base, &mmu->as.slots_lock);
>  	if (ret)
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index de6b4ee4e41a..1ee5958569b6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -21,7 +21,8 @@ int panthor_mmu_init(struct panthor_device *ptdev);
>  void panthor_mmu_unplug(struct panthor_device *ptdev);
>  void panthor_mmu_pre_reset(struct panthor_device *ptdev);
>  void panthor_mmu_post_reset(struct panthor_device *ptdev);
> -void panthor_mmu_suspend(struct panthor_device *ptdev);
> +void panthor_mmu_pre_suspend(struct panthor_device *ptdev);
> +void panthor_mmu_post_suspend(struct panthor_device *ptdev);
>  void panthor_mmu_resume(struct panthor_device *ptdev);
>  
>  int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo,
> 
> -- 
> 2.55.0

Adrian Larumbe
