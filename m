Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E4AC4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F1510E33F;
	Tue, 21 Jul 2026 12:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="G8SjaOBa";
	dkim-atps=neutral
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D9C10E33F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:53:59 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=fYw3POhAXYqr/Iwv+AX1BKOL3bCwbDJzR2L11+7RLYY=;
 b=G8SjaOBaPMEXOYTv/u/SRq54bytD+OEXpy9nTQtTqdG/3N/qd76AFBhtRLpzlXf16jleognrd
 gx+ZMUzRzgxB9zdoq+XxGvgCAZ+C119nEXGyR/kdFHGeKJVqe8iGTyFvYtqn+fh9j/tszxj9y6l
 gch8WN1/z2x2447Em/pYKZo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h4HC847VGz1T4Hh;
 Tue, 21 Jul 2026 20:44:36 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id EBF3D40561;
 Tue, 21 Jul 2026 20:53:55 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 20:53:55 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 20:53:55 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
Date: Tue, 21 Jul 2026 20:43:23 +0800
Message-ID: <20260721124324.1885856-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721124324.1885856-1-shiyongbang@huawei.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

From: Lin He <helin52@huawei.com>

To more accurately determine whether the current HPD status matches the
interrupt status, the polling mechanism in the lower half of the HPD
interrupt (via hibmc_dp_check_hpd_status) has been replaced with directly
retrieving the interrupt status in the upper half of the interrupt (via
hibmc_dp_get_hpd_status).

* Detection and training are not performed if hpd_status is not HPD_IN.

* Set the initial status of hpd_status to HPD_OUT.

Fixes: 3906e7a3b26d ("drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq")
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v1 -> v2:
  - More states in HIBMC_DP_HPD_STATUS are added to the
    'hibmc_dp_get_hpd_status'.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 -
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 32 ++++++++++++-------
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  4 ++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 29 ++++++++++-------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  1 +
 5 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index f53dac256ee0..b0e258b9265e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -43,7 +43,6 @@ struct hibmc_dp_dev {
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 	struct drm_dp_desc desc;
 	bool is_branch;
-	int hpd_status;
 	void __iomem *serdes_base;
 };
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index d5bd3c45649b..c9a113a1937d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -191,6 +191,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
 	/* clock enable */
 	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
+	/* To latch the HPD interrupt, ensuring that DP can support more modes
+	 * within the fbcon framework when connected alone.
+	 */
+	msleep(100);
 
 	return 0;
 }
@@ -322,20 +326,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
 	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
 }
 
-bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
+int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
 {
+	int ret = HIBMC_HPD_UNKNOWN;
 	u32 status;
-	int ret;
 
-	ret = readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
-				 FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) == exp_status,
-				 1000, 100000); /* DP spec says 100ms */
-	if (ret) {
-		drm_dbg_dp(dp->drm_dev, "wait hpd status timeout");
-		return false;
+	status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE,
+			   readl(dp->dp_dev->base + HIBMC_DP_HPD_STATUS));
+	switch (status) {
+	case 0: /* idle */
+	case 3: /* unplug */
+	case 4: /* unplug intermediate */
+		ret = HIBMC_HPD_OUT;
+		break;
+	case 1: /* plug */
+	case 2: /* plug intermediate */
+		ret = HIBMC_HPD_IN;
+		break;
+	default:
+		break;
 	}
 
-	dp->dp_dev->hpd_status = exp_status;
-
-	return true;
+	return ret;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 0f3662d8737e..bcd4e9d155c8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -15,6 +15,7 @@
 struct hibmc_dp_dev;
 
 enum hibmc_hpd_status {
+	HIBMC_HPD_UNKNOWN,
 	HIBMC_HPD_OUT,
 	HIBMC_HPD_IN,
 };
@@ -55,6 +56,7 @@ struct hibmc_dp {
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
+	int hpd_status;
 	int phys_status;
 };
 
@@ -66,7 +68,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
 void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
 void hibmc_dp_enable_int(struct hibmc_dp *dp);
 void hibmc_dp_disable_int(struct hibmc_dp *dp);
-bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
+int hibmc_dp_get_hpd_status(struct hibmc_dp *dp);
 u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
 u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 2e9403b8bf3c..23716d48149f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -63,12 +63,8 @@ static int hibmc_dp_detect(struct drm_connector *connector,
 	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
 	int ret = connector_status_disconnected;
 
-	if (dp->irq_status) {
-		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
-			ret = connector_status_disconnected;
-			goto exit;
-		}
-	}
+	if (dp->hpd_status != HIBMC_HPD_IN)
+		goto exit;
 
 	if (!hibmc_dp_get_dpcd(dp_dev)) {
 		ret = connector_status_disconnected;
@@ -166,6 +162,9 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
 	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
 	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
 
+	if (dp->hpd_status != HIBMC_HPD_IN)
+		return;
+
 	if (hibmc_dp_prepare(dp, mode))
 		return;
 
@@ -189,24 +188,31 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
-	int idx, exp_status;
+	int status = priv->dp.hpd_status;
+	int idx;
 
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
 	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
 		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
+		if (status != HIBMC_HPD_IN) {
+			drm_err(&priv->dev, "HPD status (%d) error", status);
+			goto exit;
+		}
 		hibmc_dp_hpd_cfg(&priv->dp);
-		exp_status = HIBMC_HPD_IN;
 	} else {
 		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
+		if (status != HIBMC_HPD_OUT) {
+			drm_err(&priv->dev, "HPD status (%d) error", status);
+			goto exit;
+		}
 		hibmc_dp_reset_link(&priv->dp);
-		exp_status = HIBMC_HPD_OUT;
 	}
 
-	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
-		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
+	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
+exit:
 	drm_dev_exit(idx);
 
 	return IRQ_HANDLED;
@@ -223,6 +229,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	dp->mmio = priv->mmio;
 	dp->drm_dev = dev;
+	dp->hpd_status = HIBMC_HPD_OUT;
 
 	ret = hibmc_dp_hw_init(&priv->dp);
 	if (ret) {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 4d85c89f3f88..e5cca7b63b78 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -63,6 +63,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
 	status = readl(priv->mmio + HIBMC_DP_INTSTAT);
 	if (status) {
 		priv->dp.irq_status = status;
+		priv->dp.hpd_status = hibmc_dp_get_hpd_status(&priv->dp);
 		writel(status, priv->mmio + HIBMC_DP_INTCLR);
 		return IRQ_WAKE_THREAD;
 	}
-- 
2.43.0

