Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F455CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F2D10F128;
	Wed, 20 May 2026 18:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bOTrab0t";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5F610F119
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302321;
 bh=PEemA0WqVIoGoj8101WfnirTaDx5o3iLNMAMLvYhVdM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bOTrab0tw2qVYqDV74j15s/lk/v+liWC4KXy0cSJGeOruqzoGD3+tZpZay/2FK/sZ
 38O0BvNQOI1pZkXywV2Wczu1pIaE2MXUVHOspfvmEv/gorJMtKKXFjKQRpWdZSlv+/
 58M8pHWUpkdKNWandprIxZxRv2ZL2EtgHapaYoIpQQkICZfufGY3La1nj7JVfsHCbT
 GiZke9Ytlxxw/PjY1HbkWQtpSsCXOVxE1aWsZrbahkvOzfAmvv8wBztsYvsiR+TYY0
 vEk31trLsio6cPBYCIQTacQyL/5jfwmG6/1kORYdBpkeahbx+cNX0wRZ0NggAJyuLB
 mYCRXP6UxsGdA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 97C7B17E1544;
 Wed, 20 May 2026 20:38:41 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:25 +0300
Subject: [PATCH v6 14/22] drm/bridge: dw-hdmi-qp: Provide
 dw_hdmi_qp_hpd_notify() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-14-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.1
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

Export dw_hdmi_qp_hpd_notify() for platform drivers to report hot-plug
detection events.  Unlike drm_helper_hpd_irq_event() which polls all
connectors, this helper targets only the affected connector and ensures
.detect_ctx() is invoked on reconnection events to trigger SCDC state
recovery.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 31 ++++++++++++++++++++++++++++
 include/drm/bridge/dw_hdmi_qp.h              |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 001916a98da8..ed0c68d6c6fd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -29,6 +29,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 
 #include <media/cec.h>
 
@@ -1431,6 +1432,36 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_qp_bind);
 
+/**
+ * dw_hdmi_qp_hpd_notify() - Notify a hot-plug detection event
+ * @hdmi: pointer to the DW HDMI QP controller
+ *
+ * Platform drivers should call this from their HPD interrupt handler
+ * or work function to notify the bridge of a connection status change.
+ * The bridge's .read_hpd() phy_ops callback is used to read the current
+ * connection status.
+ */
+void dw_hdmi_qp_hpd_notify(struct dw_hdmi_qp *hdmi)
+{
+	enum drm_connector_status status;
+
+	status = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+	dev_dbg(hdmi->dev, "%s status=%d\n", __func__, status);
+
+	/*
+	 * When the display pipeline has been already active, switch to
+	 * drm_connector_helper_hpd_irq_event() to ensure .detect_ctx()
+	 * gets invoked, i.e. via drm_helper_probe_detect(), because
+	 * drm_bridge_hpd_notify() defers to a delayed hotplug path in
+	 * this case.
+	 */
+	if (hdmi->curr_conn && status == connector_status_connected)
+		drm_connector_helper_hpd_irq_event(hdmi->curr_conn);
+	else
+		drm_bridge_hpd_notify(&hdmi->bridge, status);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_qp_hpd_notify);
+
 void dw_hdmi_qp_suspend(struct device *dev, struct dw_hdmi_qp *hdmi)
 {
 	disable_irq(hdmi->main_irq);
diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi_qp.h
index b80fceffc315..b4fb1c578a5b 100644
--- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -36,6 +36,7 @@ struct dw_hdmi_qp_plat_data {
 struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 				   struct drm_encoder *encoder,
 				   const struct dw_hdmi_qp_plat_data *plat_data);
+void dw_hdmi_qp_hpd_notify(struct dw_hdmi_qp *hdmi);
 void dw_hdmi_qp_suspend(struct device *dev, struct dw_hdmi_qp *hdmi);
 void dw_hdmi_qp_resume(struct device *dev, struct dw_hdmi_qp *hdmi);
 #endif /* __DW_HDMI_QP__ */

-- 
2.53.0

