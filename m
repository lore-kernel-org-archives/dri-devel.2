Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2191E8538E
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 18:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FAB10E1F5;
	Fri,  3 Apr 2026 18:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="n/HSHVY6";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0EF710E1F5
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1775242462; bh=E0mkfxt+70i0sVXF+aEVWPvQZUQWrx57uJ1ok/r354g=;
 b=n/HSHVY6/T6k+5mDZFlWi0mlaG10KRSx0XSiI3OQBLmioFTlT2/3icxVBGV8U3TA+z4wNo3oO
 tjWkxgi5fSs5ssdHBJxeu7avjiLqT8f7WLXhEGIWx9Dy7aWZhUFYETtvtfDoRJ4uRrciSi8DsvY
 33XOkteO0++g6y4RPSIvKYpq0tEhk5gu5mhBtoEcatGClZCTgPg4h3CybZxMJ4/gGMiZzBJUbGe
 4KJxGrTfEBk46wo6eeOJ8+RojF8jBP8PbLinFt4tq/5aEPkl9JfjAbH/dv5dxTtzqOGp1AtvgC7
 QR4wY/MGC+s/yznKslh9zCShYMyjm0OjhjD1Jp6gKYcA==
X-Forward-Email-ID: 69d00cd7dc98192b40b89417
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.68
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] drm: bridge: dw_hdmi: Extract
 dw_hdmi_connector_status_update()
Date: Fri,  3 Apr 2026 18:52:57 +0000
Message-ID: <20260403185303.80748-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403185303.80748-1-jonas@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
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

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 30 +++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 4a0498922476..0d42fdf9a386 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2467,6 +2467,21 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
  * DRM Connector Operations
  */
 
+static void
+dw_hdmi_connector_status_update(struct drm_connector *connector,
+				enum drm_connector_status status)
+{
+	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
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
@@ -2484,20 +2499,9 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 {
-	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
-					     connector);
-	const struct drm_edid *drm_edid;
-	int ret;
+	dw_hdmi_connector_status_update(connector, connector->status);
 
-	drm_edid = dw_hdmi_edid_read(hdmi, connector);
-
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
2.53.0

