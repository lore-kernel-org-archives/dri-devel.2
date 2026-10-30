Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92A606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W7bQjWyx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE0210E291;
	Fri, 30 Oct 2026 21:46:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ADF10E291
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:46:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4885F418BF;
 Fri, 30 Oct 2026 21:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279D1F000C1;
 Fri, 30 Oct 2026 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793396779;
 bh=A8bty2xhpQEFt8XdfhZdrJMH6VRl1vFFWjPnQkRB0U4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=W7bQjWyxx0G83VBTtw/JxxuoHOmXkFi9A212AR09YwP187iUP00qFjByoH4GgSJic
 FN+rCJpRTwYHDqkrFqMhhpqLnyLnO8eGVB3hhBTetkPo88m32aqy62uKUSNTs2dgue
 +uaY0BQAkwTqOUDq0ROnnWvP07+Sg3cXdYVHlu9y0HvYwmKrGIK6/xxBeRxLlNX8FO
 Jl2/z2tzoi+0lB1InDXZUJkMYl+ulkH4295bNprDUI8+Xyea7qXCevzFdn9kk9bEYs
 Owiw2RcMatIMS+F8MrdhoUAueg5DajfpVlBVisLx5ZHI7c6KGcdzyBV/AfHTi3LsLm
 l5mYbYScTH5uQ==
Message-ID: <sashiko-outbox-191550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/msm/gem: dma_map/unmap_sgtable()
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030213251.55365-3-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
 <20261030213251.55365-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:46:18 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/gem: dma_map_sgtable() in get_pages() uses iommu-dma on MD=
P IOMMUs
--

commit e379fa230053c8f948229c260c41caa88a3e753f
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: dma_map/unmap_sgtable()

This commit inlines sync_for_device() and sync_for_cpu() into get_pages()
and put_pages(), calling dma_map_sgtable() and dma_unmap_sgtable() on all
GEM objects using DMA_ATTR_SKIP_CPU_SYNC for cached buffers to populate the
scatterlist DMA addresses and lengths.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 181b9ad326729..bcdb57866cf6c 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c

[ ... ]

> @@ -219,13 +192,20 @@ static struct page **get_pages(struct drm_gem_objec=
t *obj)
>  			goto error;
>  		}
> =20
> -		update_device_mem(dev->dev_private, obj->size);
> -
> -		/* For non-cached buffers, ensure the new pages are clean
> -		 * because display controller, GPU, etc. are not coherent:
> -		 */
> +		/* For non-cached buffers, ensure the new pages are clean. */
>  		if (msm_obj->flags & MSM_BO_WC)
> -			sync_for_device(msm_obj);
> +			map_attrs =3D 0;
> +
> +		ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
> +				      msm_obj->sgt,
> +				      DMA_BIDIRECTIONAL,
> +				      map_attrs);
> +		if (ret) {
> +			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
> +			goto error;
> +		}

[Severity: High]
As reported by Sashiko on v3 [1], will calling dma_map_sgtable() on
drm_dev_dma_dev(obj->dev) in get_pages() invoke iommu_dma_map_sg() instead
of dma_direct_map_sg() on platforms where the display controller device has
an IOMMU attached directly to the MDP node?

In msm_kms_init_vm(), the IOMMU can be attached directly to mdp_dev
(which is obj->dev->dev, returned by drm_dev_dma_dev(obj->dev)):

drivers/gpu/drm/msm/msm_kms.c:msm_kms_init_vm() {
	if (device_iommu_mapped(mdp_dev))
		iommu_dev =3D mdp_dev;
	else if (mdss_dev && device_iommu_mapped(mdss_dev))
		iommu_dev =3D mdss_dev;
}

This occurs on qcom_iommu platforms (such as MSM8916, MSM8939, MSM8953, and
MSM8976) where qcom_iommu_ops does not implement def_domain_type, as well as
on arm-smmu-qcom MDP5 platforms (such as MSM8996, SDM630, and SDM660) where
the iommus property is on the qcom,mdp5 node rather than the parent mdss
node and is not matched by qcom_smmu_client_of_match[]:

drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:
static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused=
 =3D {
	{ .compatible =3D "qcom,adreno" },
	{ .compatible =3D "qcom,adreno-gmu" },
	{ .compatible =3D "qcom,glymur-mdss" },
	{ .compatible =3D "qcom,mdp4" },
	{ .compatible =3D "qcom,mdss" },
...

On these platforms, iommu_setup_dma_ops() allocates a DMA default_domain and
sets use_dma_iommu(dev) to true on obj->dev->dev. When msm_iommu_new() later
attaches an unmanaged domain via iommu_attach_device(), use_dma_iommu(dev)
and group->default_domain remain set.

Even though get_dma_ops(dev) is NULL, dma_go_direct() checks
use_dma_iommu(dev) before checking ops:

kernel/dma/mapping.c:dma_go_direct() {
	if (use_dma_iommu(dev))
		return false;

	if (likely(!ops))
		return true;
}

As a result, get_pages() -> dma_map_sgtable() -> __dma_map_sg_attrs() routes
into iommu_dma_map_sg() for every GEM object (now including MSM_BO_CACHED
buffers). That maps the buffer into the unused group->default_domain,
coalesces sgt->nents, and populates sg_dma_address(sg) with default_domain
IOVAs rather than CPU physical addresses.

When paired with commit 2ee69d02162f ("drm/msm: Convert map helper to use
dma-address") later in this series, where __do_map() in
drivers/gpu/drm/msm/msm_iommu.c passes sg_dma_address(sg) as the physical
address to iommu_map(), won't this program the GPU and display page tables
with default_domain IOVAs instead of physical addresses?

[1] https://lore.kernel.org/r/20261027230452.130031-3-robin.clark@oss.qualc=
omm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030213251.5536=
5-1-robin.clark@oss.qualcomm.com?part=3D2
