Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A738CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACAC10E3EC;
	Tue,  6 Oct 2026 13:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X/6+jtri";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD4310E3EC
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:19:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3AE5418B7;
 Tue,  6 Oct 2026 13:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870D1F000FF;
 Tue,  6 Oct 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791292760;
 bh=SPGEuxVRGc0U6ugcz8kluCuYJtEw43OvlJlFhYe1sPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X/6+jtriD9jJxB4M3GuaO80rZpsGB9k5Tv2AcpJG9PZNXs3sSuVuAVj8tjaVHqWFo
 hOy987ymV1jYz8rSDFxgtw9m48EAhwFDbe04LF/QtG8FYAePHSTOMvIeh94dnYMvWX
 TlAEWmPvpwSifpTwdwsS8dEqEZurnemik7ZMnVXAV+05GzBUlj0OsxWt0bjXFQkcwI
 1oNOtqXSrJ0a611YA7CVKLEh4irQ/wIw3dnNCCPZNDBapcukEAknyqiN/WNo2VNUvp
 kVcnywAwVfF8pzUR1Qx195RNdCCJgo8G7pWF1PiXYjBbBO7qgFzj+b/8+z5t42GnSg
 +k2qC9S1lKsQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFT 3/5] drm/msm: Extract out map/unmap helpers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006131000.81501-4-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:19:19 +0000
Message-Id: <20261006131920.6870D1F000FF@smtp.kernel.org>
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
- [High] drm/msm: missing IOTLB flush on pagetable map error path
--

commit 7d5e2545b852417f316f5873d935ec2b95998bbf
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Extract out map/unmap helpers

This commit extracts `__do_map()` and `__do_unmap()` helpers from
`msm_iommu_pagetable_map()` and `msm_iommu_pagetable_unmap()` respectively.
It aims to reuse these helpers without any functional changes.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index da6782fca6bd2..a658493f80072 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
[ ... ]
> @@ -204,10 +169,9 @@ static int msm_iommu_pagetable_map(struct msm_mmu *m=
mu, u64 iova,
>  			size_t pgsize, count, mapped =3D 0;
>  			int ret;
> =20
> -			pgsize =3D calc_pgsize(pagetable, addr, phys, size, &count);
> +			pgsize =3D calc_pgsize(pgsize_bitmap, addr, phys, size, &count);
> =20
> -			ret =3D ops->map_pages(ops, addr, phys, pgsize, count,
> -					     prot, GFP_KERNEL, &mapped);
> +			ret =3D map(arg, phys, addr, pgsize, count, prot, &mapped);
> =20
>  			/* map_pages could fail after mapping some of the pages,
>  			 * so update the counters before error handling.
> @@ -218,7 +182,7 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mm=
u, u64 iova,
>  			len  -=3D mapped;
> =20
>  			if (ret) {
> -				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
> +				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, unmap);
>  				return -EINVAL;
>  			}

[Severity: High]
Does this error path miss an IOTLB flush?

Before this commit, a failure in the mapping loop would call
msm_iommu_pagetable_unmap(), which flushes the IOTLB after unmapping.

Now, the refactored __do_map() calls the new __do_unmap() helper directly.
Because __do_unmap() skips the IOTLB flush, the error rollback leaves stale
virtual-to-physical address translations for partially mapped pages in the
TLB, which can lead to rogue DMA and memory corruption (use-after-free).

[ ... ]
> @@ -227,6 +191,78 @@ static int msm_iommu_pagetable_map(struct msm_mmu *m=
mu, u64 iova,
>  	return 0;
>  }
> =20
> +static size_t
> +__unmap_pgtable(void *arg, u64 iova, size_t pgsize, size_t pgcount)
[ ... ]
> +static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> +				   struct sg_table *sgt, size_t off, size_t len,
> +				   int prot)
> +{
> +	struct msm_iommu_pagetable *pagetable =3D to_pagetable(mmu);
> +	struct io_pgtable_ops *ops =3D pagetable->pgtbl_ops;
> +
> +	if (!sgt)
> +		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
> +
> +	return __do_map(pagetable->pgsize_bitmap, iova, sgt, off, len, prot,
> +			ops, __map_pgtable, __unmap_pgtable);
> +}

[Severity: High]
Can this propagate the error from __do_map() without flushing the IOTLB?

When __do_map() hits an error and returns, msm_iommu_pagetable_map() passes
the error up the stack without initiating a TLB flush, cementing the
missing flush bug from the __do_map() failure path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006131000.8150=
1-4-robin.clark@oss.qualcomm.com?part=3D1
