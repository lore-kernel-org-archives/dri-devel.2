Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811F606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAqWBtDM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110610E379;
	Mon, 26 Oct 2026 19:11:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6311D10E379
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1840A43925;
 Mon, 26 Oct 2026 19:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49131F031E0;
 Mon, 26 Oct 2026 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793041895;
 bh=N+7+96iYzCn2z5dU+2HKLKLzhcOYCzZWe8+Aw3Gq5WI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SAqWBtDMzMd9heBEfpPjyrN4eNMLACyMgRoNshx6fSS7Y2n32js5dLcF68I/KA5KY
 7o/dlKDqSS2niwVOrHw+CiAl4Uy3yf7BZA9bM57N+fEk82rRC9Xy3MVXNByQVZPzYx
 cSyjAbLmYLFOSe3S5ynnCBbF7QWJie+1Dg2Rzjln0Qxu3Reho1E5eS5CFGw8Gpcy0D
 N6NeTC0bgfWF4AFY90BJwlPL9ABaA20OdpuGkNY6qknxK9oZ2OdTGOBLEvVHSZbwWl
 0ZO9GF5ySrSq5QGqxUjXjnl6qT5zEGer2Ovy3F6KmDnQXlQGqPxwU8kzZ7AHirwohC
 GECdBUuGwltzg==
Message-ID: <sashiko-outbox-185656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027-fastrpc-kvm-iommu-v3-v3-1-f3cd5c030c78@oss.qualcomm.com>
References: <20261027-fastrpc-kvm-iommu-v3-v3-1-f3cd5c030c78@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:11:34 +0000
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
- [Critical] misc: fastrpc: fastrpc_remote_heap_map() maps unallocated CMA =
pages to DSP
--

commit 4898c75b9b126cd912353d04edaa3233af524f7c
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: map ADSP remote heap into remoteproc IOMMU domain

This commit detects whether the remoteproc DT node has an "iommus" property
and maps the ADSP remote heap carveout into the remoteproc's IOMMU domain
via iommu_map() instead of calling qcom_scm_assign_mem(). It also extracts
fastrpc_remote_heap_release() to tear down the mapping or SCM assignment on
driver removal and probe error paths.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5ac7b3e78ba7e..398bcd0cfab48 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2536,6 +2650,19 @@ static int fastrpc_init_reserved_mem(struct fastrp=
c_channel_ctx *cctx,
>  	if (domain_id =3D=3D ADSP_DOMAIN_ID) {
>  		cctx->remote_heap_addr =3D res.start;
>  		cctx->remote_heap_size =3D resource_size(&res);
> +
> +		rproc_node =3D fastrpc_get_rproc_node(rdev->of_node);
> +		if (rproc_node)
> +			cctx->use_iommu_map =3D of_property_present(rproc_node, "iommus");
> +
> +		if (cctx->use_iommu_map) {
> +			err =3D fastrpc_remote_heap_map(rdev, rproc_node, res.start,
> +						      resource_size(&res));
> +			of_node_put(rproc_node);
> +			return err;
> +		}

[Severity: Critical]
Does this map unallocated CMA pages into the ADSP IOMMU domain when the
reserved-memory region is defined as a reusable shared-dma-pool?

On platforms where remoteproc_adsp has an "iommus" property and
adsp_rpc_remote_heap_mem is a reusable CMA pool (such as
arch/arm64/boot/dts/qcom/glymur.dtsi and arch/arm64/boot/dts/qcom/talos.dtsi
with talos-el2.dtso):

	adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
		compatible =3D "shared-dma-pool";
		alloc-ranges =3D <0x0 0x80000000 0x0 0x80000000>;
		reusable;
		alignment =3D <0x0 0x400000>;
		size =3D <0x0 0x800000>;
	};

During boot, rmem_cma_setup() in kernel/dma/contiguous.c initializes this
region as a CMA pool, and cma_init_reserved_areas() -> cma_activate_area()
releases all pageblocks in [rmem->base, rmem->base + rmem->size) into the
Linux buddy allocator for movable allocations.

In fastrpc_rpmsg_probe(), devm_of_reserved_mem_device_init(rdev) calls
rmem_cma_device_init(), which only sets rdev->cma_area without allocating
any pages from CMA.

fastrpc_init_reserved_mem() then retrieves rmem->base and rmem->size via
of_reserved_mem_region_to_resource(rdev->of_node, 0, &res) without calling
dma_alloc_coherent() or cma_alloc() to allocate and migrate movable pages
out of the CMA range. When cctx->use_iommu_map is true,
fastrpc_remote_heap_map() maps [res.start, res.start + size) with
IOMMU_READ | IOMMU_WRITE into the remoteproc IOMMU domain, and
fastrpc_init_create_static_process() hands this range to the ADSP as its
remote heap while the physical pages remain in the kernel buddy allocator
and can be concurrently used by userspace processes, page cache, or
fastrpc_remote_heap_alloc() buffers.

(Similarly, on non-IOMMU platforms with a reusable shared-dma-pool, calling
qcom_scm_assign_mem() on the unallocated range revokes HLOS permissions on
pages that are still in the kernel linear map and page allocator.)

Should the driver allocate the region through the DMA/CMA API before mapping
or assigning it to the DSP, or should these regions not be marked reusable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fastrpc-kv=
m-iommu-v3-v3-1-f3cd5c030c78@oss.qualcomm.com?part=3D1
