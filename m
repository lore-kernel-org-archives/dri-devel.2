Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC87606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SbNKTvTd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8297310EDCD;
	Mon,  2 Nov 2026 12:46:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3027210ED9A;
 Mon,  2 Nov 2026 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793623604; x=1825159604;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ME0095WuKQv8ZFeSMelPcUgrO+NfNTGYWmdhK5ZwVfU=;
 b=SbNKTvTdyL30oCiWZyjXVSRp4Y0++OBBFdOzZNhtfmnpCowhTqZbQ+ER
 e5copQJmIlMoGgWhgdT1HKa7Df+UNfgcISYyOLq6kHPpkXOdT6xG5AWqo
 RUetGtqj3YdMV8S7As7zjyAqQINTN/8GJ0McxFHa6g6t7D2yrVLqd6GoN
 ToSHwL1JMq2Q3qrPfstF54AkLH0O/9Atf1Rr5Vlg0H7+1ki0NtxGSuvFR
 Osjmln6T/89qPQW+koPZpWmSWdrRuY5zwdvmhPSHnwvBVSeK5pqjeb7Jv
 nFttznNSWzATQH3dLTers1fYBbyGQjybznCuIWMonm3h4BD1j4vZR6JX+ g==;
X-CSE-ConnectionGUID: YAuECQGBQem2IpxOtUZPrA==
X-CSE-MsgGUID: dIgAi28VRPa1AVZHujIEyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2193611"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2193611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:46:44 -0800
X-CSE-ConnectionGUID: mZ7dLPF2RRC/4w3cc87J1Q==
X-CSE-MsgGUID: rFcyC7IFS9SYidhBKp5+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6446529"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.237])
 ([10.245.244.237])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:46:41 -0800
Message-ID: <9aaff638454782d9719c1d62391391f35f44affc.camel@linux.intel.com>
Subject: Re: [RFC 1/7] drm/ttm/pool: Add ttm_pool_alloc_node() for
 caller-selected NUMA node
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Himal
 Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, Huang Rui
 <ray.huang@amd.com>, Rodrigo Vivi	 <rodrigo.vivi@intel.com>, Natalie Vock
 <natalie.vock@gmx.de>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>, Matthew Brost
 <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
Date: Mon, 02 Nov 2026 13:46:38 +0100
In-Reply-To: <8c2b893a-b666-4678-88f0-4e6b33142e1a@amd.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
 <8c2b893a-b666-4678-88f0-4e6b33142e1a@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
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

Hi, Christian,

On Mon, 2026-11-02 at 11:50 +0100, Christian K=C3=B6nig wrote:
> First of all please add Natalie and Arun on TTM patches, they are the
> maintainers of that component now.
>=20
> On 11/2/26 11:18, Himal Prasad Ghimiray wrote:
> > ttm_pool_alloc() always allocates on the pool's default node,
> > although
> > the internal TTM helpers (__ttm_pool_alloc(),
> > ttm_pool_alloc_page(),
> > ttm_pool_type_take()) already take a nid. Add ttm_pool_alloc_node()
> > to
> > let a driver pass that nid for a specific tt.
> >=20
> > ttm_pool_alloc() passes NUMA_NO_NODE, keeping current behaviour. An
> > explicit node on a dma_alloc pool returns -EOPNOTSUPP, as
> > dma_alloc_attrs() can't honor it.
>=20
> We already have an interface for NUMA node aware allocations in the
> TTM pool.
>=20
> I don't mind changing/improving that when necessary, but that here is
> only adding a second path and therfore a clear NO-GO from my side.

What we were looking at moving forward is to possibly support
interleaving modes (and that would mean interleaving per folio).

>=20
> If you want to change the nid from ttm_pool_init() to
> ttm_pool_alloc() then change all existing users.

Point taken. Any specific reason ttm_pool_init() was initially chosen?

Thanks,
Thomas


>=20
> Regards,
> Christian.
>=20
> > Signed-off-by: Himal Prasad Ghimiray
> > <himal.prasad.ghimiray@intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 59 +++++++++++++++++++++++++++++=
-
> > ----
> > =C2=A0include/drm/ttm/ttm_pool.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A02 files changed, 53 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 1bf37023fed6..54d2f6b5c229 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -158,9 +158,9 @@ static int ttm_pool_nid(struct ttm_pool *pool)
> > =C2=A0	return nid;
> > =C2=A0}
> > =C2=A0
> > -/* Allocate pages of size 1 << order with the given gfp_flags */
> > +/* Allocate pages of size 1 << order with the given gfp_flags on
> > node @nid */
> > =C2=A0static struct page *ttm_pool_alloc_page(struct ttm_pool *pool,
> > gfp_t gfp_flags,
> > -					unsigned int order)
> > +					unsigned int order, int
> > nid)
> > =C2=A0{
> > =C2=A0	const unsigned int beneficial_order =3D
> > ttm_pool_beneficial_order(pool);
> > =C2=A0	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> > @@ -189,7 +189,7 @@ static struct page *ttm_pool_alloc_page(struct
> > ttm_pool *pool, gfp_t gfp_flags,
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (!ttm_pool_uses_dma_alloc(pool)) {
> > -		p =3D alloc_pages_node(pool->nid, gfp_flags, order);
> > +		p =3D alloc_pages_node(nid, gfp_flags, order);
> > =C2=A0		if (p) {
> > =C2=A0			p->private =3D order;
> > =C2=A0			mod_lruvec_page_state(p, NR_GPU_ACTIVE, 1
> > << order);
> > @@ -783,7 +783,8 @@ static unsigned int
> > ttm_pool_alloc_find_order(unsigned int highest,
> > =C2=A0static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt
> > *tt,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 const struct ttm_operation_ctx *ctx,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 struct ttm_pool_alloc_state *alloc,
> > -			=C2=A0=C2=A0=C2=A0 struct ttm_pool_tt_restore *restore)
> > +			=C2=A0=C2=A0=C2=A0 struct ttm_pool_tt_restore *restore,
> > +			=C2=A0=C2=A0=C2=A0 int nid)
> > =C2=A0{
> > =C2=A0	enum ttm_caching page_caching;
> > =C2=A0	gfp_t gfp_flags =3D GFP_USER;
> > @@ -818,7 +819,7 @@ static int __ttm_pool_alloc(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> > =C2=A0		p =3D NULL;
> > =C2=A0		pt =3D ttm_pool_select_type(pool, page_caching,
> > order);
> > =C2=A0		if (pt && allow_pools)
> > -			p =3D ttm_pool_type_take(pt,
> > ttm_pool_nid(pool));
> > +			p =3D ttm_pool_type_take(pt, nid);
> > =C2=A0
> > =C2=A0		/*
> > =C2=A0		 * If that fails or previously failed, allocate
> > from system.
> > @@ -829,7 +830,7 @@ static int __ttm_pool_alloc(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> > =C2=A0		if (!p) {
> > =C2=A0			page_caching =3D ttm_cached;
> > =C2=A0			allow_pools =3D false;
> > -			p =3D ttm_pool_alloc_page(pool, gfp_flags,
> > order);
> > +			p =3D ttm_pool_alloc_page(pool, gfp_flags,
> > order, nid);
> > =C2=A0		}
> > =C2=A0		/* If that fails, lower the order if possible and
> > retry. */
> > =C2=A0		if (!p) {
> > @@ -900,10 +901,52 @@ int ttm_pool_alloc(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> > =C2=A0
> > =C2=A0	ttm_pool_alloc_state_init(tt, &alloc);
> > =C2=A0
> > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL,
> > ttm_pool_nid(pool));
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(ttm_pool_alloc);
> > =C2=A0
> > +/**
> > + * ttm_pool_alloc_node - Fill a ttm_tt object, placing pages on a
> > given node
> > + *
> > + * @pool: ttm_pool to use
> > + * @tt: ttm_tt object to fill
> > + * @ctx: operation context
> > + * @nid: NUMA node id to allocate the backing system pages from,
> > or
> > + * NUMA_NO_NODE to use the pool's default node (@ttm_pool.nid)
> > + *
> > + * Like ttm_pool_alloc(), but allows the caller to override the
> > NUMA node the
> > + * backing system pages are allocated from. This only affects the
> > + * non-coherent (non dma-alloc) allocation path; coherent/dma
> > pools continue
> > + * to use the device-local node. Intended for drivers that expose
> > a
> > + * user-selectable host memory NUMA placement.
> > + *
> > + * Returns: 0 on success, -EOPNOTSUPP if @nid is specified on a
> > coherent/dma
> > + * pool, negative error code otherwise.
> > + */
> > +int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
> > +			struct ttm_operation_ctx *ctx, int nid)
> > +{
> > +	struct ttm_pool_alloc_state alloc;
> > +
> > +	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Coherent/dma pools allocate via dma_alloc_attrs(),
> > which places pages
> > +	 * per device DMA constraints and cannot honor a caller-
> > requested node.
> > +	 */
> > +	if (nid !=3D NUMA_NO_NODE && ttm_pool_uses_dma_alloc(pool))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (nid =3D=3D NUMA_NO_NODE)
> > +		nid =3D ttm_pool_nid(pool);
> > +
> > +	ttm_pool_alloc_state_init(tt, &alloc);
> > +
> > +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, nid);
> > +}
> > +EXPORT_SYMBOL(ttm_pool_alloc_node);
> > +
> > =C2=A0/**
> > =C2=A0 * ttm_pool_restore_and_alloc - Fill a ttm_tt, restoring
> > previously backed-up
> > =C2=A0 * content.
> > @@ -964,7 +1007,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
> > +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore,
> > ttm_pool_nid(pool));
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > diff --git a/include/drm/ttm/ttm_pool.h
> > b/include/drm/ttm/ttm_pool.h
> > index 26ee592e1994..6a0b14aca092 100644
> > --- a/include/drm/ttm/ttm_pool.h
> > +++ b/include/drm/ttm/ttm_pool.h
> > @@ -79,6 +79,8 @@ struct ttm_pool {
> > =C2=A0
> > =C2=A0int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > =C2=A0		=C2=A0=C2=A0 struct ttm_operation_ctx *ctx);
> > +int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
> > +			struct ttm_operation_ctx *ctx, int nid);
> > =C2=A0void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
> > =C2=A0
> > =C2=A0void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
