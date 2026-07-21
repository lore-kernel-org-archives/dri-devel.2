Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BAAC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5885D10E1B4;
	Tue, 21 Jul 2026 20:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbjqVrEc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7E510E1B4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:32:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B2E1400D6;
 Tue, 21 Jul 2026 20:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5341B1F000E9;
 Tue, 21 Jul 2026 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784665952;
 bh=V/4xpMBFnJELh+80jjf1kK222i36rpMcYY+WIU68E7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XbjqVrEcAodOq8CdenmFRHGLNRhJOjVHTjWVMPuzekRX64o//HnH/dgZlmyyWJix8
 Vufx1Lz3KhjLxtYvQ4fUUvLu1WqW+63C4kpGd6UyL35/gvUKK2eJr5CR0zQSrI7VGX
 bwQu7vRFNcIFTMuYbSygS0N8wo2sPqbK3y9Dgy/pKdbCzyHfvYH2gAileXFfMisbAS
 a5G1BGYR7RfTQs7F1FYDy1s4MUvK/JPhnnOjeAuAkz4wMKSMtHASFRlXpmyFb4qZrf
 qo4JSfp4+L1hiyCYb51O5vyStQwcUK69Fcy9gTpZlqC7N3P44d+aGzA3ch5AuSHJOx
 cDkxSRDGhZvgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Clear driver-provided PFNs from migration
 PFN array
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721201959.1082266-1-matthew.brost@intel.com>
References: <20260721201959.1082266-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:32:31 +0000
Message-Id: <20260721203232.5341B1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `ops->populate_devmem_pfn()` fails, `migrate.dst` is not cleare=
d of unencoded driver PFNs, leading to wild pointer dereferences and memory=
 corruption in `migrate_vma_pages()`.
--

--- Patch [1]: [PATCH] drm/pagemap: Clear driver-provided PFNs from migrati=
on PFN array ---
commit ed7304923def6f0807fcb47377684c7a1ab58012
Author: Matthew Brost <matthew.brost@intel.com>

drm/pagemap: Clear driver-provided PFNs from migration PFN array

This patch clears remaining driver-provided PFNs from the migration PFN
array when an error occurs during the incremental copy phase. This prevents
migrate_vma_*() functions from processing unencoded device PFNs.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 3902846af36b ("drm/pagemap Fix error paths in drm_pagemap_migrate_to=
_devmem")
Fixes: ec265e1f1cfc ("drm/pagemap: Support source migration over interconne=
ct")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..f991b296c8e19 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -807,8 +807,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap=
_devmem *devmem_allocation,
>  		msecs_to_jiffies(mdetails->timeslice_ms);
> =20
>  err_finalize:
> -	if (err)
> +	if (err) {
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
> +		for (i =3D npages; i < npages_in_range(start, end); ++i)
> +			migrate.dst[i] =3D 0;
> +	}
>  err_aborted_migration:
>  	migrate_vma_pages(&migrate);

[Severity: High]
This is a pre-existing issue, but I noticed an error path that might still
bypass this new zeroing loop.

Earlier in drm_pagemap_migrate_to_devmem(), if ops->populate_devmem_pfn()
fails, the code jumps directly to err_aborted_migration:

	err =3D ops->populate_devmem_pfn(devmem_allocation, npages, migrate.dst);
	if (err)
		goto err_aborted_migration;

Since this jumps directly to err_aborted_migration, it skips the err_finali=
ze
block completely. If migrate.dst was partially populated with unencoded dri=
ver
PFNs before the failure, wouldn't migrate_vma_pages() then process those
raw PFNs?

If a raw driver-provided PFN happens to have its lowest bit set,
migrate_pfn_to_page() could interpret it as MIGRATE_PFN_VALID and return a
bogus struct page pointer, which might lead to memory corruption.

Should the populate_devmem_pfn() failure jump to err_finalize instead, or
should the array clearing be moved to cover all abort paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201959.1082=
266-1-matthew.brost@intel.com?part=3D1
