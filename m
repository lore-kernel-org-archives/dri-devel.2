Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E37606A88C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPU2JCDD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B1010E501;
	Thu, 12 Nov 2026 09:13:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F0D10E501
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53E13630A8;
 Thu, 12 Nov 2026 09:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55041F00A05;
 Thu, 12 Nov 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794474775;
 bh=7v1e5YoklzILMe/mVDPlYMcGESORfDn8f9Taqws/RuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NPU2JCDDth9mbhaqjWUcMwYvAwl197zPT5W+jEGC/7DzXA3W57yKn9rAhLL7NJDOj
 1Il4SEZPwgzgaE5WQFLJ3+99B5mZDP/uEPpV3SS47qW0e3JT4y96riD1c8GXNEGXTL
 N2H+tYtxV2MPWTqLxfKR8UPWr2VkP4UIbDfo1V0Cb7KJ9k/qor1xpmMEKsycx78SBR
 eZQ+pQbqLszX5JLM3As+jiKuZIfsXdVMgB+PWGJVkoMHOUYPoTl09obrqh7YqxZOQt
 WdTf5lae+rEKQRpMrj4pWOX5sTmBI6a1dZ6xmp54omLrFS9yJO3aYBokE64TQOfWHZ
 Me971cS1EiTIw==
Message-ID: <sashiko-outbox-210837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] drm/panfrost: Give back the pages of a heap
 chunk that failed to map
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-panfrost-long-jobs-v2-6-a06830da3d99@gmail.com>
References: <20261112-panfrost-long-jobs-v2-0-a06830da3d99@gmail.com>
 <20261112-panfrost-long-jobs-v2-6-a06830da3d99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:12:54 +0000
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
- [Medium] drm/panfrost: false drm_WARN_ON() in
  panfrost_mmu_map_fault_addr()
--

commit 455071c10d7f5d95d3ce18757e41ef79db6b9400
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/panfrost: Give back the pages of a heap chunk that failed to map

This commit releases the shmem folios read during a heap BO fault and
clears their entries in bo->base.pages if mapping the 2 MB fault chunk
fails.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 35fb86b6b3242..6847359374e53 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
[ ... ]
> @@ -670,17 +696,23 @@ static int panfrost_mmu_map_fault_addr(struct panfr=
ost_device *pfdev, int as,
>  	mapping =3D bo->base.base.filp->f_mapping;
>  	mapping_set_unevictable(mapping);
> =20
> +	/* The page array range whose folio references this fault takes. */
> +	got_start =3D page_offset;
> +	got_end =3D page_offset;
> +
>  	for (pgoff_t pg =3D page_offset; pg < page_offset + NUM_FAULT_PAGES;) {
>  		bool already_owned =3D false;
>  		struct folio *folio;
> +		pgoff_t first;
> =20
>  		folio =3D shmem_read_folio(mapping, pg);
>  		if (IS_ERR(folio)) {
>  			ret =3D PTR_ERR(folio);
> -			goto err_unlock;
> +			goto err_put_chunk;
>  		}
> =20
>  		pg &=3D ~(folio_nr_pages(folio) - 1);
> +		first =3D pg;
>  		for (u32 i =3D 0; i < folio_nr_pages(folio) && pg < nr_pages; i++) {
>  			if (pages[pg])
>  				already_owned =3D true;
> @@ -692,14 +724,18 @@ static int panfrost_mmu_map_fault_addr(struct panfr=
ost_device *pfdev, int as,
>  		 * there's no valid reason for a folio range to be partially
>  		 * populated.
>  		 */
> -		if (drm_WARN_ON(&pfdev->base, already_owned))
> +		if (drm_WARN_ON(&pfdev->base, already_owned)) {
>  			folio_put(folio);
> +		} else {
> +			got_start =3D min(got_start, first);
> +			got_end =3D max(got_end, pg);
> +		}
>  	}

[Severity: Medium]
Should drm_WARN_ON() be removed when already_owned is true for a folio
larger than 2 MB?

When shmem returns a folio larger than the 2 MB fault chunk (such as a
PMD-sized or multi-megabyte THP folio on 16K or 64K page kernels), the
first chunk fault populates pages[] for the entire folio across
neighbouring 2 MB chunks, while only mapping the sg_table for the faulting
2 MB chunk.  The new else branch relies on already_owned being true when
those neighbouring 2 MB chunks later fault so that [got_start, got_end)
does not claim their shared folio, but keeping drm_WARN_ON(&pfdev->base,
already_owned) in the condition triggers a warning on every normal fault
of those neighbouring chunks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-panfrost-l=
ong-jobs-v2-0-a06830da3d99@gmail.com?part=3D6
