Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90277CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 03:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0724710F1BE;
	Thu, 21 May 2026 03:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="vI+dakBy";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11DB10F1BE
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1779334161;
 bh=uvWXleIefgMcaVUKkC88WJimguZd9IBk6W5CPEFHwdM=;
 h=From:To:Subject:Date:Message-Id;
 b=vI+dakByTYQPGmGPQ9zFBrXK5TQDfZ2kPS0VXPQlp1w6fXC6RoDuaVZOlFniJeIOs
 LhnKTAH0+BoLF8/O9UASGIFJzw+nLA9kv2P5L6kfgUvGISeSISafJSVPF/lVVWoSAR
 KtHrRflGQtGYPEvPQPXAk8MVJbiv2AuoQb8z/N2U=
X-QQ-mid: zesmtpsz7t1779334152tbdbc048d
X-QQ-Originating-IP: F0AwXrhrVjRvI3ByKviz7kUiLndPJE2H+PzKj5o739E=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 21 May 2026 11:29:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14128924836008219717
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
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 0/5] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Thu, 21 May 2026 11:28:49 +0800
Message-Id: <20260521032854.103-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5aznPMtO1XHDwURPLwJVkSrv2lbZLzZGOl24L5OUywbBWJSVg9GTBzw
 +M/uxOTVSVI2O0tdAr9gYEUIV6RzrjhyhQSLCUwfdCP+Pf6Ws+eiIjNXcCPZRUtL0loY0w7
 PwGm8p+05oHsPQS4WH5WRcIvU1b1UoG4tu2PBqgPun0TUqWotQou6AcXZ1nMq+ET7TuulEe
 oQKRBG7WTe7r95Ek5zxySO5+2FiXmaEryEG4knFsBqovAf4k+QEHO/31Tu+d2NDF4uH1Qz8
 p/iUa+9k99rSoPd6tw1GFGk4YPiKzHQPxjWwqkpGfqbXxsHBQSvQvnhdhYZboq+NZKRIC/W
 BIDjDiC+kAqBKHVmXKvq8Lkd/QQGupHMF0QJ461PoysRKs5e432sJ1XogRBJ2deMIMEK06g
 le+DMG6O9oS6UbzCkSlVZDgXMxi4E0UGJ961Ai4lji+C9eqa4EMHazXpFQJjZuLhp/GnGHP
 jmNqOvTW9yMgtB1ltnv0AKz7wGBg7UNLYcDYUUglfYeb7iLWo56Cl4cEzyJl2cAzGgmAE+U
 /aKWndP6+VvIM6cBLReITT2BKQObIxQhMKB3kgs/tVUhTZCF4uRaZf/H54SXB6/HgoHNSHz
 OqbH9PR0gdwSTKbeVj9+hSIs5uWXNB7EnzqnWKwWtqvONN3arwOejErbNRCdJn2nLbK+55J
 yU2HmSvq+NI8y5dit5HGzQRrhfkdnw8+EsQDX0Qdimb7V8npAoE51H+3fyC/S4a7fMdUQaB
 lgkaQCV3tjleGW6oDlvRWv3UF0N7l2l7D3zZuXt2Bhf3I+Ag7wwCqfS4GtUKRb+6+753Dto
 CueSngT6pRGI6jJnwFuxB72Pi+ivEGs+lj6Hr7rsmjINiaIAZULwg7yuKynNWPR6zBehrnR
 /16SxXkV130GgaNz/DiOOCoDZ5m+FXDUmdL+q1vmuHDhBE9XkiwDhQoKeBFvTRzToX054Ax
 oJprqFC6SAFIKhRozOlDNvVz6YGSc4OKAnu/S6ZXp5zfm97AlJTI1h6gxHNr9JM+01XkzrY
 9fc2fQdRgyislVYrix
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Chaoyi Chen (5):
  drm/bridge: Implement generic USB Type-C DP HPD bridge
  drm/bridge: aux: Add drm_aux_bridge_register_from_node()
  phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
  drm/rockchip: cdn-dp: Support handle lane info without extcon
  drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
    selection

 drivers/gpu/drm/bridge/Kconfig                |  10 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/aux-bridge.c           |  24 +-
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  49 +++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 349 ++++++++++++++----
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
 drivers/phy/rockchip/Kconfig                  |   2 +
 drivers/phy/rockchip/phy-rockchip-typec.c     |  13 +-
 include/drm/bridge/aux-bridge.h               |   6 +
 10 files changed, 404 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

-- 
2.53.0

