Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B15DC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7973910E20C;
	Wed, 29 Jul 2026 04:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j9kTjOJN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9272C10E20C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:32:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B70D415B5;
 Wed, 29 Jul 2026 04:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240A1F000E9;
 Wed, 29 Jul 2026 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785299565;
 bh=x0hjZNnJUgys1o1AVzk//ZHCv+9Tbd4JF+GcNR7k6ag=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j9kTjOJN/rLTBxMUwLEd3MnT0ud5GH2YTO6RC4cSGoz/7i7B4P5WrUKksViQdRGVM
 AEuPg60//BAzXkhXHsTsqh4xIuDEFPydNBQzYCsGCfd8BVv1WDo4DN/lHyPp6tcU7W
 AGUI00HfApcRlGIiyAiHk501mcpJCHqQjVhohNyPP5NoJenarPbzuYNSFvtUqQjdBg
 ZpO802PjTnS4aAlYHd3pGOG2oAVrZabvFySAa+lU50JsULBR3BmwsapnHW8xxAuopR
 22fMj1mv2t4HVj2mf8C2FYkYVtTAEJpozjjl7ENz5LYRtWXmEMbubKvGKRTI2lQ+jX
 sJtfcoYvkl9Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] nouveau/gsp: make libos init per-gsp version.
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729041653.3985549-3-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
 <20260729041653.3985549-3-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 04:32:44 +0000
Message-Id: <20260729043244.F240A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Medium] DMA buffers for GSP logging (`gsp->libos`) and boot firmware (`g=
sp->boot.fw`) are leaked on the initialization error path.
--

--- Patch [2]: [PATCH 2/6] nouveau/gsp: make libos init per-gsp version. ---
commit 85ebb9d2d6335df98fac564dbbe77909c7d38c2b
Author: Dave Airlie <airlied@redhat.com>

nouveau/gsp: make libos init per-gsp version.
   =20
This makes libos initialization a per-gsp version feature. It adds r570 as a
copy of r535 for now, with enhancements to r570 expected next.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index 996941c668ba9..64011430f4c0a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
[ ... ]
> @@ -205,8 +205,76 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resum=
e)
[ ... ]
> +/**
> + * r570_gsp_libos_init() -- create the libos arguments structure
> + * @gsp: gsp pointer
> + */
> +static int
> +r570_gsp_libos_init(struct nvkm_gsp *gsp)
> +{
> +	LibosMemoryRegionInitArgument *args;
> +	int ret;
> +
> +	ret =3D nvkm_gsp_mem_ctor(gsp, 0x1000, &gsp->libos);

[Severity: Medium]
This is a pre-existing issue, but does this leak the gsp->libos and
gsp->boot.fw DMA buffers on the initialization error path?

If GSP initialization fails after libos_init is called but before postinit
executes (for example, if set_system_info or RPC registry configuration
fails), the initialization falls back to tearing down the subdevice via
r535_gsp_dtor().

While postinit frees these buffers on a successful boot, r535_gsp_dtor()
appears to skip freeing gsp->libos and gsp->boot.fw when cleaning up on
the error path.

> +	if (ret)
> +		return ret;
> +
> +	args =3D gsp->libos.data;
> +
> +	ret =3D gsp_fill_libos_entry(gsp, &args[0], 0x10000, &gsp->loginit, "LO=
GINIT");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729041653.3985=
549-1-airlied@gmail.com?part=3D2
