Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE70606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fejUhc/t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6C110E1C0;
	Mon, 26 Oct 2026 12:33:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F67710E1C0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:33:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECA494396E;
 Mon, 26 Oct 2026 12:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79EF1F01828;
 Mon, 26 Oct 2026 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793017979;
 bh=Ja62S+qA5E7SwUb8tQK+Ee9SdG5q8k/sV2OR2KuIYkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fejUhc/tEuY22faUMAovotXCGW0rutU/Zx8C5bQdRevhIPLikDlTwtse5zSCsQ0k2
 LW/Kpr9xT9rTHq3tex+X4nTb44aNo0Ys3e05fNNzOGchsvfScixRl00gdDH5WISeRd
 C4C71iS+Qx8UBp6FpZKlvvxJQk0GHqRBPMmT7G3+tmKlRCVJp8iy6Fqk074GBA+xsO
 sB6rGQDkFf0+gNE1O3QSV7271cxCNof0p8nvYeHwNiLF7wCCXTwPKcpeAAHzFxf/uR
 mjzbZCka6eItOR4zRRdF7X1NmBT5CYxTrOv9QV5GxRufVwL4jozFlmI0wrQcNI5IuX
 4FWe7lcSW9G9A==
Message-ID: <sashiko-outbox-185215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: Use shmem for DMA IOMMU buffer allocations
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-b4-tegradrm-allocate-shmem-v1-1-eae07ab827d6@nvidia.com>
References: <20261026-b4-tegradrm-allocate-shmem-v1-1-eae07ab827d6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:32:59 +0000
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
- [High] drm/tegra: use_direct_dma not set in host1x_client_iommu_attach()
- [High] drm/tegra: missing chunk count in tegra_bo_pin() for shmem BOs
--

commit 12a809963b5e12b284858a4f0ff8bc1a58e8b048
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: Use shmem for DMA IOMMU buffer allocations

This commit records whether host1x clients are attached to a DMA IOMMU
domain during initialization and uses drm_gem_get_pages() via
tegra_bo_get_pages() for buffer allocations when DMA IOMMU is active. In
mixed IOMMU and direct DMA configurations, it attempts to fall back to
contiguous DMA allocations.

> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 324480c87fb1f..1013bbd662f84 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -958,14 +958,10 @@ int host1x_client_iommu_attach(struct host1x_client=
 *client)
>  	}
>  #endif
> =20
> -	/*
> -	 * If the host1x client is already attached to an IOMMU domain that is
> -	 * not the shared IOMMU domain, don't try to attach it to a different
> -	 * domain. This allows using the IOMMU-backed DMA API.
> -	 */
> -	if (domain && domain->type !=3D IOMMU_DOMAIN_IDENTITY &&
> -	    domain !=3D tegra->domain)
> +	if (domain && iommu_is_dma_domain(domain)) {
> +		tegra->use_dma_iommu =3D true;
>  		return 0;
> +	}
> =20
>  	if (tegra->domain) {
>  		group =3D iommu_group_get(client->dev);
> @@ -981,6 +977,8 @@ int host1x_client_iommu_attach(struct host1x_client *=
client)
>  		}
> =20
>  		tegra->use_explicit_iommu =3D true;
> +	} else {
> +		tegra->use_direct_dma =3D true;
>  	}

[Severity: High]
Can tegra->use_direct_dma remain unset when a direct-DMA client is
initialized while tegra->domain is speculatively allocated?

In host1x_drm_probe(), tegra->domain is allocated before
host1x_device_init() runs whenever the parent host1x device is IOMMU-mapped,
and is only freed after host1x_device_init() completes:

drivers/gpu/drm/tegra/drm.c:host1x_drm_probe() {
	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dma_dev)) {
		tegra->domain =3D iommu_paging_domain_alloc(dma_dev);
		...
	}
	...
	err =3D host1x_device_init(dev);
	...
	if (tegra->use_explicit_iommu) {
		...
	} else if (tegra->domain) {
		iommu_domain_free(tegra->domain);
		tegra->domain =3D NULL;
		iova_cache_put();
	}
}

When a client without an IOMMU group calls host1x_client_iommu_attach()
during host1x_device_init(), tegra->domain is non-NULL, so execution enters
the if (tegra->domain) branch instead of the else branch:

drivers/gpu/drm/tegra/drm.c:host1x_client_iommu_attach() {
	if (tegra->domain) {
		group =3D iommu_group_get(client->dev);
		if (!group)
			return -ENODEV;
}

Client initialization callbacks such as tegra_dc_init() ignore -ENODEV and
continue operating in direct-DMA mode:

drivers/gpu/drm/tegra/dc.c:tegra_dc_init() {
	err =3D host1x_client_iommu_attach(client);
	if (err < 0 && err !=3D -ENODEV) {
		dev_err(client->dev, "failed to attach to domain: %d\n", err);
		return err;
	}
}

Because host1x_client_iommu_attach() returned -ENODEV early without setting
tegra->use_direct_dma =3D true, the mixed-configuration check in
host1x_drm_probe() (if (tegra->use_dma_iommu && tegra->use_direct_dma)) will
not trigger, leaving tegra->use_dma_iommu enabled and allocating
discontiguous shmem buffers that direct-DMA clients cannot use.

Should tegra->use_direct_dma =3D true also be set before returning -ENODEV
when !group?

[ ... ]

> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index f76af733ea793..bb8d9f9e64534 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -111,10 +111,6 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct=
 device *dev, struct host1x_
>  	}
> =20
>  	if (obj->pages) {
> -		/*
> -		 * If the buffer object was allocated from the explicit IOMMU
> -		 * API code paths, construct an SG table from the pages.
> -		 */
>  		err =3D sg_alloc_table_from_pages(map->sgt, obj->pages, obj->num_pages=
, 0, gem->size,
>  						GFP_KERNEL);
>  		if (err < 0)

[Severity: High]
With shmem-backed buffers now taking the obj->pages path in tegra_bo_pin()
when tegra->use_dma_iommu is enabled (where obj->mm is NULL), does
map->chunks get set to 0 instead of the mapped scatterlist chunk count?

Looking at tegra_bo_pin() in drivers/gpu/drm/tegra/gem.c:

	if (obj->pages) {
		err =3D sg_alloc_table_from_pages(map->sgt, obj->pages, obj->num_pages, 0=
, gem->size,
						GFP_KERNEL);
		if (err < 0)
			goto free;
	} else {
		...
	}

	err =3D dma_map_sgtable(dev, map->sgt, direction, 0);
	if (err)
		goto free_sgt;

out:
	if (!obj->mm) {
		map->phys =3D sg_dma_address(map->sgt->sgl);
		map->chunks =3D err;
	} else {
		map->phys =3D obj->iova;
		map->chunks =3D 1;
	}

Unlike the obj->dma_buf path above it which sets
err =3D sgt_dma_count_chunks(map->sgt), the non-imported path leaves err as=
 0
(the return value of dma_map_sgtable()).

When !obj->mm is true, map->chunks is assigned 0, which bypasses the
if (map->chunks > 1) contiguity checks in tegra_dc_pin() and host1x's
pin_job() if the DMA mapping is not coalesced into a single contiguous
chunk.

Should err =3D sgt_dma_count_chunks(map->sgt) be called after
dma_map_sgtable() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-tegradr=
m-allocate-shmem-v1-1-eae07ab827d6@nvidia.com?part=3D1
