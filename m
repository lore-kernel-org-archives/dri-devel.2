Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A893CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF12310E6CE;
	Tue, 29 Sep 2026 11:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOotmrsr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E8910E6CE
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1156F409EE;
 Tue, 29 Sep 2026 11:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93C1F000FF;
 Tue, 29 Sep 2026 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790680055;
 bh=xhBwNNCpXoQCpM0mTTJfiov/xOzj5LCov6hCtYp8syg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OOotmrsr4GWEjTGzC1JIYx/Fb6oLwJnAwWYmVYusUn9KI24/kde1kWfm3XoqqQZvF
 ebOezHAeqHyg4filgNhP2bHht0h1uluyj8mbdw725CdhLYHuPr/e5rASIzTfXz/vAg
 RWUkOW08MTfamN71QuwR6DvroMWtP4PRliRrWCjM4W/vEGal6iirhh3tuCkB5P3ae8
 kE3aeizeMwSOsuPl2u6zfthoNpd+DKQohGpHmEPDN2imDlxM5ATUkyw9Neot4xPlEn
 /6eNXEOJZw/Xo1fqWA9FmgpIsg1mBnxxXUGmwIbDRh2fOnTti5Vfv+6xNegtpuw0my
 LBuNvznbMIXjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] drm/bridge: dw-mipi-dsi2: stop using deprecated
 devm_drm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-4-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v1-4-ccb7e602daad@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:07:34 +0000
Message-Id: <20260929110734.9B93C1F000FF@smtp.kernel.org>
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
- [Medium] drm/bridge: dw-mipi-dsi2: memory leak of downstream bridge refer=
ence
--

commit 3a105594a4d4f8c22ed3e9167fb40a2696227085
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: dw-mipi-dsi2: stop using deprecated devm_drm_of_get_bridge()

This commit replaces the deprecated devm_drm_of_get_bridge() function with
of_drm_get_bridge_by_endpoint(), which returns a refcounted bridge. It upda=
tes
the code to store the acquired bridge in the next_bridge field of the
drm_bridge structure so that the reference is automatically released when t=
he
parent bridge is destroyed.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu=
/drm/bridge/synopsys/dw-mipi-dsi2.c
> index 7fd2f1e60654f..a008450d83aa3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> @@ -528,12 +527,12 @@ static int dw_mipi_dsi2_host_attach(struct mipi_dsi=
_host *host,
>  	dsi2->format =3D device->format;
>  	dsi2->mode_flags =3D device->mode_flags;
> =20
> -	bridge =3D devm_drm_of_get_bridge(dsi2->dev, dsi2->dev->of_node, 1, 0);
> +	bridge =3D of_drm_get_bridge_by_endpoint(dsi2->dev->of_node, 1, 0);
>  	if (IS_ERR(bridge))
>  		return PTR_ERR(bridge);
> =20
>  	bridge->pre_enable_prev_first =3D true;
> -	dsi2->panel_bridge =3D bridge;
> +	dsi2->bridge.next_bridge =3D bridge;

[Severity: Medium]
Does this assignment potentially leak the bridge reference if the error pat=
h is
taken later in dw_mipi_dsi2_host_attach()?

The DRM core automatically drops the next_bridge reference when the parent
bridge is freed (at driver unbind). However, if pdata->host_ops->attach()
fails later in this function, the error path calls drm_bridge_remove() but
next_bridge is not explicitly cleared or manually put.

If the DSI peripheral later triggers another attach attempt, will a new
reference overwrite next_bridge, permanently leaking the previous one?

> =20
>  	drm_bridge_add(&dsi2->bridge);
> =20

[ ... ]

> @@ -565,8 +564,6 @@ static int dw_mipi_dsi2_host_detach(struct mipi_dsi_h=
ost *host,
> =20
>  	drm_bridge_remove(&dsi2->bridge);
> =20
> -	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
> -
>  	return 0;
>  }

[Severity: Medium]
Does this detach path also leak the downstream bridge reference if the DSI
device is unbound and rebound?

Similar to the error path in dw_mipi_dsi2_host_attach(), detaching removes =
the
bridge from the list but leaves the refcounted pointer in
dsi2->bridge.next_bridge without putting it. On the next attach attempt, a =
new
reference will be acquired and assigned, potentially stranding the previous
reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-drm-fix-of=
_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com?part=3D4
