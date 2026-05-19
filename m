Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640FFCD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE50D10EC31;
	Tue, 19 May 2026 10:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0BJG74P8";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1156C10EC37
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:39:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0001C1A3629;
 Tue, 19 May 2026 10:39:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C76C5606E9;
 Tue, 19 May 2026 10:39:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 42623107E8AE1; 
 Tue, 19 May 2026 12:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6Kk3lX1KY2eCXTfU74I0d1YFIDad5SvyHhY6xeby2Ic=;
 b=0BJG74P8irxrxeCnn5GOnqAWLhMGDQVe6vG7n63qU1pEiN7UR0UmCFb2VTINBi2J7TRZTZ
 1YApi9oLLO49DS0foJg2OE/FoVj7do1CjRhNZT/2WSw2w502HYI0WkWmPeRTsGe/8mA3Lk
 FI804bTOFZ/lwjWhROxJgevPsDYlGL//w37jyhwlOOS8V6eaMprZSg/aoWyly6kyqBgpOa
 WsmyazIpFEexM8gUjet5k3hHPsnXxmsF1s4VRakpqvm+00kfDXIlO3UmmqtOD1F70QqB0a
 BAI7bZ8z27S7IGz5BD2e3GKaoRf4WVwQjZvi49Je3RemFQNGldevHrL+4z8hSQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:33 +0200
Subject: [PATCH 16/37] drm/display: bridge-connector: move per-connector
 fields to the dynamic connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-16-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

The various bridge pointers and the hdmi_funcs pointer are per-connector
specific. In other words, when introducing bridge hotplug and the
dynamically-created connector, they will have to be set per each created
connector, possibly with different values from any previously created
connector.

Those pointers are currently in struct drm_bridge_connector, which will
persist across multiple connector creations and destructions. This means
when a dynamic connector is created before the previous one is destroyed,
these fields would be overwritten by the new connector but the old one will
still reference them. This would lead to possible put of incorrect briges,
resulting in use-after-free and leaks.

In preparation for bridge hotplug, move all those fields from struct
drm_bridge_connector to struct drm_bridge_connector_dynconn, so they have
the same allocation and lifetime of the connector they refer to.

Update the many locations where these fields are used.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 370 +++++++++++++------------
 1 file changed, 187 insertions(+), 183 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index b4e2c8f1d32d..bd421b6beb7c 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -67,26 +67,6 @@ struct drm_bridge_connector_dynconn {
 	 * @connector: the drm_connector exposed to user space
 	 */
 	struct drm_connector connector;
-};
-
-/**
- * struct drm_bridge_connector - A connector backed by a chain of bridges
- */
-struct drm_bridge_connector {
-	/**
-	 * @drm: The DRM device we belong to
-	 */
-	struct drm_device *drm;
-	/**
-	 * @encoder:
-	 *
-	 * The encoder at the start of the bridges chain.
-	 */
-	struct drm_encoder *encoder;
-	/**
-	 * @dynconn: The DRM connector added by the drm_bridge_connector
-	 */
-	struct drm_bridge_connector_dynconn *dynconn;
 	/**
 	 * @bridge_edid:
 	 *
@@ -154,24 +134,47 @@ struct drm_bridge_connector {
 	struct drm_connector_hdmi_funcs hdmi_funcs;
 };
 
-static struct drm_bridge_connector *to_drm_bridge_connector(const struct drm_connector *connector)
+/**
+ * struct drm_bridge_connector - A connector backed by a chain of bridges
+ */
+struct drm_bridge_connector {
+	/**
+	 * @drm: The DRM device we belong to
+	 */
+	struct drm_device *drm;
+	/**
+	 * @encoder:
+	 *
+	 * The encoder at the start of the bridges chain.
+	 */
+	struct drm_encoder *encoder;
+	/**
+	 * @dynconn: The DRM connector added by the drm_bridge_connector
+	 */
+	struct drm_bridge_connector_dynconn *dynconn;
+};
+
+static struct drm_bridge_connector_dynconn *
+to_drm_bridge_connector_dynconn(const struct drm_connector *connector)
 {
-	const struct drm_bridge_connector_dynconn *dynconn =
-		container_of(connector, struct drm_bridge_connector_dynconn, connector);
+	return container_of(connector, struct drm_bridge_connector_dynconn, connector);
+}
 
-	return dynconn->bridge_connector;
+static struct drm_bridge_connector *to_drm_bridge_connector(const struct drm_connector *connector)
+{
+	return to_drm_bridge_connector_dynconn(connector)->bridge_connector;
 }
 
-static void drm_bridge_connector_put_bridges(struct drm_bridge_connector *bridge_connector)
+static void drm_bridge_connector_put_bridges(struct drm_bridge_connector_dynconn *dynconn)
 {
-	drm_bridge_put(bridge_connector->bridge_edid);
-	drm_bridge_put(bridge_connector->bridge_hpd);
-	drm_bridge_put(bridge_connector->bridge_detect);
-	drm_bridge_put(bridge_connector->bridge_modes);
-	drm_bridge_put(bridge_connector->bridge_hdmi);
-	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
-	drm_bridge_put(bridge_connector->bridge_dp_audio);
-	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+	drm_bridge_put(dynconn->bridge_edid);
+	drm_bridge_put(dynconn->bridge_hpd);
+	drm_bridge_put(dynconn->bridge_detect);
+	drm_bridge_put(dynconn->bridge_modes);
+	drm_bridge_put(dynconn->bridge_hdmi);
+	drm_bridge_put(dynconn->bridge_hdmi_audio);
+	drm_bridge_put(dynconn->bridge_dp_audio);
+	drm_bridge_put(dynconn->bridge_hdmi_cec);
 }
 
 /* -----------------------------------------------------------------------------
@@ -225,7 +228,9 @@ static void drm_bridge_connector_enable_hpd(struct drm_connector *connector)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
-	struct drm_bridge *hpd = bridge_connector->bridge_hpd;
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
+	struct drm_bridge *hpd = dynconn->bridge_hpd;
 
 	if (hpd)
 		drm_bridge_hpd_enable(hpd, drm_bridge_connector_hpd_cb,
@@ -234,9 +239,9 @@ static void drm_bridge_connector_enable_hpd(struct drm_connector *connector)
 
 static void drm_bridge_connector_disable_hpd(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-	struct drm_bridge *hpd = bridge_connector->bridge_hpd;
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
+	struct drm_bridge *hpd = dynconn->bridge_hpd;
 
 	if (hpd)
 		drm_bridge_hpd_disable(hpd);
@@ -249,10 +254,10 @@ static void drm_bridge_connector_disable_hpd(struct drm_connector *connector)
 static enum drm_connector_status
 drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-	struct drm_bridge *detect = bridge_connector->bridge_detect;
-	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
+	struct drm_bridge *detect = dynconn->bridge_detect;
+	struct drm_bridge *hdmi = dynconn->bridge_hdmi;
 	enum drm_connector_status status;
 
 	if (detect) {
@@ -281,9 +286,9 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 
 static void drm_bridge_connector_force(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
+	struct drm_bridge *hdmi = dynconn->bridge_hdmi;
 
 	if (hdmi)
 		drm_atomic_helper_connector_hdmi_force(connector);
@@ -305,11 +310,11 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 
 static void drm_bridge_connector_reset(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 
 	drm_atomic_helper_connector_reset(connector);
-	if (bridge_connector->bridge_hdmi)
+	if (dynconn->bridge_hdmi)
 		__drm_atomic_helper_connector_hdmi_reset(connector,
 							 connector->state);
 }
@@ -320,7 +325,7 @@ static void drm_bridge_connector_dynconn_destroy(struct drm_connector *connector
 		container_of(connector, struct drm_bridge_connector_dynconn, connector);
 
 	drm_connector_cleanup(connector);
-	drm_bridge_connector_put_bridges(dynconn->bridge_connector);
+	drm_bridge_connector_put_bridges(dynconn);
 	kfree(dynconn);
 }
 
@@ -370,15 +375,15 @@ static int drm_bridge_connector_get_modes_edid(struct drm_connector *connector,
 
 static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
 	/*
 	 * If there is a HDMI bridge, EDID has been updated as a part of
 	 * the .detect(). Just update the modes here.
 	 */
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (bridge)
 		return drm_edid_connector_add_modes(connector);
 
@@ -386,7 +391,7 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 	 * If display exposes EDID, then we parse that in the normal way to
 	 * build table of supported modes.
 	 */
-	bridge = bridge_connector->bridge_edid;
+	bridge = dynconn->bridge_edid;
 	if (bridge)
 		return drm_bridge_connector_get_modes_edid(connector, bridge);
 
@@ -394,7 +399,7 @@ static int drm_bridge_connector_get_modes(struct drm_connector *connector)
 	 * Otherwise if the display pipeline reports modes (e.g. with a fixed
 	 * resolution panel or an analog TV output), query it.
 	 */
-	bridge = bridge_connector->bridge_modes;
+	bridge = dynconn->bridge_modes;
 	if (bridge)
 		return bridge->funcs->get_modes(bridge, connector);
 
@@ -410,10 +415,10 @@ static enum drm_mode_status
 drm_bridge_connector_mode_valid(struct drm_connector *connector,
 				const struct drm_display_mode *mode)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 
-	if (bridge_connector->bridge_hdmi)
+	if (dynconn->bridge_hdmi)
 		return drm_hdmi_connector_mode_valid(connector, mode);
 
 	return MODE_OK;
@@ -422,10 +427,10 @@ drm_bridge_connector_mode_valid(struct drm_connector *connector,
 static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 					     struct drm_atomic_commit *state)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 
-	if (bridge_connector->bridge_hdmi)
+	if (dynconn->bridge_hdmi)
 		return drm_atomic_helper_connector_hdmi_check(connector, state);
 
 	return 0;
@@ -444,11 +449,11 @@ drm_bridge_connector_tmds_char_rate_valid(const struct drm_connector *connector,
 					  const struct drm_display_mode *mode,
 					  unsigned long long tmds_rate)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return MODE_ERROR;
 
@@ -460,11 +465,11 @@ drm_bridge_connector_tmds_char_rate_valid(const struct drm_connector *connector,
 
 static int drm_bridge_connector_clear_avi_infoframe(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -474,11 +479,11 @@ static int drm_bridge_connector_clear_avi_infoframe(struct drm_connector *connec
 static int drm_bridge_connector_write_avi_infoframe(struct drm_connector *connector,
 						    const u8 *buffer, size_t len)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -487,11 +492,11 @@ static int drm_bridge_connector_write_avi_infoframe(struct drm_connector *connec
 
 static int drm_bridge_connector_clear_hdmi_infoframe(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -501,11 +506,11 @@ static int drm_bridge_connector_clear_hdmi_infoframe(struct drm_connector *conne
 static int drm_bridge_connector_write_hdmi_infoframe(struct drm_connector *connector,
 						     const u8 *buffer, size_t len)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -514,11 +519,11 @@ static int drm_bridge_connector_write_hdmi_infoframe(struct drm_connector *conne
 
 static int drm_bridge_connector_clear_audio_infoframe(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -528,11 +533,11 @@ static int drm_bridge_connector_clear_audio_infoframe(struct drm_connector *conn
 static int drm_bridge_connector_write_audio_infoframe(struct drm_connector *connector,
 						      const u8 *buffer, size_t len)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -541,11 +546,11 @@ static int drm_bridge_connector_write_audio_infoframe(struct drm_connector *conn
 
 static int drm_bridge_connector_clear_hdr_drm_infoframe(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -555,11 +560,11 @@ static int drm_bridge_connector_clear_hdr_drm_infoframe(struct drm_connector *co
 static int drm_bridge_connector_write_hdr_drm_infoframe(struct drm_connector *connector,
 							const u8 *buffer, size_t len)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -568,11 +573,11 @@ static int drm_bridge_connector_write_hdr_drm_infoframe(struct drm_connector *co
 
 static int drm_bridge_connector_clear_spd_infoframe(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -582,11 +587,11 @@ static int drm_bridge_connector_clear_spd_infoframe(struct drm_connector *connec
 static int drm_bridge_connector_write_spd_infoframe(struct drm_connector *connector,
 						    const u8 *buffer, size_t len)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi;
+	bridge = dynconn->bridge_hdmi;
 	if (!bridge)
 		return -EINVAL;
 
@@ -596,11 +601,11 @@ static int drm_bridge_connector_write_spd_infoframe(struct drm_connector *connec
 static const struct drm_edid *
 drm_bridge_connector_read_edid(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_edid;
+	bridge = dynconn->bridge_edid;
 	if (!bridge)
 		return NULL;
 
@@ -638,12 +643,12 @@ static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_spd_
 
 static int drm_bridge_connector_audio_startup(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	if (bridge_connector->bridge_hdmi_audio) {
-		bridge = bridge_connector->bridge_hdmi_audio;
+	if (dynconn->bridge_hdmi_audio) {
+		bridge = dynconn->bridge_hdmi_audio;
 
 		if (!bridge->funcs->hdmi_audio_startup)
 			return 0;
@@ -651,8 +656,8 @@ static int drm_bridge_connector_audio_startup(struct drm_connector *connector)
 		return bridge->funcs->hdmi_audio_startup(bridge, connector);
 	}
 
-	if (bridge_connector->bridge_dp_audio) {
-		bridge = bridge_connector->bridge_dp_audio;
+	if (dynconn->bridge_dp_audio) {
+		bridge = dynconn->bridge_dp_audio;
 
 		if (!bridge->funcs->dp_audio_startup)
 			return 0;
@@ -667,18 +672,18 @@ static int drm_bridge_connector_audio_prepare(struct drm_connector *connector,
 					      struct hdmi_codec_daifmt *fmt,
 					      struct hdmi_codec_params *hparms)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	if (bridge_connector->bridge_hdmi_audio) {
-		bridge = bridge_connector->bridge_hdmi_audio;
+	if (dynconn->bridge_hdmi_audio) {
+		bridge = dynconn->bridge_hdmi_audio;
 
 		return bridge->funcs->hdmi_audio_prepare(bridge, connector, fmt, hparms);
 	}
 
-	if (bridge_connector->bridge_dp_audio) {
-		bridge = bridge_connector->bridge_dp_audio;
+	if (dynconn->bridge_dp_audio) {
+		bridge = dynconn->bridge_dp_audio;
 
 		return bridge->funcs->dp_audio_prepare(bridge, connector, fmt, hparms);
 	}
@@ -688,17 +693,17 @@ static int drm_bridge_connector_audio_prepare(struct drm_connector *connector,
 
 static void drm_bridge_connector_audio_shutdown(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	if (bridge_connector->bridge_hdmi_audio) {
-		bridge = bridge_connector->bridge_hdmi_audio;
+	if (dynconn->bridge_hdmi_audio) {
+		bridge = dynconn->bridge_hdmi_audio;
 		bridge->funcs->hdmi_audio_shutdown(bridge, connector);
 	}
 
-	if (bridge_connector->bridge_dp_audio) {
-		bridge = bridge_connector->bridge_dp_audio;
+	if (dynconn->bridge_dp_audio) {
+		bridge = dynconn->bridge_dp_audio;
 		bridge->funcs->dp_audio_shutdown(bridge, connector);
 	}
 }
@@ -706,12 +711,12 @@ static void drm_bridge_connector_audio_shutdown(struct drm_connector *connector)
 static int drm_bridge_connector_audio_mute_stream(struct drm_connector *connector,
 						  bool enable, int direction)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	if (bridge_connector->bridge_hdmi_audio) {
-		bridge = bridge_connector->bridge_hdmi_audio;
+	if (dynconn->bridge_hdmi_audio) {
+		bridge = dynconn->bridge_hdmi_audio;
 
 		if (!bridge->funcs->hdmi_audio_mute_stream)
 			return -ENOTSUPP;
@@ -720,8 +725,8 @@ static int drm_bridge_connector_audio_mute_stream(struct drm_connector *connecto
 							     enable, direction);
 	}
 
-	if (bridge_connector->bridge_dp_audio) {
-		bridge = bridge_connector->bridge_dp_audio;
+	if (dynconn->bridge_dp_audio) {
+		bridge = dynconn->bridge_dp_audio;
 
 		if (!bridge->funcs->dp_audio_mute_stream)
 			return -ENOTSUPP;
@@ -742,22 +747,22 @@ static const struct drm_connector_hdmi_audio_funcs drm_bridge_connector_hdmi_aud
 
 static int drm_bridge_connector_hdmi_cec_enable(struct drm_connector *connector, bool enable)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi_cec;
+	bridge = dynconn->bridge_hdmi_cec;
 
 	return bridge->funcs->hdmi_cec_enable(bridge, enable);
 }
 
 static int drm_bridge_connector_hdmi_cec_log_addr(struct drm_connector *connector, u8 logical_addr)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi_cec;
+	bridge = dynconn->bridge_hdmi_cec;
 
 	return bridge->funcs->hdmi_cec_log_addr(bridge, logical_addr);
 }
@@ -767,11 +772,11 @@ static int drm_bridge_connector_hdmi_cec_transmit(struct drm_connector *connecto
 						  u32 signal_free_time,
 						  struct cec_msg *msg)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi_cec;
+	bridge = dynconn->bridge_hdmi_cec;
 
 	return bridge->funcs->hdmi_cec_transmit(bridge, attempts,
 						signal_free_time,
@@ -780,11 +785,11 @@ static int drm_bridge_connector_hdmi_cec_transmit(struct drm_connector *connecto
 
 static int drm_bridge_connector_hdmi_cec_init(struct drm_connector *connector)
 {
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
+	struct drm_bridge_connector_dynconn *dynconn =
+		to_drm_bridge_connector_dynconn(connector);
 	struct drm_bridge *bridge;
 
-	bridge = bridge_connector->bridge_hdmi_cec;
+	bridge = dynconn->bridge_hdmi_cec;
 
 	if (!bridge->funcs->hdmi_cec_init)
 		return 0;
@@ -821,7 +826,6 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 					    struct drm_bridge **panel_bridge,
 					    bool *support_hdcp)
 {
-	struct drm_bridge_connector *bridge_connector = dynconn->bridge_connector;
 	struct drm_connector *connector = &dynconn->connector;
 
 	/*
@@ -831,7 +835,7 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 	connector->ycbcr_420_allowed = true;
 	*connector_type = DRM_MODE_CONNECTOR_Unknown;
 
-	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
+	drm_for_each_bridge_in_chain_scoped(dynconn->bridge_connector->encoder, bridge) {
 		if (!bridge->interlace_allowed)
 			connector->interlace_allowed = false;
 		if (!bridge->ycbcr_420_allowed)
@@ -841,26 +845,26 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 		 * Ensure the last bridge declares OP_EDID or OP_MODES or both.
 		 */
 		if (bridge->ops & DRM_BRIDGE_OP_EDID || bridge->ops & DRM_BRIDGE_OP_MODES) {
-			drm_bridge_put(bridge_connector->bridge_edid);
-			bridge_connector->bridge_edid = NULL;
-			drm_bridge_put(bridge_connector->bridge_modes);
-			bridge_connector->bridge_modes = NULL;
+			drm_bridge_put(dynconn->bridge_edid);
+			dynconn->bridge_edid = NULL;
+			drm_bridge_put(dynconn->bridge_modes);
+			dynconn->bridge_modes = NULL;
 
 			if (bridge->ops & DRM_BRIDGE_OP_EDID)
-				bridge_connector->bridge_edid = drm_bridge_get(bridge);
+				dynconn->bridge_edid = drm_bridge_get(bridge);
 			if (bridge->ops & DRM_BRIDGE_OP_MODES)
-				bridge_connector->bridge_modes = drm_bridge_get(bridge);
+				dynconn->bridge_modes = drm_bridge_get(bridge);
 		}
 		if (bridge->ops & DRM_BRIDGE_OP_HPD) {
-			drm_bridge_put(bridge_connector->bridge_hpd);
-			bridge_connector->bridge_hpd = drm_bridge_get(bridge);
+			drm_bridge_put(dynconn->bridge_hpd);
+			dynconn->bridge_hpd = drm_bridge_get(bridge);
 		}
 		if (bridge->ops & DRM_BRIDGE_OP_DETECT) {
-			drm_bridge_put(bridge_connector->bridge_detect);
-			bridge_connector->bridge_detect = drm_bridge_get(bridge);
+			drm_bridge_put(dynconn->bridge_detect);
+			dynconn->bridge_detect = drm_bridge_get(bridge);
 		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
-			if (bridge_connector->bridge_hdmi)
+			if (dynconn->bridge_hdmi)
 				return -EBUSY;
 			if (!bridge->funcs->hdmi_write_avi_infoframe ||
 			    !bridge->funcs->hdmi_clear_avi_infoframe ||
@@ -883,7 +887,7 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 			     !bridge->funcs->hdmi_clear_spd_infoframe))
 				return -EINVAL;
 
-			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
+			dynconn->bridge_hdmi = drm_bridge_get(bridge);
 
 			if (bridge->supported_formats)
 				*supported_formats = bridge->supported_formats;
@@ -892,10 +896,10 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
-			if (bridge_connector->bridge_hdmi_audio)
+			if (dynconn->bridge_hdmi_audio)
 				return -EBUSY;
 
-			if (bridge_connector->bridge_dp_audio)
+			if (dynconn->bridge_dp_audio)
 				return -EBUSY;
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -906,14 +910,14 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 			    !bridge->funcs->hdmi_audio_shutdown)
 				return -EINVAL;
 
-			bridge_connector->bridge_hdmi_audio = drm_bridge_get(bridge);
+			dynconn->bridge_hdmi_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_DP_AUDIO) {
-			if (bridge_connector->bridge_dp_audio)
+			if (dynconn->bridge_dp_audio)
 				return -EBUSY;
 
-			if (bridge_connector->bridge_hdmi_audio)
+			if (dynconn->bridge_hdmi_audio)
 				return -EBUSY;
 
 			if (!bridge->hdmi_audio_max_i2s_playback_channels &&
@@ -924,21 +928,21 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 			    !bridge->funcs->dp_audio_shutdown)
 				return -EINVAL;
 
-			bridge_connector->bridge_dp_audio = drm_bridge_get(bridge);
+			dynconn->bridge_dp_audio = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-			if (bridge_connector->bridge_hdmi_cec)
+			if (dynconn->bridge_hdmi_cec)
 				return -EBUSY;
 
-			bridge_connector->bridge_hdmi_cec = drm_bridge_get(bridge);
+			dynconn->bridge_hdmi_cec = drm_bridge_get(bridge);
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-			if (bridge_connector->bridge_hdmi_cec)
+			if (dynconn->bridge_hdmi_cec)
 				return -EBUSY;
 
-			bridge_connector->bridge_hdmi_cec = drm_bridge_get(bridge);
+			dynconn->bridge_hdmi_cec = drm_bridge_get(bridge);
 
 			if (!bridge->funcs->hdmi_cec_enable ||
 			    !bridge->funcs->hdmi_cec_log_addr ||
@@ -972,20 +976,20 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector_dynconn
 	return 0;
 }
 
-static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_connector)
+static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector_dynconn *dynconn)
 {
-	struct drm_connector *connector = &bridge_connector->dynconn->connector;
+	struct drm_connector *connector = &dynconn->connector;
 	int ret;
 
-	if (bridge_connector->bridge_hdmi_audio ||
-	    bridge_connector->bridge_dp_audio) {
+	if (dynconn->bridge_hdmi_audio ||
+	    dynconn->bridge_dp_audio) {
 		struct device *dev;
 		struct drm_bridge *bridge;
 
-		if (bridge_connector->bridge_hdmi_audio)
-			bridge = bridge_connector->bridge_hdmi_audio;
+		if (dynconn->bridge_hdmi_audio)
+			bridge = dynconn->bridge_hdmi_audio;
 		else
-			bridge = bridge_connector->bridge_dp_audio;
+			bridge = dynconn->bridge_dp_audio;
 
 		dev = bridge->hdmi_audio_dev;
 
@@ -999,9 +1003,9 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
 			return ret;
 	}
 
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+	if (dynconn->bridge_hdmi_cec &&
+	    dynconn->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER) {
+		struct drm_bridge *bridge = dynconn->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_notifier_register(connector, NULL,
 								bridge->hdmi_cec_dev);
@@ -1009,9 +1013,9 @@ static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector
 			return ret;
 	}
 
-	if (bridge_connector->bridge_hdmi_cec &&
-	    bridge_connector->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
-		struct drm_bridge *bridge = bridge_connector->bridge_hdmi_cec;
+	if (dynconn->bridge_hdmi_cec &&
+	    dynconn->bridge_hdmi_cec->ops & DRM_BRIDGE_OP_HDMI_CEC_ADAPTER) {
+		struct drm_bridge *bridge = dynconn->bridge_hdmi_cec;
 
 		ret = drmm_connector_hdmi_cec_register(connector,
 						       &drm_bridge_connector_hdmi_cec_funcs,
@@ -1061,29 +1065,29 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 		return ret;
 	}
 
-	if (bridge_connector->bridge_hdmi) {
+	if (dynconn->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
 			supported_formats &= ~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 
-		bridge_connector->hdmi_funcs = drm_bridge_connector_hdmi_funcs;
+		dynconn->hdmi_funcs = drm_bridge_connector_hdmi_funcs;
 
-		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_AUDIO)
-			bridge_connector->hdmi_funcs.audio =
+		if (dynconn->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_AUDIO)
+			dynconn->hdmi_funcs.audio =
 				drm_bridge_connector_hdmi_audio_infoframe;
 
-		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME)
-			bridge_connector->hdmi_funcs.hdr_drm =
+		if (dynconn->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME)
+			dynconn->hdmi_funcs.hdr_drm =
 				drm_bridge_connector_hdmi_hdr_drm_infoframe;
 
-		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME)
-			bridge_connector->hdmi_funcs.spd =
+		if (dynconn->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME)
+			dynconn->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
 		ret = drm_connector_hdmi_dynamic_init(bridge_connector->drm, connector,
-						      bridge_connector->bridge_hdmi->vendor,
-						      bridge_connector->bridge_hdmi->product,
+						      dynconn->bridge_hdmi->vendor,
+						      dynconn->bridge_hdmi->product,
 						      &drm_bridge_connector_funcs,
-						      &bridge_connector->hdmi_funcs,
+						      &dynconn->hdmi_funcs,
 						      connector_type, ddc,
 						      supported_formats,
 						      max_bpc);
@@ -1093,7 +1097,7 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 						 connector_type, ddc);
 	}
 	if (ret) {
-		drm_bridge_connector_put_bridges(dynconn->bridge_connector);
+		drm_bridge_connector_put_bridges(dynconn);
 		kfree(dynconn);
 		return ret;
 	}
@@ -1104,15 +1108,15 @@ static int drm_bridge_connector_add_connector(struct drm_bridge_connector *bridg
 
 	drm_bridge_connector_reset(connector);
 
-	ret = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
+	ret = drm_bridge_connector_init_hdmi_audio_cec(dynconn);
 	if (ret)
 		goto err_put;
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 
-	if (bridge_connector->bridge_hpd)
+	if (dynconn->bridge_hpd)
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
-	else if (bridge_connector->bridge_detect)
+	else if (dynconn->bridge_detect)
 		connector->polled = DRM_CONNECTOR_POLL_CONNECT
 				  | DRM_CONNECTOR_POLL_DISCONNECT;
 

-- 
2.54.0

