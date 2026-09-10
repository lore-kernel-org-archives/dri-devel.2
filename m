Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB0AC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AC810F327;
	Thu, 10 Sep 2026 07:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dL8aMwUD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9889010F327
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789024493; x=1820560493;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=k4nyCBxi7fpuVu67lXrSDcu9nkhykGQULtMJku448KU=;
 b=dL8aMwUD3TGSlJN5DJ1bQv36D4Rb/26kxvHS28z5bLIclZ4snib90jl/
 1++PZvRl84jBvA7RY6T8esAXjXtzcYjxAkGxuePX26mNQkTEW3nNQPt77
 2jW8tXj63y/v0ISDjRY/EnPJ+cJmDNJ3a5/skkyN5D2Jst5Aa7y8rLaSo
 EaYZPGo5gI769s5PIYM7T01IYO6fJ5jCCEhrDlHAaHPGETQFj+kn7T+h7
 939REmyy9twPRof+Vz1qTbjcu6JXPGBuiH4ehypI2iSdf3Zq757iXBhD0
 mNNPNqtRKQ9CxSQO30E4igQmxX5gTSzbgG+2oGgJ+bj7byh3CejoP/0uM g==;
X-CSE-ConnectionGUID: gRNxxE3FSTi9xzLrW5Jo6w==
X-CSE-MsgGUID: VMUA0NvjQfu9XG/W1KbI0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89481356"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="89481356"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:14:53 -0700
X-CSE-ConnectionGUID: F0sv97FpTDe5+bnQSepLkA==
X-CSE-MsgGUID: +1GF7q62SVuRahHI+JQv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="267260720"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.193])
 ([10.245.245.193])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:14:50 -0700
Message-ID: <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Vadim Nikitushkin <bub4z0r@gmail.com>, christian.koenig@amd.com, 
 ray.huang@amd.com, matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com, 
 bernardomagri21@gmail.com
Date: Thu, 10 Sep 2026 09:14:47 +0200
In-Reply-To: <20260909205028.13799-1-bub4z0r@gmail.com>
References: <20260909205028.13799-1-bub4z0r@gmail.com>
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

On Wed, 2026-09-09 at 23:50 +0300, Vadim Nikitushkin wrote:
> ttm_tt_swapout() returns the number of pages swapped out on success
> and
> a negative error code on failure; for a populated ttm it never
> returns
> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite
> LRU
> walk on swapout failure") moved the bulk_move bookkeeping in
> ttm_bo_swapout_cb() under "if (!ret)", so the
> ttm_resource_del_bulk_move_unevictable() /
> ttm_resource_move_to_lru_tail()
> pair is now skipped on every successful swapout. The equivalent
> change
> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix
> ttm_bo_shrink()
> infinite LRU walk on backup failure") tests "lret > 0", which is what
> was intended here as well.
>=20
> Before b2ed01e7ad3d the resource was taken off the bulk_move before
> the
> swapout; since then a swapped-out resource stays inside its BO's
> bulk_move range (and on the manager LRU) although it is unevictable.
> When it is later freed or the BO leaves the bulk_move
> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
> ttm_resource_del_bulk_move() skips it because of its
> !ttm_resource_unevictable() guard, so a range endpoint in pos->first
> /
> pos->last is left pointing at freed memory. The next
> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that
> cursor
> is a use-after-free, seen as the resv WARN in
> ttm_lru_bulk_move_add(),
> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> dereference in ttm_resource_manager_next() -- minutes to hours after
> a
> hibernation, or at process exit / reboot following one. Samuel
> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> dangling cursor; the missing removal at swapout time is the reason it
> dangles.
>=20
> Testing the condition for success restores the removal. On an AMD
> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate
> on
> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
> crashed 5 of 18 hibernation cycles; a function profile of one
> hibernation showed 336 ttm_tt_swapout() calls and zero
> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> removal happens for every swapped-out resource and 12 further cycles
> were clean.
>=20
> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
> on swapout failure")
> Cc: stable@vger.kernel.org=C2=A0# v7.1+
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> Link:
> https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D=
_eSL+UJeevXw@mail.gmail.com/
> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>

Nice catch.

This also explains why https://patchwork.freedesktop.org/series/170311/
appeared to fix the issue. But that series actually kept the resource
on the bulk sublist until someone bumped the LRU or removed it.

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index ef56c18..9b85b5f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk,
> struct ttm_buffer_object *bo)
> =C2=A0
> =C2=A0	if (ttm_tt_is_populated(tt)) {
> =C2=A0		ret =3D ttm_tt_swapout(bdev, tt, swapout_walk-
> >gfp_flags);
> -		if (!ret) {
> +		if (ret > 0) {
> =C2=A0			spin_lock(&bdev->lru_lock);
> =C2=A0			ttm_resource_del_bulk_move_unevictable(bo-
> >resource, bo);
> =C2=A0			ttm_resource_move_to_lru_tail(bo->resource);
