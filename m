Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C095CF4368D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1804910EA1E;
	Fri, 17 Apr 2026 11:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZBelgqYO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD4410EA05;
 Fri, 17 Apr 2026 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423844; x=1807959844;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=CS8+wPNve0d5RmijPI+grh6X7/tS2Tyrtio87nCPnuA=;
 b=ZBelgqYOnQAVYf7CObxHfZkn7UIsyH6Cz3FgrJPrcFX2b9/WmXxItpvG
 VAbTWeUsESiMC2JYgeeb5sF7u1ww8HIYJXzgKp1OjlaTAspFjNZ0OT7Di
 rtx36iFy2MQyv1pLRrYLn4/crshNjZwVYwrQt6eBUy9F8vylL5Y0NX4MK
 /wokdEg7xcVgvw70NBlRYu4zZGI90g85M0OMXRrKXaNLuuzTV6RyQ/zJx
 5iP9FqFA8DGZAvna0QYKz2QHMRGLdx1Sfo5z2Zv11jP1sYenasGLYqa3/
 k6D9TfLKeVwqgCTSk2CjidRvDMOQwzVq0wYIEbVhA1lIGIFUiQjxAqgdm w==;
X-CSE-ConnectionGUID: OFPjl6rpRx+07tHNzqlYUw==
X-CSE-MsgGUID: 9Y9RO4HJRR+g5wjuHv4v8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77313395"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77313395"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:04:04 -0700
X-CSE-ConnectionGUID: YpvLb5AFTzCIiMWYVRtVSA==
X-CSE-MsgGUID: 25lMKpo+SGyWSAHPKyILkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="232758987"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:04:02 -0700
Message-ID: <34a9f1ee6ef7b3cbecad9ce3ec2b112a9e7d2f69.camel@linux.intel.com>
Subject: Re: [PATCH v7 2/5] drm/pagemap: Drop source_peer_migrates flag and
 assume true
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Francois Dugast <francois.dugast@intel.com>
Date: Fri, 17 Apr 2026 13:03:49 +0200
In-Reply-To: <20260410205929.3914474-3-matthew.brost@intel.com>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
 <20260410205929.3914474-3-matthew.brost@intel.com>
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

On Fri, 2026-04-10 at 13:59 -0700, Matthew Brost wrote:
> All current users of DRM pagemap set source_peer_migrates to true
> during
> migration, and it is unclear whether any user would ever want to
> disable
> this for performance reasons or for features such as compression. It
> is
> also questionable whether this flag could be made to work with
> high-speed fabric mapping APIs.
>=20
> Drop the flag and make DRM pagemap unconditionally assume that
> source_peer_migrates is true.
>=20
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Francois Dugast <francois.dugast@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 10 ++++------
> =C2=A0drivers/gpu/drm/xe/xe_svm.c=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0include/drm/drm_pagemap.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++-----=
--
> =C2=A03 files changed, 6 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index 5002049e0198..63f32cf6e1a7 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -651,12 +651,10 @@ int drm_pagemap_migrate_to_devmem(struct
> drm_pagemap_devmem *devmem_allocation,
> =C2=A0				own_pages++;
> =C2=A0				goto next;
> =C2=A0			}
> -			if (mdetails->source_peer_migrates) {
> -				cur.dpagemap =3D src_zdd->dpagemap;
> -				cur.ops =3D src_zdd-
> >devmem_allocation->ops;
> -				cur.device =3D cur.dpagemap->drm->dev;
> -				pages[i] =3D src_page;
> -			}
> +			cur.dpagemap =3D src_zdd->dpagemap;
> +			cur.ops =3D src_zdd->devmem_allocation->ops;
> +			cur.device =3D cur.dpagemap->drm->dev;
> +			pages[i] =3D src_page;
> =C2=A0		}
> =C2=A0		if (!pages[i]) {
> =C2=A0			cur.dpagemap =3D NULL;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c
> b/drivers/gpu/drm/xe/xe_svm.c
> index ba67355f64cb..e1651e70c8f0 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -1055,7 +1055,6 @@ static int xe_drm_pagemap_populate_mm(struct
> drm_pagemap *dpagemap,
> =C2=A0	struct xe_pagemap *xpagemap =3D container_of(dpagemap,
> typeof(*xpagemap), dpagemap);
> =C2=A0	struct drm_pagemap_migrate_details mdetails =3D {
> =C2=A0		.timeslice_ms =3D timeslice_ms,
> -		.source_peer_migrates =3D 1,
> =C2=A0	};
> =C2=A0	struct xe_vram_region *vr =3D xe_pagemap_to_vr(xpagemap);
> =C2=A0	struct dma_fence *pre_migrate_fence =3D NULL;
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 75e6ca58922d..95eb4b66b057 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -329,17 +329,12 @@ struct drm_pagemap_devmem {
> =C2=A0 * struct drm_pagemap_migrate_details - Details to govern migration=
.
> =C2=A0 * @timeslice_ms: The time requested for the migrated pagemap pages
> to
> =C2=A0 * be present in @mm before being allowed to be migrated back.
> - * @can_migrate_same_pagemap: Whether the copy function as indicated
> by
> - * the @source_peer_migrates flag, can migrate device pages within a
> - * single drm_pagemap.
> - * @source_peer_migrates: Whether on p2p migration, The source
> drm_pagemap
> - * should use the copy_to_ram() callback rather than the destination
> - * drm_pagemap should use the copy_to_devmem() callback.
> + * @can_migrate_same_pagemap: Whether the copy function can migrate
> + * device pages within a single drm_pagemap.
> =C2=A0 */
> =C2=A0struct drm_pagemap_migrate_details {
> =C2=A0	unsigned long timeslice_ms;
> =C2=A0	u32 can_migrate_same_pagemap : 1;
> -	u32 source_peer_migrates : 1;
> =C2=A0};
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_ZONE_DEVICE)
