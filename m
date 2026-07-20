Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E533BC44527
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0299710E85D;
	Mon, 20 Jul 2026 10:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R/Vi7i0w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F6E10E173;
 Mon, 20 Jul 2026 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542797; x=1816078797;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Dp0fjG0t8rCEdB4jrHSNd8VTVbLUv/2+7jQ0Fb9t3iA=;
 b=R/Vi7i0wQR9n6Fd7hyQPoLxVb+1EsXEsFcGbUhq7+IbRYiQlR/CA2Hjn
 sh7qws42fMNpMpJvQ8W2vFaHGZbJNi2IQoq/bbAjCuzmHkKnJWx8IBJu3
 eKHyE8pBIL+KFvn35Gij7sGaHWs5j25T39kW1avkgNy90FbZaNE1MWcdX
 DD753GUx79Q525df8gLn/PWu6qcv2q72jZDRjTwGjAFfRPNJI8VtvdC2K
 sJOPUK06FKDnMT5kmalaJ8HIRSdZvhQ9rN599HxGMfPWTVeX4P4oAYoP8
 uGLwSRfE7Y+LNssSn27J0EXwwIOH1TsAziCrw2LXfmXKUk3FCrE7j3roa w==;
X-CSE-ConnectionGUID: mIHHk/38S3OvE+ETWdghiw==
X-CSE-MsgGUID: 6RlVYPvJQN+UI9T2wCAtuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84996914"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="84996914"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:19:57 -0700
X-CSE-ConnectionGUID: aHCr9372Rs2YDR6Rf3osFw==
X-CSE-MsgGUID: 1fH5KnWHTBm2IvH2ntbCFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253048567"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.94])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:19:53 -0700
Message-ID: <4aeb95b2eca04bc4972e2e88ac47f34ee6020a07.camel@linux.intel.com>
Subject: Re: [PATCH v3 5/5] drm/i915/gem: Remove iterator and use while loop
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, Robin
 Murphy	 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 =?UTF-8?Q?Micha=C5=82?= Grzelak	 <michal.grzelak@intel.com>, Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Mon, 20 Jul 2026 12:19:51 +0200
In-Reply-To: <gjalgvm2zdtzz67lh7jvzopm4ba44w4eh2rpaaniqc2jyegpn2@edzadixxdexq>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-6-krzysztof.karas@intel.com>
 <a9b6b5c4165904ac474fb4a0d56341827b33e66b.camel@linux.intel.com>
 <gjalgvm2zdtzz67lh7jvzopm4ba44w4eh2rpaaniqc2jyegpn2@edzadixxdexq>
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

On Mon, 2026-07-20 at 08:25 +0000, Krzysztof Karas wrote:
> Hi Janusz,
>=20
> On 2026-07-15 at 19:04:42 +0200, Janusz Krzysztofik wrote:
> > Hi Krzysztof,
> >=20
> > On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > > Change the main "for" loop into "while" to get rid of obscure
> > > iterator "i" and use more descriptive name to indicate how many
> > > pages were already covered. Detect first loop with st->nents and
> > > put instructions for that case in their own block for easier
> > > reading.
> > >=20
> > > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > > ---
> > > v3:
> > >  * Split refactoring and put it after the fix in shmem folio
> > >   counting suggested by Andi.
> > >=20
> > >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 29 +++++++++++----------=
--
> > >  1 file changed, 14 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/=
drm/i915/gem/i915_gem_shmem.c
> > > index 7c8de8fe0a22..66d0f8f6ffcc 100644
> > > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > > @@ -135,11 +135,11 @@ int shmem_sg_alloc_table(struct drm_i915_privat=
e *i915, struct sg_table *st,
> > >  	unsigned int page_count; /* restricted by sg_alloc_table */
> > >  	unsigned long next_pfn =3D 0; /* suppress gcc warning */
> > >  	unsigned long folio_start =3D 0;
> > > +	unsigned long pages_done =3D 0;
> > >  	unsigned long folio_end =3D 0;
> > >  	struct folio *folio =3D NULL;
> > >  	struct scatterlist *sg;
> > >  	gfp_t noreclaim;
> > > -	unsigned long i;
> > >  	int ret;
> > > =20
> > >  	page_count =3D size / PAGE_SIZE;
> > > @@ -163,15 +163,15 @@ int shmem_sg_alloc_table(struct drm_i915_privat=
e *i915, struct sg_table *st,
> > > =20
> > >  	sg =3D st->sgl;
> > >  	st->nents =3D 0;
> > > -	for (i =3D 0; i < page_count; i++) {
> > > +	while (pages_done < page_count) {
> > >  		unsigned long folio_page_index =3D 0;
> > >  		unsigned long nr_pages;
> > >  		gfp_t gfp =3D noreclaim;
> > > =20
> > >  		/* Grab the next folio if we exhausted the current one. */
> > > -		if (!i || i > folio_end) {
> > > -			folio =3D shmem_shrink_get_folio(mapping, i, gfp,
> > > -						       page_count, i915);
> > > +		if (!pages_done || pages_done > folio_end) {
> > > +			folio =3D shmem_shrink_get_folio(mapping, pages_done, gfp,
> > > +						       page_count - pages_done, i915);
> > >  			if (IS_ERR(folio)) {
> > >  				ret =3D PTR_ERR(folio);
> > >  				goto err_sg;
> > > @@ -181,7 +181,7 @@ int shmem_sg_alloc_table(struct drm_i915_private =
*i915, struct sg_table *st,
> > >  			folio_end =3D folio_start + folio_nr_pages(folio) - 1;
> > >  		}
> > > =20
> > > -		folio_page_index =3D i - folio_start;
> > > +		folio_page_index =3D pages_done - folio_start;
> > >  		if (WARN_ON_ONCE(folio_page_index >=3D folio_nr_pages(folio))) {
> > >  			ret =3D -EINVAL;
> > >  			folio_put(folio);
> > > @@ -190,16 +190,15 @@ int shmem_sg_alloc_table(struct drm_i915_privat=
e *i915, struct sg_table *st,
> > > =20
> > >  		nr_pages =3D min_array(((unsigned long[]) {
> > >  					folio_nr_pages(folio) - folio_page_index,
> > > -					page_count - i,
> > > +					page_count - pages_done,
> > >  					max_t(unsigned int, 1, max_segment / PAGE_SIZE),
> > >  				      }), 3);
> > > -
> > > -		if (!i ||
> > > -		    sg->length >=3D max_segment ||
> > > -		    folio_pfn(folio) + folio_page_index !=3D next_pfn) {
> > > -			if (i)
> > > -				sg =3D sg_next(sg);
> > > -
> > > +		if (!st->nents) {
> > > +			st->nents++;
> > > +			sg_set_page(sg, folio_page(folio, 0), nr_pages * PAGE_SIZE, 0);
> > > +		} else if (sg->length >=3D max_segment ||
> > > +			   folio_pfn(folio) + folio_page_index !=3D next_pfn) {
> > > +			sg =3D sg_next(sg);
> >=20
> > Repeating two or three lines of code to avoid calling another one=C2=A0
> > conditionally doesn't look optimal to me.  Maybe you could invent a sim=
ple=C2=A0
> > replacement of that 'if (i)' conditional expression.
> Perhaps it is not optimal. I do not feel comfortable having two
> conditions that contradict each other in the same block, which
> is why I wanted to take out the first iteration setup.
>=20
> It is more about aesthetics here, so I do not have a strong
> argument here besides readability. If that is not enough, then
> I'll revert to the previous code.

I think that also depends on how you address my comment to your patch 1/5=
=C2=A0
on that if condition, so we'll see if this comment will be still=C2=A0
applicable.

Thanks,
Janusz
