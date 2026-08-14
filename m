Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A208EC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1C010E571;
	Fri, 14 Aug 2026 14:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ozkb8yd1";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C3A10E571
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:06:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C90A34E411D9;
 Fri, 14 Aug 2026 14:06:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 896446046D;
 Fri, 14 Aug 2026 14:06:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D61711C4EDA5; 
 Fri, 14 Aug 2026 16:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Tjzdbymf6RS/Z+tBjOvVpccAHLlxgBk3KM/dTssvFMU=;
 b=Ozkb8yd18ElouWPyT8/RwDp/dHDRGpArjVyid5bRbrORZkDcf1w9hFcDfbQRlZqeRnk7j4
 Io+PczuTSPxDZGMn1lRentrZ+0Be+EyqGdbaLLOfaZmz1b+lIBY+y6MYZcWDvVY119rPhI
 u0JNSGNxj06DUqLs/tAnH0wNAnqg0+dVWvqYDior6Zt3CKA14xFCg2B5McKLFtrTgNTbyB
 yd4ml7vdS8DdROkGrpVcoxX1JfLJedLyUQzBHq2gf+tyUkB4k5LL0C4YBjmb/Ui136auef
 AfjqU2dqnO0moVubi0B84fkt9lUd3BI2zyBTuMeDpEzfyWba67B2Q6CrBSY6Ng==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/11] drm/panel: add a panel_bridge to every panel
Date: Fri, 14 Aug 2026 16:05:48 +0200
Message-Id: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQ6CMBCE4auQfWYT2mgjXIXwUOiga6CQrRIN4
 e5WffwymX+nBBUkaoqdFJskWWKGKQsabj5ewRKyyVbWVRdjOejMvUrICzbom1cfMbE359oFhxH
 +RPm8KkZ5/cJt93d69ncMj2+NjuMDmFFaA3oAAAA=
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
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
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

This series makes every drm_panel create a drm_panel_bridge wrapping it, as
previously discussed [1][2].

A panel_bridge is currently created only afterwards by the component
accessing it (such as the previous bridge), but that creates a mismatch
between the panel and the panel_bridge lifetimes and devm ownership.

== Series outline

 1. The most common pattern for panel_bridge creation is:

      | drm_of_find_panel_or_bridge(..., &panel, &bridge);
      | if (panel)
      |     bridge = drm_panel_bridge_add();

    Adapt drm_of_find_panel_or_bridge() so it prioritizes the bridge, not
    the panel. With this small change all drivers using the above pattern
    get ready in advance for when every panel will have a bridge
    (a few commits below).

      drm: of: drm_of_find_panel_or_bridge: simplify freeing the remote node pointer
      drm: of: drm_of_find_panel_or_bridge: simplify error return paths
      drm: of: drm_of_find_panel_or_bridge: prioritize the bridge, not the panel

 2. Address circular module dependency that would arise in the following
    commit [RFC!]
 
      drm/panel: merge the drm_kms_helper module into the drm module

 3. The main commit

      drm/bridge: panel: add a panel_bridge to every panel

 4. After the previous commit, many drivers not using the pattern in (1.)
    will unconditionally create a second panel_bridge for the same panel.
    Being an RFC, fix *some* of them as an example; if the approach will
    be acked, all of them will be converted in a later iteration.
    
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: simplify device_node management using scoped for_each variant
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge

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

[1] https://lore.kernel.org/all/emuj2innmp6zmzd7pyakqzjqpdzhly6qfhakya3ydwmd63pl26@5jwxaidpikjw/
[2] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-8-9d6f2c9c3058@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (11):
      drm: of: drm_of_find_panel_or_bridge: simplify freeing the remote node pointer
      drm: of: drm_of_find_panel_or_bridge: simplify error return paths
      drm: of: drm_of_find_panel_or_bridge: prioritize the bridge, not the panel
      drm/panel: merge the drm_kms_helper module into the drm module
      drm/bridge: panel: add a panel_bridge to every panel
      drm/bridge: tc358767: don't create a panel_bridge
      drm/bridge: waveshare-dsi: don't create a panel_bridge
      drm/mcde: dsi: simplify device_node management using scoped for_each variant
      drm/mcde: dsi: don't create a panel_bridge
      drm/bridge: fsl-ldb: don't create a panel_bridge
      drm/bridge: samsung-dsim: don't create a panel_bridge

 drivers/gpu/drm/Makefile               |  7 +++--
 drivers/gpu/drm/bridge/fsl-ldb.c       | 18 ++++---------
 drivers/gpu/drm/bridge/panel.c         | 47 +++++++++++++++++-----------------
 drivers/gpu/drm/bridge/samsung-dsim.c  | 19 +++-----------
 drivers/gpu/drm/bridge/tc358767.c      | 22 +++++-----------
 drivers/gpu/drm/bridge/waveshare-dsi.c | 16 ++++--------
 drivers/gpu/drm/drm_of.c               | 36 ++++++++++++--------------
 drivers/gpu/drm/drm_panel.c            |  3 +++
 drivers/gpu/drm/mcde/mcde_dsi.c        | 47 ++++++++--------------------------
 include/drm/drm_panel.h                |  8 ++++++
 10 files changed, 83 insertions(+), 140 deletions(-)
---
base-commit: c0f5782834718a69465a7169112062d4412856e4
change-id: 20260812-drm-bridge-every-panel-a1596d6efea4

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

