Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977C606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HJMAi2yg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECA410E85A;
	Tue, 24 Nov 2026 13:02:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0220A10E85A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795525329; x=1827061329;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=dCaBx1IJBtbAURuvD9d5zeTZDkdcqQyuv0GJTZd8RCM=;
 b=HJMAi2ygcPsMnwd8GHHIty9NF0PwS1vMMPytgtqEJ+h0h9VGj4DQxgmX
 gb2ZDvqF26iGFdOpNbzc+1nYbpbo+xqKOuJ2qGkQ8dv+HGyjkOUmOPTeA
 Q+SMHg9LfjChJeubxZeRle6+ZBJ7D3uUcAOhpXwQ9tFFXeykRf2nFe5H7
 1VuY2Gcjh2yV3QOLTLimMlINUZ9BNs+GiPI8AYXM4/h3gEM6Ep01YNSfQ
 d3vcMEhkyThWXaFvm3m7fGJ5pP4YnF5Kaz2JMAF1zOyHTTQDwbF0vb4oP
 v2dMcYD9h8HmWW06h5Bx+wIz1oCK8/jlZK/tN0PvG8x/ktTHFJdunSiAD g==;
X-CSE-ConnectionGUID: 7seCs9uMRB66cBrQk02dLA==
X-CSE-MsgGUID: lkWyATgMQ2G7L3GB2ouIpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4469459"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4469459"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:01:35 -0800
X-CSE-ConnectionGUID: ZdmjBAXfQ8isfXc68bYqnQ==
X-CSE-MsgGUID: JfyzpOW2SIOtX7oCza+tBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11678762"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.188])
 ([10.245.245.188])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:01:32 -0800
Message-ID: <19507a679f7ac52bed0e1cfc549789ea1f9ddb7d.camel@linux.intel.com>
Subject: Re: [PATCH] ttm/pool: Don't leak LRU list on shutdown
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 airlied@redhat.com, dri-devel@lists.freedesktop.org, Ian Forbes
 <ian.forbes@broadcom.com>
Date: Tue, 24 Nov 2026 14:01:30 +0100
In-Reply-To: <CAPM=9tx4ausyL0qoxA+4gDN8ciWhd8m99obh5O7-M2y2ndGTcw@mail.gmail.com>
References: <cf3c13a8-1dc3-4b2a-8d37-0be289a31980@amd.com>
 <20261122140812-09f251792405451c0dc74623-pchelkin@ispras>
 <CAPM=9tx4ausyL0qoxA+4gDN8ciWhd8m99obh5O7-M2y2ndGTcw@mail.gmail.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, 2026-11-23 at 10:35 +1000, Dave Airlie wrote:
> Thanks,
>=20
> Pushed to drm-misc-fixes now.
>=20
> Dave.

This breaks TTM kunit tests.=20
https://lore.kernel.org/r/179551898058.76739.11365088738563088346@9ac1b63fe=
3ea

Thanks,
Thomas

>=20
> On Sun, 22 Nov 2026 at 22:16, Fedor Pchelkin <pchelkin@ispras.ru>
> wrote:
> >=20
> > Christian K=C3=B6nig wrote:
> > > On 5/27/26 22:20, Ian Forbes wrote:
> > > > TTM pool was changed from a regular list to an lru list in the
> > > > referenced fixes commit. list_lru_init allocates state and it
> > > > needs to
> > > > be freed unlike a simple list.
> > > >=20
> > > > Found using the igt@core_hotunplug and kmemleak.
> > > >=20
> > > > Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> > > > Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> > >=20
> > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >=20
> > > > ---
> > > > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 1 +
> > > > =C2=A01 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index 26a3689e5fd9..a41addbf3ddf 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -395,6 +395,7 @@ static void ttm_pool_type_fini(struct
> > > > ttm_pool_type *pt)
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 list_lru_walk(&pt->pages, pool_move_to_dispose_l=
ist,
> > > > &dispose, LONG_MAX);
> > > > =C2=A0=C2=A0=C2=A0 ttm_pool_dispose_list(pt, &dispose);
> > > > +=C2=A0=C2=A0 list_lru_destroy(&pt->pages);
> > > > =C2=A0}
> > > >=20
> > > > =C2=A0/* Return the pool_type to use for the given caching and orde=
r
> > > > */
> >=20
> > The patch probably fell through the cracks.=C2=A0 Can't find it at drm-
> > tip.git.
> > Would you apply this, please?
