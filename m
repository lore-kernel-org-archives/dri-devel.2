Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD710A1E63
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DED10EC60;
	Fri, 27 Mar 2026 02:18:31 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0484910EC60
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 02:18:29 +0000 (UTC)
Received: from localhost (unknown [124.16.138.129])
 by APP-05 (Coremail) with SMTP id zQCowAAHmQzu6MVpUpagCw--.15452S2;
 Fri, 27 Mar 2026 10:18:22 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, mitltlatltl@gmail.com,
 Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/panel: himax-hx83121a: Fix incorrect error check for
 devm_drm_panel_alloc()
Date: Fri, 27 Mar 2026 10:17:28 +0800
Message-Id: <20260327021728.647182-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHmQzu6MVpUpagCw--.15452S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWfJr1rXr48Jr4DuF18uFg_yoWkJwb_Ga
 1UXF97Xr9rCr9rur1xAa1jyF92kF4kuFs7Zw1rK3s3Cry7Cr1xX347WrZ8Ar17Ga10yFWD
 ta48ZFya9FnxWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
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

Check devm_drm_panel_alloc() return value for ERR_PTR instead of NULL.
devm_drm_panel_alloc() returns an ERR_PTR on failure, never NULL. Using
a NULL check skips the error path and may cause a NULL pointer
dereference.

Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-himax-hx83121a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
index ebe643ba4184..bed79aa06f46 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
@@ -596,8 +596,8 @@ static int himax_probe(struct mipi_dsi_device *dsi)
 
 	ctx = devm_drm_panel_alloc(dev, struct himax, panel, &himax_panel_funcs,
 				   DRM_MODE_CONNECTOR_DSI);
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	ret = devm_regulator_bulk_get_const(&dsi->dev,
 					    ARRAY_SIZE(himax_supplies),
-- 
2.25.1

