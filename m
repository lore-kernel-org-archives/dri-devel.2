Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9DAC44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BEA410EBAA;
	Tue,  7 Jul 2026 12:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G6PBZFgP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BC710E4BD;
 Tue,  7 Jul 2026 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783427079; x=1814963079;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=H+e3am5bkmWAqDrpInK+XxfwX0696SVIY/2yyZwcuLM=;
 b=G6PBZFgPN7pYLMHsD2vLpGvBHeFhM41mbgbvqwKDFEL7PWQy2WEhddRo
 1vd+pL1pz+txcmOdB1qROfimmWVbJEvm08i3JVwrOplTqckOR59F4zWOI
 c5nalecSYtioMLzAy0VvXJWAX5Xq0qU5sUBbad3phV+VcnuPOeX7sgS9X
 tr9OIFFf2396fb5rGBIng6ghNO60bjlwW83XUCW8kuKRvcgBOTQKCQDIB
 +Ifk60AnITUGU9hCE4e8/j6WkBVGn6nFSKSq/dekTJ++UAewu1geurzzG
 mg5ljeh5qQPLPuJ51QmSrcGfpBaggjhdPr5LILiEXNSbEZxw4KfbjhZWz A==;
X-CSE-ConnectionGUID: UuYpJLrBQzaAjuD+pyB94w==
X-CSE-MsgGUID: qmQKhxbATDmf/6ssG5m1IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101617694"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="101617694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:24:39 -0700
X-CSE-ConnectionGUID: S3/zQBKCTAmUH7YB7P3t/Q==
X-CSE-MsgGUID: Fz5OH36eQy2vJvOkNPFyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="249998997"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:24:35 -0700
Message-ID: <80900aaceb79fc445c19016f08df8dedf3735aa2.camel@linux.intel.com>
Subject: Re: [PATCH 06/10] drm/ttm: move zombie handling into ttm_bo_evict
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig	
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld	
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, Alex
 Deucher	 <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Tue, 07 Jul 2026 14:24:32 +0200
In-Reply-To: <20260703-ttm_2_drm_exec-v1-6-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-6-43685ac1286b@gmx.de>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Fri, 2026-07-03 at 18:31 +0200, Natalie Vock wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> Both callers do the same thing, so we can trivially unify that.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Although might need a different definition of ttm_bo_is_zombie if we
keep the ttm refcount for now.

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++---------------
> =C2=A01 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index 24c52df169ac8..54f01611ec823 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -359,6 +359,13 @@ static int ttm_bo_evict(struct ttm_buffer_object
> *bo,
> =C2=A0	struct ttm_place hop;
> =C2=A0	int ret =3D 0;
> =C2=A0
> +	if (ttm_bo_is_zombie(bo)) {
> +		ret =3D ttm_bo_wait_ctx(bo, ctx);
> +		if (!ret)
> +			ttm_bo_cleanup_memtype_use(bo);
> +		return ret;
> +	}
> +
> =C2=A0	memset(&hop, 0, sizeof(hop));
> =C2=A0
> =C2=A0	dma_resv_assert_held(bo->base.resv);
> @@ -466,13 +473,7 @@ int ttm_bo_evict_first(struct ttm_device *bdev,
> struct ttm_resource_manager *man
> =C2=A0	if (!bo->resource || bo->resource->mem_type !=3D mem_type)
> =C2=A0		goto out_bo_moved;
> =C2=A0
> -	if (ttm_bo_is_zombie(bo)) {
> -		ret =3D ttm_bo_wait_ctx(bo, ctx);
> -		if (!ret)
> -			ttm_bo_cleanup_memtype_use(bo);
> -	} else {
> -		ret =3D ttm_bo_evict(bo, ctx);
> -	}
> +	ret =3D ttm_bo_evict(bo, ctx);
> =C2=A0out_bo_moved:
> =C2=A0	dma_resv_unlock(bo->base.resv);
> =C2=A0out_no_lock:
> @@ -520,14 +521,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk
> *walk, struct ttm_buffer_object *
> =C2=A0	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo,
> evict_walk->place))
> =C2=A0		return 0;
> =C2=A0
> -	if (ttm_bo_is_zombie(bo)) {
> -		lret =3D ttm_bo_wait_ctx(bo, walk->arg.ctx);
> -		if (!lret)
> -			ttm_bo_cleanup_memtype_use(bo);
> -	} else {
> -		lret =3D ttm_bo_evict(bo, walk->arg.ctx);
> -	}
> -
> +	lret =3D ttm_bo_evict(bo, walk->arg.ctx);
> =C2=A0	if (lret)
> =C2=A0		goto out;
> =C2=A0
