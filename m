Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E4BC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D85810E118;
	Sun, 28 Jun 2026 14:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ej2UGlNg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCDD10E118
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF1074366F;
 Sun, 28 Jun 2026 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7650A1F000E9;
 Sun, 28 Jun 2026 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782655638;
 bh=fTDyIT8JSBf4jUQC1zS6Ugi96xXKLKQHUro66hLitos=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ej2UGlNgDP4i6KxJREN/6rBqaTEmP+ZTC0MQpJI6D91giNn5voJEus+bZnsk75n3C
 Z8sUHGmmWB3SIFqyiI3QEvhsbgiJJqsr2UwHNeEzfLFFlWh7b50qTI8oT6mjw+fo7o
 gk4awJqXguD42XdDm+sXeY9YjvMt4JO2g0RFqIVViAAvaIpaLwi2ktFZdO2xNqeYlW
 +1+GY7gq4qYt3yYqrQQsTg+3AkCF60OCNCuISUo3maZPa7cZDgUCajK+b2oNx5nWor
 SLqEi5dGQzeEfGCFnvLrxRn4TRZkktat3amvBKiIolVcuS7OhvW1LVi7DSlIRtx1//
 G9Boa4YQDY0hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/hisilicon: fix dangling pointer in
 kirin_drm_crtc_init
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628135700.46645-1-vulab@iscas.ac.cn>
References: <20260628135700.46645-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:07:17 +0000
Message-Id: <20260628140718.7650A1F000E9@smtp.kernel.org>
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
- [High] The patch attempts to fix a dangling pointer (use-after-free) by s=
imply swapping the order of a pointer assignment (`crtc->port =3D port`) an=
d the reference release (`of_node_put(port)`). This fix is completely ineff=
ective. In C, assigning a pointer does not increment the reference count. `=
of_node_put(port)` still drops the reference acquired by `of_get_child_by_n=
ame()`. When `kirin_drm_crtc_init()` returns, the CRTC holds a raw pointer =
to a device node without holding an active reference to it, leaving it exac=
tly as vulnerable as before.
--

commit a7a4845c1da7436e4f1b2446968b4b040228f36f
Author: WenTao Liang <vulab@iscas.ac.cn>

drm/hisilicon: fix dangling pointer in kirin_drm_crtc_init

This patch attempts to fix a dangling pointer by moving the of_node_put()
call after assigning the port to crtc->port.

> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gp=
u/drm/hisilicon/kirin/kirin_drm_drv.c
> index 8a11c2df5b886..2fda894d482e4 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c

[ ... ]

> @@ -53,8 +53,9 @@ static int kirin_drm_crtc_init(struct drm_device *dev, =
struct drm_crtc *crtc,
>  		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
>  		return -EINVAL;
>  	}
> -	of_node_put(port);
> +
>  	crtc->port =3D port;
> +	of_node_put(port);

[Severity: High]
This isn't a bug introduced by this patch, but does this actually fix the
dangling pointer issue?

Since pointer assignment does not increment the reference count, dropping
the reference with of_node_put() here leaves crtc->port pointing to a
device node without holding an active reference to it. If the device node
is subsequently removed (for example, via device tree overlay removal),
couldn't this still lead to a use-after-free when the DRM subsystem later
accesses crtc->port?

To properly resolve the dangling pointer, should the reference be held for
the lifetime of the CRTC and released in the CRTC destruction path instead
of here in kirin_drm_crtc_init()?

> =20
>  	ret =3D drm_crtc_init_with_planes(dev, crtc, plane, NULL,
>  					driver_data->crtc_funcs, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628135700.4664=
5-1-vulab@iscas.ac.cn?part=3D1
