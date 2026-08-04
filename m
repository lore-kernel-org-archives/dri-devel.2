Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5F5C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7F410E654;
	Tue,  4 Aug 2026 07:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="b8kwgOQn";
	dkim-atps=neutral
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1059510E654
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785827901;
 bh=4uFCqu0p0pYyvP6VJhfQU8lFG2oyNVxdn8MamPTgQlc=;
 h=From:To:Subject:Date:Message-Id;
 b=b8kwgOQnhNBptL9Js2K+ah7kEDgYnsS9p/DVe8tSJTXdytVyTHdW6DNpFSEq70JmN
 VIwURaJPcGZVqhb7GGOWVOpKk2Xyr3QkaHt+EiBEClHltKTrKklqjw9AyGm9FkgnTc
 5CQfnhnFc3UBQskX4oG2mTZxVWnV/lRJ8PnckOjk=
X-QQ-mid: esmtpsz19t1785827273t108231cc
X-QQ-Originating-IP: oW8kOPLlM9qGybeiNyNpDJs4YNZHTBEyPC279s2oho8=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 04 Aug 2026 15:07:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 452998556394821966
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v6 0/7] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Tue,  4 Aug 2026 15:07:23 +0800
Message-Id: <20260804070730.68-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmPNY57tR1XnN02YEdttJlrR5OaEvAeJIEBokg6kcclEiQ67fgs51Two
 VRc7nR1oKLyjYZEOhkPa9A6XR4hEQLvKEgtSSdAUGHMNYQ2b8UzoVJ6UpEeqCYCZBKL2XEq
 CTl0669+744XfzAcf/G3Jh9+lum42yv+n1cPNO4U0LtFLbQuQrhQky4ewms0OsLCswa5b1x
 Nzh+J/MBMk+tgW6n4aJvvQBTpaC5Rbv17fJ4FIUvV8aHk6NKAyB2239Zxpz7E3E6Pd3I/9N
 1qbx7bVyysH0B53dkEec/KEurotI0PdzFopVyi/1TLWz1Bh/C4DCWNmoXV6c97TYQzaDdDh
 erqc8DmDyikLJznhS3h8HuhFw2QojKcksExw3OqRzWyTfxTuHPQ+MrUk42M96QXZGoh1JVZ
 iB4JLuO4yo21oyUgczeRUagaEbkWhDjjFatLuv6s1SReIKW7EbJ/L3yet3gfPTlJXwELqjT
 5TxY/7l0RhhVOO/mKGpUa9hCH2M9mjmgs07/Zf5dF91kXkium012wwh6cHi49p7DXf/+fr5
 SXYUPp6uTEtqU4Ssk4TciYg0hww4r8tt90jdFembBz3g4SVPzIhVpPFRQzC9wL5ceSf0MIn
 WrvfF7lxWAsouKdx9risyYkdgK+tnHImWIoIntyUmpM0SEsiPYlfue+F7hpCVpSQU2MNuAx
 g2dzuhE12e7mGRCsod2jSbn4rYFWMab2NKsLk7JzuYkwq51Bzh8FLffEvxGAPEt+oYQlDF8
 HGFnHLmk7qGg3gZ3jrnToxOBB9zO6OFf2FlpsGhuYDCVe1ItI9u1ofLzX0pTCHp0xgXnhYD
 UfM3lhNycrKl/VIRiWDIGatA8YYtlt3iM34aTY+tOGs88g32qkWwmC+0YAhUIZjitwM/Dju
 6pJKHE+5S8NsDSVG5CE3PAuHpVQq8/aHxInH5r8vqbFM3d+U4gy/JUu3xkvBaz+2q9HRHGZ
 Qv7CLgQsfiJsJPQ9VtqFUvAss107MtinaaYbVGELyxdPKRHu6+rDqCMVpZ8FPAFgmETS6FI
 SPntbj70rq7Y6oJTMu5egJ4+IQ2xv0SEvEjNFZsCv6liPsEJJb
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This series is split from the v15 "Add Type-C DP support for RK3399 EVB
IND board" series [1]. It focuses on the DRM bridge and Rockchip
platform CDN-DP controller changes.

[1] https://lore.kernel.org/all/20260304094152.92-1-kernel@airkyi.com/

====
1. Generic Type-C DP HPD bridge

Currently, several USB-C controller drivers register their own DP HPD
bridge via aux-hpd-bridge.c, each duplicating the same logic. For
devicetree based platforms, the USB-C controller may vary across boards,
and not every USB-C controller driver implements this feature. Patch 1
implements a generic DP HPD bridge that monitors Type-C bus events and
automatically creates an HPD bridge when a Type-C port device with DP
SVID is registered.

2. Multiple bridge model for CDN-DP

The RK3399 has two USB/DP combo PHY and one CDN-DP controller. Patch 5
introduces a multi-bridge model where each PHY port gets a separate
encoder and bridge, allowing flexible selection of the output PHY port.
This is based on the DRM AUX HPD bridge rather than extcon.

====
Patch 1 adds new API to check whether a DisplayPort HPD bridge has
	already been registered(Sebastian).
Patch 2 adds generic USB Type-C DP HPD bridge (Dmitry, Heikki).
Patch 3 adds module soft depend for USB Type-C DP HPD bridge(Sebastian).
Patch 4 adds new API drm_aux_bridge_register_from_node() (Neil).
Patch 5 adds DRM AUX bridge support for RK3399 USBDP PHY (Neil).
Patch 6 drops CDN-DP's extcon dependency when Type-C is present (Dmitry).
Patch 7 adds multiple bridges to support PHY port selection (Dmitry, Luca).

Changes in v6:
- Link to v5: https://lore.kernel.org/all/20260730013349.51-1-kernel@airkyi.com/
- Avoid duplicate registration of the same DisplayPort HPD bridge.

Changes in v5:
- Link to v4: https://lore.kernel.org/all/20260727064408.101-1-kernel@airkyi.com/
- Add module soft depend for USB Type-C DP HPD bridge.

Changes in v4:
- Link to v3: https://lore.kernel.org/all/20260717072323.96-1-kernel@airkyi.com/
- Scan the entire typec_bus and attempt to register the hpd bridge,
  so as not to miss devices that were already added during initialization.

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20260608070805.88-1-kernel@airkyi.com/
  (Sorry, I forgot to add the "v2" title, so it looks like v1.)
- Remove now-redundant call to drm_connector_attach_encoder()
- Rebase to v7.2-rc2

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20260521032854.103-1-kernel@airkyi.com/
- Add copyright text.
- Remove useless goto.
- Fix incorrect function names in the documentation comments.
- Fix the check logic for dp->active_port (0 is valid).
- Fix the uninitialized prev_port.
- Remove duplicate logic from cdn_dp_switch_port().
- Fix the prototype of cdn_dp_bridge_hpd_notify().
- Properly release connector->fwnode.
- Properly release next_bridge.

Chaoyi Chen (7):
  drm/bridge: aux-hpd-bridge: Add drm_dev_has_dp_hpd_bridge()
  drm/bridge: Implement generic USB Type-C DP HPD bridge
  drm/display: Add soft depend for aux-hpd-typec-dp-bridge module
  drm/bridge: aux: Add drm_aux_bridge_register_from_node()
  phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
  drm/rockchip: cdn-dp: Support handle lane info without extcon
  drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
    selection

 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/aux-bridge.c           |  26 +-
 drivers/gpu/drm/bridge/aux-hpd-bridge.c       |  42 +-
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  67 ++++
 .../gpu/drm/display/drm_display_helper_mod.c  |   1 +
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 358 ++++++++++++++----
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
 drivers/phy/rockchip/Kconfig                  |   2 +
 drivers/phy/rockchip/phy-rockchip-typec.c     |  13 +-
 include/drm/bridge/aux-bridge.h               |  12 +
 12 files changed, 479 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

--
2.53.0

