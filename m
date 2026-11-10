Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC9606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MR3MfKVF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE0310EE7D;
	Tue, 10 Nov 2026 08:04:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1B210EE7D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:03:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58AD540F07;
 Tue, 10 Nov 2026 08:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBF91F0089F;
 Tue, 10 Nov 2026 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794297834;
 bh=3iTWUeRBQqYrd8pGeKq1N6Bp1xaeJhOLD2vBMKkKmUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MR3MfKVFyHZ55HOj9qygjnQywZttAKYLhgs+R9NbK4/EBnHbIcr7F0hVRM0N/MLWF
 G3EJNfGPIeesqHEqW6FKoleE1/QxZup6SBUO8nLY12mvMAsi5OquQV5BX2VAK3flR9
 nxT7E4IPgbnxJsVoFzuDBGPTW5cWSyVJke2xOUwhlULnusVQzkknjMqkihKtgiaW+D
 Z6TY2vZSRrqa+oZXEFWofVFVYtNtNUIAf+Ck/xVd45JdeeWP4CUUEFKQgXBp+NbeVO
 c2X+8u1jsjI6gvzPqm6/dVCnIOOjhnUZuJy1NgTWLyvnheDv5kCsPvcD/CBhDMC1Mf
 u6WLfLgy8i/1Q==
Message-ID: <sashiko-outbox-206561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/panfrost: Give back the pages of a heap chunk
 that failed to map
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-panfrost-long-jobs-v1-3-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
 <20261110-panfrost-long-jobs-v1-3-24508939ae8d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:03:53 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/panfrost: partial cleanup of >2MB folios in
  panfrost_heap_put_chunk()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/panfrost: NULL pointer dereference in
  panfrost_gem_sync() on heap BOs [1]
--

commit afb30e586f33dffb885482044302a7b61909475c
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Give back the pages of a heap chunk that failed to map

This commit adds panfrost_heap_put_chunk() to release folios and clear page
array entries when mapping a 2 MB heap chunk fails in
panfrost_mmu_map_fault_addr().

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index ba37da4992307..13728b0c46efc 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -597,6 +597,28 @@ addr_to_mapping(struct panfrost_device *pfdev, int a=
s, u64 addr)
> =20
>  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
> =20
> +static void panfrost_heap_put_chunk(struct page **pages, pgoff_t start,
> +				    pgoff_t end)
> +{
> +	pgoff_t pg =3D start;
> +
> +	while (pg < end) {
> +		struct folio *folio;
> +		pgoff_t n;
> +
> +		if (!pages[pg]) {
> +			pg++;
> +			continue;
> +		}
> +
> +		folio =3D page_folio(pages[pg]);
> +		n =3D folio_nr_pages(folio);
> +		for (pgoff_t i =3D 0; i < n && pg < end; i++)
> +			pages[pg++] =3D NULL;
> +		folio_put(folio);
> +	}
> +}
> +
>  static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, in=
t as,
>  				       u64 addr)
>  {
> @@ -671,7 +693,7 @@ static int panfrost_mmu_map_fault_addr(struct panfros=
t_device *pfdev, int as,
>  		folio =3D shmem_read_folio(mapping, pg);
>  		if (IS_ERR(folio)) {
>  			ret =3D PTR_ERR(folio);
> -			goto err_unlock;
> +			goto err_put_chunk;
>  		}

[Severity: Critical]
This problem wasn't introduced by this patch, but can calling
panfrost_gem_sync() on a heap BO [1] cause a NULL pointer dereference?

On coherent devices (pfdev->coherent is true), should_map_wc() returns
false, so panfrost_gem_sync() does not return early on shmem->map_wc and
calls drm_gem_shmem_get_pages_sgt():

drivers/gpu/drm/panfrost/panfrost_gem.c:panfrost_gem_sync() {
	...
	if (shmem->map_wc)
		return 0;

	/* Nothing to do if the size is zero. */
	if (size =3D=3D 0)
		return 0;

	sgt =3D drm_gem_shmem_get_pages_sgt(shmem);
	...
}

If a heap BO has already faulted in at least one chunk, bo->base.pages is
non-NULL with NULL entries for unfaulted chunks and bo->base.sgt is NULL, so
drm_gem_shmem_get_pages_sgt() passes the sparse bo->base.pages array to
drm_prime_pages_to_sg() and dereferences NULL page pointers.  Conversely, if
panfrost_gem_sync() runs before the first GPU fault on the heap BO,
drm_gem_shmem_get_pages_sgt() populates bo->base.pages while leaving
bo->sgts NULL, and a later fault in panfrost_mmu_map_fault_addr() skips
allocating bo->sgts and dereferences NULL when indexing bo->sgts.

[ ... ]

> @@ -720,6 +742,14 @@ static int panfrost_mmu_map_fault_addr(struct panfro=
st_device *pfdev, int as,
>  	dma_unmap_sgtable(pfdev->base.dev, sgt, DMA_BIDIRECTIONAL, 0);
>  err_map:
>  	sg_free_table(sgt);
> +err_put_chunk:
> +	/*
> +	 * Give back the folios read for this chunk, so that the next fault in
> +	 * it (the chunk has no sg table yet) starts from an empty page range
> +	 * instead of finding it partly owned.
> +	 */
> +	panfrost_heap_put_chunk(pages, page_offset,
> +				min_t(pgoff_t, page_offset + NUM_FAULT_PAGES, nr_pages));

[Severity: Medium]
Can panfrost_heap_put_chunk() leave dangling page pointers or drop an active
folio reference when shmem_read_folio() returns a folio larger than 2 MB?

With PAGE_SIZE > 4 KB (such as 16 KB or 64 KB pages on arm64) and
transparent hugepages enabled, shmem_read_folio() on the huge=3Dwithin_size
mount can return a folio with folio_nr_pages(folio) > NUM_FAULT_PAGES.  The
fill loop in panfrost_mmu_map_fault_addr() aligns pg down to the folio
boundary and populates pages[] across the entire folio:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_map_fault_addr() {
		...
		pg &=3D ~(folio_nr_pages(folio) - 1);
		for (u32 i =3D 0; i < folio_nr_pages(folio) && pg < nr_pages; i++) {
			if (pages[pg])
				already_owned =3D true;

			pages[pg++] =3D folio_page(folio, i);
		}
}

On error, panfrost_heap_put_chunk() only clears pages[] within
[page_offset, page_offset + NUM_FAULT_PAGES) before calling
folio_put(folio).  Any pages[] slots populated for that folio in adjacent
2 MB chunks remain non-NULL after the folio reference is dropped (or if an
adjacent chunk was already mapped and the duplicate reference was dropped v=
ia
already_owned, folio_put(folio) drops the mapped chunk's reference), leading
to a second folio_put() in drm_gem_put_pages() when the BO is freed and a
folio use-after-free.

[1] https://sashiko.dev/#/bug/linux-fe4f761b-d268-4774-87c0-3f0de658e362

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-panfrost-l=
ong-jobs-v1-0-24508939ae8d@gmail.com?part=3D3
