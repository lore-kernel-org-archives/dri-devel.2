Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EB4C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFBC10F014;
	Wed,  5 Aug 2026 23:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e92hBcal";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE4410F02A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:22:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B780560A63;
 Wed,  5 Aug 2026 23:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439271F000E9;
 Wed,  5 Aug 2026 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785972135;
 bh=1nDAYrxdiXcm45jg6uZSRGR8MdAeu+PcnGDPUvweFHI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e92hBcalVHhlRwF9aW60wCN4bxf62iy4MdP/t710xs3soIeKzSjzj679NKszpcSGY
 /GF91jrhf+hrwXghhDi82UmMNt2+bgIa/syXNmDmC8WThxJPZS5xltw4rwf7z15Y/b
 9gAPXhIegurVJ9boELjDStA9YfE2CFyZAMuBP+7aCzyNiHvDORgsweKmd7yBvRQPgH
 5MCjQTxZZuzPBwrOeDV6kI4yvJVGZtxbUwxQ44ol6dqmYkvNddytT7NnNG6+g8QJzs
 FRpYtdsbDSDaOVmkFFpticudf3uVRSVXJEkM8sB3PPg/ftktqFf0d+41SOHZfZGzo7
 HDJotSk9J4hew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] drm/pagemap: dma-unmap pages before handling
 migration errors
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805231041.3791771-5-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-5-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:22:14 +0000
Message-Id: <20260805232215.439271F000E9@smtp.kernel.org>
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
- [Critical] Valid DMA address 0 is leaked because `drm_pagemap_migrate_unm=
ap_pages` skips unmapping when `pagemap_addr[i].addr =3D=3D 0`, leading to =
a stale IOMMU mapping and potential use-after-free.
--

--- Patch [4]: [PATCH v3 4/6] drm/pagemap: dma-unmap pages before handling =
migration errors ---
commit 449a54e82e1a7fd00fc19c70ae34414088711db1
Author: Matthew Brost <matthew.brost@intel.com>

    drm/pagemap: dma-unmap pages before handling migration errors

This commit reorders the cleanup sequence during migration errors. It ensur=
es
that DMA unmapping occurs before the pages array is cleared, preventing mis=
sing
unmaps due to invalid page information.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 892b325fa99b8..aef1fcea663d5 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1175,12 +1175,12 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_d=
evmem *devmem_allocation)
>  		goto err_finalize;
> =20
>  err_finalize:
> +	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, d=
st, npages,
> +					DMA_FROM_DEVICE, &state);

[Severity: Critical]
This is a pre-existing issue, but does the check inside
drm_pagemap_migrate_unmap_pages() accidentally leak valid DMA address 0?

drivers/gpu/drm/drm_pagemap.c:drm_pagemap_migrate_unmap_pages() {
    ...
	if (!page || !pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[=
i].addr))
		goto next;
    ...
}

Since 0 is a valid DMA address on many platforms, skipping the unmap when
pagemap_addr[i].addr =3D=3D 0 might leave a stale IOMMU mapping.=20

When the page is subsequently freed, could a malicious userspace instruct t=
he
GPU to access this DMA address and cause memory corruption or an IOMMU
use-after-free?

>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
>  	migrate_device_finalize(src, dst, npages);
> -	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, d=
st, npages,
> -					DMA_FROM_DEVICE, &state);
> =20
>  err_free:
>  	kvfree(buf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805231041.3791=
771-1-matthew.brost@intel.com?part=3D4
