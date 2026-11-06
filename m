Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E4606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGvvK8P6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61E010EA94;
	Fri,  6 Nov 2026 16:35:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5230A10EA94
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1D6541259;
 Fri,  6 Nov 2026 16:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8311F0089F;
 Fri,  6 Nov 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793982922;
 bh=v4OwBa2E0VPB4vyX45/RmPgMtoWKTKRGaNJwMC9mgTM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGvvK8P63KCR6JgAtC+9IrmI7YGG8gt3dICRtSb8MH9IN/1AhfOAR613nUzWQeD6K
 F6IeMDdD5aWNGLOsoC0COb9WXjgs5z88nn4+SXsoKupEaxentGL8rcQm5v0HiVWADa
 A4SaRXtdMowUQblBRGlHfkWnD2S7ZIzNzUqJPJ2F6X1kVuu6HQUis7gfX3Ld+of8WZ
 Fo1gH4up/oSwGLyG7cl33/dg+8FMl6r0KH9Phf5cPKYWupb+HKGEKL2xK4ZSH21HIm
 jdYF0h7MAefeQYOpMVxFAfL9Wn0QO9A/qsn/bTX5wZF+Qyov5AYzqeXyCRuWnFwucy
 w87oJ3iaKZTbQ==
Message-ID: <sashiko-outbox-201829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/panel: remove drmm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-2-c0ea3382b798@bootlin.com>
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
 <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-2-c0ea3382b798@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:35:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/panel: build failure in vc4 driver after removing
  drmm_of_get_bridge()
--

commit 4e516e61e060977ea843a480424ba4b15e3d19c9
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/panel: remove drmm_of_get_bridge()

This commit removes the deprecated drmm_of_get_bridge() helper and its
header declarations.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index c00529bfb706b..12f39ce1b7035 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c

[ ... ]

> -struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
> -				      struct device_node *np,
> -				      u32 port, u32 endpoint)
> -{
> -	struct drm_bridge *bridge;
> -	struct drm_panel *panel;
> -	int ret;
> -
> -	ret =3D drm_of_find_panel_or_bridge(np, port, endpoint,
> -					  &panel, &bridge);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	if (panel) {
> -		bridge =3D drmm_panel_bridge_add(drm, panel);
> -		drm_panel_put(panel);
> -	}
> -
> -	return bridge;
> -}
> -EXPORT_SYMBOL(drmm_of_get_bridge);

[Severity: High]
Does removing drmm_of_get_bridge() break building the vc4 driver?
vc4_dpi_init_bridge() in drivers/gpu/drm/vc4/vc4_dpi.c and vc4_dsi_bind()
in drivers/gpu/drm/vc4/vc4_dsi.c still call
drmm_of_get_bridge(drm, dev->of_node, 0, 0).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-panel_=
bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com?part=3D2
