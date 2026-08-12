Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B7CC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2864110E406;
	Wed, 12 Aug 2026 13:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JrBe0b3C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB0910E406
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:16:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 562D460A85;
 Wed, 12 Aug 2026 13:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FC31F000E9;
 Wed, 12 Aug 2026 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540603;
 bh=T860I+2wIDKcAp6xmZvZPpiaPG04nZ079353trEpbLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrBe0b3CCkch8irUKwSNCBT0Efzr6jv7v06WGZEweRHuOkwsQrcRbiT4yLn8/QiS5
 zi7oR4c4rZ1dVhOdLeUTbLFl2wC7m/I6fuLsmeo5P88jrOX8mCWMnZafcZ/zapHW7v
 Y50ouT+HHtANtiffA/EI7qVWpYWQDy27VTGwiHaq29uCYZWPcReyZnu1HWGzWsBARx
 4miehE7TNgXi8G8tI/1SvLi9snreCq/0R51hL2QE1U4yJckiKYhb4OuSNPqDbM+coe
 J7tyx13Ef0i+7dUqDQ04ZmPtdudajrilpg6zMaPZTIwXOnHQFEIIhx8114qtLSkb+O
 xuf8fh+6JCuBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] drm/panel: Use devm_mipi_dsi_attach in Novatek
 and Raydium panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812130429.16850-3-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812130429.16850-3-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:16:42 +0000
Message-Id: <20260812131642.D6FC31F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but there is a Use-A=
fter-Free in the driver unbind path due to an ignored error return value fr=
om devm_mipi_dsi_attach.
--

--- Patch [3]: [PATCH v3 3/6] drm/panel: Use devm_mipi_dsi_attach in Novate=
k and Raydium panels ---
commit 4038e87306192174f8d35deb13351bd8c956f7e3
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: Use devm_mipi_dsi_attach in Novatek and Raydium panels

Use the managed MIPI DSI attach helper in Novatek and Raydium panel
drivers and drop the corresponding manual detach calls from remove paths.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/=
drm/panel/panel-novatek-nt35510.c
> index 3189d89c7ca00..e75b6ac3df5c3 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -1175,7 +1175,7 @@ static int nt35510_probe(struct mipi_dsi_device *ds=
i)
> =20
>  	drm_panel_add(&nt->panel);
> =20
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0)
>  		drm_panel_remove(&nt->panel);

[Severity: High]
This is a pre-existing issue, but if devm_mipi_dsi_attach() fails here,
drm_panel_remove() is called, but the nt35510_probe() function still
returns 0 (success) immediately after this. Because probe succeeds, devres
cleanup isn't triggered at probe time.

[ ... ]

> @@ -1186,8 +1186,6 @@ static void nt35510_remove(struct mipi_dsi_device *=
dsi)
>  {
>  	struct nt35510 *nt =3D mipi_dsi_get_drvdata(dsi);
>  	int ret;
> -
> -	mipi_dsi_detach(dsi);

[Severity: High]
This isn't a bug introduced by this patch, but when the driver is later unb=
ound,
nt35510_remove() calls drm_panel_remove() a second time. This drops the
refcount to 0, freeing the panel memory prematurely.=20

After nt35510_remove() completes, the devres cleanup handlers execute,
including drm_panel_put_void(), which will access the already freed panel
memory resulting in a use-after-free.

Should nt35510_probe() return the error code instead of 0 when
devm_mipi_dsi_attach() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812130429.1685=
0-1-osama.abdelkader@gmail.com?part=3D3
