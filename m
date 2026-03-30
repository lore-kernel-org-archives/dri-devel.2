Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE4F1061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCE410E7A0;
	Mon, 30 Mar 2026 19:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YS9DiUgT";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F3510E7A0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:26:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AABFA4E4286D;
 Mon, 30 Mar 2026 19:26:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C1B45FFA8;
 Mon, 30 Mar 2026 19:26:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7617A10450C85; 
 Mon, 30 Mar 2026 21:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774898790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=CxC6W+lWciuGPHof3yM5J3AM+C2kzWOd5iyEtmbwMWM=;
 b=YS9DiUgTeHtKqFfIo1Bwn325arnUo0lYeHfDJFgQKBTxXppiEbhP5AqgQbH0ee60AA3pxH
 nZEqZNHtJ9NiUIRLnlpb9IcHlpOoY6Q2SulfQErCAPQR5vzNZo4LcJuAw0Oe0bxSQepO1V
 bCfPgMS8d5PpbUYcPwN+0AEyNvFHh21A+DCAXuIoSLSw0pan1DuR/brBiYutkgg+GifWTJ
 wSlVHdX+iiSRxS9ZnS6UBvnLmytrcVAMNV9rixiGRemVEc/6Vb0FTDJV+RQVPOXb10TOmQ
 G3+NlaZynIcid5CYboh5FGxnw0Pw5XB3FSnkG9pTiRgzIYwsCcSA8XuwLqOeAw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 00/10] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
Date: Mon, 30 Mar 2026 21:25:41 +0200
Message-Id: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADbOymkC/2WNywqDMBBFf0Vm3SkxER9d9T+KC82MdUATSURax
 H9vKt11eQ7cc3eIHIQj3LIdAm8SxbsE+pKBHTv3ZBRKDFrpUhlVIoUZJ0syIPWds1gboqaoja6
 IIa2WwIO8zuKjTTxKXH14nwdb/rW/llZ/rS1HhUXVdKrIjeFK3Xvv10nc1foZ2uM4Ph6vkPuwA
 AAA
X-Change-ID: 20260306-drm-lcdif-dbanc-83dd948327de
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
 Saravana Kannan <saravanak@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, 
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>, 
 Richard Hu <richard.hu@technexion.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.1
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

This series modernizes the i.mx8mp LCDIF driver to use the
bridge-connector, which is the current best practice in DRM.

== Call for testing on i.MX8MP boards (especially those using HDMI)!

For who tested v1 (thanks!): some patches have changed so I had to drop
your Tested-by on them. A new round of test would still be useful.

This series applies changes to how video output devices are probed on
i.MX8MP, especially those using HDMI. Even though I have put care in not
breaking anything, there could potentially be pitfalls I haven't realized,
causing regressions on existing boards.

I have thus added in Cc all developers which appeared active on dts files
for imx8mp boards involving video. I would appreciate testing on as many
boards as possible, along with a Tested-by tag, or a report about any
issues encountered.

Thanks in advance to all testers!

== Review recommendation

I recommend reviewing patches in this order to be understood more
effectively:

 * Cover letter
 * Patches 1-6: small preliminary cleanups (can be applied independently)
 * Patch 10: the goal of this series, but would not work alone
 * Patch 9: lets patch 10 work; but in turn it can't work alone
 * Patch 8: lets patch 9 work; but in turn it can't work alone
 * Patch 7: lets patch 8 work

== Series description

This series is not strictly related to DRM bridge hotplug, it is rather a
preparation step. Introducing hotplug would need two different approaches:
one for the new way, for drivers using bridge-connector and
DRM_BRIDGE_ATTACH_NO_CONNECTOR, another for drivers using the "old, legacy
way" where the last bridge is supposed to instantiate the
drm_connector. Hotplug is complicated enough in one case, so it makes sense
to only support the new way.

The hardware I'm working on is an i.MX8MP, whose LCDIF driver is still
using the old way. So this series converts to the new way as a preparation
step.

Patch 10 does the conversion, which is simple. However this would introduce
a regression on some boards. Here's why:

There are 3 instances of the LCDIF in i.MX8MP:

 * LCDIF1, driving the DSI output
 * LCDIF2, driving the LVDS output
 * LCDIF3, driving the HDMI output

The device drivers of peripherals connected to LCDIF1 and LCDIF2 already
support the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag. So far so good.

LCDIF3 is more tricky. The HDMI pipeline is:

  LCDIF3 -> fsl,imx8mp-hdmi-pvi -> fsl,imx8mp-hdmi-tx -> HDMI connector

The fsl,imx8mp-hdmi-tx (hdmi-tx) does not support
DRM_BRIDGE_ATTACH_NO_CONNECTOR, but it is based on the dw-hdmi component
which supports it by simply changing a setting in the driver platform
data. Patch 9 does this switch.

However, for that switch to work, the device tree must describe the HDMI
connector (compatible = "hdmi-connector").

Unfortunately not all device trees in mainline have an hdmi-connector
node. Adding one is easy, but would break existing hardware upgrading to a
newer kernel without upgrading the device tree blob. This is addressed by
patch 8 reusing an existing approach to add such a node to the live device
tree at init time using a device tree overlay for boards which don't have
one.

Finally, patch 8 cannot work alone because of a bad interaction between
devlink and device tree overlays. Patch 7 solves that.

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. … add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. … protect encoder bridge chain with a mutex
       7. … of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
	       convert basic direct users (v7.0-v7.1)
	  b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
	  c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
	  d. ✔… convert direct of_drm_get_bridge() users, part 4
	        (some v7.1, some pending)
	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. … protect private_obj removal from list
    C. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. ➜ Migrate i.MX LCDIF driver to bridge-connector
 6.   DRM bridge hotplug
    A.   Bridge hotplug management in the DRM core
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Dropped patch removing the loop in lcdif_attach_bridge, adapted following
  patches as needed, added patch to use __free on the ep pointer
- Added new cleanup patch (patch 6)
- Build the fixup module unconditionally
- patch 7: fix returned error codes
- patch 1: fix cleanup action
- Various minor improvements based on reviews, see per-patch changelog
- Removed bouncing recipients from Cc
- Link to v1: https://lore.kernel.org/r/20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com

---
Luca Ceresoli (10):
      drm/mxsfb/lcdif: simplify remote pointer management using __free
      drm/mxsfb/lcdif: simplify ep pointer management using __free
      drm/mxsfb/lcdif: use dev_err_probe() consistently in lcdif_attach_bridge
      drm/mxsfb/lcdif: lcdif_attach_bridge: move iteration-specific variables declaration inside loop
      drm/bridge: dw-hdmi: document the output_port field
      drm/bridge: dw-hdmi: warn on unsupported attach combination
      drm/bridge: dw-hdmi: move next_bridge lookup to attach time
      drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector when missing using a DT overlay at boot time
      drm/bridge: imx8mp-hdmi-tx: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
      drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector

 drivers/gpu/drm/bridge/imx/Kconfig                 | 18 ++++++
 drivers/gpu/drm/bridge/imx/Makefile                |  2 +
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 53 +++++++++++++++++
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 56 ++++++++++++++++++
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 49 +++++++--------
 drivers/gpu/drm/mxsfb/Kconfig                      |  2 +
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  | 69 +++++++++++-----------
 include/drm/bridge/dw_hdmi.h                       |  6 ++
 9 files changed, 193 insertions(+), 63 deletions(-)
---
base-commit: cb6fd48ab016a4b2245d805a5b766eea590e32dd
change-id: 20260306-drm-lcdif-dbanc-83dd948327de

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

