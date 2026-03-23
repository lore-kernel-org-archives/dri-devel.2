Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10658EC01A5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5096C10E438;
	Mon, 23 Mar 2026 08:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hcIcTtu3";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9E210E427
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=42wfj5oPDvYYm2P83J07LN41r7Hpdm8uxGaKSkks4V0=; b=hcIcTtu3a187FMmZZd09cjZgZ6
 0RKZ2THUgo9rlSFYblFTPydzpgzu+XFVu3/n87gN3NDjab4YNydSZwU/mD9Yi3hle/JepOSKY/I00
 ksunZLkLlMrZo70P2n1vIvL/L2EtOssAAmhLTdc8MgG9sscBEOABsbK90RqN7uSLplPfZKRrzapf1
 ELxVQgJGwpdwQ0N3xi45eS7ri5cuLJsFsCBq9CoKcWnTNPXI31e6Uapf82WRyILAwUjZqLFRtOEuR
 SZ7CAPMyybyaO9lGfmo2yCQ3WZBJf2MBGwS4MjYK6oOOEfQQMkmydFuoKHbRXaiiGjoX3572cAz8M
 xRxuvxIw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w4avO-0009O3-0d; Mon, 23 Mar 2026 09:46:14 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w4avM-000JBH-1N; Mon, 23 Mar 2026 09:46:12 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?ISO-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 =?ISO-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 0/8] drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR
 and the bridge-connector
Date: Mon, 23 Mar 2026 09:46:10 +0100
Message-ID: <2948177.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27949/Mon Mar 23 07:24:47 2026)
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

Am Freitag, 20. M=C3=A4rz 2026, 11:46:11 CET schrieb Luca Ceresoli:
> This series modernizes the i.mx8mp LCDIF driver to use the
> bridge-connector, which is the current best practice in DRM.
>=20
> =3D=3D Call for testing on i.MX8MP boards (especially those using HDMI)!
>=20
> This series applies changes to how video output devices are probed on
> i.MX8MP, especially those using HDMI. Even though I have put care in not
> breaking anything, there could potentially be pitfalls I haven't realized,
> causing regressions on existing boards.
>=20
> I have thus added in Cc all developers which appeared active on dts files
> for imx8mp boards involving video. I would appreciate testing on as many
> boards as possible, along with a Tested-by tag, or a report about any
> issues encountered.
>=20
> Thanks in advance to all testers!

=46or the whole series:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8MPxL/MB=
a8MPxL

Because this platform falls into type A of patch 7
DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP has been disabled for me.

Best regards,
Alexander

>=20
> =3D=3D Review recommendation
>=20
> I recommend reviewing patches in this order to be understood more
> effectively:
>=20
>  * Cover letter
>  * Patches 1-5 are small preliminary cleanups/improvements
>  * Patch 8 is the goal of this series, but would not work alone
>  * Patch 7 this lets patch 8 work; but in turn it can't work alone
>  * Patch 6 lets patch 7 work
>=20
> =3D=3D Series description
>=20
> This series is not strictly related to DRM bridge hotplug, it is rather a
> preparation step. Introducing hotplug would need two different approaches:
> one for the new way, for drivers using bridge-connector and
> DRM_BRIDGE_ATTACH_NO_CONNECTOR, another for drivers using the "old, legacy
> way" where the last bridge is supposed to instantiate the
> drm_connector. Hotplug is complicated enough in one case, so it makes sen=
se
> to only support the new way.
>=20
> The hardware I'm working on is an i.MX8MP, whose LCDIF driver is still
> using the old way. So this series converts to the new way as a preparation
> step.
>=20
> Patch 8 does the conversion, which is simple. However this would introduce
> a regression on some boards. Here's why:
>=20
> There are 3 instances of the LCDIF in i.MX8MP:
>=20
>  * LCDIF1, driving the DSI output
>  * LCDIF2, driving the LVDS output
>  * LCDIF3, driving the HDMI output
>=20
> The device drivers of peripherals connected to LCDIF1 and LCDIF2 already
> support the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag. So far so good.
>=20
> LCDIF3 is more tricky. The HDMI pipeline is:
>=20
>   LCDIF3 -> fsl,imx8mp-hdmi-pvi -> fsl,imx8mp-hdmi-tx -> HDMI connector
>=20
> The fsl,imx8mp-hdmi-tx (hdmi-tx) component supports both cases (with or
> without DRM_BRIDGE_ATTACH_NO_CONNECTOR), but in the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR case it does not create a drm_connector,
> thus preventing the creation of the pipeline. To make it work a connector
> must be created, and the way to do so is describing the connector in the
> device tree (compatible =3D "hdmi-connector"), so the display-driver will=
 add
> the connector along with a wrapping bridge.
>=20
> Unfortunately not all device trees in mainline have an hdmi-connector
> node. Adding one is easy, but would break existing hardware upgrading to a
> newer kernel without upgrading the device tree blob. This is addressed by
> patch 7 reusing an existing approach to add such a node to the live device
> tree at init time using a device tree overlay for boards which don't have
> one.
>=20
> Finally, patch 7 cannot work alone because of a bad interaction between
> devlink and device tree overlays. Patch 6 solves that.
>=20
> =3D=3D Grand plan
>=20
> This is part of the work to support hotplug of DRM bridges. The grand plan
> was discussed in [0].
>=20
> Here's the work breakdown (=E2=9E=9C marks the current series):
>=20
>  1. =E2=80=A6 add refcounting to DRM bridges struct drm_bridge,
>       based on devm_drm_bridge_alloc()
>     A. =E2=9C=94 add new alloc API and refcounting (v6.16)
>     B. =E2=9C=94 convert all bridge drivers to new API (v6.17)
>     C. =E2=9C=94 kunit tests (v6.17)
>     D. =E2=9C=94 add get/put to drm_bridge_add/remove() + attach/detach()
>          and warn on old allocation pattern (v6.17)
>     E. =E2=80=A6 add get/put on drm_bridge accessors
>        1. =E2=9C=94 drm_bridge_chain_get_first_bridge(), add cleanup acti=
on (v6.18)
>        2. =E2=9C=94 drm_bridge_get_prev_bridge() (v6.18)
>        3. =E2=9C=94 drm_bridge_get_next_bridge() (v6.19)
>        4. =E2=9C=94 drm_for_each_bridge_in_chain() (v6.19)
>        5. =E2=9C=94 drm_bridge_connector_init (v6.19)
>        6. =E2=80=A6 protect encoder bridge chain with a mutex
>        7. =E2=80=A6 of_drm_find_bridge
>           a. =E2=9C=94 add of_drm_get_bridge() (v7.0),
> 	       convert basic direct users (v7.0-v7.1)
> 	  b. =E2=9C=94 convert direct of_drm_get_bridge() users, part 2 (v7.0)
> 	  c. =E2=9C=94 convert direct of_drm_get_bridge() users, part 3 (v7.0)
> 	  d. =E2=9C=94=E2=80=A6 convert direct of_drm_get_bridge() users, part 4
> 	        (some v7.1, some pending)
> 	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
>        8. drm_of_find_panel_or_bridge, *_of_get_bridge
>        9. =E2=9C=94 enforce drm_bridge_add before drm_bridge_attach (v6.1=
9)
>     F. =E2=9C=94 debugfs improvements
>        1. =E2=9C=94 add top-level 'bridges' file (v6.16)
>        2. =E2=9C=94 show refcount and list lingering bridges (v6.19)
>  2. =E2=80=A6 handle gracefully atomic updates during bridge removal
>     A. =E2=9C=94 Add drm_bridge_enter/exit() to protect device resources =
(v7.0)
>     B. =E2=80=A6 protect private_obj removal from list
>     C. =E2=9C=94 Add drm_bridge_clear_and_put() (v7.1)
>  3. =E2=80=A6 DSI host-device driver interaction
>  4. =E2=9C=94 removing the need for the "always-disconnected" connector
>  5. =E2=9E=9C Migrate i.MX LCDIF driver to bridge-connector
>  6.   DRM bridge hotplug
>     A.   Bridge hotplug management in the DRM core
>     B.   Device tree description
>=20
> [0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9=
c3058@bootlin.com/#t
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Luca Ceresoli (8):
>       drm/mxsfb/lcdif: simplify remote pointer management using __free
>       drm/mxsfb/lcdif: don't unnecessarily loop over ports
>       drm/mxsfb/lcdif: use dev_err_probe() consistently in lcdif_attach_b=
ridge
>       drm/bridge: dw-hdmi: document the output_port field
>       drm/bridge: dw-hdmi: warn on unsupported attach combination
>       drm/bridge: dw-hdmi: move next_bridge lookup to attach time
>       drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector when missing usin=
g a DT overlay at boot time
>       drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-=
connector
>=20
>  drivers/gpu/drm/bridge/imx/Kconfig                 | 17 +++++
>  drivers/gpu/drm/bridge/imx/Makefile                |  2 +
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 60 +++++++++++++++
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 38 ++++++++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |  1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 45 ++++-------
>  drivers/gpu/drm/mxsfb/Kconfig                      |  1 +
>  drivers/gpu/drm/mxsfb/lcdif_drv.c                  | 88 +++++++++-------=
=2D-----
>  include/drm/bridge/dw_hdmi.h                       |  5 ++
>  9 files changed, 174 insertions(+), 83 deletions(-)
> ---
> base-commit: 8402cf4fc8f8d5756dc81cf9fda1dccdb3622634
> change-id: 20260306-drm-lcdif-dbanc-83dd948327de
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


