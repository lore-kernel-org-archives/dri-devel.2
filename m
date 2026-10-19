Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1C6078868
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrqKiDRS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1798710EDF5;
	Mon, 19 Oct 2026 14:59:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769FD10E98A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:59:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3ED9841B65
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041191F000C4;
 Mon, 19 Oct 2026 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792421983;
 bh=I684XN2MGodvp1oMLFZvn51pkX/fBn8JAjHJrhlQ2DA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SrqKiDRS8viTMCGH6XpkOKc5ZWUVoO71w6SBQlQJL2HlUV0FGU90CZl9ku8ulStXA
 6dx8CdwyyJ0ZRhwfX0J8j4TcZxB6SnK4A5/NQ2tdAzgz1Mzrj1uplHLIP209dpj0sE
 4QFHDTrkSwk2upFHJW2XqDyR+2gkW6+t/oclHq7pF+IyVP8sKeKdFB1Drr7D1PuTBE
 BTDIkGUMyOWg4eNFr79hSg/nDLcWFoOhDNJmYvh6+wp5glRdu/7RfdnniNmWF97XeB
 k8UZassSZJwHSxfh3ztfL/1Lsj38t5RyuXPCLJW2feFLSWpUcUHdf8NoeZAE4qvQeW
 XTIXFXI53cRmg==
Message-ID: <sashiko-outbox-177584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/msm: detach the ARM DMA mapping before
 attaching our own domain
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-276-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-276-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:59:42 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: NULL dereference in __free_iova() via msm_iommu_new() det=
ach
--

commit 8a10d4b676f6bf2e4f498788e23c54cc872ffbc5
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: detach the ARM DMA mapping before attaching our own domain

This commit detaches and releases the default ARM32 DMA IOMMU mapping in
msm_iommu_new() before attaching the driver's own IOMMU domain so that
__iommu_attach_group() does not fail with -EBUSY on ARM32 platforms with
CONFIG_ARM_DMA_USE_IOMMU enabled.

Link: https://lore.kernel.org/r/20260730-fix-qcom-smmu-v2-3-18e0daf2d836@os=
s.qualcomm.com

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 82a172f21a3ec..41a4eaa1b8fd9 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c

[ ... ]

> @@ -746,6 +755,19 @@ struct msm_mmu *msm_iommu_new(struct device *dev, un=
signed long quirks)
> =20
>  	mutex_init(&iommu->init_lock);
> =20
> +	/*
> +	 * ARM32 attaches a DMA mapping domain to every IOMMU-backed device,
> +	 * which would make attaching our own domain fail with -EBUSY.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
> +		struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +
> +		if (mapping) {
> +			arm_iommu_detach_device(dev);
> +			arm_iommu_release_mapping(mapping);
> +		}
> +	}

[Severity: High]
Could backporting this patch without the rest of its upstream series cause a
NULL pointer dereference in __free_iova() when probing the GPU or display
controller on APQ8064?

Upstream commit 140b13475302 ("drm/msm: detach the ARM DMA mapping before
attaching our own domain") is patch 3/3 of the series at
20260730-fix-qcom-smmu-v2-3-18e0daf2d836@oss.qualcomm.com, alongside two
prerequisite fixes in drivers/iommu/msm_iommu.c:

  1/3: "iommu/msm: track a context master per device and IOMMU"
  2/3: "iommu/msm: use the IOMMU device for page table allocation"

Neither of those prerequisite patches is present in this tree.

During initial DMA setup in arm_setup_iommu_dma_ops(),
__arm_iommu_attach_device(dev, mapping) runs before set_dma_ops(dev,
&iommu_ops). Without patch 2/3, msm_iommu_attach_dev() and
msm_iommu_domain_config() set priv->cfg.iommu_dev to the client device (dev)
instead of the IOMMU hardware device:

drivers/iommu/msm_iommu.c:msm_iommu_domain_config() {
	priv->cfg =3D (struct io_pgtable_cfg) {
		.pgsize_bitmap =3D priv->domain.pgsize_bitmap,
		.ias =3D 32,
		.oas =3D 32,
		.tlb =3D &msm_iommu_flush_ops,
		.iommu_dev =3D priv->dev,
	};
}

When alloc_io_pgtable_ops() allocates the L1 page table in
__arm_v7s_alloc_table(), dev->dma_ops is still NULL, so dma_map_single() us=
es
direct DMA and returns the physical RAM address virt_to_phys(data->pgd)
without allocating an IOVA in mapping. Afterward, arm_setup_iommu_dma_ops()
sets dev->dma_ops =3D &iommu_ops.

When msm_iommu_new() now calls arm_iommu_detach_device(dev),
iommu_detach_device() runs while dev->dma_ops is still &iommu_ops:

arch/arm/mm/dma-mapping.c:arm_iommu_detach_device() {
	...
	iommu_detach_device(mapping->domain, dev);
	kref_put(&mapping->kref, release_iommu_mapping);
	to_dma_iommu_mapping(dev) =3D NULL;
	set_dma_ops(dev, NULL);
}

This triggers the following call chain:

  iommu_detach_device(mapping->domain, dev)
    -> msm_iommu_identity_attach()
      -> free_io_pgtable_ops(priv->iop)
        -> arm_v7s_free_pgtable()
          -> __arm_v7s_free_table()
            -> dma_unmap_single(cfg->iommu_dev, __arm_v7s_dma_addr(table), =
...)
              -> arm_iommu_unmap_page()
                -> __free_iova(mapping, iova, len)

Because cfg->iommu_dev is the client device and dev->dma_ops is still
&iommu_ops, arm_iommu_unmap_page() treats the page table's physical RAM
address (for example >=3D 0x80000000 on APQ8064) as an IOVA handle in
mapping->domain, hits WARN_ON(!ARM_V7S_PTE_IS_VALID(pte[i])) in iommu_unmap=
(),
and passes that address to __free_iova():

arch/arm/mm/dma-mapping.c:__free_iova() {
	...
	spin_lock_irqsave(&mapping->lock, flags);
	bitmap_clear(mapping->bitmaps[bitmap_index], start, count);
	spin_unlock_irqrestore(&mapping->lock, flags);
}

Since arm_iommu_create_mapping() initializes mapping with base =3D 0,
mapping_size =3D 128 MB, extensions =3D 32, and nr_bitmaps =3D 1 (leaving
mapping->bitmaps[1..31] NULL), a physical address >=3D 0x80000000 yields
bitmap_index >=3D 16 and dereferences a NULL mapping->bitmaps[bitmap_index]=
 (or
hits BUG_ON(bitmap_index >=3D mapping->nr_bitmaps) if out of range).

In addition, this tree includes commit da33e87bd2bf ("iommu: Handle yet
another race around registration") without patch 1/3 ("iommu/msm: track a
context master per device and IOMMU"), so find_iommu_for_dev() and
msm_iommu_attach_dev() call list_first_entry(&iommu->ctx_list, ...) on IOMMU
instances whose ctx_list is still empty, and insert_iommu_master() does not
track per-IOMMU context masters for devices attached to two IOMMU instances
(gfx3d/gfx3d1 for the GPU and mdp_port0/mdp_port1 for MDP4).

Should patches 1/3 and 2/3 from the same series also be backported before
this change?

> +
>  	ret =3D iommu_attach_device(iommu->domain, dev);
>  	if (ret) {
>  		iommu_domain_free(domain);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-276-sashal@kernel.org?part=3D1
