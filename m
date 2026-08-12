Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2663FC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754A310E47F;
	Wed, 12 Aug 2026 21:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="czagod/c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4C410F11B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:10:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68847600AD;
 Wed, 12 Aug 2026 21:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37311F000E9;
 Wed, 12 Aug 2026 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786569031;
 bh=qTocXYfU7xuh3l9vwo2Dh63SrNZxr5hEGnvvOQRz4nE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=czagod/crZYTus5c7qWyqOrQKn5Os+yI1QxMVkkuGFpHFu6cGKkR3HC31QLEavs6u
 IlyDGPDEtTvTlNJmIdnzehiysPoStwwxcGBChvqrU+ZcQ9w4LstXSQDwhAjPPzTf7l
 ky1pBxl4k0ApkCSLx7boUxJ9ADwgrtbkIJqtRvhvWFKC0oCe+WhSEa9ZA1AVbs8ntg
 nToD/4mkstK6WCLyINvDzsy+HeW416nm0By554cMRPG0KVMsYQxVoSej488k3PCrj8
 DtzCwjL+dTOJgTqr9pb0jcohgtyHWFvheQCZq36UfrAAQDmKzEXVhMfVQl5hYMjcj3
 nd2cs4tpiRBew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Skip unmapped range in
 aie2_populate_range()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812205628.810816-1-lizhi.hou@amd.com>
References: <20260812205628.810816-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 21:10:30 +0000
Message-Id: <20260812211030.F37311F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incomplete fix for skipping unmapped entries due to a TOCTOU race.=
 Concurrent unmaps can still spuriously fail jobs.
- [High] Denial of Service due to infinite invalidation retry loop bypassin=
g absolute deadline.
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Skip unmapped range in aie2_popula=
te_range() ---
commit 1e3ba3d3372ac85262e7eb721d68d3f6974ff9b1
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Skip unmapped range in aie2_populate_range()

This commit addresses an issue where jobs fail incorrectly for buffer
objects with multiple memory mappings. It modifies aie2_populate_range()
to skip entries that have already been unmapped, allowing the driver to
successfully process the remaining valid mappings.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 73f8001eef4f2..baf9a8b90a4d6 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1053,6 +1053,16 @@ static int aie2_populate_range(struct amdxdna_gem_=
obj *abo)
>  	found =3D false;
>  	down_write(&xdna->notifier_lock);
>  	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
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
>  		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>  			found =3D true;
>  			break;
>  		}

[Severity: High]
This is a pre-existing regression, but this patch does not fully fix the
problem due to a time-of-check to time-of-use race.

Could a concurrent unmap cause amdxdna_hmm_invalidate() to set mapp->invalid
to true before mapp->unmapped is updated?

If aie2_populate_range() runs in drivers/accel/amdxdna/aie2_ctx.c after
the invalidation but before mapp->unmapped is set to true, it will bypass
this check and pick up the invalid VMA.

It would then later fail when checking mmget_not_zero():

	mm =3D mapp->notifier.mm;
	if (!mmget_not_zero(mm)) {
		amdxdna_umap_put(mapp);
		return -EFAULT;
	}

Does this return -EFAULT and abort the entire job instead of gracefully
skipping the unmapped entry?

>  	}
> =20
>  	if (!found) {
> +		/*
> +		 * This also covers the case where all mappings have been
> +		 * removed. There are no invalid mappings left to process.
> +		 * Any subsequent I/O using the unmapped address will be
> +		 * rejected by the IOMMU.
> +		 */
>  		abo->mem.map_invalid =3D false;
>  		up_write(&xdna->notifier_lock);
>  		return 0;

[Severity: High]
This is a pre-existing regression, but is it possible for this code
to enter an infinite invalidation retry loop?

Looking at aie2_populate_range() in drivers/accel/amdxdna/aie2_ctx.c:

	timeout =3D msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
again:
	found =3D false;
[ ... ]
	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
		up_write(&xdna->notifier_lock);
		amdxdna_umap_put(mapp);
		mmput(mm);
		goto again;
	}

Because timeout is initialized before the again label, the relative timeout
used by hmm_range_fault_unlocked_timeout() is continuously reset on each
retry.

If there is a continuous stream of memory invalidations, such as a
userspace thread looping madvise(MADV_DONTNEED) on a mapping, could this
trap the kernel thread in an infinite loop?

Could this hold job_sem and cause a Denial of Service by preventing further
job submissions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812205628.8108=
16-1-lizhi.hou@amd.com?part=3D1
