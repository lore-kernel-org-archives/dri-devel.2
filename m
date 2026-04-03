Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83674D730AC
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E431089CC1;
	Fri,  3 Apr 2026 07:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OlOoyejo";
	dkim-atps=neutral
Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com
 [45.254.49.209])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B91089CC1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 07:00:40 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 396d58c6e;
 Fri, 3 Apr 2026 15:00:36 +0800 (GMT+08:00)
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
Subject: [PATCH v1 1/4] drm/bridge: dw-hdmi: Pass bridge attach flags for
 dw_hdmi_bind()
Date: Fri,  3 Apr 2026 15:00:29 +0800
Message-Id: <20260403070032.447102-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403070032.447102-1-damon.ding@rock-chips.com>
References: <20260403070032.447102-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d5224cc9f03a3kunm1d6b6bc811de6a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlLHVZJGUIaGklMT0tOHh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=OlOoyejoOkXGTU0c6apybdH7VloZYuymy3nY8UshMSA/uZrhmc5R0e/cHRqTMPPT4ts1ZuQHeZtwbl5PrhrJw/gbb17xqSbn8A58hlp6/36pSUmFjsTJo5DU0GsPN2VZxUpglrz+Vek1RK0D28zCnasPVmCr9eMpxEtc1kwl/7E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=McMc5vAPh2G/cVqrH2p4ek7fEhv61YfNK/RtiS2LLiY=;
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

For Rockchip and Allwinner platforms, the HDMI encoder attaches the
dw-hdmi bridge via dw_hdmi_bind(). This additional bridge attach flag
serves as preparation for the Rockchip dw-hdmi driver to support the
bridge-connector framework.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 5 +++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       | 2 +-
 include/drm/bridge/dw_hdmi.h                | 4 +++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ada45e8b3e2c..dd50dda3a4f5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3619,7 +3619,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_remove);
  */
 struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
-			     const struct dw_hdmi_plat_data *plat_data)
+			     const struct dw_hdmi_plat_data *plat_data,
+			     enum drm_bridge_attach_flags flags)
 {
 	struct dw_hdmi *hdmi;
 	int ret;
@@ -3628,7 +3629,7 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 	if (IS_ERR(hdmi))
 		return hdmi;
 
-	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, 0);
+	ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, flags);
 	if (ret) {
 		dw_hdmi_remove(hdmi);
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..21b141b7cb9c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -608,7 +608,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 	platform_set_drvdata(pdev, hdmi);
 
-	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data, 0);
 
 	/*
 	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 96532709c2a7..04173335f7e7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -188,7 +188,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	platform_set_drvdata(pdev, hdmi);
 
-	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
+	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data, 0);
 
 	/*
 	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 8500dd4f99d8..e789fb451ef2 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -6,6 +6,7 @@
 #ifndef __DW_HDMI__
 #define __DW_HDMI__
 
+#include <drm/drm_bridge.h>
 #include <sound/hdmi-codec.h>
 
 struct drm_display_info;
@@ -182,7 +183,8 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi);
 void dw_hdmi_unbind(struct dw_hdmi *hdmi);
 struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
-			     const struct dw_hdmi_plat_data *plat_data);
+			     const struct dw_hdmi_plat_data *plat_data,
+			     enum drm_bridge_attach_flags flags);
 
 void dw_hdmi_resume(struct dw_hdmi *hdmi);
 
-- 
2.34.1

