Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6E2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA6D10F2C9;
	Thu, 13 Aug 2026 11:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YDzgQN+P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765A210F2C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:21:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C65B56011F;
 Thu, 13 Aug 2026 11:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B701F00A3A;
 Thu, 13 Aug 2026 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786620060;
 bh=U1xOwUDjhVDd5rRjTHHGd7rI/g9bnbbo8ImQRdZbm8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YDzgQN+PaMYHd9OrIrL54oXOKu8xPjyAuXlQehROSLPR6feI23ATakNYcEsSWF/AV
 8ZRAdKe0nbAm+clYTCDR1o84wwc4D63+hBzccKCtWKCbI16HCK5rbOy3pz/xhuAvPX
 A2wALHl3ei2H9370M6Cg2JCwL37g6scqHPYfO3vDH4MEzYlTa4setr1PMSTpSxbQNA
 qA4O5LDj4zazLy7gUb0GHDWA16IHUs8KpOdTYuBU4QnfkwHDVTxegaVE6A0ZT2H8Oj
 JHLnAECEMfyNp0Teey4rwp6Owk65E/sVZQzSHivQluE/TRv1Ct0sfEO3IJZN8AVBYo
 KKjTuNu7uEVKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/17] drm/panthor: Make the VM cleanup path more
 robust against UAF
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-12-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-12-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:20:59 +0000
Message-Id: <20260813112100.68B701F00A3A@smtp.kernel.org>
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
- [High] Self-deadlock and lockdep violation in panthor_mmu_pre_suspend whe=
n AS disable fails.
- [High] Unconditional removal of PANTHOR_AS_FORBID_UNMAP leads to Use-Afte=
r-Free if soft reset fails.
--

--- Patch [12]: [PATCH v3 12/17] drm/panthor: Make the VM cleanup path more=
 robust against UAF ---
commit 5812e6e60c1cdbc7bb20a9803d7bf5a58663d7d2
Author: Boris Brezillon <boris.brezillon@collabora.com>
Subject: drm/panthor: Make the VM cleanup path more robust against UAF

The commit defers the cleanup of VMs when a hardware hang prevents eviction
of a page table from its AS slot, waiting for the next post_reset. It
introduces a cleanup list for VMs and schedules a workqueue to process it
once the hardware is confirmed idle.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index acdc0dd04f8be..5f4aab5813d52 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
[ ... ]
> @@ -1985,23 +2002,67 @@ static void panthor_mmu_irq_handler(struct pantho=
r_device *ptdev, u32 status)
>   *
>   * We also suspend the MMU IRQ.
>   */
> -void panthor_mmu_suspend(struct panthor_device *ptdev)
> +void panthor_mmu_pre_suspend(struct panthor_device *ptdev)
>  {
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	for (u32 i =3D 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
>  		struct panthor_as *as =3D ptdev->mmu->as.slots[i].as;
> +		int ret;
> =20
> -		if (as) {
> -			drm_WARN_ON(&ptdev->base,
> -				    panthor_mmu_as_disable(ptdev, i, false));
> +		if (!as)
> +			continue;
> +
> +		/* If the disable fails, leave the AS on its slot so we can
> +		 * properly evict it when we're sure the GPU is off.
> +		 */
> +		ret =3D panthor_mmu_as_disable(ptdev, i, false);
> +		if (!ret)
>  			panthor_as_release_hw_slot_locked(as);
> -		}
> +		else
> +			panthor_as_restrict_usage_locked(as,
> +							 PANTHOR_AS_FORBID_USE |
> +							 PANTHOR_AS_FORBID_MAP |
> +							 PANTHOR_AS_FORBID_UNMAP);
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);

[Severity: High]
Does this code cause a lockdep violation and self-deadlock if the hardware
hangs and panthor_mmu_as_disable() fails?

The panthor_mmu_pre_suspend() function acquires ptdev->mmu->as.slots_lock
before the loop. When calling panthor_as_restrict_usage_locked(), that
function asserts lockdep_assert_held(&as->op_lock) which doesn't appear
to be held here.

Furthermore, panthor_as_restrict_usage_locked() immediately tries to
acquire the slots_lock again:

static void panthor_as_restrict_usage_locked(...)
{
	...
	if (new_restrictions & PANTHOR_AS_FORBID_USE) {
		guard(mutex)(&ptdev->mmu->as.slots_lock);

Since standard mutexes are non-recursive, won't this self-deadlock the
thread performing the suspend?

> =20
>  	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
>  }
> =20
> +static void mmu_post_reset_cleanup(struct panthor_device *ptdev)
> +{
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	/* Now that the reset is effective, we can assume that none of the
> +	 * AS slots are setup, and clear the faulty flags too.
> +	 */
> +	ptdev->mmu->as.alloc_mask =3D 0;
> +	ptdev->mmu->as.faulty_mask =3D 0;
> +
> +	for (u32 i =3D 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> +		struct panthor_as *as =3D ptdev->mmu->as.slots[i].as;
> +
> +		if (!as)
> +			continue;
> +
> +		panthor_as_release_hw_slot_locked(as);
> +
> +		/* FIXME: We shouldn't drop the no-unmap restriction if
> +		 * we're in the unplug path and the device wasn't properly
> +		 * stopped with a SOFT_RESET.
> +		 */
> +		atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);

[Severity: High]
Can this unconditional clearing lead to a use-after-free if a soft reset
fails to halt the GPU?

As noted in the FIXME comment, dropping this restriction might be dangerous.
If the device wasn't properly stopped, the hardware could still be actively
performing DMA. Dropping PANTHOR_AS_FORBID_UNMAP here will allow
vm_cleanup() to execute panthor_vm_unmap_range() and
panthor_heap_pool_destroy(), potentially freeing memory that the active
GPU can still access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D12
