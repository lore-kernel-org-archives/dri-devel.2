Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A59C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFC310E3A1;
	Wed, 16 Sep 2026 13:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n3aO308I";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13ACF10E3B7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:45:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5C32F1A07A8;
 Wed, 16 Sep 2026 13:45:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20DC660337;
 Wed, 16 Sep 2026 13:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 70B7511C7B031; 
 Wed, 16 Sep 2026 15:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566345; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=q4C1pzG9+EtJ/2hH0YXWQ40f9dRoQswHxQlqElZewcs=;
 b=n3aO308IOwzLiSpBj6Rpkxe9ZNqdqPI0CmCQMKrNSfN9UPSPY5uVwsfDsm/D9PMNLSGDAz
 D3NsmMr0PdC9qhjOn9RXm3tf2sw3OQwvoKGTpxWxbs0JtsMoE5Lg76KnpwBvIj9Wqrd+Vz
 tXwe77zGb9Se2LcKSr36bWDFRtdgAP7SgOUYwZtFaBAT/vqQwTmcliaWroX5T+REJdc8qQ
 J0GMPNron3ITx86jJFd+8gtaLAY/dp9wsxse3bzg1iseCzrGdyC/7fNtanZ+k1RNrezSSo
 T581sGjN2JOLUhCCMjM0zc0YtHluFtfSdpVRRdTnrMNbpbCj31YbMx3WcmzZgw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 00/19] drm/panel: embed a drm_bridge into every
 drm_panel
Date: Wed, 16 Sep 2026 15:45:24 +0200
Message-Id: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQ3WrDMAyFXyX4eh7+Texc7T3GGLasrB7Nz5zEr
 JS++5yEUQbrnQ6SviOdK5kxRZxJW11JwhznOA5FyKeKwMkNH0hjKJoIJmpmuKAh9dSnGEoHM6Y
 LndyAZ+q4tnWosUOnSFmeEnbxewe/vh16Xv0nwrLRtolTnJcxXXbnzLe5XxP1yCRzyii3ELRoG
 gATXvw4Luc4PMPYk80mizvIMvkQJApIOG8QhdLS4F/Q7Tg44ddaAlmOL+55tNV/aZTy/aDDGd2
 wTpRZDBqAM6tMm/dYvJuRFo8+Lm3lwDMNRmiUVpbSKBe8Vo3wnfe8AcOkdNZ25aDbD/C9UqmpA
 QAA
X-Change-ID: 20260812-drm-bridge-every-panel-a1596d6efea4
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
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

This series embeds a drm_bridge into every drm_panel, as previously
discussed [1][2] and in previous iterations.

This will allow bridges and encoders to interact with the next pipeline
component always with the bridge API, not caring whether it is a panel or
another device (e.g. a bridge from a bus to another bus).

Currently a drm_panel does not have a corresponding drm_bridge when it is
created. A panel_bridge is often created afterwards by the component
accessing it (typically the previous bridge or encoder). This creates a
mismatch between the drm_panel and the drm_bridge (part of the
panel_bridge), in terms of lifetime and devm ownership. It also makes
implementing bridge hotplug close to impossible in some cases.

This work leverages the work done by Anusha Srivatsa and Albert Esteve to
implement drm_panel lifetime.

== panel_bridge API impact

This series moves the panel_bridge code inside drm_panel.c and changes it
to be reusable by the panel code. However this implies the old panel_bridge
behaviour (drm_panel_bridge_add() and derivatives create a panel_bridge, to
name one) cannot coexist with the new behaviour (devm_drm_panel_alloc()
allocates an embedded drm_bridge and initializes it).

To handle this, the old panel_bridge API is kept to not break its users,
but now behaves differently:

 * drm_panel_bridge_add() and derivatives don't create a bridge, they
   just drm_bridge_get() and return a pointer to the existing one
 * drm_panel_bridge_remove() and devm_drm_panel_bridge_release() don't
   remove the bridge, they just drm-bridge_put() it
 * The other panel_bridge functions stack on those listed in the previous 2
   bullets, so their behaviour is changed correspondingly

As a result, all drivers using the panel_bridge now behave the new way
without any changes. Converting them to not stop using the panel_bridge is
a goal, but can be done over time. Still this series converts a few
drivers.

== Series outline

 1. move code around in preparation

      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to drm_panel.c
      drm: of: remove now unnecessary forward declarations
      drm/panel: move to a new module
      drm/bridge: panel: move all code to drm_panel.c

 2. The main change

      drm/panel: embed a drm_bridge into every drm_panel

 3. API cleanup

      drm/bridge: remove devm_drm_put_bridge()
      drm/panel: deprecate panel-bridge APIs
      drm/todo: add entry for removing the panel_bridge API

 4. Update some drivers to not create a panel_bridge

      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge

== Dependencies

This series depends on:

 * "drm/bridge: Kconfig: cleanup DRM_PANEL usage"
   https://lore.kernel.org/r/20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com
   Reason: trivial, both touch drivers/gpu/drm/bridge/Kconfig, would
           conflict otherwise

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ✔ protect encoder bridge chain with a mutex (v7.2)
       7. ✔ of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
               convert basic direct users (v7.0-v7.1)
          b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
          c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
          d. ✔ convert direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
          e. ✔ bridge-only drm_of_find_panel_or_bridge() users (v7.2)
       8. ➜ panel_bridge lifetime
          a. … cleanup DRM_PANEL in bridge drivers
	  b. ➜ add a panel_bridge to every panel
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. ✔ handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. ✔ Migrate i.MX LCDIF driver to bridge-connector (v7.2)
 6. … DRM bridge hotplug
    A. … Bridge hotplug management in the DRM core
       1. ✔ bridge-connector: attach encoder to the connector (v7.2)
       2. … drm bridge hotplug
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

[1]  https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya3ydwmd63pl26@5jwxaidpikjw/
[2]  https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f2c9c3058@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- Move the panel_bridge code to drm_panel.c, don't duplicate it, and change
  the panel_bridge API to just wrap the newly embedded drm_bridge
- Remove deprecated devm_drm_put_bridge() and TODO entry
- Deprecate panel_bridge APIA, add TODO entry for its removal
- Link to v2: https://patch.msgid.link/20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com

Changes in v2:
- Totally new approach: embed a drm_bridge, don't create it dynamically
- New approach to module dependencies management: new drm_panel module etc
- Convert more drivers, including a complex, multi-user one (analogix_dp)
- Add Albert and Anusha to Cc list
- Minor improvements
- Link to v1: https://patch.msgid.link/20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com

---
Luca Ceresoli (19):
      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to drm_panel.c
      drm: of: remove now unnecessary forward declarations
      drm/panel: move to a new module
      drm/bridge: panel: move all code to drm_panel.c
      drm/panel: embed a drm_bridge into every drm_panel
      drm/bridge: remove devm_drm_put_bridge()
      drm/panel: deprecate panel-bridge APIs
      drm/todo: add entry for removing the panel_bridge API
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge

 Documentation/gpu/todo.rst                         |  33 +-
 drivers/gpu/drm/Makefile                           |   3 +-
 drivers/gpu/drm/adp/adp-mipi.c                     |   1 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   1 +
 drivers/gpu/drm/bridge/Kconfig                     |  10 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |   1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  40 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |   1 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |   1 +
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  19 +-
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c            |   1 +
 drivers/gpu/drm/bridge/panel.c                     | 563 -----------------
 drivers/gpu/drm/bridge/samsung-dsim.c              |  24 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |  23 +-
 drivers/gpu/drm/bridge/tc358767.c                  |  64 +-
 drivers/gpu/drm/bridge/tc358768.c                  |  25 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |   1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  17 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   1 +
 drivers/gpu/drm/drm_bridge.c                       |  17 -
 drivers/gpu/drm/drm_of.c                           |  63 --
 drivers/gpu/drm/drm_panel.c                        | 664 +++++++++++++++++++--
 drivers/gpu/drm/exynos/exynos_dp.c                 |  36 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                    |   1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   1 +
 drivers/gpu/drm/ingenic/Kconfig                    |   1 +
 drivers/gpu/drm/logicvc/Kconfig                    |   1 +
 drivers/gpu/drm/mcde/Kconfig                       |   2 +-
 drivers/gpu/drm/mcde/mcde_display.c                |   1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  45 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   1 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |   3 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   1 -
 drivers/gpu/drm/omapdrm/dss/output.c               |  42 +-
 drivers/gpu/drm/panel/Kconfig                      |   2 +-
 drivers/gpu/drm/pl111/Kconfig                      |   1 +
 drivers/gpu/drm/rockchip/Kconfig                   |   2 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   9 -
 drivers/gpu/drm/stm/Kconfig                        |   1 +
 drivers/gpu/drm/tegra/rgb.c                        |   1 +
 drivers/gpu/drm/tidss/Kconfig                      |   1 +
 drivers/gpu/drm/tve200/Kconfig                     |   2 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |   1 -
 drivers/gpu/drm/tve200/tve200_drv.c                |  30 +-
 include/drm/bridge/analogix_dp.h                   |   1 -
 include/drm/drm_bridge.h                           |  54 --
 include/drm/drm_of.h                               |  15 +-
 include/drm/drm_panel.h                            |  99 ++-
 48 files changed, 855 insertions(+), 1072 deletions(-)
---
base-commit: acb05c825e393b0584adb5472bfbb17c8033a99f
change-id: 20260812-drm-bridge-every-panel-a1596d6efea4
prerequisite-change-id: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948:v4
prerequisite-patch-id: e15ab172f92263f58d86253708d0ad31d0a876e2
prerequisite-patch-id: 8e8841279db302d98d060c2311781c51673031cd
prerequisite-patch-id: 45c8dac16aad1187d7573c3680117954544b75ff
prerequisite-patch-id: 9afefac08440b7aab2979bb919baf78ba60af1c0
prerequisite-patch-id: 904a81179c02e6a3fe9e85d9a356cf265a4f4d11
prerequisite-patch-id: 665576b9273a19567a410888e2eaf1ac3221ae3e
prerequisite-patch-id: 9578cfffb25341935a89501736a5a59e59c50c56
prerequisite-patch-id: ec32062a627672377ee6621cf73a7a1b99680403
prerequisite-patch-id: d311eba3ac81be3b6af2264442369ff2b8fd5e48

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

