Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6A606A339
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E8110F404;
	Tue, 24 Nov 2026 09:39:36 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023108.outbound.protection.outlook.com
 [40.107.44.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5BC710F3FF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg+OAF6CP+CxyoRJFePpENxcktuoli7krKVCKAelxnP6aov/zGC4AVEINwTZ+xvSD3iek5Lxh2VcAOPfAj5xBP8A3e8LE7uPlHxN9yeq/KsO1/flKaROagR3A86+pPiAgGeTK82K1nhLc0VW3umV3O9NeLz3UC6uFZz4lq8CCl8YncvC3IRlOsHNAWSVUiyz0n1IrV8lknnm073kjwt7RoVunB7kASoP8skQ0nXX4OqEVAoFB4h1CsCoyS/CJXHZhLgm0DXPidl38x3qwerlHEkujwbnX/tpmRv9YiBmwBqr3pZxC60wt8QrJyGQ033wDR2CD27JK8K/qy+gWnZrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PS0YeE8SMRJhJumT1urXmJUui+Lz5HSvuayNaA0WeI=;
 b=QH1GZ5Woms6kbVYACU0WODT1RTv4pyaniSjcly1d6nbDO4vC4/x31nl8256O7kqAy2JtFCGyD8t5VC6kFueSEjkVK3WnzlX8mVC4BqwKvCLRAo7LHvpj4egab5MKbdc8l/fTi2ngM2zMhFcg8yNslY7xnyEERP7bnIdxeC99e8LzZfSh0Ijwv1RqPFhc72AHphBNhj5FgfSCZkif/8cp/dChHYRmqnNHBh/W/a1NjrkwwvpkjBdz5lS6IZdDFJXun38jz8yjc4u2S1YXWpYF48HZqJukC+B5KxLv1/yjl+wQ3JqtvpX8ntuQmc8qFGRGSTEAueVvbP4fcKl2EF1c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18) by
 SI4PR06MB8448.apcprd06.prod.outlook.com (2603:1096:4:299::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3; Tue, 24 Nov 2026 09:39:30 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::50) by SG2P153CA0049.outlook.office365.com
 (2603:1096:4:c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.3 via Frontend Transport; Tue, 24
 Nov 2026 09:39:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:39:29 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6935640920E5;
 Tue, 24 Nov 2026 17:39:28 +0800 (CST)
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
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] drm/bridge: tda998x: fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
Date: Tue, 24 Nov 2026 17:39:28 +0800
Message-Id: <20261124093928.3220071-5-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
References: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SI4PR06MB8448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44b43f01-999d-47c8-3562-08df4a0ed677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|23010399003|42112799006|6133799003|261009223027099003|22082099003|18002099003|261022115727099003|261022105027099003|261021133027099003|261022075727099003|261021123027099003|261022113327099003|261028144727099003|261021135927099003|261026121527099003|261026130827099003|261026135527099003|261026140227099003|261021130227099003|56012099006|261021121427099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: vyPi3wzyiEdAAdR4gvscay1tgA22FeJAv8FGQXp6tsIOMRRXH97Cy9ablIA7uw2dXUS2W/G49P/oF4AhaGSa/LkmTpkl02rC0CXBdbe/BZZsay0cbOUYfywgW9e/x1dfpa5QTfRtB5K0zda6V+XHzlZh6qTfZBpMOJUB0tm1EJZQUgY2/iDxbZXoTHWaqsSqgC7b6WHu7m7S4TiOZD6OgkVbYk3kw99OH4FHwGg+OC5tty+eZfeObymj2df/pE62i0rKbzj2m8sgLB1Pw8pjYbzo6VZUQ+o9f84ZzqTycfGS8PRctDQA275aIVm7MjLW7hPZ3YEYxMYDggcfXlXngBFaGWCOEGDEXyev5ow+pwV2I1Nqht1De48kL1H9g3K5o8B/4+rNYj3o2pgJ9vQOjWk75JpBcFOUNHHL5gYQjIRI6R7MkllsashKzYsfNMi2J86OCc/n9B0KIIte8nA46gSTYEEpy5O7pA2MNBHNlZSeC1Z4nTsi7iiWXxp99zjsSnke5XNc9L96vNm82tTsqK+dGOMrGOWtzaYh5e7guom3hhQeGDNIX4EVBzad0YEsguP1eUsWdtr3ePvwNAFtHPX0rP3crZdIy3gNnaPoFG2NOdGXpYla7fpWKn6aEdwfeEV+FXWhJlmUCr6Kfk4hovhvtnsqNSt8pnbGGCU2zKgb6VS59zuSg0xvqPgCyuFasXpmfJ3cVXz/Wcw8J+8QXQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(42112799006)(6133799003)(261009223027099003)(22082099003)(18002099003)(261022115727099003)(261022105027099003)(261021133027099003)(261022075727099003)(261021123027099003)(261022113327099003)(261028144727099003)(261021135927099003)(261026121527099003)(261026130827099003)(261026135527099003)(261026140227099003)(261021130227099003)(56012099006)(261021121427099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQ33Qqkw8OLThvnETo629fe+nHYL2DWL9CLzj4MI7NB/+hQR7uIRCsXAy7eEsJaT0KpxMZDl4qEG5gS9oiJRa9xNiRuEzfknG1ydbhGXk4pYELeNS4GWKF3R5SkYM+ggi18LrQyj8/Dh8Dfz1LXpjxFUABYX+i4syYU+V5gCOs2uC2oQNQInkMeXN+wBQnlq7WUVixfqA3ixm6gsqGAhxyDGjVvmgqdFLUJ2Lnff4P1t+LPM4tvtNlJR/v36TtavQd3P092TpcgZMEHX4vvB2MJ+PrWhSw4jlmoghs7VcpCec5+zeoxXbOlJ5AfuG8cWJWyejpoqtuoNFyP8SHhGzhLRnTNOIUEq9GRoc6O3bkivDAnbMlsoNGiObEjOuEOSHNst8vO5LfklLhU/wJda4Hvw1q+hZS2weZRDsWmZRT8FqwBeVSWOtZIFasi8LJiK
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:39:29.6200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b43f01-999d-47c8-3562-08df4a0ed677
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8448
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

