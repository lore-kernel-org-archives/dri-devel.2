Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8E606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dY2ZJn4G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9838810F9F0;
	Wed, 25 Nov 2026 08:41:25 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013015.outbound.protection.outlook.com
 [52.101.83.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2206510F4DF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVflSU9HHzwNuqGpqawYo6yNW4oEetXWN0Bis6vjlTU64kN2xq+HRx+FHD2EENrPHGMywez1pkr613wnhTx27m43RG1cDGJR/5wc1PiVYM21fQTDmXzS8tB9AbOZ5FIl/oaNN00gwd4mKetc/RCfyTODJH9E4HYuuc9wxh/Ttb750vBJSHeBzZWeFDuJme8LFrHxumjSbxw+sLkPvR+Z/FaiDlSYZMqYYhbb8JSUcqSD+j9XS3HsMn3v9fnXkNqXWtwntc+G+knUV2dW/SzRM6fWCXwdVsU3uVDGt4l5SX4Kr8eRxheLfML34q2x8vhhwTboEwe6hOdT2VGijvrChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WzDFzRlQvG6jxJCaBjMWLUBknQsy2kqZHHbWf1+cEg=;
 b=HInh9Ir13NwyAbbW1OzDmqM3ywzV9R+9clQxr6Qpd9DEx+scIP6IdOiwK0kDhMDGjQcM9t4i5VOyJ0lZv0OP/s1rV/Y6cx8VZtxWbWvl7T5lmW2lYQyX4qqxQ+xykvZH2JoJdlPIstlgnT3Am291mbAvmhflzvUGRFALjFlFIP8GqM38xQMgvPg6teUOjDro5V/DIvdDMD2qLMQr5X1saZQe5cYptsrHQ61I3Gv3K4bsQHyZGhGLDXkm3ylFQYI+84RjaQyUyjTRp/FGmzhVJyx/e1MEhyt5Bu/aLQC4kQsY4siJ9ivq9RAM3E93t8+raubEy6dmfIIkXKpbv7HgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WzDFzRlQvG6jxJCaBjMWLUBknQsy2kqZHHbWf1+cEg=;
 b=dY2ZJn4Gbi49HqPhqrUeLjQuXMlf9cYKY+KBKaczJ+gKk5yDcZ9bYk7vbPQXkPAmnPnvR+18Y4tld/+8VEjme3GCnNR3L1ZNmZHui8bvki+aUmkeqlRfTnSx11s4tEq0qQyo50Lhk/21Nk3g2c3siErxc7K82dHZ6xbt6ik3OvoKfGB+d8UJXtm0o/jwQ9T1VOoLcrTmwHm0brK2X9yqT3j2PWA2qpfm8fkpuK0gtIMj/ZDHpexr8jT0Wpt5hYkI0e09+IiWSPdvhDtzU0C0Zr6dlzxhRG/SWQjkDr4nE4JzfMoB+XHyFgoMnTjTyj7pp7S6o8rM+EdCJHr/H580Jg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by MMZPR04MB669910.eurprd04.prod.outlook.com (2603:10a6:190:52::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:53:00 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 11:53:00 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] drm/bridge: imx93-mipi-dsi: Fix mode validation
Date: Tue, 24 Nov 2026 13:52:55 +0200
Message-ID: <20261124115255.679017-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR03CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::16) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|MMZPR04MB669910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7594e6-6c37-4390-31e2-08df4a217d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|18002099003|11063799006|5023799004|56012099006|261021121427099003|261102123227099003|261022105027099003|261028144727099003|261022075727099003|261026140227099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: rJ9umvIOvm6QVe281IcFVP3EQrH2goljvIiZ+5z4QkhPIbmI+bu6iLibtSDTGpjS7wf8xX4nko75eN58/YXFRlGKkjcU+PUx0N7SJL/HeH6XpHrR10L/hn0ozw/T3P+soqKlYCt18aRNX+AuXjh79PqBoRNOFchqN51kqN1/44XWlZHKdMOmCWJTcJj53UmwU5q/miKfJ4mjZoAy9FGvTGajrmcTnrBbfDveqk4AxyHhmkkNPUGzZeo/yyz07GeGq5YuC+QGP+2aJk8CPiy1GriNQUdhKymVgo9p5vykM42JQJ6fjXuIX+jEb20/ZSHH3w/kg7WlvaJO1DLEISOrq27/l0tENSYk+p44jv53nGg7hk3LSwZsSk2ZP40PGLWOCaxIKaNbUT//umIqQGwKXy7dL6OWdfQ+joGztsDrugYg6GdVl4IVYSgKHYw44iHLW/aUl6BCIQBr5nTR/WPmyPWry3/iWLd7djYSMSw7NFCQ53IsgkMdnxU+1Y3FK1l0myOW6g2ULZehRK4MMfYKR8zppDkAyXRnyosvmfQIub4conjO6U5ATMFPjcpNtE2SxJGy+Jy9gdQpAUfZAViF4GhzjhuUCq4oUCCgfy6l/dklk96fyc7SJajX2w4wpD3y1IrSHdD3mfYCyMW+mkig/1DWLxg3Qfl7wRGtqzeAHlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB4472.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026140227099003)(261021123027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TThp94w0kzi+U5ATHag5QmNwQSxToszIqaLSO+Bu8RcFsnpdiTYlA1SJCmFP?=
 =?us-ascii?Q?Xidmbi1Vs6LWSZaOHX9sIbPR4/it0B3KzcEEqjkfUwK4hUSBIR3yOhe/9hY0?=
 =?us-ascii?Q?g2Rsb0SpApN9ZpTCAyph73Mv1f7UBitSOeajl5mhINW8seCLDTiSOiwOvvu9?=
 =?us-ascii?Q?IEnJisy+ICEOoHkPv52hutSoQxcVeW/f0v7IhD/OQrL91oi78SGsuYs/LVW4?=
 =?us-ascii?Q?LtTAqWSuMZwbf0mskc+dHjdb8Rj4YxIUimyevJwN/OvFevcTGV9/vt+sLLnI?=
 =?us-ascii?Q?t1cPIebXmiL34ZBO3YPYNIJzzKjlLibXHTWPFinTtCDQqpeUOu0n7WAyhUqL?=
 =?us-ascii?Q?mv2/8kbwgeXbFt25NBqARpjocBvKRjGZXvmoPMxjmyPt6jlMhKa30LC41jKZ?=
 =?us-ascii?Q?+jiOmt+TV24MWsU6RQAHuELmKQAqn3WqI7/fxY6qnzauMyTL+1DrxwVIw8oX?=
 =?us-ascii?Q?t+sfsT1FaprBOVXGroY74IaZxhHsILEKCm//DqCfrOpzW6pEJCCdV9ZIqoll?=
 =?us-ascii?Q?fZS6TDT56IBSWbHN9EoIpW+dZ4uo1dqos4ARe3pr9uUf4r3bxVc7wWXLpE/d?=
 =?us-ascii?Q?kgMMtdU0zSV5n8s60cY8T6MLygC2Tn8n+vVtmQpZI1GReCmVxubJ/S584hgX?=
 =?us-ascii?Q?RO1DvIdj6lrxc+Hj+6Vy+YRbDfwT1jBZiOcqyup7YeRK8to+nKHIt8GkawPB?=
 =?us-ascii?Q?ti9XIR/Hah13lQiGuYimTPXka8PjdyhqTUtqC7UA8fnalSVMUjgbGv08qMrb?=
 =?us-ascii?Q?sa5+eIA9cZ/MVokq4wE/oHQtcngPcwXp/A/gFBDyosnjKb521fJDN8ert529?=
 =?us-ascii?Q?mmrK83U6b10/ygi7st0HWcuWr2ARs8cEKqU6Ph+Dbt6JbdXOGXfcY94s3BAm?=
 =?us-ascii?Q?dOPLMP8C1pp23jg9mMzu5DoDpeOeZZ6eC4SCB/yc8ISU7gZqCo6/usV8mQo6?=
 =?us-ascii?Q?K3b+TMnK/LLl39MRMAMMXHcjvT7Ft3T53sY7cmgwpYxGXYjyEbT0JDai9+NR?=
 =?us-ascii?Q?tPTUSqYMPZSqap+9W3U8plkgVhKAw2VhfEkJaw1A4hn6VMPvn+miqAnJ3Haz?=
 =?us-ascii?Q?oo447NwYusfOgbrBj2Vg+ESchvyLDb5f14VpPYl7b8RQhsiH2jCiD01zZmwD?=
 =?us-ascii?Q?e1DivpHuC7Q8TJ7TayZAb7WD0RpIySqScAYrgJOOmcjmMaZt2gt8VFLrYFD4?=
 =?us-ascii?Q?aVGhvDfn8TCPCYE8GfSj7NgLq+f5NqRh5rQ/LBHz0iJ98s5Q4Anz8VBbshv3?=
 =?us-ascii?Q?EdFpIKDTiYjuDVh7M2F6t6dIJ0Z6+iLWkGjKFjPlvGRqv3Z3JTimpLwSWdwl?=
 =?us-ascii?Q?JgWLZhmvD6TGsyItb6pEQdl4cf2qaaMa7t+fp6N/0/fbEkNt71DZNBvzl9v0?=
 =?us-ascii?Q?Z8QAN/QJ/WObYnsWsV4Mr3slLUFnOKRuT2ZUwyfTrgw8WkGac08+FTwJdv7B?=
 =?us-ascii?Q?ED/L+zZQP2cp15nZu6LqC8ObJ3u2EIsi/fy0dhvJ8q/bI9gc54N4LyMk3XkT?=
 =?us-ascii?Q?F/q1iRtIXFwWPpD/lIxfyFdGTV3SXV97ACkM0XQMX/HjneP7N4ewOiaPJd0G?=
 =?us-ascii?Q?wxuSk11ZVsoPWYx4+iFgn+CcaMCTYPHzAIohjcpB90GcCxDt8SFAbZe39wl1?=
 =?us-ascii?Q?5A79KOrHDcve+lGnHniq+MUaYtZcbJr5MHGzC3N2MFOoMX9FBnb6JWNHgusX?=
 =?us-ascii?Q?XwZn5VJsSVwnd26SPhFE5amzUMMVqHPgF311LyTRc/ROaCt3Nv3zvQ2Abw8L?=
 =?us-ascii?Q?IuLJNqtyQA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7594e6-6c37-4390-31e2-08df4a217d0d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:53:00.4006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnZzdlPdCu2O9Mbe5nbg2Bv+lIPJvYLkKAeLv1ZvA7wTlyjPhBUX78qSuv1Q+XxMkhEl5Ot6IAmphUCzsvEzGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB669910
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Liu Ying <victor.liu@nxp.com>

i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typical
1920x1080p@60Hz CEA/DMT display mode with a pixel clock rate running
at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mode,
while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz = 445.5MHz.
Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
clock rate deviation for timings.  So, for those display modes read
from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID
operation bit masks set, pixel clock rate could be adjusted to match
with the PLL frequency(for the above example, the pixel clock rate is
adjusted to be 148.444444MHz with about -0.03% deviation from the 148.5MHz
nominal rate so that the adjusted rate matches with the 445.333333MHz PLL
frequency).

Instead of checking the last bridge's operation bit masks against
DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
+/-0.5% pixel clock rate deviation, check any bridge after this bridge,
because the last bridge is usually a display connector bridge without
any operation bit mask when the clock rate deviation is allowed.

Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 54 +++++++++++++++------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 8f312f9edf974..64beedde7c464 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -489,25 +489,49 @@ static int imx93_dsi_get_phy_configure_opts(struct imx93_dsi *dsi,
 	return 0;
 }
 
+static inline struct drm_bridge *
+imx93_dsi_get_next_bridge_in_chain(struct drm_bridge *bridge)
+{
+	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
+
+	drm_bridge_put(bridge);
+
+	return next;
+}
+
 static enum drm_mode_status
 imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
 {
 	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
-	struct drm_bridge *last_bridge __free(drm_bridge_put) =
-		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
-
-	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
-	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
-		unsigned long pixel_clock_rate = mode->clock * 1000;
-		unsigned long rounded_rate;
-
-		/* Allow +/-0.5% pixel clock rate deviation */
-		rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
-		if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
-		    rounded_rate > pixel_clock_rate * 1005 / 1000) {
-			dev_dbg(dsi->dev, "failed to round clock for mode " DRM_MODE_FMT "\n",
-				DRM_MODE_ARG(mode));
-			return MODE_NOCLOCK;
+	struct drm_bridge *bridge;
+
+	/*
+	 * This function is called by DRM bridge infrastructure core code
+	 * when validating a mode against all bridges in the encoder chain,
+	 * so it assumes that the locking for the encoder chain is already
+	 * in place and handled by the core code.
+	 */
+	for (bridge = drm_bridge_get_next_bridge(dmd_bridge);
+	     bridge;
+	     bridge = imx93_dsi_get_next_bridge_in_chain(bridge)) {
+		if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
+		    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
+			unsigned long pixel_clock_rate = mode->clock * 1000;
+			unsigned long rounded_rate;
+
+			/* Allow +/-0.5% pixel clock rate deviation */
+			rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
+			if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
+			    rounded_rate > pixel_clock_rate * 1005 / 1000) {
+				dev_dbg(dsi->dev,
+					"failed to round clock for mode " DRM_MODE_FMT "\n",
+					DRM_MODE_ARG(mode));
+				drm_bridge_put(bridge);
+				return MODE_NOCLOCK;
+			}
+
+			drm_bridge_put(bridge);
+			break;
 		}
 	}
 
-- 
2.53.0

