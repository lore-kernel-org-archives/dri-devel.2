Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2120DCDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5598F10E202;
	Thu, 25 Jun 2026 11:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BM3y8BBj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FAD10E202
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:18:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 549E160139;
 Thu, 25 Jun 2026 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7521F000E9;
 Thu, 25 Jun 2026 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782386284;
 bh=v0H8jm9KVI/T5reyJKG1RDh6SrvUXlIFOcRoxKFsjFo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BM3y8BBjkepI4C+0iT2xleXR5rBG7EjZPxAoBnMXWvzsC/s34R0SodPQUXxfoIanr
 fG4NZJcEcHklc/6xTqF0qr01W4KlGJRKZeYo+DjHtiETOQl4uwpTOvfgkjjlWZKRZY
 50x1G+9V63aY8qh7hD3Acod6QrXvRWta6B43zZMYqLMjvrqZacJhNNHBflqEJonC+q
 LZ82C9tZ8Y+hl0f7/n3PL/qynp/fsuDSoPu++h90sL+oo+TgzvA5iJoMLD/QFBs3fK
 5Giv8mWT9XEGgeEwWzZszn2ni9A1IAUM3Cgh+cCg3zqGcbtPZ2GAI4qDYNV8WUB6rq
 VVGUmld1iRzSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/mmu_notifier: let interval notifiers block THP
To: "Yitao Jiang" <jytscientist@hotmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <SY1PR01MB1059616E59F213B6FB4F4E3C5C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
References: <SY1PR01MB10596EB75463208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
 <SY1PR01MB1059616E59F213B6FB4F4E3C5C0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 11:18:03 +0000
Message-Id: <20260625111803.CF7521F000E9@smtp.kernel.org>
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
- [High] Bypass of THP protections via VMA modification and logic bug in hu=
gepage_madvise().
- [High] mmu_interval_notifier_range_block_thp() misses notifiers on the de=
ferred_list, allowing a concurrent MADV_HUGEPAGE to re-enable THP.
- [Medium] MADV_HUGEPAGE requests are silently dropped for valid memory reg=
ions due to coarse VMA-level overlap checks.
- [Medium] VMAs with the VM_NO_KHUGEPAGED flag are incorrectly skipped duri=
ng THP blocking, allowing synchronous THP allocations.
--

commit 70ad5b57ebfe62382bb716c4e65db9bc1f0ee638
Author: Yitao Jiang <jytscientist@hotmail.com>
Subject: mm/mmu_notifier: let interval notifiers block THP

This patch introduces MMU_INTERVAL_NOTIFIER_BLOCK_THP to allow interval
notifiers to request blocking of transparent huge pages on covered VMA rang=
es.
The MM core handles updating the VMA flags (setting VM_NOHUGEPAGE and clear=
ing
VM_HUGEPAGE) during registration instead of drivers doing it directly.

> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 617bca76db49b..a9b05e71686c5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
[ ... ]
> @@ -445,11 +445,16 @@ static unsigned int collapse_max_ptes_swap(struct c=
ollapse_control *cc,
>  	return khugepaged_max_ptes_swap;
>  }
> =20
> -int hugepage_madvise(struct vm_area_struct *vma,
> -		     vm_flags_t *vm_flags, int advice)
> +int hugepage_madvise(struct vm_area_struct *vma, unsigned long start,
> +		     unsigned long end, vm_flags_t *vm_flags, int advice)
>  {
>  	switch (advice) {
>  	case MADV_HUGEPAGE:
> +		if ((*vm_flags & VM_NOHUGEPAGE) &&
> +		    mmu_interval_notifier_range_block_thp(vma->vm_mm,
> +							  start, end))
> +			return 0;
> +

[Severity: High]
If a new VMA is created within the notifier's range (e.g., via mremap or a
new mmap with MAP_FIXED), it will be created with default flags lacking
VM_NOHUGEPAGE, because mmu_interval_notifier_block_thp_locked() only
statically applies flags to existing VMAs. Because this check short-circuits
when VM_NOHUGEPAGE is absent, it seems it would evaluate to false and allow
MADV_HUGEPAGE to succeed. Does this allow userspace to bypass the THP block=
ing
protection for newly created VMAs?

[Severity: Medium]
Additionally, if a VMA was previously marked with VM_NOHUGEPAGE before the
notifier was registered, it may not have been split if its flags already
matched. If a user later calls MADV_HUGEPAGE on that entire VMA, this
condition will return 0 and ignore the hint completely. Should this logic
only reject the hint for the specific regions overlapping the notifier,
rather than dropping valid MADV_HUGEPAGE requests for the rest of the VMA?

> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 245b74f39f912..852a5682b07f2 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
[ ... ]
> +bool mmu_interval_notifier_range_block_thp(struct mm_struct *mm,
> +					   unsigned long start,
> +					   unsigned long end)
> +{
> +	struct mmu_notifier_subscriptions *subscriptions;
> +	struct mmu_interval_notifier *interval_sub;
> +	struct interval_tree_node *node;
> +	bool block_thp =3D false;
> +
> +	if (start >=3D end)
> +		return false;
> +
> +	/* Pairs with the store in mmu_notifier_register(). */
> +	subscriptions =3D smp_load_acquire(&mm->notifier_subscriptions);
> +	if (!subscriptions || !subscriptions->has_itree)
> +		return false;
> +
> +	spin_lock(&subscriptions->lock);
> +	for (node =3D interval_tree_iter_first(&subscriptions->itree, start,
> +					     end - 1);
> +	     node;
> +	     node =3D interval_tree_iter_next(node, start, end - 1)) {
> +		interval_sub =3D container_of(node, struct mmu_interval_notifier,
> +					    interval_tree);
> +		if (interval_sub->flags & MMU_INTERVAL_NOTIFIER_BLOCK_THP) {
> +			block_thp =3D true;
> +			break;
> +		}
> +	}
> +	spin_unlock(&subscriptions->lock);
> +
> +	return block_thp;
> +}

[Severity: High]
When an interval notifier is registered concurrently with an active page
table invalidation, __mmu_interval_notifier_insert() defers tree insertion
by placing the notifier on subscriptions->deferred_list. Since this loop
only inspects subscriptions->itree, could it miss active notifiers on the
deferred list and mistakenly allow a concurrent MADV_HUGEPAGE request to
re-enable THP?

[ ... ]
> +static int
> +mmu_interval_notifier_block_thp_locked(struct mm_struct *mm,
> +				       unsigned long start,
> +				       unsigned long end)
> +{
> +	struct vm_area_struct *vma, *prev;
> +	struct vma_iterator vmi;
> +
> +	mmap_assert_write_locked(mm);
> +
> +	vma_iter_init(&vmi, mm, start);
> +	vma =3D vma_iter_load(&vmi);
> +	prev =3D vma_prev(&vmi);
> +	if (vma && start > vma->vm_start)
> +		prev =3D vma;
> +
> +	for_each_vma_range(vmi, vma, end) {
> +		const unsigned long curr_start =3D max(vma->vm_start, start);
> +		const unsigned long curr_end =3D min(vma->vm_end, end);
> +		vma_flags_t new_flags;
> +
> +		if (vma->vm_flags & VM_NO_KHUGEPAGED)
> +			goto next;

[Severity: Medium]
The VM_NO_KHUGEPAGED flag only disables background scanning by khugepaged,
but it does not prevent transparent huge pages from being synchronously
allocated and mapped during page faults. By skipping these VMAs and not
setting VM_NOHUGEPAGE, does this leave them vulnerable to synchronous THP
allocations, thereby breaking the protection required by the notifier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SY1PR01MB10596EB754=
63208A8E1EBBA0FC0EC2@SY1PR01MB10596.ausprd01.prod.outlook.com?part=3D1
