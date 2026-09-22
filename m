Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A24C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F63A10E608;
	Tue, 22 Sep 2026 05:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="epXPUqMY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E911110E608;
 Tue, 22 Sep 2026 05:58:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B91204385A;
 Tue, 22 Sep 2026 05:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A981F000FF;
 Tue, 22 Sep 2026 05:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056731;
 bh=9+LAkdE5O2aghGHVUZJr165EbuGT1ov9K+bm2/ZEW50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=epXPUqMY0W4c5Zd6lejW/hIwH8C5xFSDB3cCYJ/7pTfuwG9vGv8d93XctsyfBMZ+r
 th3SCeowxb0opfcGQRLCJHe4a6oSZQ6esY+/qx+dosnJyhEcOHgbsbHtTvBNKBxhk+
 /NG9zplRdxgBbZUsmOAd9zLVXuBeZN/LCy9D4JeLOj4v26KxA5XJeWnQZHWCMUWXmg
 4AQl2zksK9ApMGtp7CZvhUdSdOOhaqujXTrI4l6fDfBoYqIR/X5+DyfQKXD7N5u1+G
 2W9gXuyKrhdxsNW/lu12RQI1y971gPBVlx0g4Hl73ewuh4yf948Lr5Bq9Cyj6t8h+J
 Ax9GgHDGv81IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/12] mm: enable device page migration from HMM
 pagewalk
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-11-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-11-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:58:50 +0000
Message-Id: <20260922055851.65A981F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: unbalanced mmu_notifier in hmm_range_fault during migration
--

commit 3e05399d761177583ed386d43f42e228c070f447
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm: enable device page migration from HMM pagewalk

This patch integrates HMM pagewalk machinery into the first phase of device
page migration by enabling migration in hmm_range_fault(). It updates
migrate_vma_setup() to use the HMM pagewalk path and removes the older
migrate_vma_collect() paths. Two new flags, MIGRATE_VMA_FAULT and
MIGRATE_VMA_WRITE, are introduced for faulting missing pages and requesting
write access.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 43e571e82ccad..1e1a592e12672 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
[ ... ]
> @@ -739,10 +241,20 @@ static void migrate_vma_unmap(struct migrate_vma *m=
igrate)
>   */
>  int migrate_vma_setup(struct migrate_vma *args)
>  {
> +	int ret;
>  	long nr_pages =3D (args->end - args->start) >> PAGE_SHIFT;
> +	struct hmm_range range =3D {
> +		.notifier =3D NULL,
> +		.hmm_pfns =3D args->src,
> +		.dev_private_owner =3D args->pgmap_owner,

[Severity: High]
Does this code cause a permanent MMU notifier imbalance when args->pgmap_ow=
ner
is NULL?

If a caller invokes migrate_vma_setup() with args->pgmap_owner set to NULL
(which is standard for migrations not involving device-private memory, such=
 as
PowerPC KVM secure guest page-in), range.dev_private_owner is also NULL.

In mm/hmm.c:hmm_vma_capture_migrate_range(), the code checks:

	if (!hmm_vma_walk->mmu_range.owner) {
		mmu_notifier_range_init_owner(&hmm_vma_walk->mmu_range, MMU_NOTIFY_MIGRAT=
E, 0,
					      walk->vma->vm_mm, start, end,
					      range->dev_private_owner);
		mmu_notifier_invalidate_range_start(&hmm_vma_walk->mmu_range);
	}

Because mmu_range is zero-initialized, this condition is true. It calls
mmu_notifier_range_init_owner(), which assigns the NULL dev_private_owner
to hmm_vma_walk->mmu_range.owner. mmu_notifier_invalidate_range_start() is
then called.

Additionally, if the range spans multiple VMAs, invalidate_range_start is
called multiple times because the sentinel remains NULL.

Later, in mm/hmm.c:hmm_vma_post_range_fault():

	if (hmm_select_migrate(range) &&
	    hmm_vma_walk->mmu_range.owner) {
		mmu_notifier_invalidate_range_end(&hmm_vma_walk->mmu_range);
	}

Because mmu_range.owner remains NULL, this condition evaluates to false,
completely skipping the required mmu_notifier_invalidate_range_end() call.

A skipped invalidate_range_end() leaves the invalidation count permanently
elevated, causing any subsequent operation on that memory range requiring
mmu_interval_read_retry() or VMA teardown to block indefinitely.

> +		.migrate =3D args,
> +		.default_flags =3D HMM_PFN_REQ_MIGRATE
> +	};
> =20
>  	args->start &=3D PAGE_MASK;
>  	args->end &=3D PAGE_MASK;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D10
