Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEE7FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD86610E10A;
	Wed, 29 Apr 2026 08:06:11 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B778710E10A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:06:09 +0000 (UTC)
Received: from localhost (unknown [124.16.138.129])
 by APP-01 (Coremail) with SMTP id qwCowABH62buu_FprjCzDg--.2401S2;
 Wed, 29 Apr 2026 16:06:06 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: neil.armstrong@linaro.org,
	jesszhan0024@gmail.com
Cc: dmitry.baryshkov@oss.qualcomm.com, linusw@kernel.org,
 dri-devel@lists.freedesktop.org, Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/panel: focaltech-ota7290b: Fix error check for
 devm_drm_panel_alloc()
Date: Wed, 29 Apr 2026 16:05:27 +0800
Message-Id: <20260429080527.1456732-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABH62buu_FprjCzDg--.2401S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF48uF48Jw18Gry7CFW5GFg_yoWDtFc_Ga
 10qFs3XryUGw1q9r47Aay7AFyIkF4q9F4kZw1rKa4fGFy5CrnFq34UJrn8X348WF18uF98
 W3W2vF4avw17CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
 Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
 ZEXa7VUUcyCPUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
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

The devm_drm_panel_alloc() function returns an error pointer on failure,
not NULL. Fix the check to use IS_ERR() and return PTR_ERR() to
correctly handle allocation failures.

Fixes: 07853e954248 ("drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
index dd420bb19440..ed02a8daf96f 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -156,8 +156,8 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 	ctx = devm_drm_panel_alloc(&dsi->dev, struct ota7290b, panel,
 				   &ota7290b_funcs,
 				   DRM_MODE_CONNECTOR_DSI);
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
-- 
2.25.1

