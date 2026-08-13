Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A96C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DF910F2CB;
	Thu, 13 Aug 2026 11:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BuKlAFk6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F4510F2CB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:25:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCA2A600AD;
 Thu, 13 Aug 2026 11:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7BD1F00A3A;
 Thu, 13 Aug 2026 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786620350;
 bh=6bCfAdP6soZNSDgVI5JknasmWaAv6pykGABnhb977Js=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BuKlAFk6Qd4uUhH65TzOXgQBZe+GBugWT9u0BNkXAtfhgx+hEBMpeHslZ0SHNg9w2
 KnoLmfLWp3mOlPBUQtzTJZFPbp61lFsbVmHUHrxx7OAyVuB/iyg0/ax4RtIUxnHT7S
 TR0meadjn6C7OxyD8OhHfLsZt/VkjTPWXvzAwBt4d1Zy+9QInFh5RrnS95HSklwzD8
 Z0+e76yoI+gNh/orDw9Gn5xT1py6SDkobhrCaBugD+QySVnpEghQFyDKou0yDOpQIh
 tWRiLxpSWI1PLCb+zYfgP+m3QC0EPa+5V75gBjWooGz0LNyRuzvFXLzIQadqr5fZNk
 vFULBoCrFsx9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/17] drm/panthor: Fix the unplug logic
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-15-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-15-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:25:50 +0000
Message-Id: <20260813112550.7F7BD1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional memory leak of non-resident VMs (including page tabl=
es and mapped BOs) during device unplug.
- [High] Groups in the `waiting` list are skipped during scheduler unplug, =
leading to leaked jobs and list corruption.
- [High] The device's PM runtime usage counter is permanently elevated beca=
use the `put` operation was removed while the `get` was retained.
- [High] Kernel BOs (firmware sections) are unconditionally freed during un=
plug, bypassing the leak_active_resources mitigation and leading to hardwar=
e Use-After-Free.
--

--- Patch [15]: [PATCH v3 15/17] drm/panthor: Fix the unplug logic ---
commit ca8eb24c765a734575adb5e02e03ca868df2f058
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Fix the unplug logic

This commit resets the GPU before calling the component unplug functions,
drops unnecessary pm_get/put calls around sub-component unplugs, and attemp=
ts
to safely release resources at unplug time even if open FDs exist. It also
introduces a leak_active_resources flag to purposefully leak resources if t=
he
hardware cannot be successfully stopped.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> [ ... ]
> @@ -112,13 +148,6 @@ void panthor_device_unplug(struct panthor_device *pt=
dev)
>  	panthor_gpu_unplug(ptdev);
>  	panthor_pwr_unplug(ptdev);
> =20
> -	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> -	pm_runtime_put_sync_suspend(ptdev->base.dev);
> -
> -	/* If PM is disabled, we need to call the suspend handler manually. */
> -	if (!IS_ENABLED(CONFIG_PM))
> -		panthor_device_suspend(ptdev->base.dev);
> -
>  	/* Report the unplug operation as done to unblock concurrent
>  	 * panthor_device_unplug() callers.
>  	 */

[Severity: High]
Does this leave the PM runtime usage counter unbalanced?

The panthor_device_unplug() function retains the call to
pm_runtime_get_sync(ptdev->base.dev) earlier in this path, but this patch
removes the matching pm_runtime_put_sync_suspend() call here.

Could this permanent elevation of the usage counter prevent the device and
its parent power domains from entering low-power states?

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> [ ... ]
> @@ -1285,11 +1285,9 @@ void panthor_fw_unplug(struct panthor_device *ptde=
v)
> =20
>  	disable_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
> =20
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
> -		/* Make sure the IRQ handler cannot be called after that point. */
> +	/* Make sure the IRQ handler cannot be called after that point. */
> +	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
>  		panthor_job_irq_suspend(&ptdev->fw->irq);
> -		panthor_fw_stop(ptdev);
> -	}
> =20
>  	list_for_each_entry(section, &ptdev->fw->sections, node)
>  		panthor_kernel_bo_destroy(section->mem);

[Severity: High]
Should this check ptdev->unplug.leak_active_resources before destroying
the kernel buffer objects?

The commit message mentions leaking resources if the hardware cannot be
stopped, but panthor_fw_unplug() unconditionally destroys the firmware
sections here.

If the hardware soft-reset failed, destroying these buffer objects could
return physical memory to the OS allocator while the active GPU still
retains access, potentially causing memory corruption.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> [ ... ]
> @@ -2227,6 +2238,11 @@ static bool vm_prep_for_cleanup(struct panthor_vm =
*vm)
>  	}
> =20
>  	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> +		/* Device is gone, take the unplug lock to make sure
> +		 * panthor_device_stop_before_unplug() has run and
> +		 * ::leak_active_resources is valid.
> +		 */
> +		guard(mutex)(&ptdev->unplug.lock);
>  		guard(mutex)(&ptdev->mmu->as.slots_lock);
> =20
>  		/* If we're still on slot after an unplug, it means
>  		 * drm_dev_unplug() has returned but the part in
>  		 * panthor_mmu_unplug() that evicts all resident AS has
>  		 * not been executed yet. In that case, we simply queue
>  		 * the VM to the cleanup list and wait for
>  		 * panthor_mmu_unplug() to do its job.
>  		 */
>  		if (as->hw_slot.id >=3D 0) {
>  			list_add_tail(&vm->node, &ptdev->mmu->as.cleanup_list);
>  			return false;
>  		}
> =20
>  		return true;
>  	}

[Severity: High]
When drm_dev_enter() fails during an unplug, this path returns true for
non-resident VMs without clearing the PANTHOR_AS_FORBID_UNMAP restriction.

Since panthor_mmu_freeze_before_unplug() applies this restriction to all
VMs earlier in the unplug sequence, leaving it set forces unmap operations
to fail or skip.

Could this cause an unconditional memory leak of the non-resident VMs,
their page tables, and mapped buffer objects?

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> [ ... ]
> @@ -4081,23 +4105,76 @@ void panthor_job_update_resvs(struct drm_exec *ex=
ec, struct drm_sched_job *sched
>  void panthor_sched_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_scheduler *sched =3D ptdev->scheduler;
> +	struct panthor_group *group, *tmp_group;
> +	LIST_HEAD(groups);
> =20
>  	disable_delayed_work_sync(&sched->tick_work);
>  	disable_work_sync(&sched->fw_events_work);
>  	disable_work_sync(&sched->sync_upd_work);
> =20
>  	mutex_lock(&sched->lock);
> [ ... ]
> +	/* Now take care of the non-resident groups. */
> +	for (u32 i =3D 0; i < ARRAY_SIZE(sched->groups.runnable); i++)
> +		list_splice_init(&sched->groups.runnable[i], &groups);
> +
> +	for (u32 i =3D 0; i < ARRAY_SIZE(sched->groups.idle); i++)
> +		list_splice_init(&sched->groups.idle[i], &groups);
> +
> +	list_for_each_entry_safe(group, tmp_group, &groups, run_node) {
> +		list_del_init(&group->run_node);
> +		list_del_init(&group->wait_node);
> +		group_queue_work(group, term);
> +	}

[Severity: High]
Does this skip the groups currently waiting on synchronization objects?

The logic splices the sched->groups.runnable and sched->groups.idle
lists to terminate them, but it appears to entirely omit the
sched->groups.waiting list.

It seems any groups in the waiting list at the time of unplug will be
stranded here, leading to a memory leak and a later WARN_ON during
scheduler teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D15
