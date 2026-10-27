Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F1F606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqYNN1P4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F77810F6C4;
	Tue, 27 Oct 2026 15:52:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EB210E38E
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:52:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3130E60232;
 Tue, 27 Oct 2026 15:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E01F01825;
 Tue, 27 Oct 2026 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793116361;
 bh=1nV/yje5P8xSFhChAKRYs5VsdXqSLPeU/EHfORRuSQc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=EqYNN1P4ugxWwWHy+btkr7RpLtCDKiy6QcZeDsrfrhYQihqaFL66y1RsuP4TAQNRe
 j5qH/Isjs5DI28VX0/ypqQ08TGGPQRU+zuP6hQOfKyivyC/iEAfiHDsAO8BHNTFn2w
 2bta4NErPz20hs0+ZfDsFVGtORAOYvD5NgAb9QsvElVa0+A6ew2u0n6f0Gs+myOAjJ
 Im7/c7GkqlKNDbAibaLtUhBkCY/MGVFWUhdvh3IbBUSF60mP25os664sLNpr9jiyF1
 MhFf+GV4FxnTeLxOYdn77vvTInRan/s5m2uOiuS6TbS096wQl45tXhXSmRs76FQIG4
 mzXyBkJ06vDQA==
Message-ID: <sashiko-outbox-186870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] drm/msm: Convert map helper to use dma-address
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027152821.51144-6-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
 <20261027152821.51144-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:52:41 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] drm/msm: __do_map() uses sg_dma_address() as CPU physical addr=
ess
- [High] drm/msm: double dma_map_sgtable() and unmap in get_pages() and put=
_pages()
- [High] drm/msm: NULL deref in get_pages() via drm_prime_gem_destroy() on =
error
- [High] drm/msm: missing IOTLB invalidation in __unmap_iommu() and msm_iom=
mu_map()
--

commit e639a62aaac331070fa9f9ceece15e985cb308ad
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert map helper to use dma-address

This series updates the MSM DRM driver to DMA-map GEM scatter-gather tables
and converts the IOMMU and page table mapping helpers to iterate over DMA
addresses and lengths rather than struct page pointers.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 130ae27ee00be..72e3cd8bb1e7c 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -190,6 +190,7 @@ static void update_lru(struct drm_gem_object *obj)
>  static struct page **get_pages(struct drm_gem_object *obj)
>  {
>  	struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
> +	int ret =3D 0;
> =20
>  	msm_gem_assert_locked(obj);
> =20
> @@ -209,19 +210,26 @@ static struct page **get_pages(struct drm_gem_objec=
t *obj)
>  			return p;
>  		}
> =20
> -		update_device_mem(dev->dev_private, obj->size);
> -
>  		msm_obj->pages =3D p;
> =20
>  		msm_obj->sgt =3D drm_prime_pages_to_sg(obj->dev, p, npages);
>  		if (IS_ERR(msm_obj->sgt)) {
> -			void *ptr =3D ERR_CAST(msm_obj->sgt);
> -
>  			DRM_DEV_ERROR(dev->dev, "failed to allocate sgt\n");
> -			msm_obj->sgt =3D NULL;
> -			return ptr;
> +			ret =3D PTR_ERR(msm_obj->sgt);
> +			goto error;
>  		}
> =20
> +		ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
> +				      msm_obj->sgt,
> +				      DMA_BIDIRECTIONAL,
> +				      DMA_ATTR_SKIP_CPU_SYNC);
> +		if (ret) {
> +			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
> +			goto error;
> +		}
> +
> +		update_device_mem(dev->dev_private, obj->size);
> +
>  		/* For non-cached buffers, ensure the new pages are clean
>  		 * because display controller, GPU, etc. are not coherent:
>  		 */
> @@ -232,6 +240,16 @@ static struct page **get_pages(struct drm_gem_object=
 *obj)
>  	}
> =20
>  	return msm_obj->pages;
> +
> +error:
> +	if (!IS_ERR(msm_obj->sgt))
> +		drm_prime_gem_destroy(obj, msm_obj->sgt);

[Severity: High]
Won't calling drm_prime_gem_destroy() in the error path of get_pages() caus=
e a
NULL pointer dereference when dma_map_sgtable() fails?

In drivers/gpu/drm/msm/msm_gem.c, get_pages() is only used for non-imported
GEM objects and rejects imported objects at the start:

    if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
        return ERR_PTR(-EINVAL);

Because obj->import_attach is NULL for native GEM objects, jumping to error
after drm_prime_pages_to_sg() succeeds calls drm_prime_gem_destroy(), which
dereferences attach->dmabuf:

    attach =3D obj->import_attach;
    if (sg)
        dma_buf_unmap_attachment_unlocked(attach, sg, DMA_BIDIRECTIONAL);
    dma_buf =3D attach->dmabuf;

Should this error path call sg_free_table(msm_obj->sgt) and
kfree(msm_obj->sgt) instead of drm_prime_gem_destroy()?

> +	msm_obj->sgt =3D NULL;
> +
> +	drm_gem_put_pages(obj, msm_obj->pages, false, false);
> +	msm_obj->pages =3D NULL;
> +
> +	return ERR_PTR(ret);
>  }
> =20
>  static void put_pages(struct drm_gem_object *obj)
> @@ -246,18 +264,21 @@ static void put_pages(struct drm_gem_object *obj)
>  		drm_gpuvm_bo_gem_evict(obj, true);
> =20
>  	if (msm_obj->pages) {
> -		if (msm_obj->sgt) {
> -			/* For non-cached buffers, ensure the new
> -			 * pages are clean because display controller,
> -			 * GPU, etc. are not coherent:
> -			 */
> -			if (msm_obj->flags & MSM_BO_WC)
> -				sync_for_cpu(msm_obj);
> +		/* For non-cached buffers, ensure the new
> +		 * pages are clean because display controller,
> +		 * GPU, etc. are not coherent:
> +		 */
> +		if (msm_obj->flags & MSM_BO_WC)
> +			sync_for_cpu(msm_obj);
> =20
> -			sg_free_table(msm_obj->sgt);
> -			kfree(msm_obj->sgt);
> -			msm_obj->sgt =3D NULL;
> -		}
> +		dma_unmap_sgtable(drm_dev_dma_dev(obj->dev),
> +				  msm_obj->sgt,
> +				  DMA_BIDIRECTIONAL,
> +				  DMA_ATTR_SKIP_CPU_SYNC);

[Severity: High]
Doesn't this map msm_obj->sgt twice in get_pages() and unmap it twice in
put_pages() whenever MSM_BO_WC is set?

In get_pages(), dma_map_sgtable() is called with DMA_ATTR_SKIP_CPU_SYNC, and
then if (msm_obj->flags & MSM_BO_WC) is true, sync_for_device() is called:

    static void sync_for_device(struct msm_gem_object *msm_obj)
    {
        struct device *dev =3D msm_obj->base.dev->dev;

        dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
    }

Symmetrically, in put_pages(), sync_for_cpu() calls dma_unmap_sgtable(dev,
msm_obj->sgt, DMA_BIDIRECTIONAL, 0), followed immediately by a second
dma_unmap_sgtable() with DMA_ATTR_SKIP_CPU_SYNC on the same sg_table and
device.

With CONFIG_DMA_API_DEBUG enabled, mapping an already-mapped scatterlist
triggers overlapping DMA-API debug warnings in debug_dma_map_sg() and
double-unmap warnings in debug_dma_unmap_sg(). Additionally, if
use_dma_iommu(dev) is true, the second dma_map_sgtable() overwrites
sg_dma_address(sg) and leaks the first IOVA range in group->default_domain,
while the second dma_unmap_sgtable() frees the second IOVA range twice in
iommu_dma_unmap_sg().

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index da6782fca6bd2..6258c942e66ad 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
[ ... ]
> @@ -135,6 +137,83 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu =
*mmu, u64 iova, size_t size)
>  		size -=3D unmapped;
>  	}
> =20
> +	return ret;
> +}
> +
> +static inline int
> +__do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, si=
ze_t off,
> +	 size_t len, int prot, void *arg, map_fn map, unmap_fn unmap)
> +{
> +	struct scatterlist *sg;
> +	u64 addr =3D iova;
> +	unsigned int i;
> +
> +	for_each_sgtable_dma_sg (sgt, sg, i) {
> +		size_t size =3D sg_dma_len(sg);
> +		phys_addr_t phys =3D sg_dma_address(sg);

[Severity: Critical]
Is it safe to treat sg_dma_address(sg) and sg_dma_len(sg) as CPU physical
addresses and physical segment lengths when programming the GPU and display
page tables in __do_map()?

Both __map_pgtable() (calling io_pgtable_ops->map_pages()) and __map_iommu()
(calling iommu_domain->ops->map_pages()) expect paddr to be a CPU physical
address.

In get_pages() and drm_gem_prime_import(), the sg_table is DMA-mapped for
drm_dev_dma_dev(obj->dev) (which is obj->dev->dev). As noted in the comment
above sync_for_device() in drivers/gpu/drm/msm/msm_gem.c and in
msm_kms_init_vm() in drivers/gpu/drm/msm/msm_kms.c, depending on the display
generation, the display IOMMU is wired either to the parent mdss device or
directly to the mdp sub-node (obj->dev->dev):

    if (device_iommu_mapped(mdp_dev))
        iommu_dev =3D mdp_dev;
    else if (mdss_dev && device_iommu_mapped(mdss_dev))
        iommu_dev =3D mdss_dev;

On platforms where the IOMMU is wired to the mdp node and the IOMMU driver
does not select IOMMU_DOMAIN_IDENTITY as the default domain (such as SDM630=
 /
SDM660 with "qcom,mdp5", MSM8996, and platforms using qcom_iommu), the IOMMU
core allocates a DMA default_domain during probe and calls
iommu_setup_dma_ops(), setting use_dma_iommu(dev) to true.

Even when msm_iommu_new() later attaches an unmanaged domain via
iommu_attach_device(), use_dma_iommu(dev) remains true. In
kernel/dma/mapping.c, dma_go_direct() checks use_dma_iommu(dev) before !ops:

    static bool dma_go_direct(struct device *dev, dma_addr_t mask,
            const struct dma_map_ops *ops)
    {
        if (use_dma_iommu(dev))
            return false;

        if (likely(!ops))
            return true;

As a result, dma_map_sgtable() calls iommu_dma_map_sg(), which allocates a
virtual IOVA in group->default_domain, coalesces physically non-contiguous
segments into contiguous IOVA ranges, and writes that virtual IOVA into
sg_dma_address(sg) and the coalesced length into sg_dma_len(sg). Passing th=
ose
values to __do_map() will program the GPU and display page tables with virt=
ual
IOVAs instead of physical addresses.

[ ... ]
> @@ -684,12 +731,27 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
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
> @@ -697,23 +759,23 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint6=
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

[Severity: High]
Can replacing iommu_map_sgtable() and iommu_unmap() with __do_map() and
__do_unmap() leave stale IOTLB entries behind?

There appear to be three cases where IOTLB maintenance is skipped:

1. In msm_iommu_map(), if __do_map() fails after mapping some pages, it rol=
ls
back the partial mapping via __do_unmap(..., __unmap_iommu). Unlike
msm_iommu_pagetable_map(), msm_iommu_map() does not call
iommu_flush_iotlb_all(domain) on error.

2. In __unmap_iommu(), NULL is passed for the struct iommu_iotlb_gather
pointer to domain->ops->unmap_pages(). In drivers/iommu/io-pgtable-arm.c,
__arm_lpae_unmap() only calls io_pgtable_tlb_add_page() when gather is
non-NULL:

    if (gather && !iommu_iotlb_gather_queued(gather))
        io_pgtable_tlb_add_page(data, gather, iova, size);

On SoCs using drivers/iommu/arm/arm-smmu/qcom_iommu.c,
qcom_iommu_flush_iotlb_all() only issues ARM_SMMU_CB_TLBSYNC via
qcom_iommu_tlb_sync() and relies on qcom_iommu_tlb_add_page() issuing
ARM_SMMU_CB_S1_TLBIVAL during unmap_pages(). Passing gather as NULL skips t=
he
TLB invalidation commands altogether.

3. On APQ8064 (drivers/iommu/msm_iommu.c), msm_iommu_ops implements
.iotlb_sync_map =3D msm_iommu_sync_map while leaving .flush_iotlb_all =3D N=
ULL, so
calling domain->ops->map_pages() directly in msm_iommu_map() bypasses the
iotlb_sync_map callback that iommu_map_sgtable() previously invoked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027152821.5114=
4-1-robin.clark@oss.qualcomm.com?part=3D5
