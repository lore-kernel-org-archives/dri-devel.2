Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF99606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tPEGoxpE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079C610EB3C;
	Mon, 26 Oct 2026 06:12:09 +0000 (UTC)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD3710EB3C
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:12:02 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ApIuSlFepZUuOgTuigPxe4t896l5OtGOGqcHWTrHr64=;
 b=tPEGoxpEo1z+VrhFp7MVHkHTKfmCB7/it+0p/Lt9wJ8cscwsCAJkcFR6kGXfhz0y8nW+b3Jdg
 hqkMXISjFwyHqcadjjDeRtNvN4stShvWSMf+Hsky9KPf14eTBPb8wQ/8hqL92NQowqASK5gxwOX
 D24cAdOqpLhNzfKH4UYIg9U=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jCjvD3zzqzRhRs;
 Mon, 26 Oct 2026 14:11:52 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (unknown [7.202.194.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CE1084056D;
 Mon, 26 Oct 2026 14:11:59 +0800 (CST)
Received: from localhost.huawei.com (10.169.64.31) by
 kwepemk200005.china.huawei.com (7.202.194.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 26 Oct 2026 14:11:59 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <shuliubin@huawei.com>,
 <chenjianmin@huawei.com>, <fengsheng5@huawei.com>, <shiyongbang@huawei.com>,
 <helin52@h-partners.com>, <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v4 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
Date: Mon, 26 Oct 2026 14:03:02 +0800
Message-ID: <20261026060303.289737-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026060303.289737-1-shiyongbang@huawei.com>
References: <20261026060303.289737-1-shiyongbang@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200005.china.huawei.com (7.202.194.71)
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
v3 -> v4:
  - Fix the data race on hpd_status between hardirq and process
    contexts with WRITE_ONCE()/READ_ONCE(). (sashiko-bot)
  - Delete the HPD_IN early return in encoder_enable that breaks KMS
    forced modesets. (sashiko-bot)
v2 -> v3:
  - Delete irq_status and use hpd_status directly for hotplug
    detection. (sashiko-bot)
  - Add debug logs when hpd_status is not HPD_IN in detect and
    encoder_enable.
v1 -> v2:
  - More states in HIBMC_DP_HPD_STATUS are added to the
    'hibmc_dp_get_hpd_status'.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 -
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 32 ++++++++++++-------
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  5 +--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 29 +++++++++--------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  3 +-
 5 files changed, 41 insertions(+), 29 deletions(-)

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
index d5bd3c45649b..a4cd4cd8cc75 100644
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
+	int hpd_status = HIBMC_HPD_UNKNOWN;
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
+		hpd_status = HIBMC_HPD_OUT;
+		break;
+	case 1: /* plug */
+	case 2: /* plug intermediate */
+		hpd_status = HIBMC_HPD_IN;
+		break;
+	default:
+		break;
 	}
 
-	dp->dp_dev->hpd_status = exp_status;
-
-	return true;
+	return hpd_status;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 0f3662d8737e..959bf95f6fe5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -15,6 +15,7 @@
 struct hibmc_dp_dev;
 
 enum hibmc_hpd_status {
+	HIBMC_HPD_UNKNOWN,
 	HIBMC_HPD_OUT,
 	HIBMC_HPD_IN,
 };
@@ -54,7 +55,7 @@ struct hibmc_dp {
 	void __iomem *mmio;
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
-	u32 irq_status;
+	int hpd_status;
 	int phys_status;
 };
 
@@ -66,7 +67,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
 void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
 void hibmc_dp_enable_int(struct hibmc_dp *dp);
 void hibmc_dp_disable_int(struct hibmc_dp *dp);
-bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status);
+int hibmc_dp_get_hpd_status(struct hibmc_dp *dp);
 u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
 u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 7bf6befa0440..65dd042de71d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -14,8 +14,6 @@
 #include "dp/dp_comm.h"
 #include "dp/dp_config.h"
 
-#define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
-
 static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 {
 	const struct drm_edid *drm_edid;
@@ -60,13 +58,13 @@ static int hibmc_dp_detect(struct drm_connector *connector,
 {
 	struct hibmc_dp *dp = to_hibmc_dp(connector);
 	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+	int hpd_status = READ_ONCE(dp->hpd_status);
 	int ret = connector_status_disconnected;
 
-	if (dp->irq_status) {
-		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
-			ret = connector_status_disconnected;
-			goto exit;
-		}
+	if (hpd_status != HIBMC_HPD_IN) {
+		drm_dbg_dp(dp->drm_dev, "dp detect skipped, hpd (%d)\n",
+			   hpd_status);
+		goto exit;
 	}
 
 	if (!hibmc_dp_get_dpcd(dp_dev)) {
@@ -188,24 +186,26 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
-	int idx, exp_status;
+	int status = READ_ONCE(priv->dp.hpd_status);
+	int idx;
 
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
-	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
+	if (status == HIBMC_HPD_IN) {
 		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
 		hibmc_dp_hpd_cfg(&priv->dp);
-		exp_status = HIBMC_HPD_IN;
-	} else {
+	} else if (status == HIBMC_HPD_OUT) {
 		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
 		hibmc_dp_reset_link(&priv->dp);
-		exp_status = HIBMC_HPD_OUT;
+	} else {
+		drm_err(&priv->dev, "HPD status (%d) error\n", status);
+		goto exit;
 	}
 
-	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
-		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
+	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
 
+exit:
 	drm_dev_exit(idx);
 
 	return IRQ_HANDLED;
@@ -222,6 +222,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	dp->mmio = priv->mmio;
 	dp->drm_dev = dev;
+	dp->hpd_status = HIBMC_HPD_OUT;
 
 	ret = hibmc_dp_hw_init(&priv->dp);
 	if (ret) {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 602930964e93..df4501bb076b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -63,7 +63,8 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
 
 	status = readl(priv->mmio + HIBMC_DP_INTSTAT);
 	if (status) {
-		priv->dp.irq_status = status;
+		WRITE_ONCE(priv->dp.hpd_status,
+			   hibmc_dp_get_hpd_status(&priv->dp));
 		writel(status, priv->mmio + HIBMC_DP_INTCLR);
 		return IRQ_WAKE_THREAD;
 	}
-- 
2.33.0

