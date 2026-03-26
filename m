Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689FA10AB82B
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB4910E6C8;
	Thu, 26 Mar 2026 22:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MC3Cngq2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE9F10E6C8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 22:44:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E508641AC6;
 Thu, 26 Mar 2026 22:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E5C2BCB2;
 Thu, 26 Mar 2026 22:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774565082;
 bh=wnemq+UwHPEA9TsXFKQBlPjccCQwV5RXihejKuCyumY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=MC3Cngq2BkdL0ni2bWYq3Ex8/iXcPdbnWbOn3pV5plkdsixqUt+EL3qLRuij1CGMM
 FRsloTP8OEXnVqrIB+urWx6LDARXOwoOBjJe0OjIFxcby6Tramx8N1Wtf/Floe6DVt
 Tv2vHVayknEwAVbYr/CRCgD7qhfUBYwtc+uBc3OsIlPx3DJYz2FYq4nbGSfRULOiQB
 JkUHkMzoIY2CEv3O6YZg6phNwD+Tz3ciDndGJtyfEJlRnGzHCtEER4c0uf3QHC+JOA
 vjve1r6DZ6kbrAxi7MQ/lH5ml2Oq1e+fGAgpgZ5Ing8+w8rurWh+a1zWZl1rZv3UIv
 lvr+QbOjhK1SQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 23:44:38 +0100
Message-Id: <DHD2TIKMD3E7.3L229ON925VS5@kernel.org>
Subject: Re: [PATCH v5 04/11] drm/gpuvm: Add a helper to check if two VA can
 be merged
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Steven Price" <steven.price@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>,
 <kernel@collabora.com>, "Caterina Shablia"
 <caterina.shablia@collabora.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <20260313150956.1618635-5-adrian.larumbe@collabora.com>
In-Reply-To: <20260313150956.1618635-5-adrian.larumbe@collabora.com>
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

On Fri Mar 13, 2026 at 4:09 PM CET, Adri=C3=A1n Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
>
> We are going to add flags/properties that will impact the VA merging
> ability. Instead of sprinkling tests all over the place in
> __drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
> can call it for every existing VA we walk through in the
> __drm_gpuvm_sm_map() loop.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>

This needs your Signed-off-by: as well. Does it need Caterina's Co-develope=
d-by:
tag as well?

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 46 +++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index 3c2b6102e818..4af7b71abcb4 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2378,16 +2378,47 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void =
*priv,
>  	return fn->sm_step_unmap(&op, priv);
>  }
> =20
> +static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *v=
a,
> +		      const struct drm_gpuva_op_map *new_map)

Not public, but please add some documentation regardless; it's not very obv=
ious
what the function should achieve semantically from just looking at its
signature.

> +{
> +	struct drm_gpuva_op_map existing_map =3D {
> +		.va.addr =3D va->va.addr,
> +		.va.range =3D va->va.range,
> +		.gem.offset =3D va->gem.offset,
> +		.gem.obj =3D va->gem.obj,
> +	};

IIRC, previously this was a temporary struct drm_gpuva; this seems better (=
also
because its scope is limited to this function), but it still feels like an
abuse of this structure.

Anyways, I get that you want it for the swap() trick below, but I think it =
can
also easily be done without the swap() trick. What about this?

	static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *va,
		      const struct drm_gpuva_op_map *new_map)
	{
		/* Only GEM-based mappings can be merged, and they must point to
		 * the same GEM object.
		 */
		if (va->gem.obj !=3D new_map->gem.obj || !new_map->gem.obj)
			return false;
=09
		/* We assume the caller already checked that VAs overlap or are
		 * contiguous.
		 */
		if (drm_WARN_ON(gpuvm->drm,
				new_map->va.addr > va->va.addr + va->va.range ||
				va->va.addr > new_map->va.addr + new_map->va.range))
			return false;
=09
		/* u64 underflow is fine: both sides negate equally, preserving
		 * the equality.
		 */
		return va->va.addr - new_map->va.addr =3D=3D
		       va->gem.offset - new_map->gem.offset;
	}

> +	const struct drm_gpuva_op_map *a =3D new_map, *b =3D &existing_map;
> +
> +	/* Only GEM-based mappings can be merged, and they must point to
> +	 * the same GEM object.
> +	 */
> +	if (a->gem.obj !=3D b->gem.obj || !a->gem.obj)
> +		return false;
> +
> +	/* Order VAs for the rest of the checks. */
> +	if (a->va.addr > b->va.addr)
> +		swap(a, b);
> +
> +	/* We assume the caller already checked that VAs overlap or are
> +	 * contiguous.
> +	 */
> +	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
> +		return false;
> +
> +	/* We intentionally ignore u64 underflows because all we care about
> +	 * here is whether the VA diff matches the GEM offset diff.
> +	 */
> +	return b->va.addr - a->va.addr =3D=3D b->gem.offset - a->gem.offset;
> +}
