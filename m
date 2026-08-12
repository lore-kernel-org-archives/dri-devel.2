Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE94C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031A210EFE4;
	Wed, 12 Aug 2026 13:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N3NVpHwt";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE97610EFE4
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:48:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 834BE4E411D7;
 Wed, 12 Aug 2026 13:48:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4D6646045E;
 Wed, 12 Aug 2026 13:48:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C0E9F11C4CF18; 
 Wed, 12 Aug 2026 15:48:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786542506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=9mn8+RLZ/euoxyRgD1crSDzVTtC0Rj4RzIpHK314g28=;
 b=N3NVpHwtcEt3ujgF0YvsGzMP8o4FEkoV4j3lLLHzTLjpBxvMdwD86VnuEzg5SuB04PjzGZ
 bTgdVrOlxOFM2WQYu0OlZYzsM5KogIckH+p6E7ZlBVVLaPEqIkBe4h5rFCC4aHhtD6wZ3K
 hOtKwfhML4wVA4swqpO1v/v3tg+MzBVbAmAgS0b3T5fmRTiESND9jB1E75D8fV77DfD+N7
 aud4BWD7Pum0meeiosCl6MNwiVc5aGb8gkgjPaPtUtJE56DyoUS8XrZPzl1vR5BMbuINv+
 VtwE5QOVROOkhSrvC6REXrjhSTNC2//UhBY6BSk6xGFfICwQsIfBCQ5Nf/DMOg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/12] drm/bridge: Kconfig: cleanup DRM_PANEL usage
Date: Wed, 12 Aug 2026 15:42:40 +0200
Message-Id: <20260812-drm-bridge-drm_panel-cleanup-v1-0-0d86734e908a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTbQFpXNVxEZXRo1MmtJ3RiMv
 btR787HgX+Fyipc4dSsoDxLlVc2+F0DdI/5xijJDMGFo2t9wKRPHFSSPTb7EjOPSCPHPBV0Hac
 DkXfdvgVLFOWrLL/8+fJ3nYYH0/vbhG37AMXh5EeAAAAA
X-Change-ID: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
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

As a cleanup in preparation for making every drm_panel create a
panel_bridge, remove unnecessary or wrong usage of 'depends on DRM_PANEL'
and 'select DRM_PANEL' from drivers/gpu/drm/bridge/Kconfig.

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
	  b.   add a panel_bridge to every panel
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
Luca Ceresoli (12):
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: don't select unused DRM_PANEL
      drm/bridge: tc358764: don't select unused DRM_PANEL
      drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL
      drm/bridge: ti-sn65dsi86: don't select unused DRM_PANEL
      drm/bridge: ti-sn65dsi83: select DRM_PANEL_BRIDGE
      drm/bridge: nxp-ptn3460: select DRM_PANEL_BRIDGE
      drm/bridge: parade-ps8622: select DRM_PANEL_BRIDGE
      drm/bridge: parade-ps8640: select DRM_PANEL_BRIDGE
      drm/bridge: tc358775: select DRM_PANEL_BRIDGE
      drm/bridge: tc358767: select DRM_PANEL_BRIDGE
      drm/bridge: tc358768: select DRM_PANEL_BRIDGE
      drm/bridge: ssd2825: select DRM_PANEL_BRIDGE

 drivers/gpu/drm/bridge/Kconfig | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)
---
base-commit: d3850569e847e8912b9be6e0fe6b91fb75293647
change-id: 20260812-drm-bridge-drm_panel-cleanup-09ed5cc10948

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

