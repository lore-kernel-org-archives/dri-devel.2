Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD95AC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB85F10E08E;
	Thu,  6 Aug 2026 13:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QdIub2id";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE02410E08E
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:34:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A9AE60A5C;
 Thu,  6 Aug 2026 13:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F01F000E9;
 Thu,  6 Aug 2026 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786023272;
 bh=gNiq1EkxJfhUdL8W5cUqRd28Jdv8hBdy3IXrYnYYwEM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QdIub2idhWTnnzCAME1xQINdjd7gsCR8NUvSNIZ8hTqiL1DaUA6Oe7C38McybsBs9
 SNSFihvDefjCHwrNOOIyUX+tIoKW553F3AdHrLRisMpXhz+xwQg2A+Pf+j8eO9thHn
 iTR5KKU0kyzhvsmadi7F5hvBzXoggQBk/PT5BeAPkZaqYWSLWqLVQsBjVCVAriKiaP
 hRqtoxF1ExGeUavyMUoT4Ts6kxI3yG4ZQHBhtd4HsRrCH2MqaKZ4foo/GfIenKfOvl
 uXR3SDXzFb1ut4svU3bHSeesMJyOMceVcXqCvQGizdi3Wx0fEYOz5UmTeXgpsxSHnK
 kjIEcvaoK0jzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/pagemap: no need to recheck own pagemap in
 migrate_to_devmem
To: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <anSKZabjuhl5Ojl4@hostpc>
References: <anSKZabjuhl5Ojl4@hostpc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:34:31 +0000
Message-Id: <20260806133432.188F01F000E9@smtp.kernel.org>
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
- [Critical] Migration error paths pass unencoded raw PFNs to migrate_vma_p=
ages(), causing out-of-bounds dereferences or mapping arbitrary physical me=
mory into userspace.
--

--- Patch [1]: [PATCH v2] drm/pagemap: no need to recheck own pagemap in mi=
grate_to_devmem ---
commit f37b1a946d737409d8a543e854c0c96738771e75
Author: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>

drm/pagemap: no need to recheck own pagemap in migrate_to_devmem
   =20
The second loop in drm_pagemap_migrate_to_devmem() checks to skip pages
already on the target pagemap. However, this condition is always false at
this point since the first loop already aborts if necessary. This commit
removes the dead code and simplifies the error jumping paths.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..64922b944092c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c

[ ... ]

> @@ -786,7 +779,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_=
devmem *devmem_allocation,
>  			goto err_finalize;
>  		}
> =20
> -next:
>  		i +=3D NR_PAGES(order);
>  	}

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential problem in the
error handling path during the migration loop.

If drm_pagemap_migrate_range() fails in the middle of this loop, the local
npages variable is truncated to i + 1 before jumping to err_finalize.=20
However, err_finalize falls through to err_aborted_migration:

err_finalize:
	if (err)
		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
err_aborted_migration:
	migrate_vma_pages(&migrate);

Because migrate_vma_pages() uses the struct field migrate.npages, it will
process the entire original array length rather than the truncated local
npages value. The remaining elements in migrate.dst still contain unencoded
raw PFNs previously populated by ops->populate_devmem_pfn().

If one of these raw PFNs happens to be odd (bit 0 set), it matches
MIGRATE_PFN_VALID. This could cause the kernel to shift it by 6 and use it
as a struct page pointer, leading to an out-of-bounds dereference or mapping
arbitrary physical memory into userspace.

Could this error path be updated to avoid passing unencoded PFNs to
migrate_vma_pages() when the migration loop aborts early?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anSKZabjuhl5Ojl4@ho=
stpc?part=3D1
