Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A9C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D62310E160;
	Mon, 20 Jul 2026 10:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DzWJhGik";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B77310E148;
 Mon, 20 Jul 2026 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542548; x=1816078548;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=dfyA02sKGaIMirLO3Wtz9psmT77KyIoI656f9ZGMcGA=;
 b=DzWJhGikHXaWG6tHaBY6aYnPCDeaxRzqBfx1jf+c7xnJXvJZBlU3AhYy
 LxscnnEj4BLHG0tQ/9lVK+Vu4dIdcXl4OM6HY7ihT+QB895j2rXv6sCzz
 KwAvnNpV3DK5TaQ9vNh675r2nQDWi9Vlqc6vO5pbTuouy8O8kF/nWMoCL
 Dh98Ux3mMqffMg2fbRr5iiuqeGpjRLuoQfytZJ1/+cquY4DT2/+bpVhPH
 E6KYylDJ/2vS5vbbGWi73I3ErZfL/IZx+0vrCqM79oosiOGltVqFsaBkZ
 4OGK2eIa7h1BYWLmQsRbxJkUGI49pbKi4qKZk9reBDhydkQO8zaw/ItWz Q==;
X-CSE-ConnectionGUID: JNfryugwQ86B49A9q0Rz8Q==
X-CSE-MsgGUID: 9krs8lP2QvyUdTzQKCWfrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85069856"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85069856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:15:48 -0700
X-CSE-ConnectionGUID: Eqt8sR54RD6X9IYi/5rIDg==
X-CSE-MsgGUID: gJe1YY5XSRah7RNMw1vaEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="287474905"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.94])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:15:46 -0700
Message-ID: <8154a1c3fedeb9b04df311ad92dc1db0de0a845e.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, Robin
 Murphy	 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 =?UTF-8?Q?Micha=C5=82?= Grzelak	 <michal.grzelak@intel.com>, Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Mon, 20 Jul 2026 12:15:43 +0200
In-Reply-To: <fpdox6uyoqnjx7nat427miehqtmhermzcpdpqfeystrmuwsgoq@sxbrby7ofmma>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-5-krzysztof.karas@intel.com>
 <8979872eac4f9eabb499f074b66583013f6f524c.camel@linux.intel.com>
 <fpdox6uyoqnjx7nat427miehqtmhermzcpdpqfeystrmuwsgoq@sxbrby7ofmma>
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

On Mon, 2026-07-20 at 08:18 +0000, Krzysztof Karas wrote:
> Hi Janusz,
>=20
> On 2026-07-15 at 17:31:56 +0200, Janusz Krzysztofik wrote:
> > On Mon, 2026-07-13 at 09:58 +0000, Krzysztof Karas wrote:
> > > Continue unloading shmem_sg_alloc_table by placing reading
> > > folios and shrink call into a new helper.
> > > Make the loop a bit more reader-friendly by removing iteration
> > > over a structure and replacing it with a do-while loop.
> > >=20
> > > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > > ---
> > > v3:
> > >  * Split refactoring and put it after the fix in shmem folio
> > >   counting suggested by Andi.
> > >  * Use do-while loop suggested by Robin.=20
> > >=20
> > >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 102 ++++++++++++--------=
--
> > >  1 file changed, 55 insertions(+), 47 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/=
drm/i915/gem/i915_gem_shmem.c
> > > index 4a61b012fb6f..7c8de8fe0a22 100644
> > > --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > > +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> > > @@ -78,6 +78,55 @@ static int validate_size(size_t size, unsigned int=
 page_count,
> > >  	return 0;
> > >  }
> > > =20
> > > +static struct folio *shmem_shrink_get_folio(struct address_space *ma=
pping,
> > > +					    unsigned long folio_index,
> > > +					    gfp_t gfp, unsigned int page_count,
> > > +					    struct drm_i915_private *i915)
> > > +{
> > > +	struct folio *folio =3D NULL;
> > > +	unsigned int retries =3D 2;
> > > +
> > > +	do {
> > > +		cond_resched();
> > > +		folio =3D shmem_read_folio_gfp(mapping, folio_index, gfp);
> > > +		if (IS_ERR(folio)) {
> >=20
> > Going again through then unused shrinking and modification of gfp doesn=
't=C2=A0
> > make sense, I believe.  Could be avoided based on retries value as an=
=C2=A0
> > additional condition.
> If calling i915_gem_shrink again doesn't give us anything, then
> looping doesn not really benefit us here. We could do something
> like this instead:
>=20
> folio =3D shmem_read_folio_gfp(...);
> if (IS_ERR(folio)) {
> 	i915_gem_shrink(...);
> 	gfp =3D mapping_gfp_mask(mapping);
> 	gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> 	/* again */
> 	folio =3D shmem_read_folio_gfp(...);
> }
>=20
> return folio;
>=20
> That way we'd be explicit about shrinking once and retrying
> folio reading only once. Reduced indentation would be added
> bonus.
>=20
> What do you think?

Yes, that would be much more clear.  I would only keep the cond_resched(),=
=C2=A0
at least before retrying, unless you can justify its removal.

Thanks,
Janusz
