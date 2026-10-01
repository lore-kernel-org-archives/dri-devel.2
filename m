Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A48CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBA610E043;
	Thu,  1 Oct 2026 12:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YeAjWJTt";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139B010E043
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 12:42:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 06BFB1A26F5;
 Thu,  1 Oct 2026 12:42:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C61B960341;
 Thu,  1 Oct 2026 12:42:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E213103280FE; 
 Thu,  1 Oct 2026 14:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790858559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=kFketbQjFOXUjzZoyDe0MakWl3/d+LeuaEIKcQrTGks=;
 b=YeAjWJTtzK0mgeoheHoQE4I1w8iqNuG7ku5pdUyQjq+lONZ42TVvAtPZEHvQoPaVRSVHjQ
 B2lEpNs2kRjn9374NpbFWVwAmRCbm4sMysU8UJVB6Uu9YDPDQ3K47eqKrTEbmhNXOD7WeX
 H56ubf67yPO/tcHPAOn0k12PvRa3UvbLVzem2xuhDhJkeLj6nbxAaBtdFUIoXVeIG7fnFz
 ayADvRCCQ1nHfmgi2WxYG0oENac3B40kCjHCAR+/KnLrNYjQ6wO3KbUgUwlWEnclM8zMir
 9+yGJKcNIuQnOQOQQA2XyArSuQKVWz7a42j83d7uRZ30QwZdIA5eUMjQ3ANJ0Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH RFC v2 00/24] drm bridge hotplug
Date: Thu, 01 Oct 2026 14:42:22 +0200
Message-Id: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBBFf4XM2hoolKgrExM/wK1hQekAY4BiW
 4iG8O+Wx9LlnTlzz0xg0RBauAQTGBzJku584IcAijrvKmSkfAYe8jQUkWDKtEwaUn5Ta9c3Q8W
 SlKdCxTkvTwL8YW+wpM9a+oTH/QbZNrSDfGHhlrodM/gevNJt7ILVZJ023/WfMVobdvX5n3qMW
 MgSgVwqGatSJleptWuoOxa6hWye5x/+A2x14gAAAA==
X-Change-ID: 20260515-drm-bridge-hotplug-46265d3a2f85
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

Hello,

this series adds support for Linux-based devices with a DRM pipeline whose
final components, including one or more bridges, can be hot-plugged and
hot-unplugged

For more about the use case see the v1 cover letter:
https://lore.kernel.org/lkml/20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com/

For reviewers with limited time for review
==========================================

These are the patches with the core changes and likely needing review and
discussion (most relevant first):

 * 23: the new drm_hotplug_helper (the main patch)
 * 24: an example usage
 * 5-6: the main changes to the bridge-connector
 * 17-22: the new get_next_bridge bridge func

The following can be skipped at this iteration, changes have been requested
in the v1 discussion but not yet implemented, and these patches are not
crucial:

 * 10-12: still needs rewording
 * 13-16: need docs, still todo

Design
======

The drm_bridge_connector is nowadays the recommended way to implement DRM
connectors when a chain of bridges is used.

This series proposes a small helper (drm_hotplug_helper) which drivers can
use to make their encoder able to:

 * receive hotplug-relevant events
 * add a drm_bridge_connector when a new bridge is added making the
   pipeline complete in the hardware
 * remove the drm_bridge_connector when a bridge is removed
 
Series layout
=============

 A. Add a dynamic variant of drmm_connector_hdmi_init()
    (needed for the bridge-connector to allocate the connector dynamically)

      1 drm/connector: split drmm_connector_hdmi_init() in 3 parts
      2 drm/connector: add drm_connector_hdmi_dynamic_init()

 B. bridge-connector: use a dynamic drm_connector

      3 drm/display: bridge-connector: split code allocation from initialization
      4 drm/display: bridge-connector: hoist error management to common code
      5 drm/display: bridge-connector: use a dynamic connector
      6 drm/display: bridge-connector: add APIs to add/remove the connector dynamically

 C. Misc preparation work

      7 drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
      8 drm/bridge: initialize chain_node list head on allocation
      9 drm/bridge: initialize chain_node list head on detach and attach errors

 D. drm_bridge: stop pipeline when a bridge is removed

     10 drm/encoder: add drm_encoder_cleanup_from()
     11 drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from drm_atomic_helper to drm_atomic
     12 drm/bridge: shutdown and cleanup on bridge unplug

 E. Add notifier mechanism to let common code (the bridge-connector)
    take actions on hotplug events

     13 drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
     14 drm: event-notifier: add mechanism to notify about hotplug events
     15 drm/bridge: notify about detached bridges
     16 drm/mipi-dsi: notify about DSI attach

 F. Let bridges return their next bridge
    (allows to know when the pipeline is complete)

     17 drm/bridge: add drm_bridge_get_next() and supporting func
     18 drm/panel: implement .get_next_bridge
     19 drm/bridge: display-connector: implement .get_next_bridge
     20 drm/bridge: ti-sn65dsi83: implement .get_next_bridge
     21 drm/bridge: ti-sn65dsi86: implement .get_next_bridge
     22 drm/bridge: samsung-dsim: implement .get_next_bridge

 G. Implement bridge hotplug in bridge-connector, enable it in a driver

     23 drm: drm_hotplug_helper: new helper to implement bridge hotplug
     24 drm/mxsfb/lcdif: enable bridge hotplug

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was initially discussed in [0].

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
       6. ✔ protect encoder bridge chain with a mutex (v7.2)
       7. ✔ of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
               convert basic direct users (v7.0-v7.1)
          b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
          c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
          d. ✔ convert direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
          e. ✔ bridge-only drm_of_find_panel_or_bridge() users (v7.2)
       8. … panel_bridge lifetime
          a. ✔ cleanup DRM_PANEL in bridge drivers (v7.4)
	  b. ✔ embed a drm_bridge in every drm_panel (v7.4)
	  c. … remove deprecated *_of_get_bridge(): non-OF drivers
	  d.   remove deprecated *_of_get_bridge(): OF drivers
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
 6. ➜ DRM bridge hotplug
    A. ➜ Bridge hotplug management in the DRM core
       1. ✔ bridge-connector: attach encoder to the connector (v7.2)
       2. ➜ drm bridge hotplug
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t
   

---
Changes in v2:
- Rewrote: added new drm_hotplug_helper, dropped most changes to drm_bridge_connector
- Added get_next_bridge func, dropped is_tail func
- Rebased on drm-misc-next, which required a few reworks
- Fix dynconn mutex locking
- Fix sashiko-reported bugs
- Drop "drm/display: bridge-connector: store the drm_device pointer", not
  strongly needed, and adapt the remaining patches
- Simplify handle_hpd code types
- Lots of other smaller improvements
- Link to v1: https://patch.msgid.link/20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com

---
Luca Ceresoli (24):
      drm/connector: split drmm_connector_hdmi_init() in 3 parts
      drm/connector: add drm_connector_hdmi_dynamic_init()
      drm/display: bridge-connector: split code allocation from initialization
      drm/display: bridge-connector: hoist error management to common code
      drm/display: bridge-connector: use a dynamic connector
      drm/display: bridge-connector: add APIs to add/remove the connector dynamically
      drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
      drm/bridge: initialize chain_node list head on allocation
      drm/bridge: initialize chain_node list head on detach and attach errors
      drm/encoder: add drm_encoder_cleanup_from()
      drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from drm_atomic_helper to drm_atomic
      drm/bridge: shutdown and cleanup on bridge unplug
      drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
      drm: event-notifier: add mechanism to notify about hotplug events
      drm/bridge: notify about detached bridges
      drm/mipi-dsi: notify about DSI attach
      drm/bridge: add drm_bridge_get_next() and supporting func
      drm/panel: implement .get_next_bridge
      drm/bridge: display-connector: implement .get_next_bridge
      drm/bridge: ti-sn65dsi83: implement .get_next_bridge
      drm/bridge: ti-sn65dsi86: implement .get_next_bridge
      drm/bridge: samsung-dsim: implement .get_next_bridge
      drm: drm_hotplug_helper: new helper to implement bridge hotplug
      drm/mxsfb/lcdif: enable bridge hotplug

 MAINTAINERS                                    |   8 +
 drivers/gpu/drm/Kconfig                        |   7 +-
 drivers/gpu/drm/Makefile                       |   2 +
 drivers/gpu/drm/bridge/display-connector.c     |   7 +
 drivers/gpu/drm/bridge/samsung-dsim.c          |  24 ++-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c          |   9 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c          |  11 +-
 drivers/gpu/drm/display/Kconfig                |   6 +
 drivers/gpu/drm/display/Makefile               |   2 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 172 +++++++++++------
 drivers/gpu/drm/display/drm_hotplug_helper.c   | 243 +++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic.c                   | 115 ++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c            |  76 +-------
 drivers/gpu/drm/drm_bridge.c                   |  45 ++++-
 drivers/gpu/drm/drm_connector.c                | 130 +++++++++----
 drivers/gpu/drm/drm_encoder.c                  |  38 ++++
 drivers/gpu/drm/drm_event_notifier.c           |  58 ++++++
 drivers/gpu/drm/drm_mipi_dsi.c                 |   3 +
 drivers/gpu/drm/drm_panel.c                    |   8 +-
 drivers/gpu/drm/mxsfb/Kconfig                  |   2 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c              |  12 +-
 include/drm/drm_atomic.h                       |   3 +
 include/drm/drm_bridge.h                       |  26 +++
 include/drm/drm_bridge_connector.h             |   4 +
 include/drm/drm_connector.h                    |   6 +
 include/drm/drm_encoder.h                      |   1 +
 include/drm/drm_event_notifier.h               |  38 ++++
 include/drm/drm_hotplug_helper.h               |  13 ++
 28 files changed, 894 insertions(+), 175 deletions(-)
---
base-commit: e051645b3b4be7c8f9f77596e62f554cd52b008b
change-id: 20260515-drm-bridge-hotplug-46265d3a2f85

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

