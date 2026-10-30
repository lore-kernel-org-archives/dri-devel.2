Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFA606A326
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zog0PoNz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C40710E27D;
	Fri, 30 Oct 2026 21:57:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D38510E27D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:57:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 183D842E4D;
 Fri, 30 Oct 2026 21:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32F91F000C1;
 Fri, 30 Oct 2026 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793397465;
 bh=3DyyRVL1StWrJInTrky2413jdI0YqLVPiu7ahcDNj8c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Zog0PoNz0CuibDU1H/5f+eElsKIk9YSF5bTNX/kOB+yS8p1A1bWvLGZAdJC1W6GIK
 mBWx2P7gfP1MecpbdQOxt/oRN/H2hH2DfpnktI/Pbcqmjj22KEKjrxIVwNOylbDa3E
 uMzUQ7l/gJWB4+hPxXNOF523zJMjD9VqIfTLWKt9dxqTdLzKTDKUadanoCe46uFJwy
 rBJWs8Tdj2gfcdR0kUMIME157mauhPoJW1MRGTk4R/e4EaM1Fv40koKhrg1zkBUz7Y
 5OV+FV8J0Ocj5WRBTkhmC/M9XTQrcf+wP3FEHcQgzCEgsMZS05bWNqHS6D9lQCIrO1
 5lzxhKp3fBqUw==
Message-ID: <sashiko-outbox-191557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/msm: Convert map helper to use dma-address
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030213251.55365-6-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
 <20261030213251.55365-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:57:44 +0000
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
- [Critical] drm/msm: bogus physical addresses in __do_map() when dma_iommu=
 is active
--

commit 2ee69d02162f3f85f96721bc094502a3dd37d6fa
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Convert map helper to use dma-address

This commit switches __do_map() in msm_iommu.c from iterating over scatterl=
ist
entries with sg_phys(sg) and sg->length to iterating with
for_each_sgtable_dma_sg(), sg_dma_address(sg), and sg_dma_len(sg) to avoid
issues when CONFIG_DMABUF_DEBUG strips page pointers from scatterlists.

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
As reported by Dmitry Baryshkov on v3 [1], can passing sg_dma_address(sg) a=
nd
sg_dma_len(sg) as physical addresses to ops->map() in __do_map() program bo=
gus
physical addresses into the SMMU page tables when use_dma_iommu() is true on
the DRM DMA device?

In get_pages() in drivers/gpu/drm/msm/msm_gem.c, scatterlists are mapped
against drm_dev_dma_dev(obj->dev):

    ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
                          msm_obj->sgt,
                          DMA_BIDIRECTIONAL,
                          map_attrs);

On platforms where the iommus property is placed directly on obj->dev->dev
(such as MDP/DPU display controller nodes checked in msm_kms_init_vm(), or
when separate_gpu_kms is used) and the IOMMU driver does not return
IOMMU_DOMAIN_IDENTITY from .def_domain_type, the IOMMU core allocates an
IOMMU_DOMAIN_DMA default domain during bus probe and iommu_setup_dma_ops()
sets use_dma_iommu(dev) to true:

    dma_iommu =3D iommu_is_dma_domain(domain);
    dev_assign_dma_iommu(dev, dma_iommu);

This happens, for example, with qcom_iommu_ops in
drivers/iommu/arm/arm-smmu/qcom_iommu.c (used on MSM8916 / db410c) which do=
es
not implement .def_domain_type, and with qcom_smmu_client_of_match in
drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c which does not match qcom,mdp5
display-controller nodes.

When msm_iommu_new() later attaches its own unmanaged domain via
iommu_attach_device(iommu->domain, dev), group->default_domain remains the =
DMA
domain and use_dma_iommu(dev) stays true. As a result, dma_go_direct() retu=
rns
false and dma_map_sgtable() calls iommu_dma_map_sg(), which allocates a
virtual IOVA from the inactive default_domain, coalesces segments into
sg_dma_len(sg), and stores that IOVA in sg_dma_address(sg).

When __do_map() then passes phys =3D sg_dma_address(sg) and size =3D
sg_dma_len(sg) to ops->map() (via msm_iommu_pagetable_map() or
msm_iommu_map()), wouldn't it program virtual IOVAs from the unused default
domain into the active GPU and display page tables as if they were CPU
physical addresses?

[1] https://lore.kernel.org/r/wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpgl=
vwolx@jhnm65bzecnq

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030213251.5536=
5-1-robin.clark@oss.qualcomm.com?part=3D5
