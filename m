Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77646C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B4110E05B;
	Thu,  3 Sep 2026 08:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yhuo5k0M";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDFB10E05B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:11:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 573611A1981;
 Thu,  3 Sep 2026 08:11:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20000602B8;
 Thu,  3 Sep 2026 08:11:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D7A9511C79B6F; 
 Thu,  3 Sep 2026 10:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788423094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=eV5ymJWMT/U5V95Od7/UCmBNly2al5Fvog9qbBc19Ho=;
 b=yhuo5k0MERZrD/xyXkcjbX8sxGZklTgI0JPk8ArN0ehfKtL1Ih9z0o/XkMY/7A1w1aUAwq
 K97YDLY1tifYp2UkxBQJ+xFBFhwhEWL5qIhmPlrESuRm9YDpgFjvcWhm7j7ip6xmwF5C2R
 BJTeqh0CmFVo8IqGq9mheg/p0BWnova9aIwO19ThFBvTWV0FLG2epMZsDGK4iC8L7HVgD7
 KPfGNVJzwXY7eEFZt4ftcuYIj9hBIuMOK/hYhezRQyEsSva3EgtZ74TFOzKa2NUIVNIyz3
 f5Ld6TXVmzDsLe6pPTpGgMsWBrN7GUejLU6J3R9mbc05i5AH7RBHphMmHaUHXQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH RFC v2 00/19] drm/panel: embed a drm_bridge into every
 drm_panel
Date: Thu, 03 Sep 2026 10:11:03 +0200
Message-Id: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNSw6CMBCGr0JmbQ1teLoyMfEAbg0LaAcZAy1ps
 ZEQ7m5Bty7/57eAQ0vo4BQtYNGTI6ODEIcIZFfrBzJSQYOIRRYXXDBlB9ZYUiFBj3ZmY62xZzV
 Py0xl2GKdQBiPFlt678d3uF0vUH1N92qeKKftcqt15CZj5x3v+V7+kZJ/JM9ZzHgpVSryXMpCn
 Rtjpp70UZoBqnVdP+sfIVvVAAAA
X-Change-ID: 20260812-drm-bridge-every-panel-a1596d6efea4
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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
discussed [1][2] and in v1.

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

== RFC status

Embedding a drm_bridge does not automatically prevent the creation of the
now-legacy one (panel_bridge). All drivers have to be adapted to not create
a panel_bridge, or there would be two drm_bridges for the same drm_panel.

This is an RFC because not all drivers are converted yet. The goal now is
discussing the core changes, while driver conversion progresses.

When all drivers are converted, the entire panel_bridge (bridge/panel.c)
and related functions such as drm_of_find_panel_or_bridge() can be removed.

== Series outline

 1. move code to modules to prevent dependency loops during the transition

      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to bridge/panel.c
      drm/bridge: panel: move to a new module
      drm/panel: move to a new module
      drm/bridge: panel: rename drm_bridge_is_panel() -> drm_bridge_is_panel_bridge()

 2. The main commit

      drm/panel: embed a drm_bridge into every drm_panel

 3. Update *some* drivers to not create a panel_bridge for the same panel

      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: simplify device_node management using scoped for_each variant
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dsi: remove unused includes
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: remove unused includes
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge

 4. Remove bridge/panel.c, drm_of_find_panel_or_bridge() and related code

      TODO

== Dependencies

This series depends on:

 * "drm/bridge: Kconfig: cleanup DRM_PANEL usage"
   https://lore.kernel.org/r/20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com
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
Changes in v2:
- Totally new approach: embed a drm_bridge, don't create it dynamically
- New approach to module dependencies management: new drm_panel module etc
- Convert more drivers, including a complex, multi-user one (analogix_dp)
- Add Albert and Anusha to Cc list
- Minor improvements
- Link to v1: https://patch.msgid.link/20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com

---
Luca Ceresoli (19):
      drm: of: move drm_of_find_panel_or_bridge() from drm_of.c to bridge/panel.c
      drm/bridge: panel: move to a new module
      drm/panel: move to a new module
      drm/bridge: panel: rename drm_bridge_is_panel() -> drm_bridge_is_panel_bridge()
      drm/panel: embed a drm_bridge into every drm_panel
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: simplify device_node management using scoped for_each variant
      drm/mcde: dsi: remove unused includes
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge
      drm/bridge: tc358768: don't create a panel_bridge
      drm/bridge: ssd2825: don't create a panel_bridge
      drm/omap: dsi: remove unused includes
      drm/omap: dss: don't create a panel_bridge
      drm/tve200: remove unused includes
      drm/tve200: don't create a panel_bridge
      drm/bridge: analogix_dp: don't create a panel_bridge

 drivers/gpu/drm/Makefile                           |   5 +-
 drivers/gpu/drm/bridge/Kconfig                     |  12 +-
 drivers/gpu/drm/bridge/analogix/Kconfig            |   2 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  40 ++--
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  19 +-
 drivers/gpu/drm/bridge/panel.c                     |  74 +++++-
 drivers/gpu/drm/bridge/samsung-dsim.c              |  24 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |  23 +-
 drivers/gpu/drm/bridge/tc358767.c                  |  64 ++---
 drivers/gpu/drm/bridge/tc358768.c                  |  25 +-
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  17 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   2 +-
 drivers/gpu/drm/drm_of.c                           |  63 -----
 drivers/gpu/drm/drm_panel.c                        | 258 +++++++++++++++++++--
 drivers/gpu/drm/exynos/exynos_dp.c                 |  36 +--
 drivers/gpu/drm/fsl-dcu/Kconfig                    |   1 +
 drivers/gpu/drm/imx/dcss/Kconfig                   |   2 +
 drivers/gpu/drm/ingenic/Kconfig                    |   1 +
 drivers/gpu/drm/logicvc/Kconfig                    |   2 +
 drivers/gpu/drm/mcde/Kconfig                       |   2 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  50 +---
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   1 -
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   1 -
 drivers/gpu/drm/omapdrm/dss/output.c               |  42 +---
 drivers/gpu/drm/omapdrm/omap_drv.c                 |   1 -
 drivers/gpu/drm/panel/Kconfig                      |   2 +-
 drivers/gpu/drm/pl111/Kconfig                      |   1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |   1 +
 drivers/gpu/drm/rockchip/Kconfig                   |   4 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   9 -
 drivers/gpu/drm/stm/Kconfig                        |   1 +
 drivers/gpu/drm/sun4i/Kconfig                      |   1 +
 drivers/gpu/drm/tegra/Kconfig                      |   1 +
 drivers/gpu/drm/tidss/Kconfig                      |   2 +
 drivers/gpu/drm/tve200/Kconfig                     |   2 +-
 drivers/gpu/drm/tve200/tve200_display.c            |   1 -
 drivers/gpu/drm/tve200/tve200_drm.h                |   1 -
 drivers/gpu/drm/tve200/tve200_drv.c                |  31 +--
 include/drm/bridge/analogix_dp.h                   |   1 -
 include/drm/drm_bridge.h                           |  20 +-
 include/drm/drm_of.h                               |  12 -
 include/drm/drm_panel.h                            |  37 +--
 42 files changed, 475 insertions(+), 419 deletions(-)
---
base-commit: 0097858c2acde041f2c4c9f5ac90ab251b5bc647
change-id: 20260812-drm-bridge-every-panel-a1596d6efea4

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

