Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A81606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SEqNZUOD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887121120B9;
	Thu, 12 Nov 2026 12:30:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032DD1120B8;
 Thu, 12 Nov 2026 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794486595; x=1826022595;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=AHF2xH2R7JBmR5THnwNyGnMNDpxxg1QNOefOFUtVVGc=;
 b=SEqNZUODOYozmQFYj0o6UzxkCMV2aV5Oo0Twrx8rfrButA6HZDRodYYc
 AIfqGdnaTh4WfeZsE9tB7YeMJuY2KUrE7eI1E7XUZ3cFbG9cj6lp444xP
 Ifk4ogSy7YZxlq5/RSf97mVn2VwYFJ5Al/yxxUw4pm4PxwaiaHF2HU4bU
 HaTBTHQahVBzsQgbNCvW/xePRYBVZ3MLWrxg5geyLz+wbhVioQYFzY5er
 MCdcXvFDfzYVwjRwLI3v0wq3V2byOThGMtZzBxD7kef2FXUCFndFlwnkO
 W6I/p6/lY3lB4G0Oc/YxIln5awsJ+otTrh1vPPZaQen1hnNV3RWKkofcK w==;
X-CSE-ConnectionGUID: YPLG621lTIyGOqcIpQnlAg==
X-CSE-MsgGUID: 8Am9eIdfQl6yWnXr2ifJ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3166203"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3166203"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:29:55 -0800
X-CSE-ConnectionGUID: SEg33JfuSguz8aseg5c0yA==
X-CSE-MsgGUID: MBOPxt2lQj2NdRsX01s/pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9084670"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:29:52 -0800
Message-ID: <500844ca6329952ed41a7cedf97b5f6a84ede545.camel@linux.intel.com>
Subject: Re: [PATCH v8 2/6] drm/i915/gem: Count mapped pages in a folio
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 13:29:50 +0100
In-Reply-To: <20261109113758.1491891-3-krzysztof.karas@intel.com>
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-3-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On Mon, 2026-11-09 at 11:37 +0000, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>=20
> Furthermore, current do-while loop goes over the same folio
> multiple times, increasing the refcount each time, and breaks
> get/put symmetry: many shmem_read_folio_gfp() gets and only one
> put in i915_gem_object_put_pages_shmem() per folio.
>=20
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>=20
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 101 +++++++++++++---------
>  1 file changed, 59 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index e35ee4bd456f..d57b5c67d47b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -71,6 +71,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915,=
 struct sg_table *st,
>  	unsigned long i;
>  	struct scatterlist *sg;
>  	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
> +	struct folio *folio =3D NULL;
>  	gfp_t noreclaim;
>  	int ret;
> =20
> @@ -104,7 +105,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -112,51 +113,61 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20

I was looking for a way to make this patch still more easily readable, but=
=C2=A0
all I invented would look like below, so not a standard syntax, then:

Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> -		do {
+		if (i && (next_pfn < folio_pfn(folio) + folio_nr_pages(folio))) {
+			/*
+			 * We are still inside the same folio,
+			 * so just update its page index.
+			 */
+			folio_page_index =3D next_pfn - folio_pfn(folio);
+		} else do {
+			/* Grab the next folio if we exhausted the current one. */

> -			cond_resched();
> -			folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -			if (!IS_ERR(folio))
> -				break;
> -
> -			if (!*s) {
> -				ret =3D PTR_ERR(folio);
> -				goto err_sg;
> -			}
> +		if (!i || (next_pfn >=3D folio_pfn(folio) + folio_nr_pages(folio))) {
> +			/* Grab the next folio if we exhausted the current one. */
> +			do {
> +				cond_resched();
> +				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> +				folio_page_index =3D 0;
> +				if (!IS_ERR(folio))
> +					break;
> =20
> -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> +				if (!*s) {
> +					ret =3D PTR_ERR(folio);
> +					goto err_sg;
> +				}
> =20
> -			/*
> -			 * We've tried hard to allocate the memory by reaping
> -			 * our own buffer, now let the real VM do its job and
> -			 * go down in flames if truly OOM.
> -			 *
> -			 * However, since graphics tend to be disposable,
> -			 * defer the oom here by reporting the ENOMEM back
> -			 * to userspace.
> -			 */
> -			if (!*s) {
> -				/* reclaim and warn, but no oom */
> -				gfp =3D mapping_gfp_mask(mapping);
> +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> =20
>  				/*
> -				 * Our bo are always dirty and so we require
> -				 * kswapd to reclaim our pages (direct reclaim
> -				 * does not effectively begin pageout of our
> -				 * buffers on its own). However, direct reclaim
> -				 * only waits for kswapd when under allocation
> -				 * congestion. So as a result __GFP_RECLAIM is
> -				 * unreliable and fails to actually reclaim our
> -				 * dirty pages -- unless you try over and over
> -				 * again with !__GFP_NORETRY. However, we still
> -				 * want to fail this allocation rather than
> -				 * trigger the out-of-memory killer and for
> -				 * this we want __GFP_RETRY_MAYFAIL.
> +				 * We've tried hard to allocate the memory by reaping
> +				 * our own buffer, now let the real VM do its job and
> +				 * go down in flames if truly OOM.
> +				 *
> +				 * However, since graphics tend to be disposable,
> +				 * defer the oom here by reporting the ENOMEM back
> +				 * to userspace.
>  				 */
> -				gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -			}
> -		} while (1);
> +				if (!*s) {
> +					/* reclaim and warn, but no oom */
> +					gfp =3D mapping_gfp_mask(mapping);
> +
> +					/*
> +					 * Our bo are always dirty and so we require
> +					 * kswapd to reclaim our pages (direct reclaim
> +					 * does not effectively begin pageout of our
> +					 * buffers on its own). However, direct reclaim
> +					 * only waits for kswapd when under allocation
> +					 * congestion. So as a result __GFP_RECLAIM is
> +					 * unreliable and fails to actually reclaim our
> +					 * dirty pages -- unless you try over and over
> +					 * again with !__GFP_NORETRY. However, we still
> +					 * want to fail this allocation rather than
> +					 * trigger the out-of-memory killer and for
> +					 * this we want __GFP_RETRY_MAYFAIL.
> +					 */
> +					gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +				}
> +			} while (1);
> +		} else {
> +			/*
> +			 * Otherwise, we are still inside the same folio,
> +			 * so just update its page index.
> +			 */
> +			folio_page_index =3D next_pfn - folio_pfn(folio);
> +		}
> =20
> -		nr_pages =3D min3(folio_nr_pages(folio),
> +		nr_pages =3D min3(folio_nr_pages(folio) - folio_page_index,
>  				page_count - i, max_segment / PAGE_SIZE);
> =20
>  		if (!i ||
> @@ -166,13 +177,19 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  				sg =3D sg_next(sg);
> =20
>  			st->nents++;
> -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> +			sg_set_page(sg, folio_page(folio, folio_page_index),
> +				    nr_pages * PAGE_SIZE, 0);
>  		} else {
>  			nr_pages =3D min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> =20
>  			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}
> -		next_pfn =3D folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * Store the next PFN, so contiguous physical pages
> +		 * can be merged into the same SG entry.
> +		 */
> +		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
>  		i +=3D nr_pages - 1;
> =20
>  		/* Check that the i965g/gm workaround works. */
