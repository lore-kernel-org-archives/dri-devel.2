Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F7C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E4310E6AE;
	Thu, 17 Sep 2026 09:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BpplGb/5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7E610E47C;
 Thu, 17 Sep 2026 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789639192; x=1821175192;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Mk9Bdo8WeSWLdlY3kVy3c9IZmIBUDNXJJG5+iJ0Plv0=;
 b=BpplGb/5vPZggBRGNfll2CnS9dmGa+cd5JGqLbLO8vG8jugxyYj3Bk9L
 jMUQEWoZGxBLwe0jXaWR627OEZzlgF0CqVsFgxrSoj9/JP6e/urtZWw2S
 hHi+cZvgu2yyfjL9tDY+pcta9mj7NsNG711mD7rEinkreycVfVv0fc3ei
 Pt24xbNLTQ5MGki9jlv5WuEjgJXTsobwh3KV/nCL6cbe5GLUNnA3CTVIl
 Hk/3Wukt72N8TnBXs7HPgNZLC2qNLe4OoZOV7635eFxkpitULpaFzpr09
 lBUoLzqOsdMF7YCxzdUYYJRAEr4ypbtaMYIVYstgnq9mvP8z73lgSEbKy g==;
X-CSE-ConnectionGUID: Ecg3uRa0QaWoPFBx+RI6VQ==
X-CSE-MsgGUID: ITNAGMrzStu9ZR02h6blbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90178592"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90178592"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:59:51 -0700
X-CSE-ConnectionGUID: eis/V58fQSOqK5wTKEJxLA==
X-CSE-MsgGUID: 2e/XBX4hQjiy2chgGcl9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271063053"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.83])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:59:48 -0700
Message-ID: <9bfa7e89cb777f5e32fe82adb77615fef58f5d69.camel@linux.intel.com>
Subject: Re: [PATCH v6 2/7] drm/i915/gem: Count mapped pages in a folio
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  =?UTF-8?Q?Micha=C5=82?= Grzelak	
 <michal.grzelak@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Thu, 17 Sep 2026 11:59:45 +0200
In-Reply-To: <20260902082525.1149367-3-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-3-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

Hi Krzysztof,

Since you are going to submit another version, here are still some comments
of mine for you to consider.

On Wed, 2026-09-02 at 08:25 +0000, Krzysztof Karas wrote:
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
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v6:
>  * moved max_segment check into its own patch;
>  * moved comment about gcc warnings above block of
>    initializations;
>  * removed
>    WARN_ON_ONCE(folio_page_index >=3D folio_nr_pages(folio))
>    block (Andi);
>  * restored original condition (folio_pfn(folio) !=3D next_pfn)
>    (Janusz);
>  * dropped folio_page_index and folio initializations;
>  * expanded the commit message to contain information about
>    previously unexplained folio reference leaks;
>  * ran final checks with Claude Opus and added a tag.
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 112 +++++++++++++---------
>  1 file changed, 67 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 4b5ce9a2f74f..8e5f2a7d5f6b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -70,7 +70,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915=
, struct sg_table *st,
>  	unsigned int page_count; /* restricted by sg_alloc_table */
>  	unsigned long i;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
> +	/* suppress gcc warnings */
> +	unsigned long next_pfn =3D 0;
> +	unsigned long folio_start =3D 0;
> +	unsigned long folio_end =3D 0;
> +	struct folio *folio;
>  	gfp_t noreclaim;
>  	int ret;
> =20
> @@ -104,7 +108,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -112,51 +116,58 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
> -		do {
> -			cond_resched();
> -			folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -			if (!IS_ERR(folio))
> -				break;
> +		/* Grab the next folio if we exhausted the current one. */
> +		if (!i || i > folio_end) {
> +			do {
> +				cond_resched();
> +				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> +				if (!IS_ERR(folio))
> +					break;
> =20
> -			if (!*s) {
> -				ret =3D PTR_ERR(folio);
> -				goto err_sg;
> -			}
> +				if (!*s) {
> +					ret =3D PTR_ERR(folio);
> +					goto err_sg;
> +				}
> =20
> -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
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
> -				 */
> -				gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -			}
> -		} while (1);
> -
> -		nr_pages =3D min3(folio_nr_pages(folio),
> +				* We've tried hard to allocate the memory by reaping
> +				* our own buffer, now let the real VM do its job and
> +				* go down in flames if truly OOM.
> +				*
> +				* However, since graphics tend to be disposable,
> +				* defer the oom here by reporting the ENOMEM back
> +				* to userspace.
> +				*/
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
> +
> +			folio_start =3D folio_pgoff(folio);
> +			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
> +		}
> +
> +		folio_page_index =3D i - folio_start;

While your point about the need to address more than one reference to a
folio unnecessarily being held was valid, I'm still not sure if what you
propose is the most simple way to resolve it.  For me, checking if next_pfn
is still inside the current folio range and omitting shmem_read_folio_gfp()
if true would be a good enough way to avoid re-getting it.

Moreover, I haven't heard from you about my idea of reusing that already
maintained next_pfn for calculation of folio_page_index, then still
simplifying the code changes that way.  Can you see any cons?

Thanks,
Janusz


> +		nr_pages =3D min3(folio_nr_pages(folio) - folio_page_index,
>  				page_count - i, max_segment / PAGE_SIZE);
> =20
>  		if (!i ||
> @@ -166,13 +177,24 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  				sg =3D sg_next(sg);
> =20
>  			st->nents++;
> -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> +			sg_set_page(sg, folio_page(folio, folio_page_index),
> +				    nr_pages * PAGE_SIZE, 0);
>  		} else {
> +			/*
> +			 * If our prediction about folio placement is true and
> +			 * scatterlist still has space left for more pages,
> +			 * then we land here.
> +			 */
>  			nr_pages =3D min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> =20
>  			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}
> -		next_pfn =3D folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * We assume folios are placed one after the other in memory
> +		 * and predict where the next folio begins.
> +		 */
> +		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
>  		i +=3D nr_pages - 1;
> =20
>  		/* Check that the i965g/gm workaround works. */
