Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB1BCD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 03:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D334E10E17C;
	Sat,  9 May 2026 03:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="UeDcLdLz";
	dkim-atps=neutral
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB8D10E17C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 03:32:17 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7lJhKW4xXjXUZ290xlOCUkrLRDnEo6xyiC/8DQaA1xA=;
 b=UeDcLdLzMwKSWRo6RMi1GEvE5euxGf6z9/mwksq4+EqzrYHxbZrRIAZfkh/SF/xmztC8h07/4
 RaY0CcWY1RpeVTJkDJXjjlPDvCUnHneTpeUpkKz6aJTx51AkY4lN6B2RZwz6/f8N+0FUDGTnouU
 RXuIS4fhh3lV2V7/DWRcVqs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gCBDj4LGdz1prPw;
 Sat,  9 May 2026 11:24:37 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id A57224048F;
 Sat,  9 May 2026 11:32:14 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 11:32:14 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 11:32:13 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <tzimmermann@suse.de>, <dmitry.baryshkov@oss.qualcomm.com>,
 <tiantao6@hisilicon.com>, <xinliang.liu@linaro.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <daniel@ffwll.ch>, <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <helin52@h-partners.com>,
 <shenjian15@huawei.com>, <shaojijie@huawei.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH for drm-misc-fixes v6 2/4] drm/hisilicon/hibmc: fix no showing
 when no connectors connected
Date: Sat, 9 May 2026 11:23:00 +0800
Message-ID: <20260509032302.2057227-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260509032302.2057227-1-shiyongbang@huawei.com>
References: <20260509032302.2057227-1-shiyongbang@huawei.com>
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
to ensure VGA display functionality.

* Add phys_state in the struct of dp and vdac to check physical outputs.

* The 'epoch_counter' of the vdac connector is incremented when the
physical status changes.

For get_modes: using BMC modes for connector if no display is attached to
phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes,
because KVM doesn't provide EDID reads.

The polling mechanism for the KMS helper is enabled.

Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: https://lore.kernel.org/all/0eb5c509-2724-4c57-87ad-74e4270d5a5a@suse.de/
Signed-off-by: Lin He <helin52@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v5 -> v6:
  - Rename 'phys_state' to 'phys_status'
  - Replace `drm_kms_helper_poll_init` with `drmm_kms_helper_poll_init`
    and adjust the timing of the call.
  - Split "return vdac->phys_state = state;" into separate statements.
  - Change `get_modes` to return 0 when no modes are available, allowing DRM to 
    install a default resolution.
  - Change the initial phys_status of vdac from
    'connector_status_connected' to 'connector_status_disconnected'
v4 -> v5:
  - The 'epoch_counter' of the vdac connector is incremented when the physical
    status changes.
  - The polling mechanism for the KMS helper is enabled.
v1 -> v2:
  - fix the checkpatch.pl warning "line length of 83/85 exceeds 80 columns".
  - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
    be given in public.
  - add 'drm-misc-fixes' in subject prefix.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 ++++++++----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  3 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 53 +++++++++++++------
 5 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 31316fe1ea8d..0f3662d8737e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -55,6 +55,7 @@ struct hibmc_dp {
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
 	u32 irq_status;
+	int phys_status;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 35dff7bfbf76..596c5bfe32d8 100644
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
+	dp->phys_status = ret;
+
+	return ret;
 }
 
 static int hibmc_dp_mode_valid(struct drm_connector *connector,
@@ -243,5 +254,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
+	dp->phys_status = connector_status_disconnected;
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index a0ecf82b576f..e3b40c6a6250 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_module.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_probe_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
@@ -385,6 +386,8 @@ static int hibmc_load(struct drm_device *dev)
 	/* reset all the states of crtc/plane/encoder/connector */
 	drm_mode_config_reset(dev);
 
+	drmm_kms_helper_poll_init(dev);
+
 	return 0;
 
 err:
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 4e212af6143d..dce8572bf63e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -31,6 +31,7 @@ struct hibmc_vdac {
 	struct drm_connector connector;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data bit_data;
+	int phys_status;
 };
 
 struct hibmc_drm_private {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 841e81f47b68..2fcfa3246fd1 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -24,28 +24,21 @@
 
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
+	struct drm_mode_config *mode_config = &connector->dev->mode_config;
 	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
-	const struct drm_edid *drm_edid;
 	int count;
 
-	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
-
-	drm_edid_connector_update(connector, drm_edid);
-
-	if (drm_edid) {
-		count = drm_edid_connector_add_modes(connector);
+	if (vdac->phys_status == connector_status_connected) {
+		count = drm_connector_helper_get_modes(connector);
+	} else {
+		drm_edid_connector_update(connector, NULL);
+		count = drm_add_modes_noedid(connector,
+					     mode_config->max_width,
+					     mode_config->max_height);
 		if (count)
-			goto out;
+			drm_set_preferred_mode(connector, 1024, 768);
 	}
 
-	count = drm_add_modes_noedid(connector,
-				     connector->dev->mode_config.max_width,
-				     connector->dev->mode_config.max_height);
-	drm_set_preferred_mode(connector, 1024, 768);
-
-out:
-	drm_edid_free(drm_edid);
-
 	return count;
 }
 
@@ -57,10 +50,34 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
+static int hibmc_vdac_detect(struct drm_connector *connector,
+			     struct drm_modeset_acquire_ctx *ctx,
+			     bool force)
+{
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
+	int status = drm_connector_helper_detect_from_ddc(connector, ctx,
+							 force);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
+
+	if (priv->dp.phys_status == connector_status_connected) {
+		vdac->phys_status = status;
+		return status;
+	}
+
+	if (status != vdac->phys_status)
+		++connector->epoch_counter;
+	vdac->phys_status = status;
+
+	/* When both the DP and VDAC physical status are disconnected,
+	 * the "connected" status is returned to support KVM display.
+	 */
+	return connector_status_connected;
+}
+
 static const struct drm_connector_helper_funcs
 	hibmc_connector_helper_funcs = {
 	.get_modes = hibmc_connector_get_modes,
-	.detect_ctx = drm_connector_helper_detect_from_ddc,
+	.detect_ctx = hibmc_vdac_detect,
 };
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
@@ -130,6 +147,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
+	vdac->phys_status = connector_status_disconnected;
+
 	return 0;
 
 err:
-- 
2.33.0

