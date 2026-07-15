Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F8DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD76610E7C8;
	Wed, 15 Jul 2026 15:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NEct2bTv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB3F10E3C9;
 Wed, 15 Jul 2026 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784129521; x=1815665521;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=uxQEkKsEB6KSJIG6TBd6vt/3+84+YhOXzaye/UwOWro=;
 b=NEct2bTvziXjcv1dwl/s65uMTCGjeArz1Yam+cGLsjxaZLsQrq0Y1ZVo
 5WJaZlwuR9p7HxnU5wgtZ75CMkRv9WUKo2w69uuW+zSVUeZOL7cW5D3Cq
 Duxbgf3Y7ISU4SVziZwAhi3q+4CI4AKQYW+TFwoSOqHEKwkpSQXvSz86l
 aJWdw8TbvcI7VTJSAPuUnbRGCjU/yDZr5JL6XvOv1zTCwq6D3Id4cgyyt
 uvm6y1mbYlbc8ok8F1c9oWWlabEU3IfC8tAsCrVQPNctvWySKiL2+b7ca
 H/TmYDJwkel7GPcFDD8Y75EQUzO5qZUj7gY1KcDRzsVgif3vo0sH+w+Zz w==;
X-CSE-ConnectionGUID: LoY+IsZ4TJa3EHgVwr+jSA==
X-CSE-MsgGUID: GkTdisb2QMy2zW2ehd19wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72302455"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="72302455"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 08:32:01 -0700
X-CSE-ConnectionGUID: wsw9T3L/Tl+JD1YnkJxouw==
X-CSE-MsgGUID: lGR3oExsSFK796u7rEBHJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="252817349"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.25])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 08:31:58 -0700
Message-ID: <8979872eac4f9eabb499f074b66583013f6f524c.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,  Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Wed, 15 Jul 2026 17:31:56 +0200
In-Reply-To: <20260713095812.1014365-5-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-5-krzysztof.karas@intel.com>
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

On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> Continue unloading shmem_sg_alloc_table by placing reading
> folios and shrink call into a new helper.
> Make the loop a bit more reader-friendly by removing iteration
> over a structure and replacing it with a do-while loop.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Split refactoring and put it after the fix in shmem folio
>   counting suggested by Andi.
>  * Use do-while loop suggested by Robin.=20
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 102 ++++++++++++----------
>  1 file changed, 55 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 4a61b012fb6f..7c8de8fe0a22 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -78,6 +78,55 @@ static int validate_size(size_t size, unsigned int pag=
e_count,
>  	return 0;
>  }
> =20
> +static struct folio *shmem_shrink_get_folio(struct address_space *mappin=
g,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int page_count,
> +					    struct drm_i915_private *i915)
> +{
> +	struct folio *folio =3D NULL;
> +	unsigned int retries =3D 2;
> +
> +	do {
> +		cond_resched();
> +		folio =3D shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (IS_ERR(folio)) {

Going again through then unused shrinking and modification of gfp doesn't=
=C2=A0
make sense, I believe.  Could be avoided based on retries value as an=C2=A0
additional condition.

Thanks,
Janusz


> +			i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
> +					I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
> +
> +			/*
> +			 * We've tried hard to allocate the memory by reaping
> +			 * our own buffer, now let the real VM do its job and
> +			 * go down in flames if truly OOM.
> +			 *
> +			 * However, since graphics tend to be disposable,
> +			 * defer the oom here by reporting the ENOMEM back
> +			 * to userspace.
> +			 *
> +			 * Reclaim and warn, but no oom.
> +			 */
> +			gfp =3D mapping_gfp_mask(mapping);
> +
> +			/*
> +			 * Our bo are always dirty and so we require
> +			 * kswapd to reclaim our pages (direct reclaim
> +			 * does not effectively begin pageout of our
> +			 * buffers on its own). However, direct reclaim
> +			 * only waits for kswapd when under allocation
> +			 * congestion. So as a result __GFP_RECLAIM is
> +			 * unreliable and fails to actually reclaim our
> +			 * dirty pages -- unless you try over and over
> +			 * again with !__GFP_NORETRY. However, we still
> +			 * want to fail this allocation rather than
> +			 * trigger the out-of-memory killer and for
> +			 * this we want __GFP_RETRY_MAYFAIL.
> +			 */
> +			gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +		}
> +	} while (IS_ERR(folio) && --retries);
> +
> +	return folio;
> +}
> +
>  int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table =
*st,
>  			 size_t size, struct intel_memory_region *mr,
>  			 struct address_space *mapping,
> @@ -117,57 +166,16 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
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
> -				cond_resched();
> -				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -				if (!IS_ERR(folio))
> -					break;
> -
> -				if (!*s) {
> -					ret =3D PTR_ERR(folio);
> -					goto err_sg;
> -				}
> -
> -				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
> -				/*
> -				* We've tried hard to allocate the memory by reaping
> -				* our own buffer, now let the real VM do its job and
> -				* go down in flames if truly OOM.
> -				*
> -				* However, since graphics tend to be disposable,
> -				* defer the oom here by reporting the ENOMEM back
> -				* to userspace.
> -				*/
> -				if (!*s) {
> -					/* reclaim and warn, but no oom */
> -					gfp =3D mapping_gfp_mask(mapping);
> -
> -					/*
> -					 * Our bo are always dirty and so we require
> -					 * kswapd to reclaim our pages (direct reclaim
> -					 * does not effectively begin pageout of our
> -					 * buffers on its own). However, direct reclaim
> -					 * only waits for kswapd when under allocation
> -					 * congestion. So as a result __GFP_RECLAIM is
> -					 * unreliable and fails to actually reclaim our
> -					 * dirty pages -- unless you try over and over
> -					 * again with !__GFP_NORETRY. However, we still
> -					 * want to fail this allocation rather than
> -					 * trigger the out-of-memory killer and for
> -					 * this we want __GFP_RETRY_MAYFAIL.
> -					 */
> -					gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -				}
> -			} while (1);
> +			folio =3D shmem_shrink_get_folio(mapping, i, gfp,
> +						       page_count, i915);
> +			if (IS_ERR(folio)) {
> +				ret =3D PTR_ERR(folio);
> +				goto err_sg;
> +			}
> =20
>  			folio_start =3D folio_pgoff(folio);
>  			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
