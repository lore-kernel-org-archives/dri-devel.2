Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB1F4368A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEF510E2A7;
	Fri, 17 Apr 2026 11:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mka+WAN8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C98D10E2A4;
 Fri, 17 Apr 2026 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776426133; x=1807962133;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=+yMaBGkT5GLi27mf+7rNlL0AO1QJDf3A+Ucoz5SkT7Q=;
 b=mka+WAN8n/TYyZBJ5DcU5X4CSKGD1DJHxC2JW+pD5HKCLj9DCB4IuKx5
 WJCIpY8n/lltPAWFTU6xwMrb/44y4Xd43+1cYdrPcXFG0yv4q/31gvzE4
 WjLOSZ9zLA3dX42TtGZfpb8EETsEfVtJLtZ/tLYj8zJzfp9cGT3+lLtdx
 nj5QdZUkjfKhNOeg5coWT0cKg3jtMwAYQChicpQJ1QGe+NKU4MsKIzKRc
 ZRhVApcKPc2WzD+vsR/OS8aSJG7jxxJIugVIPxgEWd+5H4x6oChx7SQsX
 W2Kvwa98YlvVeHh30TbSnT7nJSxqx54ECZSlmIk5iPB4m5lyi9azS3Ytw g==;
X-CSE-ConnectionGUID: OMgohNZHQQ6CQ7asagJDUA==
X-CSE-MsgGUID: VcniIuzMRh6/kfBc0ep2IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77315713"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77315713"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:42:13 -0700
X-CSE-ConnectionGUID: STjVfVrtT6mdLkG7BgdJkw==
X-CSE-MsgGUID: zcAzm+/6RHSlYlBhRrg1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="227886606"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:42:11 -0700
Message-ID: <aff8ca0727ba41ca69f3e8c8255a33219727b4be.camel@linux.intel.com>
Subject: Re: [PATCH] drm/gpusvm, pagemap: Do not assume DRM pagemap owns
 device pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: francois.dugast@intel.com, himal.prasad.ghimiray@intel.com
Date: Fri, 17 Apr 2026 13:42:09 +0200
In-Reply-To: <20260409015512.3670302-1-matthew.brost@intel.com>
References: <20260409015512.3670302-1-matthew.brost@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-04-08 at 18:55 -0700, Matthew Brost wrote:
> Update drm_pagemap_page_zone_device_data() to derive the pgmap ops
> from
> the page and compare them against the DRM pagemap ops. If the ops do
> not
> match, return NULL.
>=20
> Also harden two risky call sites by checking for NULL after
> hmm_range_fault() or migrate_vma_setup() when migrating to device
> memory, as it is possible to encounter device pages that are not
> owned
> by DRM pagemap.
>=20
> Suggested-by: sashiko.dev

Is there a proper (fake) email we can use?

> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/drm_gpusvm.c=C2=A0 |=C2=A0 5 +++++
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 14 ++++++++++----
> =C2=A0include/drm/drm_pagemap.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++-
> =C2=A03 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gpusvm.c
> b/drivers/gpu/drm/drm_gpusvm.c
> index 365a9c0b522a..b3cccd047a21 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1506,6 +1506,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm
> *gpusvm,
> =C2=A0			struct drm_pagemap_zdd *__zdd =3D
> =C2=A0				drm_pagemap_page_zone_device_data(pa
> ge);
> =C2=A0
> +			if (!__zdd) {
> +				err =3D -EINVAL;
> +				goto err_unmap;
> +			}
> +

Here, __zdd is never dereferenced. As I understand it, the current
behaviour (before this patch) is that pages from mixed pagemaps are
generating an -EOPNOTSUPP, re-trying migration, which I think is the
correct behaviour, save possibly for foreign device-coherent pages.

Also see below reasoning WRT "owner".

> =C2=A0			if (!ctx->allow_mixed &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 zdd !=3D __zdd && i > 0) {
> =C2=A0				err =3D -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index d82ea7ccb8da..95c951c5b569 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -753,10 +753,16 @@ int drm_pagemap_migrate_to_devmem(struct
> drm_pagemap_devmem *devmem_allocation,
> =C2=A0				own_pages++;
> =C2=A0				goto next;
> =C2=A0			}
> -			cur.dpagemap =3D src_zdd->dpagemap;
> -			cur.ops =3D src_zdd->devmem_allocation->ops;
> -			cur.device =3D cur.dpagemap->drm->dev;
> -			pages[i] =3D src_page;
> +			if (src_zdd) {
> +				cur.dpagemap =3D src_zdd->dpagemap;
> +				cur.ops =3D src_zdd-
> >devmem_allocation->ops;
> +				cur.device =3D cur.dpagemap->drm->dev;
> +				pages[i] =3D src_page;
> +			} else {

This shouldn't happen, because we select device_private pages based on
dev_private owner. IMO we shouldn't allow non drm_pagemap
device_private pages sharing owner because we wouldn't now how to
migrate them.

> +				npages =3D i;
> +				err =3D -EINVAL;
> +				goto err_finalize;
> +			}
> =C2=A0		}
> =C2=A0		if (!pages[i]) {
> =C2=A0			cur.dpagemap =3D NULL;
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 95eb4b66b057..9b7c50932db5 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -367,12 +367,15 @@ int drm_pagemap_reinit(struct drm_pagemap
> *dpagemap);
> =C2=A0 * drm_pagemap_page_zone_device_data() - Page to zone_device_data
> =C2=A0 * @page: Pointer to the page
> =C2=A0 *
> - * Return: Page's zone_device_data
> + * Return: Page's zone_device_data if owned by DRM pagemap, NULL
> otherwise
> =C2=A0 */
> =C2=A0static inline struct drm_pagemap_zdd
> *drm_pagemap_page_zone_device_data(struct page *page)
> =C2=A0{
> =C2=A0	struct folio *folio =3D page_folio(page);
> =C2=A0
> +	if (WARN_ON_ONCE(page_pgmap(page)->ops !=3D
> drm_pagemap_pagemap_ops_get()))

Driver could be handing a separate ops. Like if we wanted to check for
wedging / unplug before trying to migrate back to system, so this
wouldn't work.

So in general I don't think this patch is correct. Perhaps we should
look at updating the docs around owner assignment, though and also
perhaps make drm_gpusvm_get_pages() a bit more permissive?

/Thomas


> +		return NULL;
> +
> =C2=A0	return folio_zone_device_data(folio);
> =C2=A0}
> =C2=A0
