Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC155CD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 18:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C3610E5C7;
	Sat, 16 May 2026 18:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dORoxLGY";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114B810E53D
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778956785; bh=+D1KqkLN/SPso9FLi8QFUtB2wuHbBS99Pzq1qlbp+tg=;
 b=dORoxLGYr+OELDbRM7tN7Jy32QG3K5YGRg4ldurNh5//9CeSmi7MbWlOfE0xTLKlvaBBbIcec
 CVB7X7fn20FmXvb9PvddFd/Qq7zY39m1ZuoD4Z4IBt8hTWIab5QhYzw0n9S8v4czJ1Tno/B8lZK
 eIMp2zye3ZyRJ/fNFulBNjX4phO0TB7c3Sk+O/JzdVjcfjej8vCcXRVOGJeKY/ISnGygKkeSc2o
 Du9f+sNdRVkzCMtTuzRJtAxC/StMNTJm0S9PjEEcL6pbwkZy3ByAtxlb1O7nsZA1rRPsbaZ2ULC
 6gW2DmIWfWZlIcl3ggQz9pGJOLUmn7GX1dR9yBa9Wezg==
X-Forward-Email-ID: 6a08b9e379c7625f20eeee36
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
 Simona Vetter <simona@ffwll.ch>
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
Subject: [PATCH v6 11/22] drm: bridge: dw_hdmi: Extract
 dw_hdmi_connector_status_update()
Date: Sat, 16 May 2026 18:38:21 +0000
Message-ID: <20260516183838.2024991-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516183838.2024991-1-jonas@kwiboo.se>
References: <20260516183838.2024991-1-jonas@kwiboo.se>
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

Move connector EDID update and CEC phys addr handling to a helper
function as a preparation before moving EDID refresh from get_modes
funcs to detect/force funcs.

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v6: Pass struct dw_hdmi as a parameter, to allow calls from bridge funcs,
    Collect t-b tag
v5: No change
v4: Collect r-b tag
v3: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 27 ++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0dd4c823c60a..a056e147731b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2466,6 +2466,21 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
  * DRM Connector Operations
  */
 
+static void
+dw_hdmi_connector_status_update(struct dw_hdmi *hdmi,
+				struct drm_connector *connector,
+				enum drm_connector_status status)
+{
+	const struct drm_edid *drm_edid;
+
+	drm_edid = dw_hdmi_edid_read(hdmi, connector);
+	drm_edid_connector_update(connector, drm_edid);
+	drm_edid_free(drm_edid);
+
+	cec_notifier_set_phys_addr(hdmi->cec_notifier,
+				   connector->display_info.source_physical_address);
+}
+
 static enum drm_connector_status
 dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -2485,18 +2500,10 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
-	const struct drm_edid *drm_edid;
-	int ret;
 
-	drm_edid = dw_hdmi_edid_read(hdmi, connector);
+	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
 
-	drm_edid_connector_update(connector, drm_edid);
-	cec_notifier_set_phys_addr(hdmi->cec_notifier,
-				   connector->display_info.source_physical_address);
-	ret = drm_edid_connector_add_modes(connector);
-	drm_edid_free(drm_edid);
-
-	return ret;
+	return drm_edid_connector_add_modes(connector);
 }
 
 static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,
-- 
2.54.0

