Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1711D730AF
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AA210F22B;
	Fri,  3 Apr 2026 07:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="i3q+UMV3";
	dkim-atps=neutral
Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com
 [220.197.32.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A497010E089
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 07:00:40 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 396d58c5d;
 Fri, 3 Apr 2026 15:00:34 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, wens@kernel.org, samuel@sholland.org,
 luca.ceresoli@bootlin.com
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, victor.liu@nxp.com,
 dmitry.baryshkov@oss.qualcomm.com, shengjiu.wang@nxp.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 0/4] Apply bridge-connector for the Rockchip DW-HDMI driver
Date: Fri,  3 Apr 2026 15:00:28 +0800
Message-Id: <20260403070032.447102-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d5224c50403a3kunm1d6b6bc811de47
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xKT1YfHhpJHk9KThhDHUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=i3q+UMV3T40Upw+1mmYGdtYmgqCkv9XHwkxm6H6mozeFHn9SlX0oRLG/mD+xCH5lrus0RrFBhRoR6oFsI9CBcLz5+Qf11Ik7WReJYvsvc25eGOkRgJ5A6DWs++LWimnqFfoxgC7ibB9ZThrhcffXNrMjMuXp2JqBqp1c2y8rBu0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Po/SGAUNetbNZqws7TyBI/pS5fyLBPvJOytlLfUBhDg=;
 h=date:mime-version:subject:message-id:from;
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

This patch series depends on and must be applied after:
https://lore.kernel.org/all/20260402-drm-lcdif-dbanc-v3-7-27cd247a0847@bootlin.com/
(Series [v3,00/11] drm/mxsfb/lcdif: use DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector)

Patch 1: Make DRM_BRIDGE_ATTACH_NO_CONNECTOR optional for platforms that call
         dw_hdmi_bind() to attach the dw-hdmi bridge.
Patch 2: Allow &dw_hdmi_plat_data.output_port = 0 without the attach flag
         DRM_BRIDGE_ATTACH_NO_CONNECTOR for dw-hdmi bridge.
Patch 3: Apply bridge-connector for Rockchip dw-hdmi driver, so that connector
         management is unified under bridge-connector. Treat dw-hdmi purely as
         a bridge without using its own connector helper functions, which
         partially overlaps with the bridge helper.
Patch 4: Add next bridge support for Rockchip dw-hdmi driver, so that it can
         support both the HDMI connector and additional bridge chips.

Damon Ding (4):
  drm/bridge: dw-hdmi: Pass bridge attach flags for dw_hdmi_bind()
  drm/bridge: dw-hdmi: Allow &dw_hdmi_plat_data.output_port = 0 without
    DRM_BRIDGE_ATTACH_NO_CONNECTOR
  drm/rockchip: dw_hdmi: Apply DRM_BRIDGE_ATTACH_NO_CONNECTOR and the
    bridge-connector
  drm/rockchip: dw_hdmi: Support to find the next bridge

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 10 +++----
 drivers/gpu/drm/rockchip/Kconfig            |  1 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 33 ++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |  2 +-
 include/drm/bridge/dw_hdmi.h                |  4 ++-
 5 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.34.1

