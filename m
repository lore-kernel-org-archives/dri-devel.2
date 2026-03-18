Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D48103E197
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBBE10E01F;
	Wed, 18 Mar 2026 15:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mt9OZb5C";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDCA10E01F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBZjJQKgZanNoW5XH4/Ac3qCCv5DiZj6ww0Vyv5JSzdvW6rMdu0EDR2GcxVAtxU/WdfGuMtcBQSivpcs8Y/PBSUhXJCkKP9beGoC6FYQSan2+yh3oeBI5dXdNTPoqObqnYyKCA1pmliN6g3CZ7WjzihiBiVSqVMFaMefJ/JkBtiAI7qu18cL1d1WyCGVxcCAnoG4He+gQV9QcgEgNtWHDttsgPBSELki4/0dIpWsSgUsTwlp9m8jvKsvXvD6HQa5cpI+RJcEDUVetqPnqz3UwAZPqOslnANTEsG0xvZGWK1FhrZj/zHFv7VK91NfsQzUv0/Uh0SUZINo2cWhdLC4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVu1mjMBmFRhPoz+hOSqxmcf0A77cYCO60WrC8SqQ98=;
 b=l2vJB/yN/yAJpKJuuykzgtGEt1d/HzkEWFWSmImAOGNlKgt5G4wnvYl0hBiewDVtMof2SiUScpxmTUAt7VX7fMwuoX4F3ji+evAZq47MzsqMpBBJGO5bZClL79jJvQT54W2HEzuZ4vFRdc72dYYt0C4EZnjrd8h/0SKtK+yJQELyzrDcXSilLTlwyaTDdXYVWvqiK8U+OdSeNdZzbvp1y0QLG1V8EdF1J4RXd5HnvUMkEJnd/3K8O45cX3ed5JABIvdYVYUyRXOv6fglAEz+RRoIuicoUDeNxWKgiLal0lHUNZFeTxSzesQreeWufalYqd8eiF+3/bx6wtr0bTYVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVu1mjMBmFRhPoz+hOSqxmcf0A77cYCO60WrC8SqQ98=;
 b=Mt9OZb5CRUkDDak6FIw8kFig1KikGmPZDh9c/Gvidt61V7Q3u4AJqDYQwxhIzQrq0v9DCKSTZSZT4hX6vuuEYkxsq3zN4wBnJfTItVhuFwkCeSou4UdUANbSsw1F8KQGGyUcICNQcmKLFkbA7ABLg6HDq48GyR6GbvW0uR4UO9g=
Received: from SA0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:130::26)
 by DS7PR10MB5104.namprd10.prod.outlook.com (2603:10b6:5:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:46:59 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::17) by SA0PR13CA0021.outlook.office365.com
 (2603:10b6:806:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 15:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 15:46:57 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:46:44 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 10:46:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 10:46:43 -0500
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.81.246])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IFkhtB1080677;
 Wed, 18 Mar 2026 10:46:43 -0500
From: Sen Wang <sen@ti.com>
To: <ple@baylibre.com>, <neil.armstrong@linaro.org>,
 <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <j-sahu@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Sen Wang <sen@ti.com>
Subject: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio Helper
Date: Wed, 18 Mar 2026 10:46:36 -0500
Message-ID: <20260318154636.3230454-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS7PR10MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4649cc-c141-4681-ae76-08de85059672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mngR5q2qcqVZFNU3M6Yv/FnNa1/YK8sFHSddZjtHfXXT37kiF+ofO4VVHAXdPwOasbeva4VPrMo1sMGvEHf+jeO25Hqb8hmqC6DWpQtMn+gSp0Xb4iZ3tpD+mKltDbbaCl/dxUzQTRnRgKjKl85o1hawnU9IrF3xjHOi08yvWJoPfVUIfvNrymxk9+40Hp6dDITx4o1cQRqQFtOJ1T3l6d4UpTzcl4g3AUuV9uMbtpksiotmHnW27EKofTJtoBa48oY+ZBRNDoHc/Zq7a5NRmQA7lQEo9GjRaQ3PNNKudKPLvNjFo03YRBo6M6RVJJ0gcJg3pcLN+o4Nl3OCwHRQL/9YOlZPQasZe9PlfyNUjgaNnZovfAB3yW2DZBUIJOOVAZ/PeRGFyqGxePnHuo4HTOJTlHD4eDpjV5XSJFO6dfWwbvLtTmn5IyAaJ9elH3uhWO0t23HKi4WFs7PxGjfI6Vasr8AA9gqt8PrtP2FLSA04aYw3xN39zqilxUfPeB6KFzMPQbb1AzuBrq9SiRynWb64VPGwva4SiB8WUA+/LPXhlZ98+1rXMZ7GvTqVDFlVDL6xsApeAD6LEy7NpRqrdZuzQNU1myWnuvjevhKkVzQi3skx+GlEqnWsX8Sc7KVuXWSXXcXHtcTEmdWB/J3I+MXkYhKVf/Om4ym3uswAbDUI3atupUaRYz+t8gEdrMgfXwmmq3AqJ95EiDxUUnmjGtL4gTmlkUE231ENynZPjFFONA6LfR3+tGZEE52HJolqxigEf3RzPwKNL32Ry25huw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uobsc72rYk7UHzWb0AkpyIna6P93fUtD1kXCIIbfHxLk0RbiwalMjEuGC2/ibThTkJk98X+gRGO7A5cEXldwx9PWp9TXyfh7Ps2rNzmqoYVjZmXJWj8D990XWTxv7ZifMyyzotM7ZzSBP7bqxGMos5ZpOq18BuB5PjZFaGh9n7D74nxKV347nScwFAkwOsInoF8TgtD3vuYsUOFhM3nMh5sQ+k5sB/D3lwrXxyNtubsH2FwCIaHn4dCWs9varYYHP7ZAwiXy8YtGVMUQoymRF6Ko0IhGDCZi0R0A/MfpJeWjUBxPE0J8upDFpYoVFfQ8VJ7voe7OH99Tj3qjVhq2MP/p9pQfTsXTvlCV7wXNvD57izEn9gfkzekSQE9kTf3LoKe8s6FGEONDqjmwVcRdqENJ33vLkboxa2Ii9oNrz1D/v2KVCbGGtoDvLhLFqaaG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:46:57.7914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4649cc-c141-4681-ae76-08de85059672
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5104
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

Convert the IT66121 HDMI bridge driver from manually registering an
hdmi-codec platform device to using the DRM HDMI Audio Helper framework
via DRM_BRIDGE_OP_HDMI_AUDIO instead.

The previous implementation manually allocated hdmi_codec_pdata,
registered the platform device, and implemented hdmi_codec_ops callbacks
including get_eld. The new approach sets DRM_BRIDGE_OP_HDMI_AUDIO on the
bridge, letting the framework handle the codec registration. This also
resolves some non-compliance issues with the current audio implementation,
such as HDMI audio advertising a non-functional capture stream to userspace.

The audio callbacks are converted from hdmi_codec_ops signatures to
drm_bridge_funcs hdmi_audio callbacks:
  - it66121_audio_hw_params   -> it66121_hdmi_audio_prepare
  - it66121_audio_startup     -> it66121_hdmi_audio_startup
  - it66121_audio_shutdown    -> it66121_hdmi_audio_shutdown
  - it66121_audio_mute        -> it66121_hdmi_audio_mute_stream

The it66121_audio_get_eld, it66121_audio_codec_ops, and
it66121_audio_codec_init functions are removed as the framework handles
these responsibilities.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sen Wang <sen@ti.com>
---
Tested in beagleplay ensuring HDMI/ HDMI audio works correctly with
the new implementation, including proper ELD data and audio.

Changelog:

 v1 -> v2: Retained no audio registered dev_info warning.


 drivers/gpu/drm/bridge/ite-it66121.c | 135 ++++++++++-----------------
 1 file changed, 48 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 9246e9c15a6e..6ac90315b822 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -306,7 +306,6 @@ struct it66121_ctx {
 	struct mutex lock; /* Protects fields below and device registers */
 	struct hdmi_avi_infoframe hdmi_avi_infoframe;
 	struct {
-		struct platform_device *pdev;
 		u8 ch_enable;
 		u8 fs;
 		u8 swl;
@@ -902,24 +901,6 @@ static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge *bridge
 	return drm_edid;
 }
 
-static const struct drm_bridge_funcs it66121_bridge_funcs = {
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
-	.attach = it66121_bridge_attach,
-	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
-	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
-	.atomic_enable = it66121_bridge_enable,
-	.atomic_disable = it66121_bridge_disable,
-	.atomic_check = it66121_bridge_check,
-	.mode_set = it66121_bridge_mode_set,
-	.mode_valid = it66121_bridge_mode_valid,
-	.detect = it66121_bridge_detect,
-	.edid_read = it66121_bridge_edid_read,
-	.hpd_enable = it66121_bridge_hpd_enable,
-	.hpd_disable = it66121_bridge_hpd_disable,
-};
-
 static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
 {
 	int ret;
@@ -1225,14 +1206,16 @@ static int it661221_audio_ch_enable(struct it66121_ctx *ctx, bool enable)
 	return ret;
 }
 
-static int it66121_audio_hw_params(struct device *dev, void *data,
-				   struct hdmi_codec_daifmt *daifmt,
-				   struct hdmi_codec_params *params)
+static int it66121_hdmi_audio_prepare(struct drm_bridge *bridge,
+				      struct drm_connector *connector,
+				      struct hdmi_codec_daifmt *daifmt,
+				      struct hdmi_codec_params *params)
 {
 	u8 fs;
 	u8 swl;
 	int ret;
-	struct it66121_ctx *ctx = dev_get_drvdata(dev);
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
+	struct device *dev = ctx->dev;
 	static u8 iec60958_chstat[5];
 	unsigned int channels = params->channels;
 	unsigned int sample_rate = params->sample_rate;
@@ -1379,41 +1362,44 @@ static int it66121_audio_hw_params(struct device *dev, void *data,
 	return ret;
 }
 
-static int it66121_audio_startup(struct device *dev, void *data)
+static int it66121_hdmi_audio_startup(struct drm_bridge *bridge,
+				      struct drm_connector *connector)
 {
 	int ret;
-	struct it66121_ctx *ctx = dev_get_drvdata(dev);
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, true);
 	if (ret)
-		dev_err(dev, "Failed to enable audio output: %d\n", ret);
+		dev_err(ctx->dev, "Failed to enable audio output: %d\n", ret);
 
 	mutex_unlock(&ctx->lock);
 
 	return ret;
 }
 
-static void it66121_audio_shutdown(struct device *dev, void *data)
+static void it66121_hdmi_audio_shutdown(struct drm_bridge *bridge,
+					struct drm_connector *connector)
 {
 	int ret;
-	struct it66121_ctx *ctx = dev_get_drvdata(dev);
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
 	mutex_lock(&ctx->lock);
 	ret = it661221_audio_output_enable(ctx, false);
 	if (ret)
-		dev_err(dev, "Failed to disable audio output: %d\n", ret);
+		dev_err(ctx->dev, "Failed to disable audio output: %d\n", ret);
 
 	mutex_unlock(&ctx->lock);
 }
 
-static int it66121_audio_mute(struct device *dev, void *data,
-			      bool enable, int direction)
+static int it66121_hdmi_audio_mute_stream(struct drm_bridge *bridge,
+					  struct drm_connector *connector,
+					  bool enable, int direction)
 {
 	int ret;
-	struct it66121_ctx *ctx = dev_get_drvdata(dev);
+	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
 
-	dev_dbg(dev, "%s: enable=%s, direction=%d\n",
+	dev_dbg(ctx->dev, "%s: enable=%s, direction=%d\n",
 		__func__, enable ? "true" : "false", direction);
 
 	mutex_lock(&ctx->lock);
@@ -1436,64 +1422,28 @@ static int it66121_audio_mute(struct device *dev, void *data,
 	return ret;
 }
 
-static int it66121_audio_get_eld(struct device *dev, void *data,
-				 u8 *buf, size_t len)
-{
-	struct it66121_ctx *ctx = dev_get_drvdata(dev);
-
-	mutex_lock(&ctx->lock);
-	if (!ctx->connector) {
-		/* Pass en empty ELD if connector not available */
-		dev_dbg(dev, "No connector present, passing empty EDID data");
-		memset(buf, 0, len);
-	} else {
-		mutex_lock(&ctx->connector->eld_mutex);
-		memcpy(buf, ctx->connector->eld,
-		       min(sizeof(ctx->connector->eld), len));
-		mutex_unlock(&ctx->connector->eld_mutex);
-	}
-	mutex_unlock(&ctx->lock);
-
-	return 0;
-}
-
-static const struct hdmi_codec_ops it66121_audio_codec_ops = {
-	.hw_params = it66121_audio_hw_params,
-	.audio_startup = it66121_audio_startup,
-	.audio_shutdown = it66121_audio_shutdown,
-	.mute_stream = it66121_audio_mute,
-	.get_eld = it66121_audio_get_eld,
+static const struct drm_bridge_funcs it66121_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.attach = it66121_bridge_attach,
+	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
+	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
+	.atomic_enable = it66121_bridge_enable,
+	.atomic_disable = it66121_bridge_disable,
+	.atomic_check = it66121_bridge_check,
+	.mode_set = it66121_bridge_mode_set,
+	.mode_valid = it66121_bridge_mode_valid,
+	.detect = it66121_bridge_detect,
+	.edid_read = it66121_bridge_edid_read,
+	.hpd_enable = it66121_bridge_hpd_enable,
+	.hpd_disable = it66121_bridge_hpd_disable,
+	.hdmi_audio_startup = it66121_hdmi_audio_startup,
+	.hdmi_audio_prepare = it66121_hdmi_audio_prepare,
+	.hdmi_audio_shutdown = it66121_hdmi_audio_shutdown,
+	.hdmi_audio_mute_stream = it66121_hdmi_audio_mute_stream,
 };
 
-static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
-{
-	struct hdmi_codec_pdata codec_data = {
-		.ops = &it66121_audio_codec_ops,
-		.i2s = 1, /* Only i2s support for now */
-		.spdif = 0,
-		.max_i2s_channels = 8,
-		.no_capture_mute = 1,
-	};
-
-	if (!of_property_present(dev->of_node, "#sound-dai-cells")) {
-		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
-		return 0;
-	}
-
-	ctx->audio.pdev = platform_device_register_data(dev,
-							HDMI_CODEC_DRV_NAME,
-							PLATFORM_DEVID_AUTO,
-							&codec_data,
-							sizeof(codec_data));
-
-	if (IS_ERR(ctx->audio.pdev)) {
-		dev_err(dev, "Failed to initialize HDMI audio codec: %d\n",
-			PTR_ERR_OR_ZERO(ctx->audio.pdev));
-	}
-
-	return PTR_ERR_OR_ZERO(ctx->audio.pdev);
-}
-
 static const char * const it66121_supplies[] = {
 	"vcn33", "vcn18", "vrf12"
 };
@@ -1602,7 +1552,15 @@ static int it66121_probe(struct i2c_client *client)
 		}
 	}
 
-	it66121_audio_codec_init(ctx, dev);
+	if (of_property_present(dev->of_node, "#sound-dai-cells")) {
+		ctx->bridge.ops |= DRM_BRIDGE_OP_HDMI_AUDIO;
+		ctx->bridge.hdmi_audio_dev = dev;
+		ctx->bridge.hdmi_audio_max_i2s_playback_channels = 8;
+		/* of-graph not supported, phandle match only */
+		ctx->bridge.hdmi_audio_dai_port = -1;
+	} else {
+		dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
+	}

 	drm_bridge_add(&ctx->bridge);
 
-- 
2.43.0

