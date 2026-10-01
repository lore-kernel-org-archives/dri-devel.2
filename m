Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B6CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCFC10F5C1;
	Thu,  1 Oct 2026 08:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KnWwUC6Z";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F417010F5C2
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:04:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9AB901A109C;
 Thu,  1 Oct 2026 08:04:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6252060341;
 Thu,  1 Oct 2026 08:04:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 13AE21032989B; 
 Thu,  1 Oct 2026 10:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790841876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LkMJWvScoP2McGwOycO3kVpr2pNA3Xtxnmqw1hXAFHU=;
 b=KnWwUC6ZHSn8mpdNupHA/dHpj5qX3sIhg2HSqXsmRildXlcFrAmHjrCEh7zER92HE8xVT0
 T8K6OKFc8QSdC+0CgAcNa4T+SHsGE/olwDhSf0bN+xPda4U88zGr/VkrEt8zIZfFEYlrni
 nVwYJyVIYfRVSBSrWx8z3k81LbgNimJVNUBl447LidVcv3Oio+K8bPwdWGSjg28J2t6EWX
 VO9gEr/J8owPvcdrPYpzlugsm+d4KFkxffsenC21HdwmUflDnvZ2eD+VIGmJRSt/Fqq19f
 sOxp4VOTXiNS8Jk2haRtzWa+jKljofRIuvDOzqfSM9mftQeQE1ibajBF6VdyYQ==
Message-ID: <7db03f6fa24930ce7386bef277124a63a5807fcb.camel@bootlin.com>
Subject: Re: [PATCH v2 2/7] drm: verisilicon: stop using deprecated
 devm_drm_of_get_bridge()
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li	 <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng	
 <zhengxingda@iscas.ac.cn>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni	 <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 	imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Thu, 01 Oct 2026 10:04:25 +0200
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-2-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-2-6da431d8f180@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Lucas,

Le mardi 29 septembre 2026 =C3=A0 15:39 +0200, Luca Ceresoli a =C3=A9crit=
=C2=A0:
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() retur=
ns
> a refcounted bridge, ensure it is put by using bridge.next_bridge.
>=20
> Fixes build failure when CONFIG_OF is disabled.
>=20
> Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.or=
g
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202609291109.OIsGTysr-lkp@intel.com=
/
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202609290408.BOs7sk55-lkp@intel.com=
/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Paul Cercueil <paul.cercueil@bootlin.com>

Cheers,
-Paul

>=20
> ---
>=20
> Changes in v2:
> - fix bridge reference leak on attach error path
> - mention lkp report
> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c | 11 ++++++-----
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.h |=C2=A0 1 -
> =C2=A02 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index dc7c85b07fe3..3a5091c0ac2c 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -29,7 +29,7 @@ static int vs_bridge_attach(struct drm_bridge *bridge,
> =C2=A0{
> =C2=A0	struct vs_bridge *vbridge =3D drm_bridge_to_vs_bridge(bridge);
> =C2=A0
> -	return drm_bridge_attach(encoder, vbridge->next_bridge,
> +	return drm_bridge_attach(encoder, vbridge->base.next_bridge,
> =C2=A0				 bridge, flags);
> =C2=A0}
> =C2=A0
> @@ -303,8 +303,7 @@ struct vs_bridge *vs_bridge_init(struct drm_device
> *drm_dev,
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> -	next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->dev->of_node,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output, intf);
> +	next =3D of_drm_get_bridge_by_endpoint(drm_dev->dev->of_node, output,
> intf);
> =C2=A0	if (IS_ERR(next)) {
> =C2=A0		ret =3D PTR_ERR(next);
> =C2=A0		if (ret !=3D -EPROBE_DEFER)
> @@ -321,12 +320,14 @@ struct vs_bridge *vs_bridge_init(struct drm_device
> *drm_dev,
> =C2=A0
> =C2=A0	bridge =3D devm_drm_bridge_alloc(drm_dev->dev, struct vs_bridge, b=
ase,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bridge_funcs);
> -	if (IS_ERR(bridge))
> +	if (IS_ERR(bridge)) {
> +		drm_bridge_put(next);
> =C2=A0		return ERR_PTR(PTR_ERR(bridge));
> +	}
> =C2=A0
> =C2=A0	bridge->crtc =3D crtc;
> =C2=A0	bridge->intf =3D intf;
> -	bridge->next_bridge =3D next;
> +	bridge->base.next_bridge =3D next;
> =C2=A0
> =C2=A0	if (intf =3D=3D VSDC_OUTPUT_INTERFACE_DPI)
> =C2=A0		enctype =3D DRM_MODE_ENCODER_DPI;
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.h
> b/drivers/gpu/drm/verisilicon/vs_bridge.h
> index 70fee1749699..2b0ed94e4520 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.h
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.h
> @@ -25,7 +25,6 @@ struct vs_bridge {
> =C2=A0	struct drm_connector *conn;
> =C2=A0
> =C2=A0	struct vs_crtc *crtc;
> -	struct drm_bridge *next_bridge;
> =C2=A0	enum vs_bridge_output_interface intf;
> =C2=A0};
> =C2=A0
