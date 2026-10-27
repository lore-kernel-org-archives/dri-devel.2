Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CC606D944
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYT9Qv7T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B2910F6A4;
	Tue, 27 Oct 2026 15:45:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E72F10F6A3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:44:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4709043EF8;
 Tue, 27 Oct 2026 15:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A1E1F01287;
 Tue, 27 Oct 2026 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793115895;
 bh=qo8Fk6tc/v1ysWx4BNEEPKSATUhDczHOGVD1o8MuzgQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TYT9Qv7TKaOcomlv34HnjhesxQxOaUk/eqtVRQ128YOk76QXExzk4htRRMFnDafGz
 ZSnPC9SbLf23goz+iSVaptE5ZK2wD7R1m4CoXrqaWgu4FhY5p7lJcTbcjPTXV7RWeH
 /MNnnlilxUs7FiLvIaUzqR9N6KrNWJ0J80XKVoQ3O30WnaETLn9kze1/Lkdy9YseQU
 nUBnqHT3Nej62hpu9716UFEvi2FaXWdwb4OUVJ/ZjBs/LblVok0gIWGCIMUOl+UqlP
 /T8qEscGTJcbvypLzMpWx3n7XDYhsqVckVjtiqjvh/ftb+sj6FojdokPjDKVGse3iy
 YnwerhzqkLAQA==
Message-ID: <sashiko-outbox-186864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/msm: Convert iommu map/unmap to helpers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027152821.51144-5-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
 <20261027152821.51144-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:44:54 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/msm: skipped leaf IOTLB invalidation in msm_iommu_unmap()
- [High] drm/msm: missing IOTLB flush on error rollback in msm_iommu_map()
- [High] drm/msm: missing iotlb_sync_map call in msm_iommu_map()
--

commit 65df32b670bbcd4a7d2a95abeebac540248b0bbd
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert iommu map/unmap to helpers

This commit converts msm_iommu_map() and msm_iommu_unmap() to use the
__do_map() and __do_unmap() helpers with callbacks that invoke
domain->ops->map_pages() and domain->ops->unmap_pages() directly.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 78c82f4a01b92..435736c8d7150 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -731,12 +731,27 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
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
> @@ -744,23 +759,23 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint6=
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

[Severity: High]
Does msm_iommu_map() miss an IOTLB flush when __do_map() fails mid-way?

If __map_iommu() fails after some pages have already been mapped,
__do_map() unwinds the partial mappings by calling __do_unmap() with
__unmap_iommu():

drivers/gpu/drm/msm/msm_iommu.c:__do_map() {
    ...
			if (ret) {
				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, unmap);
				return -EINVAL;
			}
    ...
}

Because __unmap_iommu() passes NULL for the iotlb_gather parameter to
domain->ops->unmap_pages() and __do_unmap() does not flush the IOTLB,
stale translations for the rolled-back pages can remain cached in the
IOTLB after msm_iommu_map() returns an error.

In comparison, msm_iommu_pagetable_map() in the same file explicitly
flushes the IOTLB on error:

drivers/gpu/drm/msm/msm_iommu.c:msm_iommu_pagetable_map() {
    ...
	if (ret) {
		/*
		 * If the map failed mid-way, it will have triggered an
		 * unmap, so we need to flush the TLB:
		 */
		iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
	}
    ...
}

Also, by replacing iommu_map_sgtable() with direct calls to
domain->ops->map_pages() via __map_iommu(), msm_iommu_map() no longer
invokes domain->ops->iotlb_sync_map().

On platforms using drivers/iommu/msm_iommu.c (such as APQ8064),
msm_iommu_ops defines .iotlb_sync_map =3D msm_iommu_sync_map to flush the
IOTLB after mapping pages. Without calling iotlb_sync_map, will those
platforms miss required IOTLB synchronization on map?

> =20
>  static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t le=
n)
>  {
> -	struct msm_iommu *iommu =3D to_msm_iommu(mmu);
> +	struct iommu_domain *domain =3D to_msm_iommu(mmu)->domain;
> +	int ret;
> =20
>  	if (iova & BIT_ULL(48))
>  		iova |=3D GENMASK_ULL(63, 49);
> =20
> -	iommu_unmap(iommu->domain, iova, len);
> +	ret =3D __do_unmap(domain->pgsize_bitmap, iova, len, domain, __unmap_io=
mmu);
> =20
> -	return 0;
> +	iommu_flush_iotlb_all(domain);
> +
> +	return ret;
>  }

[Severity: Critical]
Can replacing iommu_unmap() with __do_unmap() and iommu_flush_iotlb_all()
skip leaf IOTLB invalidations on SoCs using qcom_iommu?

Here, msm_iommu_unmap() calls __do_unmap() with __unmap_iommu(), which
passes a NULL iotlb_gather pointer to domain->ops->unmap_pages().

In __arm_lpae_unmap() in drivers/iommu/io-pgtable-arm.c, per-page leaf TLB
invalidations are only issued when gather is non-NULL:

drivers/iommu/io-pgtable-arm.c:__arm_lpae_unmap() {
    ...
		if (gather && !iommu_iotlb_gather_queued(gather))
			for (int j =3D 0; j < i; j++)
				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
    ...
}

When msm_iommu_unmap() subsequently calls iommu_flush_iotlb_all(domain),
qcom_iommu_flush_iotlb_all() in drivers/iommu/arm/arm-smmu/qcom_iommu.c
only issues a TLBSYNC without issuing a context-wide TLBIASID invalidation:

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

Because gather is NULL during unmap_pages() (skipping
qcom_iommu_tlb_add_page() and its ARM_SMMU_CB_S1_TLBIVAL writes) and
qcom_iommu_flush_iotlb_all() only syncs prior invalidations, wouldn't leaf
IOTLB entries remain uninvalidated after unmapping buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027152821.5114=
4-1-robin.clark@oss.qualcomm.com?part=3D4
