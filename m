Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158A8D39403
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7718710F1AA;
	Thu,  2 Apr 2026 09:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="M/RjTFpE";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCF810F1AA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:27:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 472E7C5997A;
 Thu,  2 Apr 2026 09:28:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 99F855FDEB;
 Thu,  2 Apr 2026 09:27:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A725810450A10; 
 Thu,  2 Apr 2026 11:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775122067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=hNltrT681hiTQbE3LGT048Wx1XJA0ekV7Io5cPmIrZM=;
 b=M/RjTFpEHWGpIz1DiOGq2rb5j81ppWs+giQBMPZIUw11Dbhns1gowQY1/+iF4Vm+ncLO4j
 bsAK/Lezzs5m60qgcuZOCq+LGuY7kEX+wyTACozmVLhWjwZg8Dx2FR4Fz0uUJrJ8dGb5xf
 PnZgLeGwSvVIyeX1kOFqp+RbqWs9yvbK88jEHnweZUGXM6CN9qfXTTebxvt9RbfTjOyVqC
 Ru8JymYRkf97+IhAs+c0hlgBbc+s8gnfZfkJ1fJhbBL8+u3hmAmBfdJZbPF4ivYjh/JVCh
 vYu71Yb6apxbkH+vEgnNgbb8sYAWNSR7Ty/COntGXtEmuh4q+XYcw3s6gx6fIQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 00/11] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
Date: Thu, 02 Apr 2026 11:25:55 +0200
Message-Id: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACM2zmkC/23NTQ7CIBCG4as0rMXQAUt15T2MC8qPnaQFAw3RN
 L27tHGh0eX7JfPMTJKNaBM5VTOJNmPC4EvwXUV0r/zNUjSlCTBoGGcNNXGkgzboqOmU17Tlxhx
 Fy0EaS8rVPVqHj028XEv3mKYQn9uDXK/r2wL2Y+WaMirkUTFRc24lO3chTAP6vQ4jWbUMHwL/I
 0ARtHSg3IE3CsS3sCzLC0Gyn/zyAAAA
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

For who tested v1 or v2 (thanks!): some patches have changed so I had to
drop your Tested-by on them. A new round of test would still be useful.

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
 * Patch 11: the goal of this series, but would not work alone
 * Patch 10: lets patch 11 work; but in turn it can't work alone
 * Patch 8+9: lets patch 10 work; but in turn it can't work alone
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

Patch 11 does the conversion, which is simple. However this would introduce
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
data. Patch 10 does this switch.

However, for that switch to work, the device tree must describe the HDMI
connector (compatible = "hdmi-connector").

Unfortunately not all device trees in mainline have an hdmi-connector
node. Adding one is easy, but would break existing hardware upgrading to a
newer kernel without upgrading the device tree blob. This is addressed by
patch 8+9 reusing an existing approach to add such a node to the live device
tree at init time using a device tree overlay for boards which don't have
one.

Finally, patch 8+9 cannot work alone because of a bad interaction between
devlink and device tree overlays. Patch 7 solves that.

Tested on the Avnet MSC SM2-MB-EP1 board which currently has no
"hdmi-connector" in the upstream device tree.

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
Changes in v3:
- Patch 8: simplified overlay, handle of_overlay_fdt_apply() errors, use
  of_graph_get_endpoint_by_regs() + add warning in separate patch  
- Updated cover and mentioned the hardware used for testing
- Minor fixes to other patches
- Link to v2: https://patch.msgid.link/20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com

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
Luca Ceresoli (11):
      drm/mxsfb/lcdif: simplify remote pointer management using __free
      drm/mxsfb/lcdif: simplify ep pointer management using __free
      drm/mxsfb/lcdif: use dev_err_probe() consistently in lcdif_attach_bridge
      drm/mxsfb/lcdif: move iteration-specific variables declaration inside loop in lcdif_attach_bridge
      drm/bridge: dw-hdmi: document the output_port field
      drm/bridge: dw-hdmi: warn on unsupported attach combination
      drm/bridge: dw-hdmi: move next_bridge lookup to attach time
      drm/bridge: imx8mp-hdmi-tx-connector-fixup: add an hdmi-connector when missing using a DT overlay at boot time
      drm/bridge: imx8mp-hdmi-tx-connector-fixup: show a warning when adding the overlay
      drm/bridge: imx8mp-hdmi-tx: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
      drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector

 drivers/gpu/drm/bridge/imx/Kconfig                 | 18 ++++++
 drivers/gpu/drm/bridge/imx/Makefile                |  2 +
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 75 ++++++++++++++++++++++
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 33 ++++++++++
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 49 ++++++--------
 drivers/gpu/drm/mxsfb/Kconfig                      |  2 +
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  | 69 ++++++++++----------
 include/drm/bridge/dw_hdmi.h                       |  6 ++
 9 files changed, 192 insertions(+), 63 deletions(-)
---
base-commit: 5304ff59fe90c4f89c1ba8fea5e07d4a6673a9bf
change-id: 20260306-drm-lcdif-dbanc-83dd948327de

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

