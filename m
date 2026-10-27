Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D9606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMWPhA5F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836CB10F8BA;
	Tue, 27 Oct 2026 23:26:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DAC10F8BA
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:25:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D64C4600C8;
 Tue, 27 Oct 2026 23:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E91F01825;
 Tue, 27 Oct 2026 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793143553;
 bh=YEgWlV7crQ+WCOlIW53tVAGCN0mYEMgF+QmH+D5twEk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bMWPhA5FBpaa4giq/iqeijcN/DRZjEXQz1utspQi7ztI0//t52kVl7mMU3lrbI25J
 mXh333reVuyXFUY7zj8AdsSM7FBAoplTRmEfGwRVZ/osT2I/nagq5dTiioXsvQbpdN
 U1iXA+MuvrraT5jjxRgS0+GmgvYAqmMhPyUhN+2H3I/DFsak11uNf7vozhCc2pOtPj
 vNG4d5iJr3rNIlbMCY0M3fPbrZFffBAgWEBibPrQtYyk8bMucPhxWuoynTGLJ6n/78
 mvFlzfTJz4TYWxBVemeTTwxUgXpaVL4N8078+Pu0JzyDtegWkFSRLNF9y4YWjVJhlN
 Ch78C41Ws05Sw==
Message-ID: <sashiko-outbox-187206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] drm/msm: Convert map helper to use dma-address
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:25:53 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/msm: bogus physical addresses in __do_map() when dma_iommu=
 is active
--

commit b6b3547f9503a1fd43535b38edfaee1a6356607a
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert map helper to use dma-address

This commit switches __do_map() in drivers/gpu/drm/msm/msm_iommu.c from
iterating over scatterlist page entries with for_each_sgtable_sg() and
sg_phys() to iterating over DMA-mapped entries with for_each_sgtable_dma_sg=
(),
sg_dma_len(), and sg_dma_address().

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 479e5450a4dcd..c2950d32c5075 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struc=
t sg_table *sgt, size_t off
>  	u64 addr =3D iova;
>  	unsigned int i;
> =20
> -	for_each_sgtable_sg (sgt, sg, i) {
> -		size_t size =3D sg->length;
> -		phys_addr_t phys =3D sg_phys(sg);
> +	for_each_sgtable_dma_sg (sgt, sg, i) {
> +		size_t size =3D sg_dma_len(sg);
> +		phys_addr_t phys =3D sg_dma_address(sg);

[Severity: Critical]
Could passing sg_dma_address(sg) and sg_dma_len(sg) as physical addresses i=
nto
ops->map() program virtual IOVAs from an inactive default DMA domain into t=
he
GPU and display SMMU page tables on platforms where use_dma_iommu() is true=
 on
drm_dev_dma_dev(obj->dev)?

In drivers/gpu/drm/msm/msm_gem.c:get_pages() (and via dma_buf_map_attachmen=
t()
for PRIME imports), the scatterlist is DMA-mapped against
drm_dev_dma_dev(obj->dev):

    ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
                          msm_obj->sgt,
                          DMA_BIDIRECTIONAL,
                          map_attrs);

On platforms where the iommus property is placed directly on the display
controller node (mdp_dev, which is obj->dev->dev) rather than a parent mdss
node, as handled in drivers/gpu/drm/msm/msm_kms.c:msm_kms_init_vm():

    if (device_iommu_mapped(mdp_dev))
        iommu_dev =3D mdp_dev;
    else if (mdss_dev && device_iommu_mapped(mdss_dev))
        iommu_dev =3D mdss_dev;

and the IOMMU driver does not return IOMMU_DOMAIN_IDENTITY from
.def_domain_type, the IOMMU core allocates a default DMA domain during probe
and drivers/iommu/dma-iommu.c:iommu_setup_dma_ops() sets dev->dma_iommu:

    dma_iommu =3D iommu_is_dma_domain(domain);
    dev_assign_dma_iommu(dev, dma_iommu);

For example, drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:
qcom_smmu_client_of_match[] does not list "qcom,mdp5" (affecting MDP5
platforms such as SDM630, SDM660, and MSM8996), and qcom_iommu_ops in
drivers/iommu/arm/arm-smmu/qcom_iommu.c does not implement .def_domain_type=
 at
all.

When msm_iommu_new() later attaches an unmanaged domain via
iommu_attach_device(), group->default_domain remains the DMA domain and
use_dma_iommu(dev) stays true. As a result, kernel/dma/mapping.c:
dma_go_direct() returns false even when get_dma_ops(dev) is NULL:

    if (use_dma_iommu(dev))
        return false;

    if (likely(!ops))
        return true;

This causes dma_map_sgtable() to call iommu_dma_map_sg(), which allocates
virtual IOVAs from the inactive group->default_domain, coalesces segments, =
and
stores those IOVAs and coalesced lengths into sg_dma_address(sg) and
sg_dma_len(sg).

When __do_map() subsequently passes phys =3D sg_dma_address(sg) and
size =3D sg_dma_len(sg) to io_pgtable_ops->map_pages() or
iommu_domain->ops->map_pages() (which expect CPU physical addresses), won't
this map bogus physical addresses into the active GPU and display page tabl=
es?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027230452.1300=
31-1-robin.clark@oss.qualcomm.com?part=3D5
