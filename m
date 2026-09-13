Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BE6C88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E730710E083;
	Sun, 13 Sep 2026 10:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CXXrk3Cu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2D210E829
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0985C60DE6;
 Sun, 13 Sep 2026 10:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B521F000FF;
 Sun, 13 Sep 2026 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789295450;
 bh=h15aeROqzQEXo/13PVanMYzis8JVHg+qHqGltMgHmWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CXXrk3CuDJY1PujwdzkdxrXr5P3udBagfn/ZFT0YsE79Uxelbr6jx+mpaoeVBQFNp
 FQXJVXIPuk9oMtSb7wZqerbcuXXJYdwuxDrYH1p0z4dasvS8nqewYXrmgMEy9n8VZw
 JsAtAy9RBsOlbgN5GcG6qe7OzIu6e2OmYwkMnKH/Jf+Xa6WgkhA2Lq+o4imhhaUS3P
 4KFXoXy9jmDAI7g04+AT7zlXajKYvhqOudcglpopbsrfpypr6s4j9HBMjwNLf5rz5F
 iZBQh/PZTgVETVMmmke4v65eztdzvfjwGWYvDGR82wgoxAIAfNlQes2K1Y6zxpNAKz
 IlANmNrNIbUxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach
 failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913102608.1526916-1-lgs201920130244@gmail.com>
References: <20260913102608.1526916-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:30:50 +0000
Message-Id: <20260913103050.94B521F000FF@smtp.kernel.org>
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
- [Low] Missing semicolon at the end of the return statement for dev_err_pr=
obe, causing a syntax error and build failure.
--

commit 4d6fd7214b6dd880b985f4f7ae888ed25d2fea1a
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/panel: ilitek-ili9881c: fix panel cleanup on attach failure

This commit replaces drm_panel_add() with devm_drm_panel_add() in
ili9881c_dsi_probe() to ensure the panel registration is correctly removed
upon probe failure or driver teardown. It also removes the redundant
drm_panel_remove() call from the remove callback.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index c3d5ab67121d9..1a52f92e2963b 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2594,7 +2594,9 @@ static int ili9881c_dsi_probe(struct mipi_dsi_devic=
e *dsi)
>  	if (ret)
>  		return ret;
> =20
> -	drm_panel_add(&ctx->panel);
> +	ret =3D devm_drm_panel_add(&dsi->dev, &ctx->panel);
> +	if (ret)
> +		return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")

[Severity: Low]
Does this compile successfully? It looks like the return statement using
dev_err_probe() in ili9881c_dsi_probe() is missing a terminating semicolon,
which would cause a syntax error during the build.

>  	dsi->mode_flags =3D ctx->desc->mode_flags;
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913102608.1526=
916-1-lgs201920130244@gmail.com?part=3D1
