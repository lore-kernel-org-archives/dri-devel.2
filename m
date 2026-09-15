Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D84C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2E610E5F5;
	Tue, 15 Sep 2026 15:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DguDVMlE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8998510E5F5
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:08:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FF0143E36;
 Tue, 15 Sep 2026 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2721F000FF;
 Tue, 15 Sep 2026 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789484906;
 bh=VgwWBhlDo3cgpjLLw/BIT0Xx9YUFDfHDUZy2Jl9Y3g4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DguDVMlEboZTQmR9sXWeg7YnYJqMocQOzkCaeGOrv1/zDQ/B1V1IEGnXQUOyLr5Ix
 ydExtvgQFUQdaZkpEbl7GdEEv2y8Z4QK1u19Tqu2y8zSpltBPNKh7iMd48eMadfQBK
 w+ua/b/yy98msY+mcBijHbFk1BAkFYBhGGYcZZN5pEd3NFkxRYkJhjHUHjOfjSYZpV
 cV7HFDEQE2FMxThjRHH1objqV8NkgjuWqRKcgCLukIeqXT9Ksrblen7lz1EuuaseXl
 NQnOQZRlhufprahzunWVXzaLhYgtwjzf1FB89kgYTaI6JmLkRiOn5reRTH3fk3GZJK
 IL3wi+TRraN8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] drm/panel: simple: Use managed helpers in
 panel-simple
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915145935.60397-5-osama.abdelkader@gmail.com>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
 <20260915145935.60397-5-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:08:25 +0000
Message-Id: <20260915150825.ED2721F000FF@smtp.kernel.org>
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
- [High] drm/panel: UAF/race in panel-simple due to devres teardown inversi=
on
--

commit 16997c0bba9fd7e98551173f3a8332211618f894
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: simple: Use managed helpers in panel-simple

This commit replaces the manual drm_panel_add and drm_panel_remove
calls in panel-simple with devm_drm_panel_add, removing the explicit
drm_panel_remove call from the remove path.

> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index c95964ba25a95..02d21dde57663 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -737,7 +737,9 @@ static struct panel_simple *panel_simple_probe(struct=
 device *dev)
>  		goto disable_pm_runtime;
>  	}
> =20
> -	drm_panel_add(&panel->base);
> +	err =3D devm_drm_panel_add(dev, &panel->base);
> +	if (err)
> +		goto disable_pm_runtime;
> =20
>  	return panel;
> =20

[ ... ]

> @@ -785,7 +787,6 @@ static void panel_simple_remove(struct device *dev)
>  {
>  	struct panel_simple *panel =3D dev_get_drvdata(dev);
> =20
> -	drm_panel_remove(&panel->base);
>  	panel_simple_shutdown(dev);
> =20
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	if (panel->ddc)
>  		put_device(&panel->ddc->dev);

[Severity: High]
Does this devres conversion introduce a teardown sequence inversion that le=
ads
to a use-after-free window?

By switching to devm_drm_panel_add in panel_simple_probe, the panel's
removal from the global DRM panel list is deferred until after the
panel_simple_remove callback completes and devres cleanup runs.

However, panel_simple_remove manually shuts down the panel, disables
PM runtime, and drops the DDC adapter reference (via put_device) while the
panel is still registered and discoverable.

If a concurrent display driver probes during this window, can it find the
panel via of_drm_find_panel and call drm_panel_get_modes? This would
dereference the already-released panel->ddc adapter and call PM runtime
functions on a disabled device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915145935.6039=
7-1-osama.abdelkader@gmail.com?part=3D4
