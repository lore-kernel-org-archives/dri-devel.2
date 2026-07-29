Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB45C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AEB10E215;
	Wed, 29 Jul 2026 04:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FPCWxrjX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16DB10E215
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:33:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C26D260A5E;
 Wed, 29 Jul 2026 04:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F061F000E9;
 Wed, 29 Jul 2026 04:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785299602;
 bh=9hYySWuvm4BIPwnYeHJzcWUnvPUrWZsOBZGt7SlGIko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FPCWxrjXpa39hlT2cjZfEzqry4spXafZ52Aky3JhkIqp2/C2WSbb8tk/RAJ3vFKec
 5KKB206rT3mNyf3v8qrVzkQVh3ypBP1k7uPky89sgc9O6un8NTRRrxHxGiXm7cL/xn
 vNJv6Qf+FUwTi0nsJrn2Vsd51t/Tc4e1SLILdNuiJDSuxSP1wZOD32HPQWJ2m42Tej
 zE4qrqPmz+2CDNn/mbnr18153VoMAQioFQ4PHVmW+H9kB6uelsSk3XkMlohe0WV1JU
 d9BhVtQ8JDRs2aOPry4UQdYowOJ2JG4zRim50m9KIclMg0kfWTdECDu3lrYPMcJ6Mk
 HCjw3VAVQYnLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] nouveau/gsp: add logging entries for r570
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729041653.3985549-4-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
 <20260729041653.3985549-4-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 04:33:21 +0000
Message-Id: <20260729043322.46F061F000E9@smtp.kernel.org>
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
- [Medium] Newly added `logmnoc` and `logkrnl` logging buffers are allocate=
d and passed to GSP-RM, but they are not exported to debugfs or retained on=
 failure, making them entirely inaccessible to userspace.
--

--- Patch [3]: [PATCH 3/6] nouveau/gsp: add logging entries for r570 ---
commit bbe0f1142019c1da5450d6ce1f59020ffc413ec2
Author: Dave Airlie <airlied@redhat.com>

nouveau/gsp: add logging entries for r570

r570 adds logmnoc and logkrnl. logkrnl is only used for libos3, so
add a flag to pick libos2 out and not init on that.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index 64011430f4c0a..d9786830153da 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
[ ... ]
> @@ -255,15 +256,27 @@ r570_gsp_libos_init(struct nvkm_gsp *gsp)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D gsp_fill_libos_entry(gsp, &args[3], 0x10000, &gsp->logmnoc, "LO=
GMNOC");
> +	if (ret)
> +		return ret;
> +
> +	idx =3D 4;
> +	if (!gsp->rm->wpr->is_libos2) {
> +		ret =3D gsp_fill_libos_entry(gsp, &args[idx], 0x10000, &gsp->logkrnl, =
"LOGKRNL");
> +		if (ret)
> +			return ret;
> +		idx++;
> +	}
> +
>  	ret =3D r535_gsp_rmargs_init(gsp, false);
>  	if (ret)
>  		return ret;
> =20
> -	args[3].id8  =3D r535_gsp_libos_id8("RMARGS");
> -	args[3].pa   =3D gsp->rmargs.addr;
> -	args[3].size =3D gsp->rmargs.size;
> -	args[3].kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
> -	args[3].loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
> +	args[idx].id8  =3D r535_gsp_libos_id8("RMARGS");
> +	args[idx].pa   =3D gsp->rmargs.addr;
> +	args[idx].size =3D gsp->rmargs.size;
> +	args[idx].kind =3D LIBOS_MEMORY_REGION_CONTIGUOUS;
> +	args[idx].loc  =3D LIBOS_MEMORY_REGION_LOC_SYSMEM;
> =20
>  #ifdef CONFIG_DEBUG_FS
>  	r535_gsp_libos_debugfs_init(gsp);

[Severity: Medium]
Are these new logging buffers missing debugfs integration?

Looking at r535_gsp_libos_debugfs_init(), it doesn't appear to be updated
to expose the newly allocated logmnoc and logkrnl buffers to userspace.

Additionally, will these logs be retained on initialization failure if
r535_gsp_retain_logging() is also not updated to handle them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729041653.3985=
549-1-airlied@gmail.com?part=3D3
