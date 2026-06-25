Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79876CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCA510E1E0;
	Thu, 25 Jun 2026 11:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gwhcm+iK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF55910E1E0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87BA24349F;
 Thu, 25 Jun 2026 11:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DBB1F000E9;
 Thu, 25 Jun 2026 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782385895;
 bh=kyGlEq6hj+WA4FFSNlYY8yglxD7I/c4FXP6xdKKc2/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gwhcm+iK4zRcXlvGYdiAdglG/YiociOQSFEazyuMHIgnldJTItuPc8tZuqPCsQU0K
 Lg1ndqC7jOpZNOGnZ04Zjm2yLICBxk/jusO2bRswnoHwkQIzVVHP8dpuioAxfOwZ6+
 coMR8/Annocu7q8PvbhBELC9RaNZgJroVNt+y7Ze86tCaFXI/B5M2TQ1HIluYkUpEd
 sLYN2eMqfjleSzY9x7ETo3p9ChKV+HCOj7k/CVpsCZSFWLDECN56L7Mm0YANWiuV6E
 7Xi8FASfcWK0iKsvT6AwQzQLhxQ5HvmsBy1QPWjHj6B6L3OqE0A90LOvMJteCywhQ+
 9rBi/J1e2JE/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amdkfd: block THP for non-replayable SVM ranges
To: "Yitao Jiang" <jytscientist@hotmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <SY1PR01MB10596F9476BAA5333F02F5A6BC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <SY1PR01MB10596F9476BAA5333F02F5A6BC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:11:34 +0000
Message-Id: <20260625111135.44DBB1F000E9@smtp.kernel.org>
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
- [High] Error handling in `svm_range_set_attr` aborts the transaction mid-=
flight without rollback, leaving overlapping ranges in the SVM interval tre=
e and leaking memory.
- [High] `svm_range_add_notifier_locked` silently ignores failures when reg=
istering the MMU interval notifier, leading to WARN_ON_ONCE and interval tr=
ee corruption.
- [High] Clearing the `KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED` attribute perm=
anently leaks a THP block node and permanently disables THP for the virtual=
 address range.
- [High] Dynamically disabling XNACK via ioctl does not update SVM range no=
tifier flags, leaving THP unblocked and risking GPU page faults.

Pre-existing issues:
- [High] If a user maps SVM memory at virtual address 0, its MMU interval n=
otifier is never removed, causing a Use-After-Free.
--

commit f4df270ac94ba46190c602a81dedff1aa60cc86a
Author: Yitao Jiang <jytscientist@hotmail.com>

drm/amdkfd: block THP for non-replayable SVM ranges

KFD SVM ranges on processes without XNACK, and ranges requested as
GPU_ALWAYS_MAPPED, cannot rely on replayable GPU faults after a CPU THP
remap of the registered VA range. Keep those ranges backed by base
pages while their interval notifier is active.

Opt those SVM interval notifiers into MMU_INTERVAL_NOTIFIER_BLOCK_THP
and update the flag when SVM attributes change. XNACK-enabled ranges
that can handle remaps through replayable faults remain eligible for
THP unless GPU_ALWAYS_MAPPED is requested.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 3841943da5ece..0d0feba7b7852 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c

[ ... ]

> @@ -81,6 +82,26 @@ static const struct mmu_interval_notifier_ops svm_rang=
e_mn_ops =3D {
>  	.invalidate =3D svm_range_cpu_invalidate_pagetables,
>  };
> =20
> +static unsigned int
> +svm_range_mn_flags(struct svm_range *prange)
> +{
> +	struct kfd_process *p =3D container_of(prange->svms, struct kfd_process,
> +					     svms);
> +
> +	if (!p->xnack_enabled ||
> +	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED))
> +		return MMU_INTERVAL_NOTIFIER_BLOCK_THP;
> +
> +	return 0;
> +}

[Severity: High]
When a process dynamically disables XNACK using the KFD_IOC_SMI_EVENTS ioct=
l,
does this leave THP unblocked on existing ranges?

In svm_range_switch_xnack_reserve_mem(), p->xnack_enabled is updated
dynamically:

        p->xnack_enabled =3D xnack_enabled;

However, it does not seem to update the interval notifier flags for existing
SVM ranges. Because the existing ranges remain with THP unblocked, could
khugepaged collapse THPs and generate unrecoverable GPU page faults since
XNACK is disabled?

> +
> +static int
> +svm_range_update_mn_flags_locked(struct svm_range *prange)
> +{
> +	return mmu_interval_notifier_set_flags_locked(&prange->notifier,
> +						      svm_range_mn_flags(prange));
> +}

[Severity: High]
If userspace clears the KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag or XNACK
is enabled, does this permanently leak a THP block node?

When svm_range_update_mn_flags_locked() calls
mmu_interval_notifier_set_flags_locked() with flags =3D 0, the
interval_sub->flags are zeroed out locally. However, since there is no
teardown path to call mmu_interval_notifier_unblock_thp_locked(), the THP
block node remains.

When the SVM range is eventually freed, mmu_interval_notifier_remove() will
also skip the unblock path because the flag was cleared, resulting in a
permanent memory leak and permanently disabling THP for the virtual address
range.

[ ... ]

> @@ -112,10 +133,11 @@ svm_range_add_notifier_locked(struct mm_struct *mm,=
 struct svm_range *prange)
>  	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
>  		 prange, prange->start, prange->last);
> =20
> -	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
> -				     prange->start << PAGE_SHIFT,
> -				     prange->npages << PAGE_SHIFT,
> -				     &svm_range_mn_ops);
> +	mmu_interval_notifier_insert_locked_flags(&prange->notifier, mm,
> +						  prange->start << PAGE_SHIFT,
> +						  prange->npages << PAGE_SHIFT,
> +						  &svm_range_mn_ops,
> +						  svm_range_mn_flags(prange));
>  }

[Severity: High]
Does this silently ignore failures during interval notifier registration?

If mmu_interval_notifier_insert_locked_flags() fails, it returns an error
code and prange->notifier.mm remains NULL. Because the return value is
discarded here, subsequent code in svm_range_set_attr() will call
svm_range_update_mn_flags_locked() on the same transaction. This passes the
uninitialized notifier to mmu_interval_notifier_set_flags_locked(), which
will hit a WARN_ON_ONCE(!mm), return -EINVAL, and cause the transaction to
abort, potentially corrupting the interval tree.

[ ... ]

> @@ -3763,6 +3785,12 @@ svm_range_set_attr(struct kfd_process *p, struct m=
m_struct *mm,
>  	}
>  	list_for_each_entry(prange, &update_list, update_list) {
>  		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
> +		r =3D svm_range_update_mn_flags_locked(prange);
> +		if (r) {
> +			mutex_unlock(&svms->lock);
> +			mmap_write_unlock(mm);
> +			goto out;
> +		}

[Severity: High]
Does aborting the transaction here leak memory and corrupt the interval tre=
e?

If svm_range_update_mn_flags_locked() fails, the goto out path completely
bypasses the remove_list processing located further down in the function.
This leaves old cloned ranges permanently in the interval tree alongside
their newly inserted replacements that were added during the insert_list
loop. Additionally, because remove_list is a stack variable, skipping its
teardown leaks the ranges and leaves dangling pointers in the update_list
links.

>  		/* TODO: unmap ranges from GPU that lost access */
>  	}
>  	update_mapping |=3D !p->xnack_enabled && !list_empty(&remap_list);

[Severity: High]
This is a pre-existing issue, but does svm_range_remove_notifier() fail to
remove the notifier if the SVM range starts at virtual address 0?

In drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_remove_notifier():

	if (prange->notifier.interval_tree.start !=3D 0 &&
	    prange->notifier.interval_tree.last !=3D 0)
		mmu_interval_notifier_remove(&prange->notifier);

If an SVM range is mapped starting at virtual address 0 (which is permitted
if vm.mmap_min_addr is 0 or if the user has CAP_SYS_RAWIO), the check
evaluates to false and incorrectly skips mmu_interval_notifier_remove().
The prange is subsequently freed, but its embedded notifier structure
remains linked in the mm->notifier_subscriptions->itree, which will cause a
use-after-free the next time the tree is modified.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SY1PR01MB10596EB754=
63208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com?part=3D3
