Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A2C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1880410EE22;
	Wed, 19 Aug 2026 11:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z2plVjCx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C76610EE1B;
 Wed, 19 Aug 2026 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787140626; x=1818676626;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=0wWjtRHdG5z5eJWH7F2Cypop7FcC0fUWsM3CBOSyEig=;
 b=Z2plVjCx1Eo4XipoEqbsIU3gn0YdNvK7NLktRbHFA+PGSghH0exRzBKf
 h7vhk+pYdHIKXeJhOpAU5a/6sHHs1ki52P0YdNClQzcVE+VnPK8M51Vkz
 UD9qJFgYKDregyFerVPRsvRbv8nqGIxMR7krt7R1TmZV+Zx79MSCrppXa
 bDbncXBNzUZrrU/BHhPF+V1IEzj/6Nu15yiu613Ndujj0FudGue0NmqwL
 knsNkFlsb5Zt2PHjijN4Lg90cWu1rbO9PxS3nfM2himvvcqF3Oqk0DbWH
 feZcJ7757ODHcm0q/gz/hYyEElVXNY+l3lYwg32QK6XZS1hW4nHIKo2e0 g==;
X-CSE-ConnectionGUID: YPRRHmZmTsu8SJdCPYX77g==
X-CSE-MsgGUID: SQ1T7EDYSS6DnQsaaxWm8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91526625"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="91526625"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 04:57:06 -0700
X-CSE-ConnectionGUID: JMUqUdIZTimNa53NsHhxsg==
X-CSE-MsgGUID: FkQhxokYTQ+l0qy96pdB1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="267475120"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 04:57:02 -0700
Message-ID: <ddc172c331091e326e1d913cc2a5147efd4d8173.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,  Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Wed, 19 Aug 2026 13:56:47 +0200
In-Reply-To: <20260817095648.2438192-2-krzysztof.karas@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-2-krzysztof.karas@intel.com>
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

While I'm finally more or less OK with your commit description :-), I
still=C2=A0have some=C2=A0comments to code changes you propose.

On Mon, 2026-08-17 at 09:56 +0000, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
>=20
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>=20
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>=20
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v5:
>  * Moved max_segment value validation before allocating shmem table
>  (Sebastian).
>  * Aligned comments (Sebastian).
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 121 ++++++++++++++--------
>  1 file changed, 76 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 06543ae60706..f338dc39fad1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  			 unsigned int max_segment)
>  {
>  	unsigned int page_count; /* restricted by sg_alloc_table */
> -	unsigned long i;
> +	unsigned long next_pfn =3D 0; /* suppress gcc warning */
> +	unsigned long folio_start =3D 0;
> +	unsigned long folio_end =3D 0;
> +	struct folio *folio =3D NULL;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
>  	gfp_t noreclaim;
> +	unsigned long i;
>  	int ret;
> =20
>  	if (overflows_type(size / PAGE_SIZE, page_count))
> @@ -85,6 +88,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915,=
 struct sg_table *st,
>  	if (size > resource_size(&mr->region))
>  		return -ENOMEM;
> =20
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;
> +
>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
> =20
> @@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index =3D 0;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -109,71 +115,95 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
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

I think that even with folio_start < i < folio_end,=C2=A0
shmem_read_folio_gfp(..., i, ...) should always return the right folio, so=
=C2=A0
we shouldn't worry about getting the same folio again in a relatively rare=
=C2=A0
case=C2=A0of=C2=A0the=C2=A0folio size exceeding a scatterlist capacity, we =
only need to=C2=A0
take=C2=A0care of=C2=A0tracking=C2=A0an offset within that folio.  Then, ..=
.

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
> +
> +			folio_start =3D folio_pgoff(folio);
> +			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
> +		}
> +
> +		folio_page_index =3D i - folio_start;
> +		if (WARN_ON_ONCE(folio_page_index >=3D folio_nr_pages(folio))) {
> +			ret =3D -EINVAL;
> +			folio_put(folio);
> +			goto err_sg;
> +		}

... the existing code above, including the existing 'do' loop, may be left=
=C2=A0
untouched, I believe, an your folio_page_index can easily be calculated=C2=
=A0
from=C2=A0an already maintained next_pfn as:

+		folio_page_index =3D next_pfn - folio_pfn(folio);
+		if (folio_page_index < 0 || folio_page_index >=3D folio_nr_pages(folio))
+			folio_page_index =3D 0;

IOW, we need to calculate and apply an offset within the folio only if=C2=
=A0
next_pfn is still within the folio's PFN range, otherwise that must be a=C2=
=A0
new folio and the offset we apply must be 0.

Then, unless I'm missing something, I believe the patch could be much more=
=C2=A0
compact while still correct with my approach.  However, if other reviewers=
=C2=A0
are more OK with your proposed changes rather than what I suggest then I=C2=
=A0
won't oppose.

> =20
>  		nr_pages =3D min_array(((unsigned long[]) {
> -					folio_nr_pages(folio),
> +					folio_nr_pages(folio) - folio_page_index,
>  					page_count - i,
>  					max_segment / PAGE_SIZE,
>  				      }), 3);
> =20
>  		if (!i ||
>  		    sg->length >=3D max_segment ||
> -		    folio_pfn(folio) !=3D next_pfn) {
> +		    folio_pfn(folio) + folio_page_index !=3D next_pfn) {

I think the existing condition was correct, and still applicable even when=
=C2=A0
tracking potential offsets within folios: when there is still some room in=
=C2=A0
the current scatterlist, enter the else part that fills up the scatterlist=
=C2=A0
with more data only if we've got a new folio that starts exactly where=C2=
=A0
the=C2=A0previous one ended to have contiguity of pages preserved, otherwis=
e=C2=A0
switch to a new scatterlist.

>  			if (i)
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
>  			nr_pages =3D min_t(unsigned long, nr_pages,
>  					 (max_segment - sg->length) / PAGE_SIZE);
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
> @@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	i915_sg_trim(st);
> =20
>  	return 0;
> +

Not related, I wouldn't mix it in, unless you have a good justification.

Thanks,
Janusz

>  err_sg:
>  	sg_mark_end(sg);
>  	if (sg !=3D st->sgl) {
