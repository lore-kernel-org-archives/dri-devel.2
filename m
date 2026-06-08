Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10988CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E28010EE02;
	Mon,  8 Jun 2026 07:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="UW+DZviq";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E1B10EE02
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1780902654;
 bh=c8bAbxQipQScLcXxmIAXdGHi58J7IG7meuZVe7IO+SA=;
 h=From:To:Subject:Date:Message-Id;
 b=UW+DZviqQ+GSgkEHyyDaaOSJgrweut5k6u3Row0GpjM74F5cVwVui7f1lAyyLAC+O
 daaVeaOzjiQYTg5jlVs1Qfj0FzcMlpn900XlZExX4eIcSIGE5Kv2VrvLtDoP9vuMam
 HZSkWPe2Nnp+9I/+1RjLLschSK6i0QWHbTOJy5To=
X-QQ-mid: esmtpsz10t1780902493tf527980e
X-QQ-Originating-IP: xBVLmXb3lGPeq0AFgUf7H3AOXSDXzX2o6/6guapiblY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 08 Jun 2026 15:08:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7290291170136112092
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 0/5] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Mon,  8 Jun 2026 15:08:00 +0800
Message-Id: <20260608070805.88-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M0B+OzpJUlV8MN2xVCHpU/4mXOLXvqr5vEkmpkiW/6PeFB8n6y9kGgiR
 AH9i3l1jT5gRy2rDWws1sMu+d81Y5gKiQ7kOXIiUWoIrKccRTslUtd7fTrIlKa+KnluWh80
 Sai8HV1ibQUl08H3yswtkei/N6v1dScKKXp65G0MOovrF7IEYpPnAjT4JVkj5xm7nevyoes
 MeBErRprj1ucSuD5WlCxdSDQhdz4UWqesMgbtaEZdvFqlDTNM8ry1qjDg+tXvBkpe8BU7/d
 LXkP+I3e0PKFcXUkRrlIbbztYZV5pvNlixr1yAMkmJPlq71G2jczlHENoyflLQCjxmcWv5E
 6MfeTYktP9EcL9/Mq74kDCFjmfkC9g7dNoBXfLxvYKI25g3dqU56J8vVFkHQDSief1sFfmt
 reprog77HFCtGRGaVz3qI8vRTU5lHrc/TN9aZZI7ecWL9wLMF8i3+kuTOrtaFkqkFFYuzvS
 azp8jGlKhL2Z1avAuDW9b/rcVEiFWG88wKBpXgh2Q+7H6c/2yurBqL+AJMaiGjRhSRil4Ut
 mnEUbXbY6HzNISdA+zaa8UlYboWOxp8+Pn+3uEJWiGMudBgT8o/bf28iQi7Md78hl8EjkGE
 lmzDyGRDcnsDIXBg7edlyqQv/NUVvNpIztLP/VkKLKzmeP0qqeY8eC9tQEXXuO4TN+pMkOJ
 z1b2Espyg1fmZSA8GLwgC7Hy5tZk8QjZGZ5xs2ReUp0GPb0uuz+PUwAA/78Bw2EzK0+X8OG
 E3+jC35P0WUSG0BAlzKBQ2cbYtWcmQtzBnf/+6jli71vywxe//i2p7MusfRc6TVe0iKmLSd
 4fbXLrMDYV0V2XRGoU80V7goZMWYXEshp9+2bbOXn+g7hq4ef/8+87ArxQSxKEoRG00+CcH
 ag3oFYsBfLHOMbQnWfg8oLYPhBh1lN5AHujwSGE7Z9sgPxP7aUFEAanZ/7NA5tQovxOlVKv
 odRSbcYoB/e7XB3Y1mgwoO0bSMZo0SM4y8xTQGf0SQJnUE7qFny5fREPcAzCi9phW4MDRp6
 68FjahbYM0QF7NrX5Z8nRkSlCydUs=
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
Patch 1 adds generic USB Type-C DP HPD bridge (Dmitry, Heikki).
Patch 2 adds new API drm_aux_bridge_register_from_node() (Neil).
Patch 3 adds DRM AUX bridge support for RK3399 USBDP PHY (Neil).
Patch 4 drops CDN-DP's extcon dependency when Type-C is present (Dmitry).
Patch 5 adds multiple bridges to support PHY port selection (Dmitry, Luca).

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

Chaoyi Chen (5):
  drm/bridge: Implement generic USB Type-C DP HPD bridge
  drm/bridge: aux: Add drm_aux_bridge_register_from_node()
  phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
  drm/rockchip: cdn-dp: Support handle lane info without extcon
  drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
    selection

 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/aux-bridge.c           |  26 +-
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  54 +++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 358 ++++++++++++++----
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
 drivers/phy/rockchip/Kconfig                  |   2 +
 drivers/phy/rockchip/phy-rockchip-typec.c     |  13 +-
 include/drm/bridge/aux-bridge.h               |   6 +
 10 files changed, 418 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

-- 
2.54.0

