Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D40C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045F010E033;
	Thu, 20 Aug 2026 10:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PdE3EhVy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ECD10E033;
 Thu, 20 Aug 2026 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787222398; x=1818758398;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=8P0a4BQW7xa8cNYXKS/zF9nVfujMbJNyuwTAbDSZHAg=;
 b=PdE3EhVyWinxgsAZ56bCsMizCEVjid2q5YNng6npZ1WsFgpbeJ8i6y7+
 Np7IxXEk8R6vQ9yjakh1hI6bg4xRNu+afyGtQl0ZY6JspTLQV5fxoYw/C
 XpEKKug5dRXjYfr0vN/MRBQTAgqVPfVMpRKEaQcQzKHB5I1pCYV6Guluo
 kCo97QZnY4+YwqVjjnEFkBS7LQIU/Y0p9fMm6akkeGSZ0X9G2v6sIzIUM
 jrDMxZf5udjG6VSrobgxTgMdMVCBo8jhQIs2unl5cQZIAs4RK2JCzMOWv
 ouzQF6y1ABz0RWuSvg1JnNOYGG3UV2vsH58Y6b/Po8pyxY64rtHTqvh8K w==;
X-CSE-ConnectionGUID: Ki2NIMZwRUG6p1xWxKOnOA==
X-CSE-MsgGUID: AynbT7RNTCWlQyZyuR0Vfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87775652"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87775652"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:39:57 -0700
X-CSE-ConnectionGUID: GqvfUZDnSHKO1Xp+8NeiAA==
X-CSE-MsgGUID: 0AXgaS8jRKuThf94mEcQqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="289464278"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.82])
 ([10.245.245.82])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:39:55 -0700
Message-ID: <f4a4d6b6a4b353e2993a0e556b93da8501846d40.camel@linux.intel.com>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, "Prabhakaran, Krishna"
 <krishna.prabhakaran@intel.com>, intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org
Date: Thu, 20 Aug 2026 12:39:53 +0200
In-Reply-To: <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
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

On Thu, 2026-08-20 at 10:23 +0100, Matthew Auld wrote:
> On 16/08/2026 02:45, Prabhakaran, Krishna wrote:
> > From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
> >=20
> > When i915 needs to make an imported dma-buf coherent for GPU access
> > on
> > non-LLC platforms, or for objects that bypass LLC, it currently
> > calls
> > wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer
> > is
> > pinned, so this triggers a whole-cache write-back and invalidate,
> > broadcast by IPI to every CPU, on every execbuf submission
> > involving an
> > imported dma-buf. That stalls the entire machine for milliseconds
> > and
> > starves latency-sensitive work on unrelated cores (e.g. USB
> > isochronous
> > audio serviced on the VMM's main thread).
> >=20
> > Flush only the pages that actually need it instead:
> >=20
> > =C2=A0 - If we imported one of our own dma-bufs, the backing object is
> > =C2=A0=C2=A0=C2=A0 struct-page backed once migrated to SMEM, so flush i=
t directly
> > with
> > =C2=A0=C2=A0=C2=A0 drm_clflush_sg(), exactly as we flush our other obje=
cts. This
> > also
> > =C2=A0=C2=A0=C2=A0 avoids re-entering the exporter through dma_buf_vmap=
(), which
> > would
> > =C2=A0=C2=A0=C2=A0 recurse into i915_gem_object_pin_map() on the source=
 object we
> > =C2=A0=C2=A0=C2=A0 already hold locked (and fails the
> > igt_dmabuf_import_same_driver
> > =C2=A0=C2=A0=C2=A0 selftest with -EBUSY).
> >=20
> > =C2=A0 - For a foreign dma-buf the sg_table is not guaranteed to be
> > backed by
> > =C2=A0=C2=A0=C2=A0 struct pages, and the importer has no way to tell, s=
o
> > drm_clflush_sg()
> > =C2=A0=C2=A0=C2=A0 cannot be used. vmap the buffer and flush that virtu=
al range
> > with
> > =C2=A0=C2=A0=C2=A0 drm_clflush_virt_range() instead: x86 uses PIPT cach=
es, so
> > flushing
> > =C2=A0=C2=A0=C2=A0 one virtual alias evicts the cache lines for every a=
lias of the
> > same
> > =C2=A0=C2=A0=C2=A0 physical pages. The dma_resv lock required by dma_bu=
f_vmap() is
> > =C2=A0=C2=A0=C2=A0 already held here via the imported object.
> >=20
> > Fall back to wbinvd only when the buffer cannot be vmapped or is
> > backed
> > by I/O memory, where there is no CPU-side range to clflush.
> >=20
> > Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-
> > acquire")
> > Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
> > ---
> > v2:
> > =C2=A0 - Flush our own imported dma-bufs directly with drm_clflush_sg()
> > instead of
> > =C2=A0=C2=A0=C2=A0 dma_buf_vmap(), which re-entered i915_gem_object_pin=
_map() on
> > the source
> > =C2=A0=C2=A0=C2=A0 object and failed igt_dmabuf_import_same_driver_smem=
 with -
> > EBUSY (reported
> > =C2=A0=C2=A0=C2=A0 by Intel CI on v1). Foreign dma-bufs still use dma_b=
uf_vmap() +
> > =C2=A0=C2=A0=C2=A0 drm_clflush_virt_range(); wbinvd only as fallback.
> > =C2=A0 - Link to v1:
> > https://patchwork.freedesktop.org/patch/744955/?series=3D171760
> >=20
> > =C2=A0 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 55
> > ++++++++++++++++++----
> > =C2=A0 1 file changed, 47 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > index b43d34c7d641..c798a90f1c0f 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > @@ -10,6 +10,8 @@
> > =C2=A0=20
> > =C2=A0 #include <asm/smp.h>
> > =C2=A0=20
> > +#include <drm/drm_cache.h>
> > +
> > =C2=A0 #include "gem/i915_gem_dmabuf.h"
> > =C2=A0 #include "i915_drv.h"
> > =C2=A0 #include "i915_gem_object.h"
> > @@ -249,16 +251,53 @@ static int
> > i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
> > =C2=A0=C2=A0	 * DG1 is special here since it still snoops transactions
> > even with
> > =C2=A0=C2=A0	 * CACHE_NONE. This is not the case with other HAS_SNOOP
> > platforms. We
> > =C2=A0=C2=A0	 * might need to revisit this as we add new discrete
> > platforms.
> > -	 *
> > -	 * XXX: Consider doing a vmap flush or something, where
> > possible.
> > -	 * Currently we just do a heavy handed
> > wbinvd_on_all_cpus() here since
> > -	 * the underlying sg_table might not even point to struct
> > pages, so we
> > -	 * can't just call drm_clflush_sg or similar, like we do
> > elsewhere in
> > -	 * the driver.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	if (i915_gem_object_can_bypass_llc(obj) ||
> > -	=C2=A0=C2=A0=C2=A0 (!HAS_LLC(i915) && !IS_DG1(i915)))
> > -		wbinvd_on_all_cpus();
> > +	=C2=A0=C2=A0=C2=A0 (!HAS_LLC(i915) && !IS_DG1(i915))) {
>=20
> I think we can bump this now for dg2? I think we treat dgfx as always
> coherent with system memory. So maybe s/IS_DG1/IS_DGFX/ in a separate
> patch? Pretty sure the rest of the driver is the same.

+1

>=20
> > +		struct dma_buf *dma_buf =3D obj->base.import_attach-
> > >dmabuf;
> > +
> > +		if (dma_buf->ops =3D=3D &i915_dmabuf_ops) {
> > +			struct drm_i915_gem_object *dma_obj =3D
> > +				dma_buf_to_obj(dma_buf);
> > +
> > +			/*
> > +			 * We imported one of our own dma-bufs.
> > The backing
> > +			 * object is struct-page backed once
> > migrated to SMEM,
> > +			 * so flush it directly, the same way we
> > flush our
> > +			 * other objects. This also avoids re-
> > entering the
> > +			 * exporter through dma_buf_vmap(), which
> > would recurse
> > +			 * into i915_gem_object_pin_map() on the
> > source object
> > +			 * we already hold locked.
> > +			 */
> > +			if
> > (i915_gem_object_has_struct_page(dma_obj))
> > +				drm_clflush_sg(dma_obj->mm.pages);
> > +			else
> > +				wbinvd_on_all_cpus();
>=20
> Do we need the flush under the else here? If it's not placed in
> system=20
> memory what is this flushing, from i915 pov?
>=20
> > +		} else {
> > +			struct iosys_map map;
> > +
> > +			/*
> > +			 * A foreign sg_table is not guaranteed to
> > be backed by
> > +			 * struct pages, so we cannot use
> > drm_clflush_sg(). vmap
> > +			 * the buffer and flush the virtual range
> > instead; x86
> > +			 * uses PIPT caches, so flushing one alias
> > evicts the
> > +			 * lines for every alias of the same
> > physical pages.
> > +			 *
> > +			 * We already hold the dma_resv lock via
> > the imported
> > +			 * obj, so use the locked dma_buf_vmap()
> > variant.
> > +			 */
> > +			if (!dma_buf_vmap(dma_buf, &map)) {
> > +				if (!map.is_iomem)
> > +					drm_clflush_virt_range(map
> > .vaddr,
> > +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > obj->base.size);
> > +				else
> > +					wbinvd_on_all_cpus();

The need for this flush is a bit unfortunate. In theory iomem can be
mapped and wiped write-back, But I'm not sure how common that is...



> > +				dma_buf_vunmap(dma_buf, &map);



> > +			} else {
> > +				wbinvd_on_all_cpus();

Random idea, would it make sense to insert a GPU CLFLUSH into the
pipeline using MI_CLFLUSH (on hardware that supports it) or an
uncached but coherent MOCS / GPU PAT setting dummy blit?

Thanks,
Thomas


> > +			}
> > +		}
> > +	}
> > =C2=A0=20
> > =C2=A0=C2=A0	__i915_gem_object_set_pages(obj, sgt);
> > =C2=A0=20
> >=20
> > base-commit: 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a
