Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53625C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF19C10E558;
	Thu, 23 Jul 2026 11:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5Swv6Sk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAD510E558
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93AEB415FE;
 Thu, 23 Jul 2026 11:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E4B1F000E9;
 Thu, 23 Jul 2026 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784805968;
 bh=ndCO3J50W2pXUvntTE4rVIi48p72YCEo+7MA4V698rQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m5Swv6SkCW2FUeRV8d4XJbwP97OHEwzFcb7Gc70gWX9n13Gup8UvPi1w/B5MdCJIN
 iZvOcLBXKa15uLeLBQjOAJvHif3I/ijQ6z5j/GjnlwJ5h/KoM4gP3xdVMESwSUFg0q
 f0Iwg6cLNgho7bWweQ/00RCgkgCnEWp/nEcq7Iwj/Hh52HcVR1bYUEz4/UrqsB9moW
 FLva5TCM5kfkWcuTmu/kuHcMNnrANYcem0RoV6ho+UDku2ErsFFNhEYvInjNs9x7bi
 Xik2Dy94wzII68BtCx8v96A5qzJ7IpAjlWpj7KEHGtQ5WRrOhGYt+s5jhc+Mifx/ei
 mSLh2eJFkV3BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723102542.3245495-5-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-5-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:26:07 +0000
Message-Id: <20260723112608.42E4B1F000E9@smtp.kernel.org>
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
- [High] Memory leak on error path in `shmem_sg_alloc_table` when failing t=
o allocate after populating exactly one scatterlist entry.
--

--- Patch [4]: [PATCH v4 4/5] drm/i915/gem: Read and shrink memory in a sep=
arate function ---
commit 5dd680cf1299c10f0034b5b2b67f54aa39eb638d
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Read and shrink memory in a separate function

This commit extracts the page reading and memory shrinking logic from
shmem_sg_alloc_table() into a new helper function shmem_shrink_get_folio().
It also removes a loop, noting that multiple shrink calls do not provide
additional benefits.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index f35b7efa1fc23..ac8022997553b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c

[ ... ]

> @@ -119,57 +169,16 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  	for (i =3D 0; i < page_count; i++) {
>  		unsigned long folio_page_index =3D 0;
>  		unsigned long nr_pages;
> -		const unsigned int shrink[] =3D {
> -			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> -			0,
> -		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
>  		/* Grab the next folio if we exhausted the current one. */
>  		if (!i || i > folio_end) {
> -			do {

[ ... ]

> +			folio =3D shmem_shrink_get_folio(mapping, i, gfp,
> +						       page_count, i915);
> +			if (IS_ERR(folio)) {
> +				ret =3D PTR_ERR(folio);
> +				goto err_sg;
> +			}

[Severity: High]
This is a pre-existing issue, but does this error path leak memory if the
allocation fails after exactly one scatterlist entry is populated?

Looking at the error handling for shmem_sg_alloc_table in
drivers/gpu/drm/i915/gem/i915_gem_shmem.c:

err_sg:
	sg_mark_end(sg);
	if (sg !=3D st->sgl) {
		shmem_sg_free_table(st, mapping, false, false);
	} else {
		mapping_clear_unevictable(mapping);
		sg_free_table(st);
	}

If a folio is successfully allocated and added to the first scatterlist
entry, but the loop fails on a subsequent iteration before sg is advanced
with sg_next(), sg will still equal st->sgl.

When we jump to err_sg under this condition, the code skips calling
shmem_sg_free_table and only frees the scatterlist structure via
sg_free_table. Could this bypass the reference count decrements for the
folios already added to the first scatterlist entry, causing a permanent
leak during memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723102542.3245=
495-1-krzysztof.karas@intel.com?part=3D4
