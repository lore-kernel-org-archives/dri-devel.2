Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCCC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524BC10E122;
	Wed, 15 Jul 2026 17:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GGxcvK57";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B877F10E038;
 Wed, 15 Jul 2026 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784135088; x=1815671088;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=agh4TJPgCapaO9IbE8zNJKtF0Z/+FWmA9sTeV9lo0rQ=;
 b=GGxcvK57gHlGpRHi0UZwQbkbL3oPGyZhTn+gcUxvNPwNcOIwhmoJNG5A
 zZqiodMS2nso+6toxujtPNhfKCMh7nDXwFZwS/1ADKVwqO+tTxZMzVKmB
 OD4BNGGDiZoQ/pi82senGEuFI/4knqoRgiKJAclRPaHIQNHOByv0yo4NZ
 0qQmFNbPoyaPRxee2EC16aDM5c0AMxO/BCEObzfAYT5Um+0B8Be4KIT29
 yERoQId7tBDarQzeg9U91L/mag2xn5bHrqFq/8dSzTa9FsHN+cXJsa2/y
 7GdYRhoOja0VGjlbSmmh/F13n9iNNXULfd+INA2rXRLv3rJMe8uxrT26H A==;
X-CSE-ConnectionGUID: 5jedFKRvS36mF6Zzh25aBA==
X-CSE-MsgGUID: dSJvCGEITG67BRz7vy5GZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88458232"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="88458232"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 10:04:48 -0700
X-CSE-ConnectionGUID: tnfm4wd+Q/yfw6UVv/Ovrw==
X-CSE-MsgGUID: BvVFv0RoS2+f+45PzF5tcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="261144987"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.25])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 10:04:44 -0700
Message-ID: <a9b6b5c4165904ac474fb4a0d56341827b33e66b.camel@linux.intel.com>
Subject: Re: [PATCH v3 5/5] drm/i915/gem: Remove iterator and use while loop
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,  Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Wed, 15 Jul 2026 19:04:42 +0200
In-Reply-To: <20260713095812.1014365-6-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-6-krzysztof.karas@intel.com>
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

On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> Change the main "for" loop into "while" to get rid of obscure
> iterator "i" and use more descriptive name to indicate how many
> pages were already covered. Detect first loop with st->nents and
> put instructions for that case in their own block for easier
> reading.
>=20
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v3:
>  * Split refactoring and put it after the fix in shmem folio
>   counting suggested by Andi.
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 29 +++++++++++------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 7c8de8fe0a22..66d0f8f6ffcc 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -135,11 +135,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  	unsigned int page_count; /* restricted by sg_alloc_table */
>  	unsigned long next_pfn =3D 0; /* suppress gcc warning */
>  	unsigned long folio_start =3D 0;
> +	unsigned long pages_done =3D 0;
>  	unsigned long folio_end =3D 0;
>  	struct folio *folio =3D NULL;
>  	struct scatterlist *sg;
>  	gfp_t noreclaim;
> -	unsigned long i;
>  	int ret;
> =20
>  	page_count =3D size / PAGE_SIZE;
> @@ -163,15 +163,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
> =20
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
> -	for (i =3D 0; i < page_count; i++) {
> +	while (pages_done < page_count) {
>  		unsigned long folio_page_index =3D 0;
>  		unsigned long nr_pages;
>  		gfp_t gfp =3D noreclaim;
> =20
>  		/* Grab the next folio if we exhausted the current one. */
> -		if (!i || i > folio_end) {
> -			folio =3D shmem_shrink_get_folio(mapping, i, gfp,
> -						       page_count, i915);
> +		if (!pages_done || pages_done > folio_end) {
> +			folio =3D shmem_shrink_get_folio(mapping, pages_done, gfp,
> +						       page_count - pages_done, i915);
>  			if (IS_ERR(folio)) {
>  				ret =3D PTR_ERR(folio);
>  				goto err_sg;
> @@ -181,7 +181,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
>  		}
> =20
> -		folio_page_index =3D i - folio_start;
> +		folio_page_index =3D pages_done - folio_start;
>  		if (WARN_ON_ONCE(folio_page_index >=3D folio_nr_pages(folio))) {
>  			ret =3D -EINVAL;
>  			folio_put(folio);
> @@ -190,16 +190,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
> =20
>  		nr_pages =3D min_array(((unsigned long[]) {
>  					folio_nr_pages(folio) - folio_page_index,
> -					page_count - i,
> +					page_count - pages_done,
>  					max_t(unsigned int, 1, max_segment / PAGE_SIZE),
>  				      }), 3);
> -
> -		if (!i ||
> -		    sg->length >=3D max_segment ||
> -		    folio_pfn(folio) + folio_page_index !=3D next_pfn) {
> -			if (i)
> -				sg =3D sg_next(sg);
> -
> +		if (!st->nents) {
> +			st->nents++;
> +			sg_set_page(sg, folio_page(folio, 0), nr_pages * PAGE_SIZE, 0);
> +		} else if (sg->length >=3D max_segment ||
> +			   folio_pfn(folio) + folio_page_index !=3D next_pfn) {
> +			sg =3D sg_next(sg);

Repeating two or three lines of code to avoid calling another one=C2=A0
conditionally doesn't look optimal to me.  Maybe you could invent a simple=
=C2=A0
replacement of that 'if (i)' conditional expression.

Thanks,
Janusz

>  			st->nents++;
>  			sg_set_page(sg, folio_page(folio, folio_page_index),
>  				    nr_pages * PAGE_SIZE, 0);
> @@ -212,7 +211,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  		}
> =20
>  		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
> -		i +=3D nr_pages - 1;
> +		pages_done +=3D nr_pages;
> =20
>  		/* Check that the i965g/gm workaround works. */
>  		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >=3D 0x00100000UL);
