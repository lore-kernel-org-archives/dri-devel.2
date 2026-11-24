Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A6606A69B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA86D10F414;
	Tue, 24 Nov 2026 09:41:34 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023142.outbound.protection.outlook.com [52.101.127.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776C210F402
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w07ddV/tR0hC1FfNVSziAiPoY8omles3L/7nSNRo5tWcfgypvGa0KRBskwaLBEr91PNJo3ZpcqT7F+E8nsRRdyNBTeIam9S3RDWW7GS96uKl3wJcfZSpNWACbrizRUkfIa65bdu5dOzkA4Egdn26GWyOcj1T1jQ546KLErGQ4ho31vgV8XR4UEB1OHn6cyG2FGkhoaF1w6rv8iwQ6exi4kaGlSlMz9+iycmD4b2uiIbfj8CILgg4wVCYks2zRV36PW3HtwnaOhj9waPswjNFP/4U0Qssir5UWDzigeXTjVxi+o0OvF0hLKwQdKjqmAzEoI5QawUw5boecoZ7VngYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PS0YeE8SMRJhJumT1urXmJUui+Lz5HSvuayNaA0WeI=;
 b=G9Tqysgaq2SoXsxGuiEA6z35KpI08a5xDSWQu5ZUo4nyN2+WECNKCdocQVnpm476bxWt3brQORrEnu7IjlWPr0F3vrHr9pYQMUYCQQ8tZ1qjTCTG3PGtXxHtQ8VeZgCSf+6iptf1AXwZFvqMLxMVpWHlsMcavskDHxxPCwtJJywvDuZ4rAYsbc23tg3h7q/Ukzm/wG/73RpveArE7SDwBePfu72pPe8VMIdkkywWHWiqw2dtwD0DTVHMuPwLsBX3vuOaPm/KuTiK+ybXfm9Y2lnJ6ATqqipXDJsY+NFZEn3pLvKgOUyTdrFDGs9mSB6WX+QMjp+e7TxE33d0OS919g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0186.jpnprd01.prod.outlook.com (2603:1096:400:2b0::9)
 by TYSPR06MB7344.apcprd06.prod.outlook.com (2603:1096:405:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:41:22 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:2b0:cafe::9d) by TYCPR01CA0186.outlook.office365.com
 (2603:1096:400:2b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 09:41:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:41:21 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5010D40920E5;
 Tue, 24 Nov 2026 17:41:20 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org
Cc: Ayan Halder <Ayan.Halder@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 Wuyi.Shen@cixtech.com
Subject: [PATCH v3 4/4] drm/bridge: tda998x: fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
Date: Tue, 24 Nov 2026 17:41:19 +0800
Message-Id: <20261124094119.3220267-5-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
References: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|TYSPR06MB7344:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6323816a-b182-4656-0283-08df4a0f193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|42112799006|36860700016|23010399003|376014|7416014|18002099003|6133799003|261009223027099003|22082099003|261021123027099003|56012099006|261102123227099003|261022113327099003|261022115727099003|261021133027099003|261021121427099003|261022105027099003|261026135527099003|261028144727099003|261026130827099003|261021130227099003|261021135927099003|261022075727099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: vN4uWkbGZRKk4HcET/M5wW2XMmiwgsN8C4KC8L8FU8WlAlI1LDZiQKQo5wdBa3g91u0RXL1sIL8kfqhuMWtWT7G4grmKID8JoRGUguAF2yyy92yYkesq7yzhbfAxrRo7M4TgmEaAy1lriO/wU4vbPBEj/krgQYc16KiyHMXoCNcIZjIpSUl9aP033PoEQWBU32SwmsteQWCnUPxROlAv8YaEfbdiEqMiGJ5yH+LlAYx2CMJufQsa+uGP84gOzfUgZc04sY/QaTu/Hvh/xVclg6oNUyxoz5yFJPd1/rOIbIvGMCBEoWyuuLlRVtlZbRyQTIwhVFcHzVs5X/qeq62qJgqV0Q3Xckf4Ht8Xx1wckPkzs7FT0q7NmYmjVOgA/7mJcxYUkEksegBQ8UBfLmf5RxBr8FAQwJqJWaPa7HoWkBQjwyb3pmMcI3a5LzQGYeeOwiR1F+Y/gC9Wk5lPsm1okELs77ApRm2OdoU9g1QNGdvYGSAX01r8nfkVggs67ZVP13F3GippzLRhCNXvUmbG/OfSE1kH3vipwLTfk5cC8fXWq5PulSIMdabgZpleX3vnMTKEPG1ei0sHVC0XBhHnDfm84EAZKcgdZzEqd35+jCJ4YE4rq10aYEXEgAQ1Z2Ti3ISNbgO5GmSfZnQyqHFqmIIa4dP1b1s6dTwBm82OqE9yD/A+GNpvMkpggpNWHk3QBHnprrE2rSYqb8yRDhNheA==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(42112799006)(36860700016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(261009223027099003)(22082099003)(261021123027099003)(56012099006)(261102123227099003)(261022113327099003)(261022115727099003)(261021133027099003)(261021121427099003)(261022105027099003)(261026135527099003)(261028144727099003)(261026130827099003)(261021130227099003)(261021135927099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EKf95eLOVNQy/7SqT4zPEwgpcxw+yJi2H0cnTeoM1s07F5Fq3BKzY5LWcxxyLhBPY0NmjtyiHt64WVJxVA941nQyv/+joMei0EhNmSw02iBI6V5GKfTjw5HZUvAgNu7d3gqiC53uM4AVtCGc4f1qfnLdcmusdj1MBs2k3Leg7/R/uSQ9SYy00EVUAp+HdH44JxUpIZTJTRG6PzQdL7cMhJKj+79uncyOykrEqX6lLWT9JNkgoVQteIs5VKln0I4eTwieUFg4LgGni8dHWDK98jG6rXjutZqT8jDjuK3t6l3jtF6WzZd5u9mW1NPbTdIDI1jiKFRPfBjw/emLDRYJnUjiEhGPlzjwQcJ04s11YHMqlZPYmUWdkQb4dbqkuyNFkuECVg8CxNEeT+lvkf4W3x9CFfTXlqKSAOsBc6Ota2vlBcYgIY9v0etxhss2qZPa
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:41:21.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6323816a-b182-4656-0283-08df4a0f193c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7344
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, the connector is
created by drm_bridge_connector_init() and the driver's own connector
is never initialised. Several paths still access that connector:

- tda998x_bridge_mode_set() reads display_info from it to decide the
  RGB quantization range and whether infoframes and audio are
  supported. As it stays zeroed, the bridge always operates in DVI
  mode.

- tda998x_audio_get_eld() copies the ELD from it, which is always
  empty.

- tda998x_detect_work() uses its drm_device to send hotplug events,
  which never happens because the connector was never registered.

Use the connector passed to the bridge detect and EDID read operations
instead of the driver's own connector whenever one was provided, and
report hotplug events through drm_bridge_hpd_notify(). Also advertise
interlaced mode support through the bridge, otherwise the bridge
connector rejects them.

Fixes: c76a8be4feec ("drm/bridge: tda998x: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 64 +++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 0b966c9844e7..40379d74a53a 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -81,6 +81,7 @@ struct tda998x_priv {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
 	struct drm_connector connector;
+	struct drm_connector *bridge_connector;
 
 	u8 audio_port_enable[AUDIO_ROUTE_NUM];
 	struct tda9950_glue cec_glue;
@@ -95,6 +96,19 @@ struct tda998x_priv {
 #define bridge_to_tda998x_priv(x) \
 	container_of(x, struct tda998x_priv, bridge)
 
+/*
+ * When attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR, the connector is created
+ * by drm_bridge_connector_init() and handed to the bridge detect and EDID
+ * operations; otherwise it is the driver's own connector.
+ */
+static struct drm_connector *tda998x_get_connector(struct tda998x_priv *priv)
+{
+	if (priv->bridge_connector)
+		return priv->bridge_connector;
+
+	return &priv->connector;
+}
+
 /* The TDA9988 series of devices use a paged register scheme.. to simplify
  * things we encode the page # in upper bits of the register #.  To read/
  * write a given register, we need to make sure CURPAGE register is set
@@ -769,6 +783,14 @@ static int tda998x_edid_delay_wait(struct tda998x_priv *priv)
 	return wait_event_killable(priv->edid_delay_waitq, !priv->edid_delay_active);
 }
 
+static enum drm_connector_status tda998x_conn_detect(struct tda998x_priv *priv)
+{
+	u8 val = cec_read(priv, REG_CEC_RXSHPDLEV);
+
+	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
+			connector_status_disconnected;
+}
+
 /*
  * We need to run the KMS hotplug event helper outside of our threaded
  * interrupt routine as this can call back into our get_modes method,
@@ -778,10 +800,11 @@ static void tda998x_detect_work(struct work_struct *work)
 {
 	struct tda998x_priv *priv =
 		container_of(work, struct tda998x_priv, detect_work);
-	struct drm_device *dev = priv->connector.dev;
 
-	if (dev)
-		drm_kms_helper_hotplug_event(dev);
+	if (priv->bridge_connector)
+		drm_bridge_hpd_notify(&priv->bridge, tda998x_conn_detect(priv));
+	else if (priv->connector.dev)
+		drm_kms_helper_hotplug_event(priv->connector.dev);
 }
 
 /*
@@ -859,12 +882,12 @@ static void tda998x_write_aif(struct tda998x_priv *priv,
 static void
 tda998x_write_avi(struct tda998x_priv *priv, const struct drm_display_mode *mode)
 {
+	struct drm_connector *connector = tda998x_get_connector(priv);
 	union hdmi_infoframe frame;
 
-	drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
-						 &priv->connector, mode);
+	drm_hdmi_avi_infoframe_from_display_mode(&frame.avi, connector, mode);
 	frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_FULL;
-	drm_hdmi_avi_infoframe_quant_range(&frame.avi, &priv->connector, mode,
+	drm_hdmi_avi_infoframe_quant_range(&frame.avi, connector, mode,
 					   priv->rgb_quant_range);
 
 	tda998x_write_if(priv, DIP_IF_FLAGS_IF2, REG_IF2_HB0, &frame);
@@ -873,10 +896,11 @@ tda998x_write_avi(struct tda998x_priv *priv, const struct drm_display_mode *mode
 static void tda998x_write_vsi(struct tda998x_priv *priv,
 			      const struct drm_display_mode *mode)
 {
+	struct drm_connector *connector = tda998x_get_connector(priv);
 	union hdmi_infoframe frame;
 
 	if (drm_hdmi_vendor_infoframe_from_display_mode(&frame.vendor.hdmi,
-							&priv->connector,
+							connector,
 							mode))
 		reg_clear(priv, REG_DIP_IF_FLAGS, DIP_IF_FLAGS_IF1);
 	else
@@ -1152,10 +1176,10 @@ static int tda998x_audio_get_eld(struct device *dev, void *data,
 				 uint8_t *buf, size_t len)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct drm_connector *connector = tda998x_get_connector(priv);
 
 	mutex_lock(&priv->audio_mutex);
-	memcpy(buf, priv->connector.eld,
-	       min(sizeof(priv->connector.eld), len));
+	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
 	mutex_unlock(&priv->audio_mutex);
 
 	return 0;
@@ -1193,14 +1217,6 @@ static int tda998x_audio_codec_init(struct tda998x_priv *priv,
 
 /* DRM connector functions */
 
-static enum drm_connector_status tda998x_conn_detect(struct tda998x_priv *priv)
-{
-	u8 val = cec_read(priv, REG_CEC_RXSHPDLEV);
-
-	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
-			connector_status_disconnected;
-}
-
 static enum drm_connector_status
 tda998x_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -1390,6 +1406,8 @@ static void tda998x_bridge_detach(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
+	priv->bridge_connector = NULL;
+
 	if (priv->connector.dev)
 		drm_connector_cleanup(&priv->connector);
 }
@@ -1449,6 +1467,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 				    const struct drm_display_mode *adjusted_mode)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	struct drm_connector *connector = tda998x_get_connector(priv);
 	unsigned long tmds_clock;
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
@@ -1465,7 +1484,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 	 * it, otherwise reduce to limited-range.
 	 */
 	priv->rgb_quant_range =
-		priv->connector.display_info.rgb_quant_range_selectable ?
+		connector->display_info.rgb_quant_range_selectable ?
 		HDMI_QUANTIZATION_RANGE_FULL :
 		drm_default_rgb_quant_range(adjusted_mode);
 
@@ -1674,7 +1693,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 	 * ignore CEA version 2 and below (iow, behave as if we're a
 	 * CEA-861 source.)
 	 */
-	priv->supports_infoframes = priv->connector.display_info.cea_rev >= 3;
+	priv->supports_infoframes = connector->display_info.cea_rev >= 3;
 
 	if (priv->supports_infoframes) {
 		/* We need to turn HDMI HDCP stuff on to get audio through */
@@ -1701,6 +1720,9 @@ tda998x_bridge_edid_read(struct drm_bridge *bridge,
 	const struct drm_edid *drm_edid;
 	const struct edid *edid;
 
+	if (connector)
+		priv->bridge_connector = connector;
+
 	drm_edid = tda998x_edid_read(priv, connector);
 	if (!drm_edid) {
 		dev_dbg(&priv->hdmi->dev, "failed to get edid\n");
@@ -1729,6 +1751,9 @@ tda998x_bridge_detect(struct drm_bridge *bridge,
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
 
+	if (connector)
+		priv->bridge_connector = connector;
+
 	return tda998x_conn_detect(priv);
 }
 
@@ -2011,6 +2036,7 @@ tda998x_probe(struct i2c_client *client)
 
 	priv->bridge.ops |= DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
 	priv->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	priv->bridge.interlace_allowed = true;
 	drm_bridge_add(&priv->bridge);
 
 	return 0;
-- 
2.25.1

