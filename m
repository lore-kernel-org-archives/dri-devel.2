Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C465F8A14A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB6710E870;
	Thu, 16 Apr 2026 09:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="Qzrm7kjj";
	dkim-atps=neutral
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B322E10E86B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:14:31 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=OZTBTKcnwyTAEV4BlINvIip8mO/Xv2gyjCHQ7cOFYbg=;
 b=Qzrm7kjjloHcVKivEpr51VquIGwJqNi3UzAhA+e0yHdDsWA0TZ9o3it1POY26vdYefJTTPRYQ
 kjHcr/1niyadgeM8S1MPCicVK0iMnqUE7LrvYWsZP/trFsDwRHTHb24gMlRpIcEgMI8V2f4gfsv
 4WTnub/annZXCHn6dUiyw54=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fxBxm0pRFznTX7;
 Thu, 16 Apr 2026 17:08:12 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 81E4A40561;
 Thu, 16 Apr 2026 17:14:29 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:14:29 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:14:28 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v3 2/4] drm/hisilicon/hibmc: fix no showing
 when no connectors connected
Date: Thu, 16 Apr 2026 17:05:40 +0800
Message-ID: <20260416090542.1984002-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260416090542.1984002-1-shiyongbang@huawei.com>
References: <20260416090542.1984002-1-shiyongbang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.71.169]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Our chip support KVM over IP feature, so hibmc driver need to support
displaying without any connectors plugged in. If no connectors are
connected, the vdac connector status should be set to 'connected' to
ensure proper KVM display functionality. Additionally, for
previous-generation products that may lack hardware link support and
thus cannot detect the monitor, the same approach should be applied
to ensure VGA display functionality. Add phys_state in the struct of
dp and vdac to check all physical outputs.

For get_modes: using BMC modes for connector if no display is attached to
phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes,
because KVM doesn't provide EDID reads.

Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: https://lore.kernel.org/all/0eb5c509-2724-4c57-87ad-74e4270d5a5a@suse.de/
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v1 -> v2:
  - fix the checkpatch.pl warning "line length of 83/85 exceeds 80 columns".
  - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
    be given in public.
  - add 'drm-misc-fixes' in subject prefix.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 +++++++++-----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 45 +++++++++++++------
 4 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 31316fe1ea8d..dfaeabd05d46 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -55,6 +55,7 @@ struct hibmc_dp {
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
+	int phys_state;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 35dff7bfbf76..8fe2eb51a0b3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -61,27 +61,38 @@ static int hibmc_dp_detect(struct drm_connector *connector,
 {
 	struct hibmc_dp *dp = to_hibmc_dp(connector);
 	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
-	int ret;
+	int ret = connector_status_disconnected;
 
 	if (dp->irq_status) {
-		if (dp_dev->hpd_status != HIBMC_HPD_IN)
-			return connector_status_disconnected;
+		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
+			ret = connector_status_disconnected;
+			goto exit;
+		}
 	}
 
-	if (!hibmc_dp_get_dpcd(dp_dev))
-		return connector_status_disconnected;
+	if (!hibmc_dp_get_dpcd(dp_dev)) {
+		ret = connector_status_disconnected;
+		goto exit;
+	}
 
-	if (!dp_dev->is_branch)
-		return connector_status_connected;
+	if (!dp_dev->is_branch) {
+		ret = connector_status_connected;
+		goto exit;
+	}
 
 	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
 	    dp_dev->downstream_ports[0] & DP_DS_PORT_HPD) {
 		ret = drm_dp_read_sink_count(dp_dev->aux);
-		if (ret > 0)
-			return connector_status_connected;
+		if (ret > 0) {
+			ret = connector_status_connected;
+			goto exit;
+		}
 	}
 
-	return connector_status_disconnected;
+exit:
+	dp->phys_state = ret;
+
+	return ret;
 }
 
 static int hibmc_dp_mode_valid(struct drm_connector *connector,
@@ -243,5 +254,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
+	dp->phys_state = connector_status_disconnected;
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index ca8502e2760c..6abb49b5107b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -31,6 +31,7 @@ struct hibmc_vdac {
 	struct drm_connector connector;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data bit_data;
+	int phys_state;
 };
 
 struct hibmc_drm_private {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 841e81f47b68..806d54120d89 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -25,27 +25,20 @@
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
 	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
-	const struct drm_edid *drm_edid;
-	int count;
+	int count = 0;
 
-	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
+	if (vdac->phys_state == connector_status_connected)
+		count = drm_connector_helper_get_modes(connector);
 
-	drm_edid_connector_update(connector, drm_edid);
-
-	if (drm_edid) {
-		count = drm_edid_connector_add_modes(connector);
-		if (count)
-			goto out;
-	}
+	if (count > 0)
+		return count;
 
+	drm_edid_connector_update(connector, NULL);
 	count = drm_add_modes_noedid(connector,
 				     connector->dev->mode_config.max_width,
 				     connector->dev->mode_config.max_height);
 	drm_set_preferred_mode(connector, 1024, 768);
 
-out:
-	drm_edid_free(drm_edid);
-
 	return count;
 }
 
@@ -57,10 +50,32 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
+static int hibmc_vdac_detect(struct drm_connector *connector,
+			     struct drm_modeset_acquire_ctx *ctx,
+			     bool force)
+{
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
+
+	vdac->phys_state = drm_connector_helper_detect_from_ddc(connector,
+								ctx, force);
+
+	/* If the DP connectors are disconnected, the hibmc_vdac_detect function
+	 * must return a connected state to ensure KVM display functionality.
+	 * Additionally, for previous-generation products that may lack hardware
+	 * link support and thus cannot detect the monitor, hibmc_vdac_detect
+	 * should also return a connected state.
+	 */
+	if (priv->dp.phys_state != connector_status_connected)
+		return connector_status_connected;
+
+	return vdac->phys_state;
+}
+
 static const struct drm_connector_helper_funcs
 	hibmc_connector_helper_funcs = {
 	.get_modes = hibmc_connector_get_modes,
-	.detect_ctx = drm_connector_helper_detect_from_ddc,
+	.detect_ctx = hibmc_vdac_detect,
 };
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
@@ -130,6 +145,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
+	vdac->phys_state = connector_status_connected;
+
 	return 0;
 
 err:
-- 
2.33.0

