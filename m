Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF895CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F80110EB27;
	Tue, 29 Sep 2026 11:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YOK6NnP4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641FA10EB27
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:00:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FFFF43C45;
 Tue, 29 Sep 2026 11:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADDE1F00893;
 Tue, 29 Sep 2026 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679609;
 bh=+S0+caEP5Gva/ZrMGMescJUdcSTQZQa26qQT9etMrHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YOK6NnP4sqZVgMQAI0vMHZiO9Nwz+0fOwzulWFNvKUu084t4w6r/tPl5NAs5z1rbh
 ZFdnab2+dw5PREU4RCSKbsdvlld0/9r8KyMzGCKTzqjJBA8AS0SxhYMvI4HExk5h/U
 17bpnQi4M19Vvw5PTEGCB+OmKkrUtajW+pc5NNXoH3kGpVR2Z3h4P1hx0NBY+reyqJ
 5PfVgUmKw31T+aCcV6q6JPLh57+8sEe3NK/k0EJU6Y62juKQYJ0fCBpED17178G74F
 42OKNatDQmG+GmdXMjk62q8SXQRGNVOwK7kNJ2/Zfr0immL3ZOVXsggGVdzrsKrwNZ
 Cfglf+x0A9iCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/bridge: dw-mipi-dsi: stop using deprecated
 devm_drm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-3-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v1-3-ccb7e602daad@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:00:08 +0000
Message-Id: <20260929110008.AADDE1F00893@smtp.kernel.org>
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
- [Medium] drm: memory leak in dw_mipi_dsi_host_attach/detach due to missin=
g drm_bridge_put
--

commit 0d4a3bc896ba6f4b2176531a2fbcc45a4c4762cd
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: dw-mipi-dsi: stop using deprecated devm_drm_of_get_bridge()

This commit switches from the deprecated devm_drm_of_get_bridge() to
of_drm_get_bridge_by_endpoint(). It assigns the returned refcounted bridge =
to
dsi->bridge.next_bridge to handle cleanup.

Link: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 5dd475fcaacf8..fad6c3f710324 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c

[ ... ]

> @@ -333,12 +332,12 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_=
host *host,
>  	dsi->format =3D device->format;
>  	dsi->mode_flags =3D device->mode_flags;
> =20
> -	bridge =3D devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node, 1, 0);
> +	bridge =3D of_drm_get_bridge_by_endpoint(dsi->dev->of_node, 1, 0);
>  	if (IS_ERR(bridge))
>  		return PTR_ERR(bridge);
> =20
>  	bridge->pre_enable_prev_first =3D true;
> -	dsi->panel_bridge =3D bridge;
> +	dsi->bridge.next_bridge =3D bridge;

[Severity: Medium]
Does this leak the bridge reference if the peripheral driver is manually
unbound and rebound?

Because of_drm_get_bridge_by_endpoint() returns a refcounted bridge, each
attach/detach cycle fetches a new reference. Overwriting next_bridge here
without releasing the previous reference could lead to a memory leak.

Also, what happens if the attach fails later in this function?

err_remove_bridge:
	drm_bridge_remove(&dsi->bridge);
	return ret;

It looks like the acquired bridge reference is left dangling in next_bridge
without being put on this error path.

> =20
>  	drm_bridge_add(&dsi->bridge);

[ ... ]

> @@ -368,8 +367,6 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_ho=
st *host,
>  			return ret;
>  	}
> =20
> -	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
> -
>  	drm_bridge_remove(&dsi->bridge);
> =20
>  	return 0;

[Severity: Medium]
Does this detach path leave the bridge reference unreleased?

The commit message notes that the bridge is put by using bridge.next_bridge,
but the host bridge (dsi->bridge) is not freed during peripheral detach, it
is only removed from the list.

Is a drm_bridge_put() needed here to balance the get from
of_drm_get_bridge_by_endpoint() in dw_mipi_dsi_host_attach()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-drm-fix-of=
_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com?part=3D3
