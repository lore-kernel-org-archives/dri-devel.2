Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AB7C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E422F10E1D9;
	Mon, 21 Sep 2026 15:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nmdg5EV1";
	dkim-atps=neutral
X-Greylist: delayed 356 seconds by postgrey-1.36 at gabe;
 Mon, 21 Sep 2026 15:13:18 UTC
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C4F10E1D9
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:13:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 73771C5CD6D;
 Mon, 21 Sep 2026 15:08:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1B0345FFB2;
 Mon, 21 Sep 2026 15:07:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DF44010328ED0; 
 Mon, 21 Sep 2026 17:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790003232; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=yLzhVHiVJdkWShy8TWt3qOSaTEWWf7WaqT21FRzYsSQ=;
 b=nmdg5EV1yt1xm5Yxezzh80Y1zjtF+KOr6+SpqI+upbB8Ib74L8xu9akhDE3c9vEQlkoAhK
 EJlFnccVDaP5tOu84cPuKg8pGm0bPL3ljrcXXujpzESlovlMBJ0Z0kJbNFfXwAz0ll9sJ4
 Gw2y8RlcLVoh6TzYiOAf27vDiRb+wYPSbnSiu6VVWNZU51/xgdF/D6O09zfzJw8s9AXM9Q
 m4q9hspRgMzmcQYIG+ViT17w2Mc776eP6M4EcAAkdsSsjpcPKVNKb5I5/5aggt12GZuwb1
 /YjKataOXRtcoXOWLlI89tba6z9mbvQelajb8HncVumNdrilK7E5QCu61XTltw==
Message-ID: <2467109c58ebe37f0016d58b24125889df70e3f1.camel@bootlin.com>
Subject: Re: [PATCH v4 0/9] drm/bridge: Kconfig: cleanup DRM_PANEL usage
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda	
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	 <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,  Christopher Vollo
 <chris@renewoutreach.org>, Sean Paul <seanpaul@chromium.org>, Vincent
 Palatin <vpalatin@chromium.org>,  Tony Lindgren <tony@atomide.com>, Michael
 Walle <mwalle@kernel.org>, Vinay Simha BN <simhavcs@gmail.com>,  Maoyi Xie
 <maoyixie.tju@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, Andrey
 Gusakov	 <andrey.gusakov@cogentembedded.com>, Tomi Valkeinen	
 <tomi.valkeinen@ideasonboard.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 sashiko-bot@kernel.org
Date: Mon, 21 Sep 2026 17:06:51 +0200
In-Reply-To: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
References: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
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

Hi Luca,

Le mardi 15 septembre 2026 =C3=A0 18:46 +0200, Luca Ceresoli a =C3=A9crit=
=C2=A0:
> As a cleanup in preparation for making every drm_panel embed a drm_bridge=
,
> fix missing or unnecessary usage of DRM_PANEL and DRM_PANEL_BRIDGE in
> drivers/gpu/drm/bridge/Kconfig.
>=20
> =3D=3D Grand plan
>=20
> This is part of the work to support hotplug of DRM bridges. The grand pla=
n
> was discussed in [0].
>=20
> Here's the work breakdown (=E2=9E=9C marks the current series):
>=20
> =C2=A01. =E2=9E=9C add refcounting to DRM bridges struct drm_bridge,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 based on devm_drm_bridge_alloc()
> =C2=A0=C2=A0=C2=A0 A. =E2=9C=94 add new alloc API and refcounting (v6.16)
> =C2=A0=C2=A0=C2=A0 B. =E2=9C=94 convert all bridge drivers to new API (v6=
.17)
> =C2=A0=C2=A0=C2=A0 C. =E2=9C=94 kunit tests (v6.17)
> =C2=A0=C2=A0=C2=A0 D. =E2=9C=94 add get/put to drm_bridge_add/remove() + =
attach/detach()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and warn on old allocati=
on pattern (v6.17)
> =C2=A0=C2=A0=C2=A0 E. =E2=9E=9C add get/put on drm_bridge accessors
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. =E2=9C=94 drm_bridge_chain_get_fi=
rst_bridge(), add cleanup action (v6.18)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. =E2=9C=94 drm_bridge_get_prev_bri=
dge() (v6.18)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. =E2=9C=94 drm_bridge_get_next_bri=
dge() (v6.19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. =E2=9C=94 drm_for_each_bridge_in_=
chain() (v6.19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5. =E2=9C=94 drm_bridge_connector_in=
it (v6.19)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6. =E2=9C=94 protect encoder bridge =
chain with a mutex (v7.2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7. =E2=9C=94 of_drm_find_bridge
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. =E2=9C=94 add o=
f_drm_get_bridge() (v7.0),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 convert basic direct users (v7.0-v7.1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b. =E2=9C=94 conve=
rt direct of_drm_get_bridge() users, part 2 (v7.0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c. =E2=9C=94 conve=
rt direct of_drm_get_bridge() users, part 3 (v7.0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d. =E2=9C=94 conve=
rt direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e. =E2=9C=94 bridg=
e-only drm_of_find_panel_or_bridge() users (v7.2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8. =E2=9E=9C panel_bridge lifetime
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a. =E2=9E=9C clean=
up DRM_PANEL in bridge drivers
> 	=C2=A0 b. =E2=80=A6 embed a drm_bridge in every drm_panel
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9. =E2=9C=94 enforce drm_bridge_add =
before drm_bridge_attach (v6.19)
> =C2=A0=C2=A0=C2=A0 F. =E2=9C=94 debugfs improvements
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. =E2=9C=94 add top-level 'bridges'=
 file (v6.16)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. =E2=9C=94 show refcount and list =
lingering bridges (v6.19)
> =C2=A02. =E2=9C=94 handle gracefully atomic updates during bridge removal
> =C2=A0=C2=A0=C2=A0 A. =E2=9C=94 Add drm_bridge_enter/exit() to protect de=
vice resources (v7.0)
> =C2=A0=C2=A0=C2=A0 B. =E2=9C=94 Add drm_bridge_clear_and_put() (v7.1)
> =C2=A03. =E2=80=A6 DSI host-device driver interaction
> =C2=A04. =E2=9C=94 removing the need for the "always-disconnected" connec=
tor
> =C2=A05. =E2=9C=94 Migrate i.MX LCDIF driver to bridge-connector (v7.2)
> =C2=A06. =E2=80=A6 DRM bridge hotplug
> =C2=A0=C2=A0=C2=A0 A. =E2=80=A6 Bridge hotplug management in the DRM core
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. =E2=9C=94 bridge-connector: attac=
h encoder to the connector (v7.2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. =E2=80=A6 drm bridge hotplug
> =C2=A0=C2=A0=C2=A0 B.=C2=A0=C2=A0 Device tree description
>=20
> [0]
> https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c305=
8@bootlin.com/#t
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I had a look and everything looks fine to me.

For the series:
Reviewed-by: Paul Cercueil <paul.cercueil@bootlin.com>


> ---
> Changes in v4:
> - Removed 4 patches now upstream
> - Fixed commit message of the tc358767 patch
> - Link to v3:
> https://patch.msgid.link/20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd=
8168b3e@bootlin.com
>=20
> Changes in v3:
> - Fixed a few patches which incorrectly removed 'select DRM_BRIDGE'
> - Added missing 'select DRM_PANEL_BRIDGE' to some patches where
> =C2=A0 devm_drm_of_get_bridge() is used (thanks Doug)
> - Added patch 13 for tc358764
> - Removed boucing address spanda@codeaurora.org=C2=A0from Cc list
> - Link to v2:
> https://patch.msgid.link/20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88=
ba7ffd2@bootlin.com
>=20
> Changes in v2:
> - Added maintainers and recent authors to per-patch Cc list (these are no=
t
> =C2=A0 added automatically by get-maintainers because the patches touch o=
nly the
> =C2=A0 Kconfig file)
> - Added review trailer
> - No changes to commit messages and patch content
> - Link to v1:
> https://patch.msgid.link/20260812-drm-bridge-drm_panel-cleanup-v1-0-0d867=
34e908a@bootlin.com
>=20
> ---
> Luca Ceresoli (9):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: tc358764: don't select unused =
DRM_PANEL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: ti-dlpc3433: don't depend on D=
RM_PANEL, select
> DRM_PANEL_BRIDGE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: nxp-ptn3460: select DRM_PANEL_=
BRIDGE, not DRM_PANEL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: parade-ps8622: select DRM_PANE=
L_BRIDGE, not DRM_PANEL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: tc358775: select DRM_PANEL_BRI=
DGE, not DRM_PANEL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: tc358767: select DRM_PANEL_BRI=
DGE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: tc358768: select DRM_PANEL_BRI=
DGE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: ssd2825: select DRM_PANEL_BRID=
GE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: tc358764: select DRM_PANEL_BRI=
DGE
>=20
> =C2=A0drivers/gpu/drm/bridge/Kconfig | 14 +++++++++-----
> =C2=A01 file changed, 9 insertions(+), 5 deletions(-)
> ---
> base-commit: 2d70e1401dbbfc559b6a5d1ba8275d5282d71c2c
> change-id: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948
>=20
> Best regards,
> --=C2=A0=20
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Cheers,

--=20
Paul Cercueil, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
