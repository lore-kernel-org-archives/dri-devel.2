Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75991606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZP2VHaAk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20CB10F88A;
	Tue, 27 Oct 2026 23:18:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9221310F88A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:18:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5DA560098;
 Tue, 27 Oct 2026 23:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B94F1F01825;
 Tue, 27 Oct 2026 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793143108;
 bh=aBkI2p0jqb58qlc/qUeuZVOxAAvfchvZjXh/y/P9dXs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZP2VHaAk3yMD8Hk+16oFpY235azy/+cJG2YoTDN3JRiN/ZnkZcF0YkmXaSi5DeSvI
 TXwHdYBKFaPKDnpFD4/6zqNAX+R+OD+vk0x+PptGbPFwZ5tDgFoz+wU3G6K+q7XlW2
 1c2z8udfKsVWKbaUlHF99THJlnTw+5Y8YyuA6qbUrkf0O2a+QcjRQOkXJdzg9om5Vs
 GlLwcnVzqGZL4282gGONpgx6LllbikufJiHOQG2bvsbXF/dmmUJEncdWE1OL+Iue4U
 bPOp8NdwjkvBrY6sbBTFiWNcpHx8dInfywoRGf9s2BLrYkgWvOrRGMDq6vyRmCoPqu
 5ainPTQaLY2Xw==
Message-ID: <sashiko-outbox-187204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] drm/msm: Convert iommu map/unmap to helpers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027230452.130031-5-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:18:27 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/msm: missing leaf IOTLB invalidation in __unmap_iommu() on=
 qcom_iommu
- [High] drm/msm: bypassed iommu_sync_map() and core IOMMU API in msm_iommu=
_map()
--

commit efc83727eef15680f9e495c695cd848cb428e1a7
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert iommu map/unmap to helpers

This commit converts msm_iommu_map() and msm_iommu_unmap() in
drivers/gpu/drm/msm/msm_iommu.c to use the __do_map() and __do_unmap()
helpers via domain->ops->map_pages() and domain->ops->unmap_pages().

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 5c13ad6d5a366..479e5450a4dcd 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -731,12 +731,38 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
>  	iommu_detach_device(iommu->domain, mmu->dev);
>  }
> =20
> +static size_t
> +__unmap_iommu(void *arg, u64 iova, size_t pgsize, size_t pgcount)
> +{
> +	struct iommu_domain *domain =3D arg;
> +	return domain->ops->unmap_pages(domain, iova, pgsize, pgcount, NULL);
> +}
> +
> +static int
> +__map_iommu(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
> +	    size_t pgcount, int prot, size_t *mapped)
> +{
> +	struct iommu_domain *domain =3D arg;
> +	return domain->ops->map_pages(domain, iova, paddr, pgsize, pgcount,
> +				      prot, GFP_KERNEL, mapped);
> +}
> +
> +static void
> +__flush_iommu(void *arg)
> +{
> +	struct iommu_domain *domain =3D arg;
> +	iommu_flush_iotlb_all(domain);
> +}

[Severity: Critical]
Does passing NULL for the gather parameter in __unmap_iommu() paired with
iommu_flush_iotlb_all() in __flush_iommu() leave stale leaf IOTLB entries
on platforms using qcom_iommu?

Previously, msm_iommu_unmap() called iommu_unmap(), which passed a valid
struct iommu_iotlb_gather to domain->ops->unmap_pages() and then called
iommu_iotlb_sync().

With gather set to NULL in __unmap_iommu(), __arm_lpae_unmap() in
drivers/iommu/io-pgtable-arm.c skips per-page TLB invalidation:

drivers/iommu/io-pgtable-arm.c:__arm_lpae_unmap() {
    ...
		if (gather && !iommu_iotlb_gather_queued(gather))
			for (int j =3D 0; j < i; j++)
				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
    ...
}

On SoCs using drivers/iommu/arm/arm-smmu/qcom_iommu.c, skipping
io_pgtable_tlb_add_page() means qcom_iommu_tlb_add_page() is never called
to write ARM_SMMU_CB_S1_TLBIVAL. When __do_unmap() then calls
__flush_iommu() -> iommu_flush_iotlb_all(), qcom_iommu_flush_iotlb_all()
only issues a TLBSYNC barrier without invalidating the context bank by
ASID (qcom_iommu_tlb_inv_context()):

drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_flush_iotlb_all() {
	struct qcom_iommu_domain *qcom_domain =3D to_qcom_iommu_domain(domain);
	struct io_pgtable *pgtable =3D container_of(qcom_domain->pgtbl_ops,
						  struct io_pgtable, ops);
	if (!qcom_domain->pgtbl_ops)
		return;

	pm_runtime_get_sync(qcom_domain->iommu->dev);
	qcom_iommu_tlb_sync(pgtable->cookie);
	pm_runtime_put_sync(qcom_domain->iommu->dev);
}

As a result, unmapping leaf pages in msm_iommu_unmap() (or during error
rollback in __do_map()) issues no hardware TLB invalidation on qcom_iommu,
allowing the GPU or display engine to continue accessing unmapped and freed
GEM pages via stale IOTLB entries.

> +
> +static const struct map_ops iommu_ops =3D {
> +	__unmap_iommu, __map_iommu, __flush_iommu
> +};
> +
>  static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>  			 struct sg_table *sgt, size_t off, size_t len,
>  			 int prot)
>  {
> -	struct msm_iommu *iommu =3D to_msm_iommu(mmu);
> -	ssize_t ret;
> +	struct iommu_domain *domain =3D to_msm_iommu(mmu)->domain;
> =20
>  	WARN_ON(off !=3D 0);
> =20
> @@ -744,23 +770,18 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint6=
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
> +			domain, &iommu_ops);
>  }
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
> +	return __do_unmap(domain->pgsize_bitmap, iova, len, domain, &iommu_ops);
>  }

[Severity: High]
What happens on platforms that require .iotlb_sync_map or use generic_pt
when msm_iommu_map() and msm_iommu_unmap() bypass the core IOMMU API and
call domain->ops->map_pages() and domain->ops->unmap_pages() directly?

1. Previously, msm_iommu_map() called iommu_map_sgtable() ->
   iommu_map_sg(), which calls iommu_sync_map() after mapping the
   scatterlist:

   drivers/iommu/iommu.c:iommu_map_sg() {
       ...
	ret =3D iommu_sync_map(domain, iova, mapped);
	if (ret)
		goto out_err;
       ...
   }

   __do_map() only calls __map_iommu() -> domain->ops->map_pages() and
   never invokes domain->ops->iotlb_sync_map. On APQ8064/MSM8960
   (drivers/iommu/msm_iommu.c), the IOMMU driver relies on
   .iotlb_sync_map =3D msm_iommu_sync_map to flush the IOTLB for newly mapp=
ed
   ranges via __flush_iotlb_range(), which is now skipped.

2. In drivers/iommu/iommu.c:iommu_map_nosync() and __iommu_unmap(),
   domains converted to generic_pt (iommupt) use pt->ops->map_range and
   pt->ops->unmap_range and leave domain->ops->map_pages and
   domain->ops->unmap_pages as NULL:

   drivers/iommu/iommu.c:iommu_map_nosync() {
       ...
	if (pt)
		ret =3D pt->ops->map_range(pt, iova, paddr, size, prot, gfp,
					 &mapped);
	else
		ret =3D __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
					       gfp, &mapped);
       ...
   }

   Directly dereferencing domain->ops->map_pages and
   domain->ops->unmap_pages in __map_iommu() and __unmap_iommu() will
   dereference NULL on any IOMMU driver using generic_pt.

3. On arm-smmu, replacing iommu_unmap() (which uses struct
   iommu_iotlb_gather for range-targeted ARM_SMMU_CB_S1_TLBIVAL
   invalidations followed by iommu_iotlb_sync()) with
   domain->ops->unmap_pages(..., NULL) and iommu_flush_iotlb_all() forces a
   full ASID invalidation (ARM_SMMU_CB_S1_TLBIASID) on every unmap,
   evicting all TLB entries for active display scanout buffers and shared
   GPU mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027230452.1300=
31-1-robin.clark@oss.qualcomm.com?part=3D4
