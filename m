Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F84FC54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A6A10ED02;
	Thu, 30 Jul 2026 01:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="iWot4aIN";
	dkim-atps=neutral
X-Greylist: delayed 508 seconds by postgrey-1.36 at gabe;
 Thu, 30 Jul 2026 01:43:02 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1697410ED02
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785375779;
 bh=HGwgkD8UDDC/KvvjZYPql/0Ajl4ttvz4Z13BCLoOB8Y=;
 h=From:To:Subject:Date:Message-Id;
 b=iWot4aINX0+Uf0ahrAiOGjZ2Yb8apGUaN+ydgq6EV6U5N/FuERhLdVI1eehlAfAAu
 ghPjxS2G2qNJKiq/1wxdzqnz6TCjWQJUJo/9Fk0MuO9r5dllRN6s7xMSxx+yb80RtG
 VbJ0D0TjXlPzteinOfkbjAq5kFklwlQ82NAU/OoI=
X-QQ-mid: esmtpgz16t1785375240taa39783a
X-QQ-Originating-IP: YGs2uIrkoN4Lncdxa0Oh1sKiphWaNYiOWO2tkWSHOGA=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 30 Jul 2026 09:33:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16287405302588008076
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
Subject: [PATCH v5 0/6] drm/bridge: Implement generic USB Type-C DP HPD bridge
Date: Thu, 30 Jul 2026 09:33:43 +0800
Message-Id: <20260730013349.51-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSEFX6u+4l+KVJ4g4XOZ+94mT4tUHBRpLrHel4sll9OYzZtIdVcwfsO2
 nt65tAq86WRnLUvNR0EhHFismujTfFCvvLLlZft3QpmHKnyM5Mfqn2ePj5d/JaTzIKZQxvz
 HnqJ3nAjZCvcUxcQkTySwxBhuN/ZiROFl4fygnr8t6nnWcW2Sin4JXUp5HbQKGtoPcg93tJ
 X1NymbFJR0qSuHKGjcAywl01J+/fDjHnCxdsxfYhsiZIlfF/ZYiky99rcAxR8d/hq1YxUlZ
 DJcS0Wn0xZiNn0NuOF3ihBgAx/1CeZx63e3gVoJzknX7k/JBrhwAfzuzT5kzPJRNq9JktC2
 /V12oPy8RVi/7vPRfBl2acadhA8XW5L6UICgP4y/mKWaJIR1vERIHAE35yCJ2oxIHNjJYZq
 zoPRuuw1dDcXL5k0W+pgx0D4v6Cb4udTpciLJTj6V1l1+ibnkXiWxEleiMb23Sb/3DR4PG4
 C/G12vtCDtIESrGgRt6uLZh5MwLr66uOlIUzms0aSNght842rMbC8augKRydXEj0bTiV1xQ
 S6kaLKlmv+fQdvmHS4f9sc31S89nrC5V1idaAtSO6yWIOQYrJN2Zo87TDiG6bbdB5wqX2XY
 pbnSHIi+AMnuDsQlotWcmcmMpG8JFJX7hfqQAoJDBNces8KlHcz2IjCY6A1I2Sm8xM6FRY6
 lY30OY1mQNPWMdsPoOcPjotGNcaPIvFCbQM2kA2wWE26Y3c3VMNNfgQhSwIWK+lFVDDfzaF
 t0Kfden8iHiWL5kIy3FpM4O3vDphx3Q2JCB7nd+ziul29MvDxEuu9yS7soSMJi06Umi77gJ
 H/4tJ7iCct1j3T217SKgpLWni5YELgkptpfG6BvquzRMQ2HkEvEPLVMSOo5H0Q6PSNu/Liz
 g8nByqu4D1OuxMame8OgP6aizrsMfcHP3TLy9tdhvCVW8MOhlD8UwFkYgL28Gxzy5y9QsBQ
 H2o8wMvdo9ni55Jlo0GzaleGom0G2kz8tDzERmKNrJSd530GDrEmERRa+Y0xzqTNSPK6QqB
 87xGLlCg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Patch 2 add module soft depend for USB Type-C DP HPD bridge(Sebastian).
Patch 3 adds new API drm_aux_bridge_register_from_node() (Neil).
Patch 4 adds DRM AUX bridge support for RK3399 USBDP PHY (Neil).
Patch 5 drops CDN-DP's extcon dependency when Type-C is present (Dmitry).
Patch 6 adds multiple bridges to support PHY port selection (Dmitry, Luca).

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

Chaoyi Chen (6):
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
 .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  64 ++++
 .../gpu/drm/display/drm_display_helper_mod.c  |   1 +
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c        | 358 ++++++++++++++----
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
 drivers/phy/rockchip/Kconfig                  |   2 +
 drivers/phy/rockchip/phy-rockchip-typec.c     |  13 +-
 include/drm/bridge/aux-bridge.h               |   6 +
 11 files changed, 429 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c

-- 
2.53.0

