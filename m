Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD33C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAA410E71D;
	Mon,  6 Jul 2026 03:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Af5BofyF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F9A10E71D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A23E960018;
 Mon,  6 Jul 2026 03:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F6D1F000E9;
 Mon,  6 Jul 2026 03:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306895;
 bh=yV9RfEdGP6Kgyl3/MhwuLyjKZzEiiKyCMErJXlmKVYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Af5BofyFEE+JvMUwSW+/O0YDgaQIpd2uzs73SpL7Z2hutFgG9EFbB0/Zk+0YT7jJo
 Z4HnfS/o9p9l8GfNCIGnWcUkrpzwrjIr8QxeGa3xOuahEVluQKxDD8LMt2InpQsIcc
 l+y+LE2bGexli7qPghDDcQ1y00f+HlowC201JSazxt+gYTseiLJmbUXGaenEqtL/ko
 rSKlP1E+1DCAWowgrJ4xeOYBoKBINSEZ6sopWs9rfAoExkl+mSTZ0sTyWy+2F0OeaA
 MaKSxdqZPgYo52HsY0augH/bu/ze32XtRRBUpE1+fAo/MJUCiITfXAATE15sJq/+1x
 mMbK3b4WRwiUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] ttm: hook up memcg placement flags.
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260706024122.853329-7-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-7-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:01:34 +0000
Message-Id: <20260706030135.17F6D1F000E9@smtp.kernel.org>
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
- [Critical] Direct dereference of `bo->resource` without a NULL check in `=
ttm_bo_setup_export` causes a kernel panic when exporting pipeline-gutted B=
Os.
--

commit dc7f000aeb70e2be50c58ca89d0162684ebb0574
Author: Dave Airlie <airlied@redhat.com>

ttm: hook up memcg placement flags.

This commit adds a placement flag to request memory cgroup accounting for
system memory allocations. It updates various callers of ttm_bo_populate()
to pass this flag by checking the placement flags of the buffer object's
resource.

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
Can this dereference a NULL pointer if the buffer object has been
pipeline-gutted?

Under memory pressure, TTM eviction logic may pipeline-gut the BO via
ttm_bo_pipeline_gutting(), which frees the resource and sets bo->resource
to NULL.

If userspace then invokes the DMA-BUF export ioctl on this gutted BO, the
driver's export callback (like amdgpu_gem_prime_export) can call
ttm_bo_setup_export() without re-validating the BO. This results in an
unconditional dereference of the NULL pointer when evaluating
bo->resource->placement.

Would it be safer to check if bo->resource is valid before checking its
placement flags?

>  	ttm_bo_unreserve(bo);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D6
