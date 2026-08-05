Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA51C55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0774010EFE3;
	Wed,  5 Aug 2026 21:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bxdz1R+8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6909F10EFE3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:07:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1CD160A5A;
 Wed,  5 Aug 2026 21:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9551F000E9;
 Wed,  5 Aug 2026 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964024;
 bh=EmRTmz7OtBUsMLAwZ3QW3m7MXEP+8dp09Sj6bjXDRLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bxdz1R+8fR19dKgLJ6FYvTV0tMhf4RqrW/ki8oXjRtSn+rCj3BvP00jP7Y7+ul0Bt
 0cViQlkm+H+PCw1pr5MBCrj5Sjp7s9BoLb6gowe48DA69drlGRkMSg0MRQ9cVeSwHV
 s6dQr5SEHQavRdMQAANZ/Lde1X3hXTmmE1TUY5wCi8Pq0hGFXN2CSgorU/9onjKqY7
 pm7ZHdCxYaUFmI/2Eb5+P181sqiEkMIChvAJ6ZqlY0I9YCExciGQOcCInVeDuRVTJ3
 NIL1eRzEx3ZjAJFrqQ1R+IDKyaQnzR0FVrfn4ZujsW6Wkz802vXAcXTnikjQAv1NIR
 ZibpZCHMeBeRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] drm/pagemap: Add fault injection for
 higher-order RAM folio allocation
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805193536.3756457-6-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
 <20260805193536.3756457-6-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:07:03 +0000
Message-Id: <20260805210704.6C9551F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing debugfs cleanup on module unload causes a use-after-free v=
ulnerability.

Pre-existing issues:
- [High] DMA mappings are leaked on the error path because the destination =
PFN array is zeroed before it can be unmapped.
--

--- Patch [5]: [PATCH v2 5/5] drm/pagemap: Add fault injection for higher-o=
rder RAM folio allocation ---
commit 8131ac1d5ae4485b09ae7fb3c943731bd418c771
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/pagemap: Add fault injection for higher-order RAM folio alloca=
tion

This commit adds a fault injection mechanism to test the order-0 fallback
and THP split paths in drm_pagemap_migrate_populate_ram_pfn. It achieves
this by exposing a debugfs attribute that can artificially force
higher-order folio allocations to fail.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 05eb7254028f7..01c639da767c3 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -1554,6 +1578,16 @@ void drm_pagemap_destroy(struct drm_pagemap *dpage=
map, bool is_atomic_or_reclaim
>  		kfree(dpagemap);
>  }
> =20
> +static int __init drm_pagemap_module_init(void)
> +{
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_FAULT_INJECTION)
> +	fault_create_debugfs_attr("drm_pagemap_fault_inject", NULL,
> +				  &migrate_to_ram_fault_inject);
> +#endif
> +	return 0;
> +}
> +module_init(drm_pagemap_module_init);
> +
>  static void drm_pagemap_exit(void)
>  {
>  	flush_work(&drm_pagemap_work);

[Severity: High]
Does the module unload path need to clean up this debugfs attribute?=20

Because the dentry from fault_create_debugfs_attr is not saved and removed=
=20
in drm_pagemap_exit, the debugfs files are left behind when the module is=20
unloaded. If userspace accesses these leftover files after unloading, won't=
=20
this cause a use-after-free when it tries to read or write the freed=20
migrate_to_ram_fault_inject struct?

[Severity: High]
This is a pre-existing issue, but can the error path in=20
__drm_pagemap_migrate_to_ram leak DMA mappings?

When an error occurs during migration (for example, in ops->copy_to_ram),=20
the err_finalize label executes the following:

__drm_pagemap_migrate_to_ram() {
    ...
err_finalize:
    drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
    drm_pagemap_migrate_unmap_pages(dev, npages, pagemap_addr, migrate.dst);
    ...
}

The call to drm_pagemap_migration_unlock_put_pages unlocks the folios and=20
zeroes out the entries in the migrate.dst array. Immediately after,=20
drm_pagemap_migrate_unmap_pages is called to unmap the DMA addresses.=20

However, when the IOVA fast-path is not used, the unmap loop relies entirel=
y=20
on that same array to resolve the page:

drm_pagemap_migrate_unmap_pages() {
    ...
    for (i =3D 0; i < npages; i++) {
        struct page *page =3D migrate_pfn_to_page(migrate_pfn[i]);

        if (!page || !pagemap_addr[i].addr || dma_mapping_error(...))
            goto next;
        ...
        dma_unmap_page(dev, pagemap_addr[i].addr, ...);
    ...
}

Since the migrate.dst array was already zeroed by the previous function,=20
the page resolves to NULL. Could this cause the loop to silently take the=20
goto next path and permanently leak the DMA mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805193536.3756=
457-1-matthew.brost@intel.com?part=3D5
