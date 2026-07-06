Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C8F10E89E;
	Mon,  6 Jul 2026 10:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hsnRZzuz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973D610E89E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:32:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 151D161383;
 Mon,  6 Jul 2026 10:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED571F000E9;
 Mon,  6 Jul 2026 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783333967;
 bh=sazCpWn4MKn48/sPuBIS2Y+3NyQZxe8AkCEsU2JeigU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hsnRZzuzCPDZnx937+jxResUvqqcVyG5akOqHnfao2Xw7n4wm0av1luy0BQPlTnJC
 C4oRsiQJbpl6+xamtWDB36eOOXIQSGeuCEiJycZktUk5aLDxVCMJFogzAHOD4X81rN
 efYLNfigLNJy3uFYvSQ72mjT6Vpn4wC5pQkly0sdPNehPWqHqIK4eV7aPoYXMj650h
 fZUmamKFW5F76MufjUxlaUcXa8NDHgqczPxKqfv+FQ7GelsKLCiz9cn5eaN8Xm1K2v
 4du5+ad0IZFemP1MkcUthvwPmyR2BMmwiBxkOrBnimiCF+EHyxpxyIDpIkJjbrPRXg
 xneg5O789KbXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] drm/ttm: switch to
 ttm_bo_lru_for_each_reserved_guarded for swapout
To: "Natalie Vock" <nat@pixelcluster.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-ttm_2_drm_exec-v2-5-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
 <20260706-ttm_2_drm_exec-v2-5-4bf6bfc0d320@pixelcluster.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:32:46 +0000
Message-Id: <20260706103247.9ED571F000E9@smtp.kernel.org>
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
- [Low] Build breakage in DRM TTM KUnit tests due to updated `ttm_bo_swapou=
t` signature and removed export.
--

commit 67fbda553ce1493a6719acbdcf118e37c03311c8
Author: Natalie Vock <nat@pixelcluster.dev>
drm/ttm: switch to ttm_bo_lru_for_each_reserved_guarded for swapout

This commit refactors the TTM BO swapout path to use the guarded LRU foreach
iterator instead of the wrapper walk callback. It simplifies the code and
reduces lines of code by removing the ttm_bo_swapout_walk struct and
ttm_bo_swapout_cb.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 1fb8c53da0362..24c52df169ac8 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> -s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ct=
x,
> -		   struct ttm_resource_manager *man, gfp_t gfp_flags,
> -		   s64 target)
> -{
> -	struct ttm_bo_swapout_walk swapout_walk =3D {
> -		.walk =3D {
> -			.process_bo =3D ttm_bo_swapout_cb,
> -			.arg =3D {
> -				.ctx =3D ctx,
> -				.trylock_only =3D true,
> -			},
> -		},
> -		.gfp_flags =3D gfp_flags,
> -	};
> -
> -	return ttm_lru_walk_for_evict(&swapout_walk.walk, bdev, man, target);
> -}
> -EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_bo_swapout);

[Severity: Low]
Will this break the KUnit tests? Looking at ttm_bo_validate_swapout() in
drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c, it still attempts to call
ttm_bo_swapout() with the old 5-argument signature:

	swapped =3D ttm_bo_swapout(priv->ttm_dev, &ctx_init, man, GFP_KERNEL,
				 MANAGER_SIZE / PAGE_SIZE);

With the removal of EXPORT_SYMBOL_FOR_TESTS_ONLY and the signature change,
this appears to cause a build failure when KUnit tests are enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ttm_2_drm_=
exec-v2-0-4bf6bfc0d320@pixelcluster.dev?part=3D5
