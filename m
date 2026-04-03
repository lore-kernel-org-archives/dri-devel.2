Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6C0D730AC
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0BB10F29A;
	Fri,  3 Apr 2026 07:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aFs31TTZ";
	dkim-atps=neutral
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com
 [45.254.49.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1677110F293
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 07:00:45 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 396d58c9f;
 Fri, 3 Apr 2026 15:00:42 +0800 (GMT+08:00)
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
Subject: [PATCH v1 4/4] drm/rockchip: dw_hdmi: Support to find the next bridge
Date: Fri,  3 Apr 2026 15:00:32 +0800
Message-Id: <20260403070032.447102-5-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403070032.447102-1-damon.ding@rock-chips.com>
References: <20260403070032.447102-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d5224e24f03a3kunm1d6b6bc811ded4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkeTFZIQ09NQ0hKSktLHR5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=aFs31TTZtr+bCfSkmGEJmc0xRV7zEwxDbZrhSC+mQNg0U67RwMRuJMxl4yptVlC6kZi5QRfl2dSs3ey2cwYI+2sXDp6VJgBZEO9JDJITLh/JRY5CKD1HhV4l/ODhISn/XFR3t4jpqT9q9y/19yiV87id2R+hDfWQw9s+LbJU9AY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=qhMDeS5MJsqMangPhhuZJQL2DTnTsaxRf2SE3asViXM=;
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

If there is a remote node connected to the HDMI output (port@1), the
&dw_hdmi_plat_data.output_port should be set to 1. This patch allows
Rockchip dw-hdmi to support the hdmi-connector and the next bridge.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index b5cfcb936078..014ac09fd733 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -544,6 +544,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
 	struct drm_connector *connector;
+	struct device_node *remote;
+	struct drm_bridge *next_bridge;
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -610,6 +612,18 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 	platform_set_drvdata(pdev, hdmi);
 
+	remote = of_graph_get_remote_node(hdmi->dev->of_node, 1, -1);
+	if (remote) {
+		of_node_put(remote);
+
+		ret = drm_of_find_panel_or_bridge(hdmi->dev->of_node, 1, 0,
+						  NULL, &next_bridge);
+		if (ret && ret != -ENODEV)
+			goto err_cleanup_encoder;
+
+		plat_data->output_port = 1;
+	}
+
 	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 
 	/*
-- 
2.34.1

