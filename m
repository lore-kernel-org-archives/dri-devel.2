Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C462C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 01:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4406510E41E;
	Mon, 13 Jul 2026 01:48:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE8D210E41E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:48:46 +0000 (UTC)
X-UUID: f8964ae47e5c11f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:37285a2a-020d-4cff-93fc-76cf3109648a, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:acd1ecc9a18f14a309e819678c549fcb,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
 50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8964ae47e5c11f1aa26b74ffac11d73-20260713
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zenghongling@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1369605824; Mon, 13 Jul 2026 09:48:39 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: yannick.fertre@foss.st.com, raphael.gallais-pou@foss.st.com,
 philippe.cornu@foss.st.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 benjamin.gaignard@linaro.org, yannick.fertre@st.com
Cc: dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] drm/stm/ltdc: Fix clock cleanup error handling
Date: Mon, 13 Jul 2026 09:48:35 +0800
Message-Id: <20260713014835.23995-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

When clk_prepare_enable() fails for bus_clk or lvds_clk, the previously
prepared clocks are not cleaned up, leading to resource leaks.

In ltdc_resume():
- If bus_clk preparation fails, pixel_clk remains prepared
- If lvds_clk preparation fails, both pixel_clk and bus_clk remain prepared

In ltdc_load():
- If bus_clk preparation fails, pixel_clk remains prepared

Fix this by adding proper error handling to ensure all prepared clocks
are disabled and unprepared when a subsequent clock preparation fails.

Fixes: df61c776657f ("drm/stm: add sleep power management")
Fixes: d80667642b0f ("drm/stm: ltdc: support new hardware version for STM32MP25 SoC")
Fixes: b7243862f82a ("drm/stm: ltdc: handle lvds pixel clock")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/gpu/drm/stm/ltdc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 95fcfa48d8be..ead9e87bd719 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1907,16 +1907,25 @@ int ltdc_resume(struct drm_device *ddev)
 		ret = clk_prepare_enable(ldev->bus_clk);
 		if (ret) {
 			drm_err(ddev, "failed to enable bus clock (%d)\n", ret);
-			return ret;
+			goto err_pixel;
 		}
 	}
 
 	if (ldev->lvds_clk) {
 		ret = clk_prepare_enable(ldev->lvds_clk);
-		if (ret)
+		if (ret) {
 			drm_err(ddev, "failed to prepare lvds clock\n");
+			goto err_bus;
+		}
 	}
 
+	return 0;
+
+err_bus:
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
+err_pixel:
+	clk_disable_unprepare(ldev->pixel_clk);
 	return ret;
 }
 
@@ -1962,7 +1971,7 @@ int ltdc_load(struct drm_device *ddev)
 		ret = clk_prepare_enable(ldev->bus_clk);
 		if (ret) {
 			drm_err(ddev, "Unable to prepare bus clock\n");
-			return ret;
+			goto err;
 		}
 	}
 
-- 
2.25.1

