Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7BAC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D673610EB10;
	Tue,  4 Aug 2026 15:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RW+7EDX4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A33F10EB1A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:53:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98A55413D7;
 Tue,  4 Aug 2026 15:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD261F000E9;
 Tue,  4 Aug 2026 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785858806;
 bh=dKvZ0jCAXBIdYrSKfdFFZMMu0UGdd6cOIf4n47oKdWo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RW+7EDX4tp4X+A41N2g9LnZtIgyuDTIQjd5kXTh82+K8aOWqT6w3bH5ibNKnuNtGn
 9S2dKrkOrETimPMNltyBLaDsZ9VrjVFFJtxlOM+uv9D+ATAXLQkLYhMMsZ7nnYVSsV
 LofqouGRpeQoRVT1IFCSJ32uNaFk0Zg9TiNIVf3iMnO1l9bsxKInZmdgh5AVSsj2+H
 P6b1+4fZjrdJcMAbchXQ7xjWaZLdsQhUyPSO/OnqzOLB/En+92z0VuobMn7Cx6IyIj
 gVcq3qyH8lNXxY0UX3VQ7dqdpeTuHBOIzOJ9pzCvWk9Og5slGFOb7d6NaX5F/5zsH+
 yokoyClMmmaxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] drm/panthor: Make the unplug logic more robust
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-11-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-11-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:53:25 +0000
Message-Id: <20260804155326.5BD261F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The core clock reference is leaked on the success and fake_failure=
 paths of panthor_device_stop_before_unplug().
- [High] Unplug logic fails to terminate off-slot scheduling groups, leavin=
g jobs and fences hanging indefinitely.
- [High] Asynchronous group termination races with firmware unplug, permane=
ntly leaking pinned GEM objects.

Pre-existing issues:
- [High] The shrinker bypasses `PANTHOR_AS_FORBID_UNMAP`, evicting and free=
ing 'leaked' active resources which causes the UAF the patch aims to preven=
t.
- [High] AB-BA deadlock between `drm_unplug_srcu` (acquired via `drm_dev_en=
ter`) and `reset.work` during device suspend.
--

--- Patch [11]: [PATCH 11/12] drm/panthor: Make the unplug logic more robus=
t ---
commit 00e9b89b77965cd7d42b1e5031831cc0e8151ebf
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Make the unplug logic more robust

This patch modifies the unplug logic to first reset the GPU before calling
component unplug functions, ensuring hardware is stopped. It changes unplug
implementations to avoid touching the hardware and adds a mechanism to leak
resources if the hardware fails to reset, preventing Use-After-Free bugs.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index b7c55a6f4f081..425990369b999 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -62,8 +63,40 @@ static int panthor_init_power(struct device *dev)
>  	return devm_pm_domain_attach_list(dev, NULL, &pd_list);
>  }
> =20
> +static int panthor_device_stop_before_unplug(struct panthor_device *ptde=
v)
> +{
> +	int ret;
> +
> +	/* Make sure any further modification to the existing VMs are blocked
> +	 * before proceeding with the SOFT_RESET.
> +	 */
> +	panthor_mmu_freeze_before_unplug(ptdev);
> +
> +	/* Core clock should be enough to issue a reset. */
> +	ret =3D clk_prepare_enable(ptdev->clks.core);
> +	if (ret)
> +		return ret;
> +
> +	/* A successful soft-reset should guarantee that all components of the
> +	 * HW are off, meaning we can proceed with the rest of the unplug
> +	 * procedure.
> +	 */
> +	ret =3D panthor_hw_soft_reset(ptdev);
> +	if (ret)
> +		goto err_disable_core_clk;
> +
> +	return ptdev->unplug.fake_failure ? -EIO : 0;

[Severity: High]
Does this code leak the core clock reference?

If panthor_hw_soft_reset() succeeds, or if ptdev->unplug.fake_failure is se=
t,
the function returns directly without disabling the clock. Should this path=
 call
clk_disable_unprepare() before returning?

> +
> +
> +err_disable_core_clk:
> +	clk_disable_unprepare(ptdev->clks.core);
> +	return ret;
> +}
> +
>  void panthor_device_unplug(struct panthor_device *ptdev)
>  {
> +	int ret;
> +
>  	/* This function can be called from two different path: the reset work
>  	 * and the platform device remove callback. drm_dev_unplug() doesn't
>  	 * deal with concurrent callers, so we have to protect drm_dev_unplug()
> @@ -90,6 +123,16 @@ void panthor_device_unplug(struct panthor_device *ptd=
ev)
>  	/* Make sure we're not interrupted by resets while we're unplugging. */
>  	disable_work_sync(&ptdev->reset.work);

[Severity: High]
This is a pre-existing issue, but can this lead to an AB-BA deadlock with
device suspend?

In panthor_device_suspend(), the SRCU read lock is acquired via
drm_dev_enter() before blocking to wait for the reset work:

    cancel_work_sync(&ptdev->reset.work);

Concurrently, if the reset work fails, it calls panthor_device_unplug(),
which triggers drm_dev_unplug(). drm_dev_unplug() attempts to synchronize
the SRCU by waiting for all readers to exit. Since panthor_device_suspend()
is holding the read lock while waiting for reset.work to complete, the
system will permanently deadlock.

[ ... ]
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index fc1a423e48a8b..8d9fdc3202a1a 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
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
> @@ -1301,9 +1299,6 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  	 */
>  	panthor_vm_put(ptdev->fw->vm);
>  	ptdev->fw->vm =3D NULL;

[Severity: High]
Does this code race with asynchronous group termination and leak pinned
GEM objects?

panthor_sched_unplug() queues the term_work asynchronously, but does not
flush the workqueue. Then panthor_fw_unplug() immediately clears
ptdev->fw->vm. When the group is eventually released asynchronously,
panthor_kernel_bo_destroy() executes and checks:

    if (vm =3D=3D panthor_fw_vm(ptdev))
        panthor_gem_unpin(to_panthor_bo(bo->obj));

Since the firmware VM pointer is already NULL, this check will fail,
permanently leaking the pinned GEM objects. Should the workqueue be flushed
before the firmware VM is cleared?

> -
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_hw_l2_power_off(ptdev);
>  }
> =20
[ ... ]
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index de242ff124ed5..9252a279a47bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
[ ... ]
> @@ -3538,6 +3550,27 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device=
 *ptdev,
>  	return freed;
>  }
> =20
> +void panthor_mmu_freeze_before_unplug(struct panthor_device *ptdev)
> +{
> +	struct panthor_vm *vm;
> +
> +	guard(mutex)(&ptdev->mmu->vm.lock);
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +	list_for_each_entry(vm, &ptdev->mmu->vm.list, node) {
> +		/* We intentionally don't use panthor_vm_restrict_usage_locked() here
> +		 * because we don't want the AS eviction to happen, otherwise we
> +		 * won't be able to know which VMs were active at the time the
> +		 * unplug happened. Unmap is forbidden to make sure any modification
> +		 * to the VM is blocked after that point. This way, if the reset
> +		 * fails, we're able to flag VMs that need to leak their resources.
> +		 */
> +		atomic_or(PANTHOR_AS_FORBID_USE |
> +			  PANTHOR_AS_FORBID_MAP |
> +			  PANTHOR_AS_FORBID_UNMAP,
> +			  &vm->as->restrictions);
> +	}
> +}

[Severity: High]
This is a pre-existing issue, but can the shrinker bypass this restriction =
and
free active resources?

This patch sets PANTHOR_AS_FORBID_UNMAP to intentionally leak resources if
the GPU fails to reset. However, if the system triggers memory reclaim,
panthor_gem_try_evict_no_resv_wait() will call
panthor_vm_evict_bo_mappings_locked(), which directly executes:

    panthor_as_unmap_pages(as, va->va.addr, va->va.range);

This unmaps and frees the pages without checking the restriction flags,
leading to the exact Use-After-Free condition this patch aims to prevent.

[ ... ]
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5832dccfc0932..adc2c05251e90 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -4069,6 +4069,23 @@ void panthor_sched_unplug(struct panthor_device *p=
tdev)
>  	disable_work_sync(&sched->sync_upd_work);
> =20
>  	mutex_lock(&sched->lock);
> +
> +	/* Do a pass on the on-slot groups, and schedule termination. */
> +	for (u32 i =3D 0; i < sched->csg_slot_count; i++) {
> +		struct panthor_csg_slot *csg_slot =3D &sched->csg_slots[i];
> +		struct panthor_group *group =3D csg_slot->group;
> +
> +		if (!group)
> +			continue;
> +
> +		group_get(group);
> +		group->state =3D PANTHOR_CS_GROUP_TERMINATED;
> +		group_unbind_locked(group);
> +		list_del_init(&group->wait_node);
> +		group_queue_work(group, term);
> +		group_put(group);
> +	}
> +

[Severity: High]
Does this loop leave off-slot scheduling groups hanging indefinitely?

The iteration strictly checks sched->csg_slots for on-slot groups. However,
any scheduling groups residing in off-slot lists (runnable, idle, or
waiting) will be completely ignored.

Since tick_work is disabled prior to this, these groups will never be
scheduled and will fail to terminate, causing jobs and DMA fences to hang
permanently.

>  	if (sched->pm.has_ref) {
>  		pm_runtime_put(ptdev->base.dev);
>  		sched->pm.has_ref =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D11
