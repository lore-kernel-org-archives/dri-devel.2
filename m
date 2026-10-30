Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97280606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8r/iYsd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F102C10E08A;
	Fri, 30 Oct 2026 21:49:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147ED10E08A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2327C601F8;
 Fri, 30 Oct 2026 21:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985371F000C1;
 Fri, 30 Oct 2026 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793396992;
 bh=Q5H+GHNQqU5OzIPql1TmW8O+jQjbNsr28QPZTiTGdMc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=k8r/iYsd5bEhriNCkQrCaKpxaQ7ZwSnptH0Jcpg2dhZGtI3AAij45S2PpjunkjVv+
 WB4SW54lvHsSjEdii/0GKpmdLcRFZ/pVUs/sLFv963a6fn77sTaExvxtvfuICt8glv
 WZDTnS7Qc3uZ24tCRMOYQyqsO3Cv+KUlDT4j0oHx8j8RNmYygc8PEQHf17mujjKA3N
 X2aINw/xuNknAIl3F3Q+BAIUg7gAeok5mauTvukWyD3vimtDbdkvHG7ynkBevdvhbH
 pqJLdm+U311P1OgJT1t3jpUkVi+ci14Qi7GiVPR+t+IIxtgBjrW85Q3RSxMlXiXqzv
 6XiL/Tl3Nq89w==
Message-ID: <sashiko-outbox-191553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] drm/msm: Convert iommu map/unmap to helpers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030213251.55365-5-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
 <20261030213251.55365-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:49:52 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/msm: missing leaf IOTLB invalidation in __unmap_iommu() on=
 qcom_iommu
- [High] drm/msm: bypassed iommu_sync_map() and core IOMMU API in msm_iommu=
_map()
- [Low] drm/msm: build failure in __map_iommu() when !CONFIG_IOMMU_API
--

commit e0c13e8fe949f41860b8d6b287a4884b707293a0
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert iommu map/unmap to helpers

This commit converts msm_iommu_map() and msm_iommu_unmap() to use the
internal __do_map() and __do_unmap() helpers with callbacks that invoke
iommu_domain_ops directly instead of calling iommu_map_sgtable() and
iommu_unmap().

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

[Severity: Low]
Does dereferencing domain->ops in __unmap_iommu() and __map_iommu() break t=
he
build when CONFIG_IOMMU_API is disabled?

In drivers/gpu/drm/msm/Kconfig, DRM_MSM depends on IOMMU_SUPPORT and selects
IOMMU_IO_PGTABLE, neither of which selects CONFIG_IOMMU_API. In
include/linux/iommu.h, struct iommu_domain_ops is only forward-declared when
CONFIG_IOMMU_API is not enabled, so dereferencing domain->ops->unmap_pages =
and
domain->ops->map_pages fails to compile with an incomplete type error under
SOC_IMX5 or COMPILE_TEST configurations without an IOMMU driver that selects
CONFIG_IOMMU_API.

> +
> +static void
> +__flush_iommu(void *arg)
> +{
> +	struct iommu_domain *domain =3D arg;
> +	iommu_flush_iotlb_all(domain);
> +}

[Severity: Critical]
As reported by Sashiko on v3 [1], does passing NULL for the gather parameter
in __unmap_iommu() followed by iommu_flush_iotlb_all() in __flush_iommu() s=
kip
hardware IOTLB invalidation completely on platforms using qcom_iommu?

When msm_iommu_unmap() (or the error rollback path in msm_iommu_map() ->
__do_map()) calls __do_unmap(), __unmap_iommu() calls
domain->ops->unmap_pages(domain, iova, pgsize, pgcount, NULL).

On SoCs using drivers/iommu/arm/arm-smmu/qcom_iommu.c (such as MSM8916,
MSM8953, and MSM8976 with Adreno A3xx/A4xx/A5xx and MDP5),
qcom_iommu_init_domain() uses the ARM_32_LPAE_S1 page table format in
drivers/iommu/io-pgtable-arm.c. In __arm_lpae_unmap(), per-page TLB
invalidation via io_pgtable_tlb_add_page() -> qcom_iommu_tlb_add_page()
(which writes ARM_SMMU_CB_S1_TLBIVAL) is skipped when gather is NULL:

drivers/iommu/io-pgtable-arm.c:__arm_lpae_unmap() {
	...
		if (gather && !iommu_iotlb_gather_queued(gather))
			for (int j =3D 0; j < i; j++)
				io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
	...
}

When __do_unmap() then finishes by calling __flush_iommu() ->
iommu_flush_iotlb_all(domain), qcom_iommu_flush_iotlb_all() only issues a
TLBSYNC barrier without invalidating the context bank by ASID:

drivers/iommu/arm/arm-smmu/qcom_iommu.c:qcom_iommu_flush_iotlb_all() {
	...
	pm_runtime_get_sync(qcom_domain->iommu->dev);
	qcom_iommu_tlb_sync(pgtable->cookie);
	pm_runtime_put_sync(qcom_domain->iommu->dev);
}

As a result, neither ARM_SMMU_CB_S1_TLBIVAL nor ARM_SMMU_CB_S1_TLBIASID is
written during unmap, leaving stale TLB entries pointing to unmapped and fr=
eed
GEM buffer pages accessible to GPU and display DMA.

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
As reported by Sashiko on v3 [2], can bypassing the core IOMMU API in
msm_iommu_map() and msm_iommu_unmap() cause missing IOTLB synchronization on
map as well as regressions with arm-smmu and generic_pt domains?

First, replacing iommu_map_sgtable() with __do_map() -> __map_iommu() ->
domain->ops->map_pages() never calls iommu_sync_map()
(domain->ops->iotlb_sync_map) after mapping pages. On APQ8064/MSM8960
(drivers/iommu/msm_iommu.c, used with MDP4 and Adreno 320),
msm_iommu_ops.default_domain_ops relies on .iotlb_sync_map =3D
msm_iommu_sync_map to flush the IOTLB range via __flush_iotlb_range() after
mapping and leaves .flush_iotlb_all as NULL.

Second, on arm-smmu, iommu_unmap() previously used struct iommu_iotlb_gather
to perform VA-targeted leaf invalidations (ARM_SMMU_CB_S1_TLBIVAL) followed=
 by
iommu_iotlb_sync(). Calling domain->ops->unmap_pages() with a NULL gather
followed by iommu_flush_iotlb_all() forces a full ASID invalidation
(ARM_SMMU_CB_S1_TLBIASID) on every unmap, evicting all TLB entries for acti=
ve
display scanout buffers and GPU mappings sharing the ASID.

Third, in drivers/iommu/iommu.c (iommu_map_nosync() and __iommu_unmap()),
domains converted to the generic page table library (domain->is_iommupt) use
pt->ops->map_range and unmap_range and leave domain->ops->map_pages and
unmap_pages as NULL, while core wrappers also handle iommu_debug_map() /
iommu_debug_unmap_begin() and IOMMU tracepoints.

[1] https://lore.kernel.org/r/20261027230452.130031-5-robin.clark@oss.qualc=
omm.com
[2] https://lore.kernel.org/r/20261027230452.130031-5-robin.clark@oss.qualc=
omm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030213251.5536=
5-1-robin.clark@oss.qualcomm.com?part=3D4
