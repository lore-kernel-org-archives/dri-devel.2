Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D99606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1cbHs/8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D996210FA89;
	Wed, 25 Nov 2026 09:30:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFB110E08B;
 Wed, 25 Nov 2026 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795599025; x=1827135025;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vPbcWRXjk1j1FDWa+zwyp6LEy+c61CsZ1Bm18ReOA08=;
 b=V1cbHs/8iboHzWXdpUTKmmzCOsTOL9f4aNZ3JesLFXd15O0qxl5Eiw5g
 oNvqVE4KcvMKwJ8gOGZT9+KheufeQcuswLlHIWefUpk/ccs5Dee7S0q+K
 I3qo61lQeYvrdzGCg1w+ln6RC53kBZmS0qn0hEF3bl2afeRPVPvb4MoZ2
 EoMSUxfQDeHpY2AgAEwFqSAhEAkH3vSo3maFnGy2yi+4Zk65LUY41jxzM
 Ca8q9dQwHwbYhevPfc6rUPw83qyiA9MoDDpmuIYKUfHJcO90pVeg6OG6W
 5pufQtrxKhRtIIVfSAJgc8T3hhzpmJ44svzFXnTHCD5FzoeYZyJHRvn/K A==;
X-CSE-ConnectionGUID: fHNPILz4R7iGKLNM4IlmCA==
X-CSE-MsgGUID: HP/p+LphROS8ObPGcA0Row==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4530793"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4530793"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 01:30:23 -0800
X-CSE-ConnectionGUID: 9DX7M7rMSvuNzkVuLATd4w==
X-CSE-MsgGUID: 3ry8CE2ZQtiwRqhFQltQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="11942339"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.62])
 ([10.245.244.62])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 01:30:06 -0800
Message-ID: <0fd01434a65f928fe6799e7c7193d6ff9191805f.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when
 it's no longer needed
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>, 
 Arun Pravin <arunpravin.paneerselvam@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, 	dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Date: Wed, 25 Nov 2026 10:30:03 +0100
In-Reply-To: <awXrVdQKNToiLtmE@gsse-cloud1.jf.intel.com>
References: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
 <awXrVdQKNToiLtmE@gsse-cloud1.jf.intel.com>
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

On Tue, 2026-11-24 at 11:53 -0800, Matthew Brost wrote:
> On Tue, Nov 24, 2026 at 08:09:54PM +0100, Thomas Hellstr=C3=B6m wrote:
> > The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
> > VRAM. In that case the bo may still carry a ttm_tt that was created
>=20
> I'm wondering if other drivers which use TTM + support VRAM (amdgpu,
> Nouveau) have a similar problem or this really just an issue in Xe.

IIRC there's no other driver that takes this path to deferred memory.
From my understanding, AMD takes the route over TT, actually populating
the ttm_tt first.

/Thomas


>=20
> Either way I think this is safe and correct for any driver.
>=20
> > for its deferred placement, and it is left dangling on a bo whose
> > new
> > resource doesn't use a ttm_tt.
> >=20
> > Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is
> > NULL
> > or its memory type manager doesn't use a ttm_tt.
> >=20
> > ttm_bo_tt_destroy() is internal to TTM and not exported. Rather
> > than
> > exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
> > export that instead.
> >=20
> > Patch and commit message was drafted using an LLM.
> >=20
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: Natalie Vock <nat@pixelcluster.dev>
> > Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
>=20
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>=20
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c | 20 ++++++++++++++++++++
> > =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 15 ++-------------
> > =C2=A02 files changed, 22 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index f9458a4d5a09..7f3459db596a 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -202,6 +202,26 @@ int ttm_bo_move_memcpy(struct
> > ttm_buffer_object *bo,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(ttm_bo_move_memcpy);
> > =C2=A0
> > +/**
> > + * ttm_bo_move_null() - assign memory for a buffer object.
> > + * @bo: The bo to assign the memory to.
> > + * @new_mem: The memory to be assigned, or NULL.
> > + *
> > + * Free the current resource of @bo and assign @new_mem to it. If
> > @new_mem is
> > + * NULL or its memory type manager doesn't use a &struct ttm_tt,
> > the bo's
> > + * &struct ttm_tt, if any, is unpopulated and destroyed.
> > + */
> > +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem)
> > +{
> > +	if (!new_mem || !ttm_manager_type(bo->bdev, new_mem-
> > >mem_type)->use_tt)
> > +		ttm_bo_tt_destroy(bo);
> > +
> > +	ttm_resource_free(bo, &bo->resource);
> > +	ttm_bo_assign_mem(bo, new_mem);
> > +}
> > +EXPORT_SYMBOL(ttm_bo_move_null);
> > +
> > =C2=A0static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
> > =C2=A0{
> > =C2=A0	struct ttm_transfer_obj *fbo;
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 32791c4db2a9..d525e04893ed 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -356,19 +356,8 @@ static inline void ttm_bo_assign_mem(struct
> > ttm_buffer_object *bo,
> > =C2=A0	bo->resource =3D new_mem;
> > =C2=A0}
> > =C2=A0
> > -/**
> > - * ttm_bo_move_null - assign memory for a buffer object.
> > - * @bo: The bo to assign the memory to
> > - * @new_mem: The memory to be assigned.
> > - *
> > - * Assign the memory from new_mem to the memory of the buffer
> > object bo.
> > - */
> > -static inline void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > -				=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem)
> > -{
> > -	ttm_resource_free(bo, &bo->resource);
> > -	ttm_bo_assign_mem(bo, new_mem);
> > -}
> > +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem);
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * ttm_bo_unreserve
> > --=20
> > 2.56.1
> >=20
