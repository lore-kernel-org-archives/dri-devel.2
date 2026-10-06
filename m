Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A237CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EF510E9F6;
	Tue,  6 Oct 2026 13:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7mSZi8E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675F310E9F6
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:25:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D25A643073;
 Tue,  6 Oct 2026 13:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFD51F000FF;
 Tue,  6 Oct 2026 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791293145;
 bh=ZPCM5O980cg6lnfW5WByDY5ZuetgtAynJEVlqh0pBik=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B7mSZi8EUlke55kOWNB6NSfHqOCpfcNgdyP+SB1UOb/tp7ECH03fxHPwingh4SMm/
 fuuyWb6CcAeaSaoKJ3km2OcPwifa3EjSYv8W57Zn9A2/4Jzi1gbX6FF3bzLwsLRq5y
 D79Fl4rnDHM3yEWdKvFTZJL09y5ALLopgW24ILOI1BxWmm+S9ULh3w40cuPFoJXX+t
 lYZr4GljrhiBJy0B4hcmKXE3t6T3eSAolXKLh0Qsm5U4B3kjAgnO1kkT8bbOYlxRJz
 2mo0dDeYbd7+jihTtWVn/xvUp/6UK2ouldOXLqCfJFUg4FPSmp92j6JxhqwZb4sfFq
 GR9e7qDBwVVBw==
From: sashiko-bot@kernel.org
Subject: Re: [RFT 4/5] drm/msm: Convert iommu map/unmap to helpers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006131000.81501-5-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:25:44 +0000
Message-Id: <20261006132545.8BFD51F000FF@smtp.kernel.org>
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
- [Critical] msm: missing TLB flush in unmap sequence causes GPU UAF
- [Low] msm: build failure due to undefined __do_map and __do_unmap
--

commit a6f7885817ad9924dcb4d6924c8061a9096367bc
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drm/msm: Convert iommu map/unmap to helpers

This patch converts the msm iommu map and unmap paths to use new helpers.
It replaces calls to iommu_map_sgtable() and iommu_unmap() with __do_map()
and __do_unmap(), utilizing __map_iommu() and __unmap_iommu() callbacks.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index da6782fca6bd2..03acc851c5e6d 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
[ ... ]
> @@ -684,12 +684,27 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
>  	iommu_detach_device(iommu->domain, mmu->dev);
>  }
> =20
> +static size_t
> +__unmap_iommu(void *arg, u64 iova, size_t pgsize, size_t pgcount)
> +{
> +	struct iommu_domain *domain =3D arg;
> +	return domain->ops->unmap_pages(domain, iova, pgsize, pgcount, NULL);
> +}

[Severity: Critical]
By passing NULL for iotlb_gather, does this bypass the IOMMU driver's TLB
gathering and flushing mechanism?

When iommu_unmap() was previously used, it provided an iotlb_gather
structure and followed up with a synchronous TLB flush. Since this code is
invoked from msm_iommu_unmap(), leaving the TLB unflushed might retain
stale translations in hardware.

Can this lead to a use-after-free regression if the physical pages are
later reallocated and accessed by the GPU through the stale TLB entries?

> +
> +static int
> +__map_iommu(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
[ ... ]
> @@ -697,23 +712,18 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint6=
4_t iova,
>  	if (iova & BIT_ULL(48))
>  		iova |=3D GENMASK_ULL(63, 49);
> =20
> -	ret =3D iommu_map_sgtable(iommu->domain, iova, sgt, prot);
> -	if (ret < 0)
> -		return ret;
> -
> -	return (ret =3D=3D len) ? 0 : -EINVAL;
> +	return __do_map(domain->pgsize_bitmap, iova, sgt, off, len, prot,
> +			domain, __map_iommu, __unmap_iommu);
>  }

[Severity: Low]
Is __do_map() defined anywhere in the tree?

It appears this replaces iommu_map_sgtable() with a call to __do_map(),
but there is no declaration or definition of __do_map() available.
Does this cause an implicit declaration compile error when building with
DRM_MSM enabled?

> =20
>  static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t le=
n)
>  {
> -	struct msm_iommu *iommu =3D to_msm_iommu(mmu);
> +	struct iommu_domain *domain =3D to_msm_iommu(mmu)->domain;
> =20
>  	if (iova & BIT_ULL(48))
>  		iova |=3D GENMASK_ULL(63, 49);
> =20
> -	iommu_unmap(iommu->domain, iova, len);
> -
> -	return 0;
> +	return __do_unmap(domain->pgsize_bitmap, iova, len, domain, __unmap_iom=
mu);
>  }

[Severity: Low]
Similar to the mapping path, is __do_unmap() actually defined?

It looks like the change from iommu_unmap() to __do_unmap() will fail to
compile due to a missing definition.

Additionally, if __do_unmap() simply invokes __unmap_iommu() and returns,
is the required TLB flush completely missing from this unmap sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006131000.8150=
1-5-robin.clark@oss.qualcomm.com?part=3D1
