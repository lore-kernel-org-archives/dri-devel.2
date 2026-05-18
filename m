Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF32CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A42510E994;
	Mon, 18 May 2026 18:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZdTSDXmS";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0666E10E991
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779127967; bh=rHR6JQhfCZioVtWjb43UfYe+VOtInpIVxB1wWysQtG0=;
 b=ZdTSDXmSR5VcuiFSgMivU03F1YvEHrglStL/AjNSQXfhpJHKcu5hlRzNgmkPfomxxOlhEGpyR
 B5sbSAb94sPSUV8fsF6/fVwTt9MO7cjqGR3Z9GpxqZBPFdgArD1b8V3REfU7XUQE0/hr15BMnOe
 rJ16txIUblKAvVZucNaEBG4cHuVV6eOpGFSilr3EUrePZDAkuUqM9FNoQk1Dt1RQloQh10e+hS9
 mg1Z3BEsoNWj2jIx0UmfbVQvIAMKQWXE63cBa5qoh2G+gHpfI4jKvmYgb4TGFru2RhuuZtEepb0
 ATC56iUv3OvH6Me8XXwMXeAhtLeSXXOBKe/grt3lIybg==
X-Forward-Email-ID: 6a0b5436b84dbc72d2274e00
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/23] drm: bridge: dw_hdmi: Hold bridge ref until
 connector cleanup
Date: Mon, 18 May 2026 18:01:40 +0000
Message-ID: <20260518180206.2480119-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518180206.2480119-1-jonas@kwiboo.se>
References: <20260518180206.2480119-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

drmres connector cleanup typically run after devres has released the
last dw-hdmi bridge reference. Since struct dw_hdmi, where the connector
lives, is freed when the last bridge reference is released, connector
cleanup can end up accessing freed memory.

Call trace without a bridge reference held until connector cleanup:
- dw_hdmi_bridge_detach()
- dw_hdmi_bridge_destroy()      <<-- struct dw_hdmi is free()
- [drm:drm_managed_release] drmres release begin
- [drm:drm_managed_release] REL (...) drm_mode_config_init_release (0 bytes)
- dw_hdmi_connector_destroy()
  - drm_connector_cleanup()     <<-- drm_connector is use-after-free
  [...]
- [drm:drm_managed_release] drmres release end

Hold a bridge reference for as long as the connector exists and drop it
after drm_connector_cleanup() has completed to keep struct dw_hdmi alive
until connector teardown is finished and avoids the use-after-free.

Call trace with a bridge reference held until connector cleanup:
- dw_hdmi_bridge_detach()
- [drm:drm_managed_release] drmres release begin
- [drm:drm_managed_release] REL (...) drm_mode_config_init_release (0 bytes)
- dw_hdmi_connector_destroy()
  - drm_connector_cleanup()     <<-- drm_connector is destroy()
  - drm_bridge_put()
- dw_hdmi_bridge_destroy()      <<-- struct dw_hdmi is free()
  [...]
- [drm:drm_managed_release] drmres release end

Fixes: ed6987b67418 ("drm/bridge: dw-hdmi: convert to devm_drm_bridge_alloc() API")
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v7: Add fixes tag, re-order patch
v6: Collect t-b tag
v5: New patch

This use-after-free issue likely existed before commit ed6987b67418 when
devm_kzalloc() was used instead of devm_drm_bridge_alloc(). However,
v6.16-rc1 first introduced bridge refcount and drm_bridge_put(),
parts that are used to help fix the use-after-free issue.

KASAN report a slab-use-after-free in __refcount_add_not_zero when,
  echo fe0a0000.hdmi > /sys/bus/platform/drivers/dwhdmi-rockchip/unbind
on a Rockchip RK3566 device prior to this fix.
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b7bfc0e9a6b2..9d795c550f8a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2568,10 +2568,18 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 	mutex_unlock(&hdmi->mutex);
 }
 
+static void dw_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
+
+	drm_connector_cleanup(connector);
+	drm_bridge_put(&hdmi->bridge);
+}
+
 static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = dw_hdmi_connector_detect,
-	.destroy = drm_connector_cleanup,
+	.destroy = dw_hdmi_connector_destroy,
 	.force = dw_hdmi_connector_force,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -2588,6 +2596,7 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 	struct drm_connector *connector = &hdmi->connector;
 	struct cec_connector_info conn_info;
 	struct cec_notifier *notifier;
+	int ret;
 
 	if (hdmi->version >= 0x200a)
 		connector->ycbcr_420_allowed =
@@ -2600,10 +2609,14 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 
 	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
 
-	drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
-				    &dw_hdmi_connector_funcs,
-				    DRM_MODE_CONNECTOR_HDMIA,
-				    hdmi->ddc);
+	ret = drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
+					  &dw_hdmi_connector_funcs,
+					  DRM_MODE_CONNECTOR_HDMIA,
+					  hdmi->ddc);
+	if (ret)
+		return ret;
+
+	drm_bridge_get(&hdmi->bridge);
 
 	/*
 	 * drm_connector_attach_max_bpc_property() requires the
-- 
2.54.0

