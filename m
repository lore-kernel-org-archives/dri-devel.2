Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC557C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2649B10EFCD;
	Wed, 12 Aug 2026 13:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oe9XY/6H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3F910EFCA
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:13:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 243ED42EAF;
 Wed, 12 Aug 2026 13:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB181F000E9;
 Wed, 12 Aug 2026 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540393;
 bh=BRLSjrp0D29ZueRa0L453YQ7x/Ra0L87BBVCFcp9aO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oe9XY/6HWb7t9NSl52Kvr16Xo5fVS+shf41Yt9DmW5tyN1ZaVRarFeffgigFii0tc
 I8yZTVxltJAx6sWmDFho3Qje4XUouZvGaXhou07I6Li4mF6KImnEuUTDGbN7lhFpWB
 qCHLX1q5uy+ipn8mGQ7ROXrhRBZiE5Mq6A/z4asF5fqBJDxdm/OMQHHBCwHJe3He+P
 hvvplPEGLykzV7JFkO4FACLY1TjvM/1bE1MIsQDfUbMCKQLLHx0RDR5Rzjo7bDw1Xc
 G9nQFGgK7MqL+GpgUjTDZtZX0yQ6EnT7niBPQOGPmUBA8KIuEIh3ThWSBN4+gaziSe
 cCxC382YrhnYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and
 Ilitek panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812130429.16850-4-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812130429.16850-4-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:13:12 +0000
Message-Id: <20260812131312.DBB181F000E9@smtp.kernel.org>
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
- [High] Missing `drm_panel_remove()` in the error path of `ili9881c_dsi_pr=
obe()` when `devm_mipi_dsi_attach()` fails, leaving a dangling pointer in t=
he global panel list and causing a Use-After-Free.
--

--- Patch [4]: [PATCH v3 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax =
and Ilitek panels ---
commit 3a10b5f724df17d382396b95194d7b29446eceae
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: Use devm_mipi_dsi_attach in Himax and Ilitek panels

Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers
and drop the corresponding manual detach calls from remove paths.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
> index 3abdd0870e831..ca7037a4242c7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -2597,14 +2597,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_dev=
ice *dsi)
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
>  	dsi->lanes =3D ctx->desc->lanes;
> =20
> -	return mipi_dsi_attach(dsi);
> +	return devm_mipi_dsi_attach(&dsi->dev, dsi);
>  }

[Severity: High]
This is a pre-existing issue, but if devm_mipi_dsi_attach() fails here,
does it leave a dangling pointer in the global panel list?

Since ili9881c_dsi_probe() directly returns the result of the attach attempt
without calling drm_panel_remove() on failure, and the panel context
was allocated with devm_drm_panel_alloc(), the devres cleanup will free
the memory while it remains linked in panel_list.

Could this cause a use-after-free when the list is next traversed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812130429.1685=
0-1-osama.abdelkader@gmail.com?part=3D4
