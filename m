Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02041C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2989410E2DA;
	Tue, 15 Sep 2026 16:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WkFbKeuQ";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DED810E2DA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:46:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C9F2B4E40639;
 Tue, 15 Sep 2026 16:46:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 847F2602B0;
 Tue, 15 Sep 2026 16:46:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3617911C7B005; 
 Tue, 15 Sep 2026 18:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789490800; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=r7ws2yNGxCu99b9kREC/qBBkTq3Kz8mFcYPsCXy1MLk=;
 b=WkFbKeuQSkU4PhcQNzSuI3zOKkdFlsLI1oHzH68fWp95mQq5fomdyXjlEOXzt5+vSgCsJI
 AtMoFCHX4zt8FlnZerWJJJQITtUBRaTdzcGgZYc00Y0vqeCniX4AKhVgTX7wbEEYl9sXFr
 uXROuhcYgphRUWvIS50aMf+AxIMPU9bVg/6nusqyUIw99F2Sr4i812+afVojnETAsYjO/f
 oGW50T3ig+4llPLVugYjuSlV1oi+QcOxFxlbZG4fw1iYydCSgiDmh1kqFxkJUvU0axVEk0
 Qky4CXQN44Z1nue8YRQiwnGpTJZuizO5u0PEsqSNpBvcho8rpBoUMwNiZjPTzA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v4 0/9] drm/bridge: Kconfig: cleanup DRM_PANEL usage
Date: Tue, 15 Sep 2026 18:46:13 +0200
Message-Id: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NyQ6CMBQF0F8hXVvTgaG48j+MMR0eUgMtaZFoD
 P9u0Y3GBe7ezbs594EiBAsR7bIHCjDZaL1LId9kSLfSnQFbkzJihJVEUIZN6LEK1qRPOk+DdNB
 h3YF01wGTGkyhNSV1LlAihgCNvb34w/Gd41VdQI+LuTRaG0cf7q/9iS69P6cmigkmRpQVz6EmQ
 u6V92Nn3Vb7Hi1jE/vgWLHCscTpUguhZNU0hv1y/IPjdIXjiSsINEbQUigO39w8z08KrmP+egE
 AAA==
X-Change-ID: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Christopher Vollo <chris@renewoutreach.org>, 
 Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, 
 Tony Lindgren <tony@atomide.com>, Michael Walle <mwalle@kernel.org>, 
 Vinay Simha BN <simhavcs@gmail.com>, Maoyi Xie <maoyixie.tju@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Andrey Gusakov <andrey.gusakov@cogentembedded.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 sashiko-bot@kernel.org
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

As a cleanup in preparation for making every drm_panel embed a drm_bridge,
fix missing or unnecessary usage of DRM_PANEL and DRM_PANEL_BRIDGE in
drivers/gpu/drm/bridge/Kconfig.

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
          a. ➜ cleanup DRM_PANEL in bridge drivers
	  b. … embed a drm_bridge in every drm_panel
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

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v4:
- Removed 4 patches now upstream
- Fixed commit message of the tc358767 patch
- Link to v3: https://patch.msgid.link/20260831-drm-bridge-drm_panel-cleanup-v3-0-50efd8168b3e@bootlin.com

Changes in v3:
- Fixed a few patches which incorrectly removed 'select DRM_BRIDGE'
- Added missing 'select DRM_PANEL_BRIDGE' to some patches where
  devm_drm_of_get_bridge() is used (thanks Doug)
- Added patch 13 for tc358764
- Removed boucing address spanda@codeaurora.org from Cc list
- Link to v2: https://patch.msgid.link/20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com

Changes in v2:
- Added maintainers and recent authors to per-patch Cc list (these are not
  added automatically by get-maintainers because the patches touch only the
  Kconfig file)
- Added review trailer
- No changes to commit messages and patch content
- Link to v1: https://patch.msgid.link/20260812-drm-bridge-drm_panel-cleanup-v1-0-0d86734e908a@bootlin.com

---
Luca Ceresoli (9):
      drm/bridge: tc358764: don't select unused DRM_PANEL
      drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL, select DRM_PANEL_BRIDGE
      drm/bridge: nxp-ptn3460: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: parade-ps8622: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358775: select DRM_PANEL_BRIDGE, not DRM_PANEL
      drm/bridge: tc358767: select DRM_PANEL_BRIDGE
      drm/bridge: tc358768: select DRM_PANEL_BRIDGE
      drm/bridge: ssd2825: select DRM_PANEL_BRIDGE
      drm/bridge: tc358764: select DRM_PANEL_BRIDGE

 drivers/gpu/drm/bridge/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
---
base-commit: 2d70e1401dbbfc559b6a5d1ba8275d5282d71c2c
change-id: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

