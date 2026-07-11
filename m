Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5CEC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A5C10E64B;
	Sat, 11 Jul 2026 03:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Azk5TIXE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACD310E54B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:11:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B14360051;
 Sat, 11 Jul 2026 03:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9211F000E9;
 Sat, 11 Jul 2026 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739462;
 bh=L+dX0JoqmizQ17W7RQILHTkQMqYnxQwmklsvlQD1/LQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Azk5TIXEDAC1eDy0CMzX92M2Fjiq4YYbJPGfiEGdTLwz33k5djzVFWxJY9NzZHrwp
 uQepHIeBHviDD2MS+qZuzvoVCgG43ZVCqnKwapzqYD4qNmK/XAnYZUYOpDxjUYMeTr
 1IsvFdQFkJMMIExtkXeTv0Ot1elJ2Dl35hjPzBxxoJ6+LGBwlYHNVfcg8KitZbHK6B
 NJS/SZwPAuz+D0w8D5BugPcyDJH2DX0DYuALsidUzdn+eb+qJcagsddLC1BlAKHj9l
 bgBwT/dln3INn56osN1koPHt4D5gEg2PouQ2KX60e92goKXK1dHj61/CC+EKql5U4O
 7ZBbGUPxGoH2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/33] drm/xe: Back off beneficial-order reclaim
 under defrag pressure
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-17-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-17-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:11:02 +0000
Message-Id: <20260711031102.8B9211F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The beneficial-order reclaim backoff optimization is inadvertent=
ly skipped when restoring backed-up buffer objects (swap-ins).
--

--- Patch [16]: [PATCH v3 16/33] drm/xe: Back off beneficial-order reclaim =
under defrag pressure ---
commit 2099c6d8da1f6677d9db38b2ffe92ba3eb96f8f0
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Back off beneficial-order reclaim under defrag pressure

Once a meaningful number of BOs are tracked as being backed at a
sub-optimal order, this commit configures the TTM pool to back off from
aggressive reclaim during populate. This allows allocations to make
forward progress, leaving upgrades to beneficial orders for a deferred
defrag pass.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -598,6 +606,12 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm=
_dev, struct ttm_tt *tt,
>  	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
>  		err =3D ttm_tt_restore(ttm_dev, tt, ctx);
>  	} else {
> +		struct xe_device *xe =3D ttm_to_xe_device(ttm_dev);
> +
> +		if (atomic_read(&xe->mem.defrag.count) >=3D
> +		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
> +			ctx->beneficial_reclaim_backoff =3D true;
> +

[Severity: Medium]
Does this unintentionally skip the backoff optimization for swap-ins?

Because the beneficial_reclaim_backoff flag is only set inside the else
branch, any swapped-out buffer object being restored via ttm_tt_restore()
under fragmentation pressure will miss this optimization.

Without the flag, ttm_tt_restore() will continue pushing hard for
beneficial-order pages, potentially causing the exact reclaim and
compaction stalls this commit intended to avoid.

Would it make sense to move the device defrag count check and flag
evaluation above the ttm_tt_is_backed_up() check so both paths benefit
from the optimization?

>  		ttm_tt_clear_backed_up(tt);
>  		err =3D ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D16
