Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F40C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E70E10EC8C;
	Tue,  7 Jul 2026 12:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gvPECdFT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0E610EC85;
 Tue,  7 Jul 2026 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783426329; x=1814962329;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=McIrKgdS+Muimto9Az2SlZrfB3kVNPd1l/1tV4Nb6Bk=;
 b=gvPECdFTlO+Hr/40sEy1Nk+x1brHp7y7NjfW7wUvnmx/15aESIvBg5iN
 rxsCoVIeN/L0GNhti66sR9vZJWbupRGnZAxSt8kYYLkTF2ytE6FIcYpf8
 lidXuoZI7+Bk9GxOwjC3xOiix2qQ4CWiVcjJ8NFtDaOcBKhaJGhPH2CGn
 rKu9HS0zZEezGZr6BEZF7h0tvT63e3J7oHugMC5bdVqI0nANQ2MFd+4o8
 7fDl9N1HOe/0yvcsi6F2wscsz+uR6dsdW3iM3goi9hhp7gHsvt+uIUzgD
 qzWJ95+IHPrqziPfAFtdPio7kmvYQ6mpYU4hg+qnjG4TJP7izTzq5IpB5 Q==;
X-CSE-ConnectionGUID: In0P/uD7QB+1f6khLygOVQ==
X-CSE-MsgGUID: rBr+SHKQTrylIZNoeVZs2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101616776"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="101616776"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:12:08 -0700
X-CSE-ConnectionGUID: lPvdg7gFQVCHhEtILsHVpA==
X-CSE-MsgGUID: 11aq1Fj8S8ae+7CfWlp3EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="249997305"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:12:04 -0700
Message-ID: <3036fc490faf265551a905fff9cfaf0792398529.camel@linux.intel.com>
Subject: Re: [PATCH 04/10] drm/ttm: grab BO reference before locking it
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
Date: Tue, 07 Jul 2026 14:12:02 +0200
In-Reply-To: <20260703-ttm_2_drm_exec-v1-4-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-4-43685ac1286b@gmx.de>
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
> Previously we always grabbed the BO reference after taking the lock,
> but
> that isn't necessary any more.
>=20
> So avoid doing that and cleanup the handling here.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c | 15 +++++++++------
> =C2=A01 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 29f068944a972..a53b25e8c2967 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -1010,14 +1010,17 @@ __ttm_bo_lru_cursor_next(struct
> ttm_bo_lru_cursor *curs)
> =C2=A0			break;
> =C2=A0
> =C2=A0		bo =3D res->bo;
> -		if (ttm_lru_walk_trylock(curs, bo))
> -			bo_locked =3D true;
> -		else if (!arg->ticket || arg->ctx->no_wait_gpu ||
> arg->trylock_only)
> +		if (!ttm_bo_get_unless_zero(bo))
> =C2=A0			continue;
> =C2=A0
> -		if (!ttm_bo_get_unless_zero(bo)) {
> -			if (curs->needs_unlock)
> -				dma_resv_unlock(bo->base.resv);
> +		if (ttm_lru_walk_trylock(curs, bo)) {
> +			bo_locked =3D true;
> +
> +		} else if (!arg->ticket || arg->ctx->no_wait_gpu ||
> +			=C2=A0=C2=A0 arg->trylock_only) {
> +			spin_unlock(lru_lock);
> +			ttm_bo_put(bo);
> +			spin_lock(lru_lock);
> =C2=A0			continue;
> =C2=A0		}
> =C2=A0
