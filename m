Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69436C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDA810E2E7;
	Thu, 23 Jul 2026 17:53:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4305D10E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 17:53:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E532640B73;
 Thu, 23 Jul 2026 17:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC61D1F00A3A;
 Thu, 23 Jul 2026 17:53:22 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
 <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:53:22 +0000
Message-Id: <20260723175322.AC61D1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Dereferencing `mapp->vma` without holding `mmap_lock` or a VMA loc=
k leads to potential Use-After-Free.
--

--- Patch [7]: [PATCH v11 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_=
timeout() for range population ---
commit 49a458a983bff0bc836f15feb7b3aa4763d7eb91
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

accel/amdxdna: Use hmm_range_fault_unlocked_timeout() for range population

This patch updates aie2_populate_range() to use the new
hmm_range_fault_unlocked_timeout() helper. The helper manages the mmap lock
and retry sequences internally. The driver now scopes the HMM retry timeout=
 to
the helper while maintaining its outer invalidation loop.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 54486960cbf5e..b5b4ca263002d 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c

[ ... ]

> @@ -1061,24 +1061,9 @@ static int aie2_populate_range(struct amdxdna_gem_=
obj *abo)

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free with the VMA just before this block in aie2_populate_range():

        XDNA_DBG(xdna, "populate memory range %lx %lx",
                 mapp->vma->vm_start, mapp->vma->vm_end);
        mm =3D mapp->notifier.mm;
        if (!mmget_not_zero(mm)) {

Is it safe to dereference mapp->vma here?=20

Since aie2_populate_range() only holds the xdna->notifier_lock at this poin=
t,
it doesn't appear to be tied to the VMA's lifetime. If a concurrent munmap
from another thread triggers an invalidation and frees the VMA entirely, co=
uld
the logging statement access a freed VMA structure when reading vm_start and
vm_end?

>  		return -EFAULT;
>  	}
> =20
> -	mapp->range.notifier_seq =3D mmu_interval_read_begin(&mapp->notifier);
> -	mmap_read_lock(mm);
> -	ret =3D hmm_range_fault(&mapp->range);
> -	mmap_read_unlock(mm);
> -	if (ret) {
> -		if (time_after(jiffies, timeout)) {
> -			ret =3D -ETIME;
> -			goto put_mm;
> -		}
> -
> -		if (ret =3D=3D -EBUSY) {
> -			amdxdna_umap_put(mapp);
> -			mmput(mm);
> -			goto again;
> -		}
> -
> +	ret =3D hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
> +	if (ret)
>  		goto put_mm;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-hmm-v10-v1=
1-0-c55b003a4b61@gmail.com?part=3D7
