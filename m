Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC399C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4648910E257;
	Fri, 10 Jul 2026 22:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UspnoMUv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C09D10E257
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:09:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A01D60051;
 Fri, 10 Jul 2026 22:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA20F1F00A3F;
 Fri, 10 Jul 2026 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721397;
 bh=PbEJbmE+3OpwrcSIRHi/iCSzwFLDR7nTrwOM9ZOs86E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UspnoMUvXEmpLDyFK7L46VszC4Zgey3h0IPIqaAEcC1DviqjsUXe3+xP2S7jftaZe
 zwKFEnR3MYz5bhjHqrSVNnZU+zxq34H0wK9uZnH3B5YlMI3FW2+KCTSskj/GcasNOy
 L0MfWzER9lBDVedIGUANHw372RCIJqAEvxExdq3Zyv5mCJDPfrnSwxOsHmgcfrVhWj
 qobvHXLaWnc5Rvbxmp/zGK03u9AzKxenmQJYJ53PfmNzXnpJ0luPWrBT5bVp97Ufb1
 KI3Eu3K4mXIX3gYdmX4C/agE+vbGKJ2ezCdfQCK1bZXP4J+YCn3myTzkq5FK8o+ogI
 9Yr75efcJalbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/33] drm/ttm: Support defragmentation moves
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-6-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-6-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:09:56 +0000
Message-Id: <20260710220956.CA20F1F00A3F@smtp.kernel.org>
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
- [Critical] A defragmentation move that requires an intermediate bounce bu=
ffer (returns -EMULTIHOP) permanently leaks the original ttm_tt, loses user=
 data, and exposes uninitialized memory.
--

--- Patch [5]: [PATCH v2 05/33] drm/ttm: Support defragmentation moves ---
commit 4cef86e1c4adcce1b49f5be21dce811803bbfbeb
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Support defragmentation moves

Add infrastructure to let a driver re-back an already-resident BO with
fresh pages (e.g. at a more beneficial order) by reusing the normal move
machinery.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba4..d05da4eb1d8a4 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c

[ ... ]

> @@ -125,36 +125,93 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer=
_object *bo,

[ ... ]

> +	if (defrag)
> +		ttm_bo_unmap_virtual(bo);
> +
>  	ret =3D bdev->funcs->move(bo, evict, ctx, mem, hop);
>  	if (ret) {
>  		if (ret =3D=3D -EMULTIHOP)
>  			return ret;

[Severity: Critical]
Does returning here directly skip restoring the original backing?

If bdev->funcs->move() returns -EMULTIHOP during a defragmentation move, we
return immediately instead of going to out_err. This leaves bo->ttm pointing
to the new unpopulated TT, and bo->defrag_old_tt holding the original
populated TT.

When ttm_bo_validate() subsequently handles the multi-hop by calling
ttm_bo_bounce_temp_buffer(), it passes the same ctx where ctx->defrag is
still true.

Will the nested ttm_bo_handle_move_mem() misclassify this bounce as another
defrag move and stash the empty bo->ttm into bo->defrag_old_tt? This appears
to overwrite the original TT, permanently leaking it and resulting in the
loss of user data while exposing uninitialized memory.

>  		goto out_err;
>  	}
> =20
> +	if (bo->defrag_old_tt) {
> +		ttm_tt_unpopulate(bo->bdev, bo->defrag_old_tt);
> +		ttm_tt_destroy(bo->bdev, bo->defrag_old_tt);
> +		bo->defrag_old_tt =3D NULL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D5
