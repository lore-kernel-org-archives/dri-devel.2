Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B7C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2822810E3B2;
	Fri, 26 Jun 2026 13:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nj4Md8cF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A190D10E3B2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:30:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AAB541290;
 Fri, 26 Jun 2026 13:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE381F000E9;
 Fri, 26 Jun 2026 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782480642;
 bh=627TXZ/RfDMpHMcDEz6LUQrcpKNszf2lRFP4r9g+TAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nj4Md8cFRJq/0ONM9KVR6pVD80oqS8IWzveNj2uQwsdBkHgGlsa9ZW8HKSVDoPvJp
 XgxyQaplreuO1sLUAsEGEE5QSorFg00asF6+47dXoDjj02XD24O4LTLMfe+QAjqBJb
 mZw6/ArSdgVaYxq2vscO+TjoS16I31H6Y6Gj/HR0IwfYUgRg00Jx2zTwOOdIwYYNgq
 8KpVrNoZaPwYwbmXFSXtvqF/ZHlqQrfv2CZCff4Af8znLpQcb6ieLdoz81hMTXX5l7
 cJzHYgotLb1amVKTZOUOO6w1nCYhmikgyu3u0TgZfY+0X5M8fya5QlaQH1NHQSOlnO
 pfda2d0wHC2tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/hisilicon: kirin_drm_crtc_init: premature
 of_node_put leaves   crtc->port as dangling pointer
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626131942.38072-1-vulab@iscas.ac.cn>
References: <20260626131942.38072-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:30:41 +0000
Message-Id: <20260626133042.3DE381F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Ineffective fix and misunderstanding of C pointer lifetime in `k=
irin_drm_crtc_init`.

Pre-existing issues:
- [High] NULL pointer dereference when shared IRQ triggers before CRTC init=
ialization completes.
- [High] Resource leaks and permanent driver breakage due to `devm_*` misus=
e in component `bind`.
--

commit 5e60641f8f98c64d6ba73a1036397dc68df8729a
Author: WenTao Liang <vulab@iscas.ac.cn>
fix: drm/hisilicon: kirin_drm_crtc_init: premature of_node_put leaves crtc-=
>port as dangling pointer

This commit attempts to fix a dangling pointer by moving the of_node_put()
call after the crtc->port assignment in kirin_drm_crtc_init().

> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gp=
u/drm/hisilicon/kirin/kirin_drm_drv.c
> index 8a11c2df5b886..cc453b29b22c3 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -53,8 +53,8 @@ static int kirin_drm_crtc_init(struct drm_device *dev, =
struct drm_crtc *crtc,
>  		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
>  		return -EINVAL;
>  	}
> -	of_node_put(port);
>  	crtc->port =3D port;
> +	of_node_put(port);

[Severity: Medium]
Does moving this of_node_put() actually change the pointer lifetime? Since
assigning crtc->port =3D port only copies the address without incrementing =
the
reference count, it seems the pointer is just as dangling as it was before.

> =20
>  	ret =3D drm_crtc_init_with_planes(dev, crtc, plane, NULL,

[Severity: High]
This is a pre-existing issue, but can ade_irq_handler() trigger a NULL
pointer dereference if a shared interrupt fires early?

In drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c:ade_hw_ctx_alloc(),
the IRQ is registered with IRQF_SHARED before the CRTC is initialized:

	ret =3D devm_request_irq(dev, ctx->irq, ade_irq_handler,
			       IRQF_SHARED, dev->driver->name, ctx);

At this point, crtc->dev is still NULL until drm_crtc_init_with_planes() is
called later. If a shared interrupt fires or is left asserted by the
bootloader, ade_irq_handler() calls drm_crtc_handle_vblank(crtc), which
dereferences crtc->dev.

[Severity: High]
This is also a pre-existing issue, but does using dev-managed allocators
inside a component bind callback cause resource leaks on unbind?

In drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c:ade_hw_ctx_alloc(),
which is called from the component bind path (kirin_drm_bind), resources
are allocated using devm_platform_ioremap_resource() and other devm_* APIs.

When the component is unbound, the master device is not removed, so devm
does not release these resources. Rebinding will execute ade_hw_ctx_alloc()
again, leaking memory, duplicating the IRQ handler, and causing ioremap to
fail with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626131942.3807=
2-1-vulab@iscas.ac.cn?part=3D1
