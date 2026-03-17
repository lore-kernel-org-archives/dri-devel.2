Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D7BFED9E8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AD110E2E0;
	Tue, 17 Mar 2026 16:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O80FgRha";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B060010E2E0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgehNWk00wfIRH2YCw52kY7dqaDhDbRyY6UQWMYJUzRXIVHPIexb9wpsoaBaqdw3OuwgpZUc3xThj34bH5sMEX/nTLUgw2hHWDaC9F+nh1v5J/lUG8vvHn4LHYrejU8FmjHdeuMm1qJDovw6gP7IMhUcfokynecGDeGNnLEnWGlJLe1jWjj5KTyIqoN0JPOuwkRdYkVNXLCoGdK3gvNJS/1OdaIn1o6UT0uvvK4PW1oMiyolfg9NHg12Q/ZQTtzdrbQVHUxMoqsgEqYkm1HpclczNRhdZKNtbFX/wTka9tEPeIgqM1Zpcf2LwCnlDeif0zmj+e5Bw1ULl9KCX3razw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWmpszXa155ygVTItWyZJ33GM3FoK+ABR1vYJIajLlA=;
 b=pcTeu/wcfet0o1/+deLgRCrQEIHOW7saAY4OoN2Tz4P/Gs3Gj1RgCAwl7zXCXvfT+I69SJiKE+Rt4BD3viZ+4VOl+o8JnILVHLCiihVHTIqg98LXnRvS0WdynEgN3AMpxhQE0n3mVc9cDoCNLiwh+STuxpTEWM/PVkaqgwoJe7TZdLZNzDjU/dzH3HIZUBWCowloDDkveNCTQLznsSihPUQy7B64FPCHNrjsyLBb235QziTvPZUy7dq9KxpU0hywpa5DNfHoEz0LTlD06PRwzqL96qAtGjXnHQhqpiX4Um4kyBMqjJ6PASteil1Sjg4qFbFCzdf4r9LSJFsY45xiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWmpszXa155ygVTItWyZJ33GM3FoK+ABR1vYJIajLlA=;
 b=O80FgRhaJOs7/3uJV/IDh+/LEWXzdkHA3qzLbB68Tl4mDzA7OLD/tt9EksQXAg4dnbjlGYcxIi9vazFU+JJpTf3LW7FSCA6fIn3BoLN32+2sc/DqS9rX5LfRAkEkeDwxDLFHzZdQaoLv84jY8BAliS6we0POr8YYtWeBIb7zJeo=
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:45:45 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::37) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 16:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:45:44 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 11:45:39 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 11:45:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 11:45:38 -0500
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.81.246])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HGjcOa3511978;
 Tue, 17 Mar 2026 11:45:38 -0500
From: Sen Wang <sen@ti.com>
To: <ple@baylibre.com>, <neil.armstrong@linaro.org>,
 <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <j-sahu@ti.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Sen Wang <sen@ti.com>
Subject: [PATCH] drm/bridge: ite-it66121: Convert to DRM HDMI Audio Helper
Date: Tue, 17 Mar 2026 11:45:38 -0500
Message-ID: <20260317164538.1790079-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA1PR10MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ece6bc6-76c3-4e6f-decc-08de8444a26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +0O15dtOPxvM7/kdPXj3Sgu43ntVjfh6SmtHTJVJCq3rIm27qlqTwNkw4KldmrDxFmBsu+4EOSAKcqcBKBjly8Ufkk12OZwncBtB24RgaAg+mUN2gNnaiYrosQE+SrjRWSs83J4yrp22PdTVHzgBlrhiAZ8EA6Hqcm6mVSk0VNqfVImiQs/8G3TyS9Tv5N93mvAXPUSim3g067HZvTZ9S1uC0ACNzd58LgF9s9N/5YgRJ5VlAuf2n7YPbrxmNUAezzSorcli3YBzx2EL5vB6PWkYhVYp8GM2XC0vct8WCTbaYfiltgR+7zwGFySUXrHYcolQPCTZDdjZ7oVCEul0qvW1RPgymOHf+GLM2YaZHaYtyZiO+vc0T1U/8BcTvdNtdy6VXzjTpAeODMsq6yXAzGypnkQrgi+y+AD4QtvNiXECdP4pHaRG7D6cFU47TqaTUJkbymEjL6Ao/Qe4PBB+4O1Kcsuv7MXAc8Yq1sVkPpL916ahNLlXe6eJGav7wjY9F2ygDKTmhS9Rbc3NZwgWy5j1JkWzKtlLL5Jlj3ovnVApMDDWFGxJACcptHonxE4osljqGL4aNfY+kqj7yFPe8IZLp5hQsCKkm4Vat9yGi67KpQM5S5/Uxa8ny84T3E48X1IGeFiSX22sPi71DyzYWhBLr3c6WQ39m67JSV58glc/MqHu82kKEKFe/JdFqd+1Kg3KEQ9PGncfuGP4m7ak8AZEhC6RvhpgvqQzQhVnmQ/m79QdsH0BM4/6wxxPAnAQV/N2+FDbqnbDlJMbd4a2FA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IoFysaxaGD9rgu4eAgit1CRIAp745TosPyQzR8wa6bO6m8mDzPONp6bDq5MUiYD5cEWFsbEpkLzA/Nlv6VA2qwWVuUfda7lNfGP/W0ooeMcbipp0aI5CrsZcJKuYsdio2j2OrrRytrFNeyZUK70W+Qh3O887zkXL7c9XxF+tF7p9CLccugjtolEb6koTbCp8spZ83OaKNiGhy9RSHXIYbGIClV5AWN4xNs+6huu1OFbBR0lTXxUlpRwKNIZbxbVrDbeqYuzQ6Y9xuvxL3dIZ/n5VCkghBiXcRkKOSu+htTxNRJlA+vtFwDV+nGfPlcwL3FhKoskkfXr2I3rwrecqHXk7LKuGOPmygPsAe0eqnbiljENuStoHlBqTOR88z3lfPy2ry72l/5g4+QFqvMg8ibeYPkBpw4zIjJQlwoqLtGVk7qVhp2WVsdWwYUukyi1q
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:45:44.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ece6bc6-76c3-4e6f-decc-08de8444a26b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7634
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

 drivers/gpu/drm/bridge/ite-it66121.c | 135 +++++++++------------------
 1 file changed, 45 insertions(+), 90 deletions(-)

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
@@ -1602,7 +1552,12 @@ static int it66121_probe(struct i2c_client *client)
 		}
 	}
 
-	it66121_audio_codec_init(ctx, dev);
+	if (of_property_present(dev->of_node, "#sound-dai-cells")) {
+		ctx->bridge.ops |= DRM_BRIDGE_OP_HDMI_AUDIO;
+		ctx->bridge.hdmi_audio_dev = dev;
+		ctx->bridge.hdmi_audio_max_i2s_playback_channels = 8;
+		ctx->bridge.hdmi_audio_dai_port = -1;
+	}
 
 	drm_bridge_add(&ctx->bridge);
 
-- 
2.43.0

