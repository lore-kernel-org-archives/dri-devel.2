Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA3C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8745A10E106;
	Tue, 25 Aug 2026 00:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VVYEwd2P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FAB10E106
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:25:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F05740564;
 Tue, 25 Aug 2026 00:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEC1F000E9;
 Tue, 25 Aug 2026 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787617558;
 bh=n8QN1E5T7lzTUs9i5EJhw0uWQsZduG6dz4q0x3H4kEQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VVYEwd2PpR3K+iYpWw/IfbknaUkd6V451e545SyILF7tMx80Nuxcer+4TGFiXhXpG
 R68PuYKxt3mnH1IpQhLDCHe+VnCgJaoc0okt7gRGrJ3jgF+OeLppZenDEorOG+zxFT
 8vmeZ51WnZA4+g68x3+SNICB28FRZs/K2p+oVAX5tK2UILrZ7z+x6lyvqNEDbtb47V
 /PqjI6xJPKHlUOHGollu1tVOrAy7h4Olpt3Wrn5OpZ5qVpvCTArlmiEk8yLjq7rpbf
 J2Ohp1wNd0/vHXthl0DyuT9qvNAdc3dZKVpjhEsqHsMiYxu27TaMk3IcSCpCj5UHZ7
 tQjtZPuM91N6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] drm/nouveau/disp: route GSP-RM display MMIO
 through nvkm_disp_func hooks
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825001408.14219-4-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
 <20260825001408.14219-4-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 00:25:57 +0000
Message-Id: <20260825002558.45AEC1F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference and Use-After-Free on initialization fail=
ure in `r535_disp_new`.
--

--- Patch [3]: [PATCH v3 03/10] drm/nouveau/disp: route GSP-RM display MMIO=
 through nvkm_disp_func hooks ---
commit b67572d820daaaf9db8443eb286700e054288fb6
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks

This patch refactors the GSP-RM display MMIO routing by introducing a
gsp table in nvkm_disp_func. This allows r535_disp_new() to call hooks
specific to each chip generation rather than relying on hardcoded
functions. The changes remove chip-specific register code from
rm/r535/disp.c without altering functionality.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index cd4451e625122..bf97edcdfc959 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
[ ... ]
> @@ -1688,6 +1692,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, stru=
ct nvkm_device *device,
>  	rm->uevent =3D hw->uevent;
>  	rm->sor.cnt =3D r535_sor_cnt;
>  	rm->sor.new =3D r535_sor_new;
> +	rm->gsp =3D hw->gsp;
>  	rm->ramht_size =3D hw->ramht_size;
> =20
>  	rm->root.oclass =3D gpu->disp.class.root;
[ ... ]
>  	ret =3D nvkm_disp_new_(rm, device, type, inst, pdisp);
>  	if (ret)
>  		kfree(rm);
> =20
>  	mutex_init(&(*pdisp)->super.mutex); //XXX

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference and use-after-free here on initialization failure.

If nvkm_disp_new_() fails early due to an allocation failure, it can leave
*pdisp set to NULL. Does this cause mutex_init(&(*pdisp)->super.mutex) to
unconditionally dereference NULL?

Additionally, if nvkm_disp_new_() fails after linking the subdev to the
device, freeing rm with kfree(rm) could leave a dangling disp->func pointer.
During teardown, could the system invoke the destructor via this freed
pointer, resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825001408.1421=
9-1-mohamedahmedegypt2001@gmail.com?part=3D3
