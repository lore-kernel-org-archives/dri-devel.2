Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB5C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63DA10EA0C;
	Tue,  4 Aug 2026 15:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bqssn5oi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539BD10EA0C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:23:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86C2740DFE;
 Tue,  4 Aug 2026 15:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B591F000E9;
 Tue,  4 Aug 2026 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785857032;
 bh=rFz8jaRSJUUsvWfA57vm3eV6p2u1HACiOb6EWmVbSjE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bqssn5oic2yeMiH1jwI9TJPl2ToVGaU+SKY0Qs0QpTxN2ARcRZo6BRxjRXtQ3FM2z
 vQ4E4pNzpHLyq+VzUc88nhnJNgF9nTlwgmjz665+kNNJrty1ypzKO2kZxWkmnvm/DA
 WNfRgsT70lRAl9bcrU3pGlXQ/YED+9//W2oMbSd3TuS1lyu9lG+5+YShqzZK3F/dD5
 9vcNKhVMB2INGbZwbnDeJjl2Sd33tkBWXDja9/vKS54VJMbnCgoqXqEkEEuJupLIbk
 V2atnX3ZpauoknY6mtNM2r/cjF1QkVj4qgEUZAhVbeXhT/joATTpxmTN6Q1HuMHO9A
 c5HA8xegIaJyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] drm/panthor: Make the VM cleanup path more robust
 against UAF
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-10-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-10-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:23:51 +0000
Message-Id: <20260804152352.49B591F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free of `mmu` structure during device teardown due to in=
correct drmm action registration order.
- [Medium] Memory leak of stranded VMs in `cleanup_list` if the device susp=
ends before a scheduled reset can execute.
--

--- Patch [10]: [PATCH 10/12] drm/panthor: Make the VM cleanup path more ro=
bust against UAF ---
commit 67363ef0cc8662df9cc3d191fcef3a128e79f9d4
Author: Boris Brezillon <boris.brezillon@collabora.com>
Subject: drm/panthor: Make the VM cleanup path more robust against UAF

The VM cleanup tries to gracefully evict the page table from its AS slot to
make sure the HW doesn't have access to the memory anymore. But it might
happen that the eviction fails because the HW hung, and in that case, we
have no guarantee that the HW won't access the memory until we've properly
reset the GPU. Defer the cleanup of VMs after the reset is effective when
this situation happens.

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pantho=
r/panthor_mmu.c
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

@@ -2098,64 +2129,114 @@ void panthor_mmu_post_reset(struct panthor_device =
*ptdev)
> +	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> +		guard(mutex)(&ptdev->mmu->as.slots_lock);
> =20
> -		if (drm_dev_enter(&ptdev->base, &cookie)) {
> -			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
> -			drm_dev_exit(cookie);
> +		/* We're in the unplug path and can't recover from
> +		 * that, so we just forcibly evict the pgtable. The
> +		 * no-unmap restriction will leak resources if
> +		 * we can't guarantee the HW stopped.
> +		 */
> +		if (as->hw_slot.id >=3D 0)
> +			panthor_as_release_hw_slot_locked(as);
> =20
> -		panthor_as_release_hw_slot_locked(as);
> +		return true;
> +	}
> =20
> -	}
> -	mutex_unlock(&ptdev->mmu->as.slots_lock);
> -	mutex_unlock(&vm->as->op_lock);
> =20
> -	if (vm->dummy)
> -		drm_gem_object_put(&vm->dummy->base);
> +	scoped_guard(mutex, &ptdev->mmu->as.slots_lock) {
> +		if (as->hw_slot.id >=3D 0) {
> +			ret =3D panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
> +			if (!ret) {
> +				panthor_as_release_hw_slot_locked(as);
> +			} else {
> +				list_add_tail(&vm->node, &ptdev->mmu->as.cleanup_list);
> +				panthor_device_schedule_reset(ptdev);

[Severity: Medium]
Could this leak stranded VMs if the device suspends before the scheduled
reset executes?

If a hardware hang prevents AS slot eviction here, the VM is added to the
cleanup_list and a reset is scheduled. If the device suspends before the
reset work executes, panthor_device_suspend() synchronously cancels the
reset work. During resume, panthor_mmu_resume() is called but does not
invoke mmu_post_reset_cleanup() to process this cleanup_list, leaving the
VMs stranded.

> +			}
>  		}
> =20
> -		panthor_as_release_hw_slot_locked(as);
> +		/* Page table is no longer resident, we can relax the no-unmap
> +		 * restriction.
> +		 */
> +		ready_for_cleanup =3D as->hw_slot.id < 0;
> +		if (ready_for_cleanup)
> +			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
>  	}

[ ... ]

@@ -3488,6 +3573,27 @@ static void panthor_mmu_info_init(struct panthor_dev=
ice *ptdev)
>  	ptdev->mmu_info.page_size_bitmap =3D SZ_4K | SZ_2M;
>  }
> =20
> +static void mmu_cleanup_vms_work(struct work_struct *work)
> +{
> +	struct panthor_mmu *mmu =3D
> +		container_of(work, struct panthor_mmu, vm.cleanup_work);
> +	struct panthor_vm *vm, *tmp;
> +	LIST_HEAD(cleanup_list);
> +
> +	/* Collect the VMs to cleanup first. */
> +	scoped_guard(mutex, &mmu->as.slots_lock) {
> +		list_for_each_entry_safe(vm, tmp, &mmu->as.cleanup_list, node) {

[Severity: High]
Can this result in a use-after-free during device teardown?

In panthor_device_init(), the panthor_device_flush_cleanup_wq action is
registered via drmm_add_action() before panthor_mmu_init() is called. Then,
in panthor_mmu_init(), ptdev->mmu is allocated via drmm_kzalloc().

Because drmm actions execute in LIFO order, ptdev->mmu will be freed before
the workqueue is flushed. If this delayed work is pending or running during
teardown, it will access the already-freed mmu structure here when trying to
acquire the as.slots_lock.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D10
