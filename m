Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE24CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E767F10F15F;
	Thu,  7 May 2026 13:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="h6bwji/y";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABAF10F15E
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:46:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 53D5B4E42C30;
 Thu,  7 May 2026 13:46:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2742D60495;
 Thu,  7 May 2026 13:46:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EAD01108194AF; 
 Thu,  7 May 2026 15:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778161586; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=D3j1Kg0MGD89s0UlGQuIXfEiHzH3ubFcDL9lQxl9jOE=;
 b=h6bwji/yn40RIXN6gUyz5FkfVMqXtCHKXb+glDiSOGEZDxRpoXvs51Bsc7iv6cUN9mjDJw
 YjnkVqpMtT8KIjXzH3eTsrgPcsOLs7575N7kku2D4eanMW0wZ7FeGjXHHqNtDhdFmPARJt
 cuMh/8nuN4t0LJMnChcH3M/AOBXGXRhK+ftqSdd34C1hcqgJQNRZ430UfJRU8nJajxqcdu
 SjVMpHc2O8v1NThSzUIdJ9Ua96w7I2S0F/ZjUAqUS2bTjBUye9kLR4WvKXrfQd8xI0H4e/
 WrWHhuTO2pqJciiUF2513k4YI41oKx/9nwGN3WAmybKK837rkwbvjaRBrcdOUQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 07 May 2026 15:45:28 +0200
Subject: [PATCH v5 10/11] drm: zynqmp_dp: switch to
 of_drm_get_bridge_by_endpoint()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-10-472b913b5cb7@bootlin.com>
References: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
In-Reply-To: <20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
@panel parameter, thus using a reduced feature set of that function.
Replace this call with the simpler of_drm_get_bridge_by_endpoint().

Since of_drm_get_bridge_by_endpoint() increases the refcount of the
returned bridge, ensure it is put on removal. To achieve this, instead of
adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
pointer which is automatically put when the bridge is eventually freed.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v4:
- fix missing assignment
- simplify error management code flow

Changes in v3:
- fix ERR_PTR deref when -ENODEV is returned
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 379180fb3004..6130e31375c3 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -353,7 +353,6 @@ struct zynqmp_dp_train_set_priv {
  * @lock: Mutex protecting this struct and register access (but not AUX)
  * @irq: irq
  * @bridge: DRM bridge for the DP encoder
- * @next_bridge: The downstream bridge
  * @test: Configuration for test mode
  * @config: IP core configuration from DTS
  * @aux: aux channel
@@ -385,7 +384,6 @@ struct zynqmp_dp {
 	struct completion aux_done;
 	struct mutex lock;
 
-	struct drm_bridge *next_bridge;
 	struct device *dev;
 	struct zynqmp_dpsub *dpsub;
 	void __iomem *iomem;
@@ -1494,8 +1492,8 @@ static int zynqmp_dp_bridge_attach(struct drm_bridge *bridge,
 		return ret;
 	}
 
-	if (dp->next_bridge) {
-		ret = drm_bridge_attach(encoder, dp->next_bridge,
+	if (dp->bridge.next_bridge) {
+		ret = drm_bridge_attach(encoder, dp->bridge.next_bridge,
 					bridge, flags);
 		if (ret < 0)
 			goto error;
@@ -2461,10 +2459,15 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	 * Acquire the next bridge in the chain. Ignore errors caused by port@5
 	 * not being connected for backward-compatibility with older DTs.
 	 */
-	ret = drm_of_find_panel_or_bridge(dp->dev->of_node, 5, 0, NULL,
-					  &dp->next_bridge);
-	if (ret < 0 && ret != -ENODEV)
-		goto err_reset;
+	dp->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node, 5, 0);
+	if (IS_ERR(dp->bridge.next_bridge)) {
+		if (PTR_ERR(dp->bridge.next_bridge) != -ENODEV) {
+			ret = PTR_ERR(dp->bridge.next_bridge);
+			goto err_reset;
+		}
+
+		dp->bridge.next_bridge = NULL;
+	}
 
 	/* Initialize the hardware. */
 	dp->config.misc0 &= ~ZYNQMP_DP_MAIN_STREAM_MISC0_SYNC_LOCK;

-- 
2.53.0

