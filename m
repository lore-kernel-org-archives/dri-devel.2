Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66E2CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A538112314;
	Fri,  9 Oct 2026 23:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6Tn3xmb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A9E112314
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:06:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3025438C8;
 Fri,  9 Oct 2026 23:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1A01F000FF;
 Fri,  9 Oct 2026 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587190;
 bh=R9ba7KZtqj1dskjtHZHbVBoAZ5QTD5i6591EPZIYhks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S6Tn3xmbfOpzN82ENILVKUd9krj+MCN1rmuGwIfZNWJheMGKBCBdVGgtyPrZN/8ro
 Wt7Bz/f0qGiXdjTwrQRmCYgKaf/03nAAbj3ZOZgkkTo7p5siXnMb4Hsesjk6yYYVkG
 BkglBti14r7G5dk+vE0JTEToT9D59LDQvyq10Fm+15DQ5l2i3Es/8xSpnVScwXXTeT
 FYkoNEZ7bXLmnbXngnR3g+M/DO2T4OFmg9CfpA9jPtTHZLtzpAg0iPab10nE3LMR+2
 uDoKgzQNkGYanQlwNETyVj8j1/zVHzx+rKAvx5JwNSLThomlcXynx3qEgWDbljoYwg
 XKlnBoBmFtZtg==
Message-ID: <sashiko-outbox-166173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 15/19] accel/amdxdna: Make populate_range common for
 AIE2 and AIE4
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-16-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-16-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:06:29 +0000
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
- [High] drm/amdxdna: data race on hmm_range during concurrent faulting
- [High] mm: cross-process mmap_lock dependency blocks NPU job submission
--

commit c2a130c1477d63bd08139e79291eca214fcf225a
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Make populate_range common for AIE2 and AIE4

This commit moves aie2_populate_range() from aie2_ctx.c into amdxdna_gem.c
as amdxdna_populate_range(), making it common for both AIE2 and AIE4
command submissions.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index e1b72cef51bdf..320604ec157f7 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -337,6 +337,79 @@ void amdxdna_umap_put(struct amdxdna_umap *mapp)
>  	kref_put(&mapp->refcnt, amdxdna_umap_release);
>  }
> =20
> +int amdxdna_populate_range(struct amdxdna_gem_obj *abo)
> +{
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
> +	struct amdxdna_umap *mapp;
> +	unsigned long timeout;
> +	struct mm_struct *mm;
> +	bool found;
> +	int ret;
> +
> +	timeout =3D msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +again:
> +	found =3D false;
> +	down_write(&xdna->notifier_lock);
> +	list_for_each_entry(mapp, &abo->mem.umap_list, node) {

[Severity: High]
Does this code iterate over all mappings across all processes without
filtering by the current process?

If an unprivileged process imports a shared dmabuf, maps it, and holds its
mmap_write_lock indefinitely (e.g., via userfaultfd or FUSE), it could cause
this function to block indefinitely when attempting to acquire the
mmap_read_lock for that other process's mm.=20

Could this result in a denial of service by permanently blocking job
submission for the process that exported the dmabuf?

> +		/*
> +		 * Skip entries that have already been unmapped.
> +		 *
> +		 * If userspace unmaps the address and later submits I/O using
> +		 * it, the IOMMU will reject the access and report a fault.
> +		 * Ignore such entries here.
> +		 */
> +		if (mapp->unmapped)
> +			continue;
> +
> +		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {

[ ... ]

> +	if (!mmget_not_zero(mm)) {
> +		amdxdna_umap_put(mapp);
> +		return -EFAULT;
> +	}
> +
> +	ret =3D hmm_range_fault_unlocked_timeout(&mapp->range, timeout);

[Severity: High]
Can multiple concurrent job submissions on the same GEM object cause a data
race here?

When multiple hardware contexts submit jobs referencing the same GEM object
with invalidated memory mappings, aie2_cmd_submit() drops GEM reservations
and notifier_lock before calling amdxdna_populate_range(). Because
mapp->invalid remains true until the fault is completed, concurrent
submissions will find the exact same amdxdna_umap object and invoke
hmm_range_fault_unlocked_timeout() simultaneously on the identical
&mapp->range structure.

The HMM API requires struct hmm_range to be thread-local or synchronized by
the caller. The internal mmap_read_lock only protects the VMA, not the
hmm_range struct itself.

Could these unsynchronized writes to range->notifier_seq and the
range->hmm_pfns array break the mmu_interval_read_retry() logic, circumvent
MMU invalidations, or lead to memory corruption?

> +	if (ret)
> +		goto put_mm;
> +
> +	down_write(&xdna->notifier_lock);
> +	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq))=
 {
> +		up_write(&xdna->notifier_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D15
