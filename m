Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D996AC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE4C10ECAE;
	Tue,  7 Jul 2026 12:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ORyrNEqw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB30F10E4B1;
 Tue,  7 Jul 2026 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783428537; x=1814964537;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=c3xJLGT78382H2wwUUXrHkSRAD2v/5i9yMYobiMW27o=;
 b=ORyrNEqwR+PyCgLnzJM1twMbyGPZPQM4NjvVkCElfhe0VHiU0myQv4yj
 NzDpZE74B7blXwXFLlq7Z2XAKIhqsiYdpG8HhRIwo1Qh4WYQgQnyy1+YL
 U0wj4CT+krUVNyWMUlRlyqQ1j+k///wuOI/O/W2KfNrr9DLG2dzjGE+ya
 XuzmCKtifKWaIGj4BjiAIzdhdopI2tu0cXSyAAZ0XVFT6MsnQ8GjAKWjQ
 eoOuxMOIRs/wIkiXnjj5t1DNFcYIIn6QBoS0YEa8XfQVaZrSV/OVUlTyW
 C0Sh4chLJweUocl+IQMNvCcNGhY8YH8ygsVgDp7I3kC6uTmVp3eWUMUB4 Q==;
X-CSE-ConnectionGUID: J0EFLz0GQ+aB0L4UqdwNmw==
X-CSE-MsgGUID: Q8jydyYYQoSAmPiBx8CGaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84263705"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84263705"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:48:57 -0700
X-CSE-ConnectionGUID: xQhwTzvLQ/eZltsfvJDHDg==
X-CSE-MsgGUID: 6++/c9N0RRSb04ShGpxCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251321073"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:48:52 -0700
Message-ID: <944807b30e00606dc3f4a8ad57c3e8e70ddd2d10.camel@linux.intel.com>
Subject: Re: [PATCH 09/10] drm/ttm: support using drm_exec during eviction v4
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
Date: Tue, 07 Jul 2026 14:48:50 +0200
In-Reply-To: <20260703-ttm_2_drm_exec-v1-9-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-9-43685ac1286b@gmx.de>
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
> Allow specifying a drm_exec object in TTMs operation context which is
> used to lock objects during eviction.
>=20
> This allows to handle deadlocks much more gracefully and with that
> avoid returning -ENOMEM on heavily contended domains.
>=20
> v2: rebased on top of Thomas work
> v3: rebased again
> v4: rebased, fixed locks of already-reserved buffers being dropped
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c | 30 ++++++++++++++++++++++------=
-
> -
> =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A02 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index a53b25e8c2967..96699532817c2 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -38,6 +38,7 @@
> =C2=A0#include <drm/ttm/ttm_tt.h>
> =C2=A0
> =C2=A0#include <drm/drm_cache.h>
> +#include <drm/drm_exec.h>
> =C2=A0
> =C2=A0#include "ttm_bo_internal.h"
> =C2=A0
> @@ -837,6 +838,8 @@ static bool ttm_lru_walk_trylock(struct
> ttm_bo_lru_cursor *curs,
> =C2=A0	struct ttm_operation_ctx *ctx =3D curs->arg->ctx;
> =C2=A0
> =C2=A0	curs->needs_unlock =3D false;
> +	if (ctx->exec)
> +		return false;

The first passes of eviction typically trylocks, and no_wait_gpu also
skips sleeping locks since they can be held why waiting for fences.
Otoh we could check that no_wait_gpu and exec is mutually exclusive.

But I think trylocking should be tried before exec locking to also
avoid costly rollbacks, in line with mutex lock stealing.

> =C2=A0
> =C2=A0	if (dma_resv_trylock(bo->base.resv)) {
> =C2=A0		curs->needs_unlock =3D true;
> @@ -857,7 +860,9 @@ static int ttm_lru_walk_ticketlock(struct
> ttm_bo_lru_cursor *curs,
> =C2=A0	struct ttm_lru_walk_arg *arg =3D curs->arg;
> =C2=A0	int ret;
> =C2=A0
> -	if (arg->ctx->interruptible)
> +	if (arg->ctx->exec)
> +		ret =3D drm_exec_lock_obj_report_dup(arg->ctx->exec,
> &bo->base);
> +	else if (arg->ctx->interruptible)
> =C2=A0		ret =3D dma_resv_lock_interruptible(bo->base.resv,
> arg->ticket);
> =C2=A0	else
> =C2=A0		ret =3D dma_resv_lock(bo->base.resv, arg->ticket);
> @@ -871,7 +876,11 @@ static int ttm_lru_walk_ticketlock(struct
> ttm_bo_lru_cursor *curs,
> =C2=A0		 * trylocking for this walk.
> =C2=A0		 */
> =C2=A0		arg->ticket =3D NULL;
> -	} else if (ret =3D=3D -EDEADLK) {
> +
> +	} else if (arg->ctx->exec && arg->ctx->allow_res_evict &&
> +		=C2=A0=C2=A0 ret =3D=3D -EALREADY) {
> +		ret =3D 0;
> +	} else if (!arg->ctx->exec && ret =3D=3D -EDEADLK) {
> =C2=A0		/* Caller needs to exit the ww transaction. */
> =C2=A0		ret =3D -ENOSPC;
> =C2=A0	}
> @@ -937,12 +946,17 @@ static void ttm_bo_lru_cursor_cleanup_bo(struct
> ttm_bo_lru_cursor *curs)
> =C2=A0{
> =C2=A0	struct ttm_buffer_object *bo =3D curs->bo;
> =C2=A0
> -	if (bo) {
> -		if (curs->needs_unlock)
> +	if (!bo)
> +		return;
> +
> +	if (curs->needs_unlock) {
> +		if (curs->arg->ctx->exec)
> +			drm_exec_unlock_obj(curs->arg->ctx->exec,
> &bo->base);

Unlocking after each locks sort of defeats the purpose of ww locking,
since it can't guarantee forward progress, but I guess will work as an
initial attempt.

Thanks,
Thomas


> +		else
> =C2=A0			dma_resv_unlock(bo->base.resv);
> -		ttm_bo_put(bo);
> -		curs->bo =3D NULL;
> =C2=A0	}
> +	ttm_bo_put(bo);
> +	curs->bo =3D NULL;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1016,8 +1030,8 @@ __ttm_bo_lru_cursor_next(struct
> ttm_bo_lru_cursor *curs)
> =C2=A0		if (ttm_lru_walk_trylock(curs, bo)) {
> =C2=A0			bo_locked =3D true;
> =C2=A0
> -		} else if (!arg->ticket || arg->ctx->no_wait_gpu ||
> -			=C2=A0=C2=A0 arg->trylock_only) {
> +		} else if ((!arg->ticket || arg->ctx->no_wait_gpu ||
> +			=C2=A0=C2=A0=C2=A0 arg->trylock_only) && !arg->ctx->exec) {
> =C2=A0			spin_unlock(lru_lock);
> =C2=A0			ttm_bo_put(bo);
> =C2=A0			spin_lock(lru_lock);
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index a4060e44d23d0..156444b5e85d8 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -187,6 +187,11 @@ struct ttm_operation_ctx {
> =C2=A0	 * @bytes_moved: Statistics on how many bytes have been
> moved.
> =C2=A0	 */
> =C2=A0	uint64_t bytes_moved;
> +	/**
> +	 * @exec: optional drm_exec object to use for locking BOs
> and
> +	 * tracking which are locked.
> +	 */
> +	struct drm_exec *exec;
> =C2=A0};
> =C2=A0
> =C2=A0/**
