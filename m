Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA83C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A261010EBDD;
	Tue,  7 Jul 2026 11:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NQzwviyj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6317410E4C6;
 Tue,  7 Jul 2026 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783425172; x=1814961172;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=scQCim2uIGkfX0a9VP64B6UKFOAUFt223J/TjraSZmg=;
 b=NQzwviyjSZMv0zhaRtt720/khriIFUStCYcvybyIStxQiPUp+zyIHov8
 Yrz3gO+y92pEE9G1vDruMs0bIuYHZXpjEcNI34ct4LmXuSJZBhgdzRh6A
 1EiL3CgNJPaUz37KQZkoDjg4hLueCefVNkMp9JhpZPiURU7jsEaySM8IF
 Wpri4Ye2/Mjv9XAIloOtEateryjDf0Aj7CFqh7rtoAe1Zau48jufJ+D93
 Ej2Xqg9N3eC+wnN3w6lRLUcOrIl+dCHDTplSxsLKphtRiZOGCu6FaHKdD
 lqQ67dvDarjbPGrrj3JS26qE9lHCVgMIOVwdvBR4mHB+MWZP2rPJ1ESqQ Q==;
X-CSE-ConnectionGUID: Q1+5cvVvTG+kJ7QoyH4FgA==
X-CSE-MsgGUID: 5P7MkFtsTOWCOjtXpmH2KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84093076"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84093076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:52:46 -0700
X-CSE-ConnectionGUID: CujSQrjNSnWL6j8xh9YzhQ==
X-CSE-MsgGUID: EF03b59zRt2Xh3PwRNnI3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="258292634"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 04:52:42 -0700
Message-ID: <8642419f410b3c4b21b905b59a800bd5a78fe875.camel@linux.intel.com>
Subject: Re: [PATCH 08/10] drm/xe: remove workaround for TTM internals
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
Date: Tue, 07 Jul 2026 13:52:39 +0200
In-Reply-To: <20260703-ttm_2_drm_exec-v1-8-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-8-43685ac1286b@gmx.de>
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
> This should no longer be necessary, TTM doesn't lock the BO without a
> reference any more.
>=20
> Only compile tested!
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.c | 32 +++++---------------------------
> =C2=A01 file changed, 5 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 5843f850339c7..34eae56716076 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1642,31 +1642,6 @@ static unsigned long xe_ttm_io_mem_pfn(struct
> ttm_buffer_object *ttm_bo,
> =C2=A0
> =C2=A0static void __xe_bo_vunmap(struct xe_bo *bo);
> =C2=A0
> -/*
> - * TODO: Move this function to TTM so we don't rely on how TTM does
> its
> - * locking, thereby abusing TTM internals.
> - */
> -static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object
> *ttm_bo)
> -{
> -	struct xe_device *xe =3D ttm_to_xe_device(ttm_bo->bdev);
> -	bool locked;
> -
> -	xe_assert(xe, !kref_read(&ttm_bo->base.refcount));
> -
> -	/*
> -	 * We can typically only race with TTM trylocking under the
> -	 * lru_lock, which will immediately be unlocked again since
> -	 * the ttm_bo refcount is zero at this point. So trylocking
> *should*
> -	 * always succeed here, as long as we hold the lru lock.
> -	 */
> -	spin_lock(&ttm_bo->bdev->lru_lock);
> -	locked =3D dma_resv_trylock(&ttm_bo->base._resv);
> -	spin_unlock(&ttm_bo->bdev->lru_lock);

We could just remove the spinlocks, update the comment and keep the
asserts. Also the new code below locks .resv rather than ._resv, which
is incorrect for imported dma-bufs.

Thanks,
Thomas


> -	xe_assert(xe, locked);
> -
> -	return locked;
> -}
> -
> =C2=A0static void xe_ttm_bo_release_notify(struct ttm_buffer_object
> *ttm_bo)
> =C2=A0{
> =C2=A0	struct dma_resv_iter cursor;
> @@ -1680,8 +1655,11 @@ static void xe_ttm_bo_release_notify(struct
> ttm_buffer_object *ttm_bo)
> =C2=A0	bo =3D ttm_to_xe_bo(ttm_bo);
> =C2=A0	xe_assert(xe_bo_device(bo), !(bo->created &&
> kref_read(&ttm_bo->base.refcount)));
> =C2=A0
> -	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
> -		return;
> +	/*
> +	 * This should never fail since there are no other
> references to the BO
> +	 * any more.
> +	 */
> +	WARN_ON(!dma_resv_trylock(ttm_bo->base.resv));



> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Scrub the preempt fences if any. The unbind fence is
> already
