Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D0CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93E810E74B;
	Mon,  6 Jul 2026 05:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bd3VTIwL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D17110E74B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:36:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F27CD43C4D;
 Mon,  6 Jul 2026 05:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CE1F000E9;
 Mon,  6 Jul 2026 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316218;
 bh=Y3AsYFth2geI100MZsIMDgvfE27ElqWmklWE1orXhD0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bd3VTIwLtJVL2/O9gX1pPZjpLf4RHEDKsU3ZF+mEXT/dcqw03tRayY/07rhl40OS6
 qJKKgsulyuK8gdcWq6PJtX9cBrJAyZLPtUryGOBTQxD2pUSgyQ3WoREF40Kdc5Wv4b
 tkjjjti34nsjdJcei5mde1UYHdNcsuA83Nz+xSOLdKzzDF7A64viD3kWUxDL6rga4P
 dGKsq4V30Ubs37H4qr2be/eshvyX9hu+fAwqM5Lr/YqVypU/w173pkByC5dS3J78GM
 rzPlGf5wC1knz/Hfffzd0hw+PWRlpvEhSAaCQMVp2xfl/o1w5+7NdrbZMquRCxYkRJ
 C0olGsNPHpJJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] ttm: hook up memcg placement flags.
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706052330.1110909-7-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-7-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:36:58 +0000
Message-Id: <20260706053658.930CE1F000E9@smtp.kernel.org>
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
- [Critical] Dereferencing `bo->resource` in `ttm_bo_setup_export()` withou=
t checking for NULL causes a kernel panic if the buffer object has been gut=
ted.
--

commit 55aef0c5658ae86fbf245de25768c668ff9edb05
Author: Dave Airlie <airlied@redhat.com>

ttm: hook up memcg placement flags.

This commit adds a placement flag to request that a buffer object with
this flag is accounted for memcg if it's a system memory allocation.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 8e38c6c5c82ef..54ee9d4e7a139 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -1296,7 +1296,7 @@ int ttm_bo_setup_export(struct ttm_buffer_object *b=
o,
>  	if (ret !=3D 0)
>  		return ret;
> =20
> -	ret =3D ttm_bo_populate(bo, false, ctx);
> +	ret =3D ttm_bo_populate(bo, bo->resource->placement & TTM_PL_FLAG_MEMCG=
, ctx);

[Severity: Critical]
Does this code unconditionally dereference bo->resource?

If a buffer object has been gutted (evicted without a fallback placement),
bo->resource will be NULL.

Could a user-space application trigger a kernel panic by exporting such a
gutted buffer via the DRM_IOCTL_PRIME_HANDLE_TO_FD IOCTL, which ultimately
calls ttm_bo_setup_export() on the DMABUF export path?

>  	ttm_bo_unreserve(bo);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D6
