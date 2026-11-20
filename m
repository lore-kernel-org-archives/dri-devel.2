Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7174606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z5vlkUf0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054EE112BBD;
	Fri, 20 Nov 2026 16:17:39 +0000 (UTC)
X-Greylist: delayed 393 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 03:20:09 UTC
Received: from mail-proxy25229.mail.163.com (mail-proxy25229.mail.163.com
 [103.129.252.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A01E10E5E3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zF
 2EF/DQl8+4VspEwP0oJGoxB3Ft4fQQZd6PlbneL+Y=; b=Z5vlkUf0bpNfEntkCM
 6MHyYw1Xsv3ZbxqaRSxjcdElgRQQRLQVstewWgiW2Vgrnl8duMMEI0dPKnXV1YGP
 UHnoF1qXklJSc7ZoiP3EKwqAC8IhhiJmcvr7vMsToy8Up8J0fxS5iCHvEWAFCz7V
 VFEP8jpmUT5RgEWXlHzuIluDY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3XxYouv9qX7hrIw--.8897S2; 
 Fri, 20 Nov 2026 11:10:34 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kees+treewide@kernel.org, jsarha@ti.com
Cc: dri-devel@lists.freedesktop.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH] drm: omapdrm: dispc: Fix memory leak in dispc_bind
Date: Fri, 20 Nov 2026 11:10:31 +0800
Message-Id: <20261120031031.3545868-1-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3XxYouv9qX7hrIw--.8897S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4DGrWfCF1xZryDWw1xXwb_yoW8ZrWkpF
 Wktayqkr4xAF4Iqr9xJF1kX3WfCw4Ika18Wr4UKws3Cw1Yvr9xAF18ta45AFy8CF97C3W7
 CrnxJrZrAFy8uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U21vfUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7QpT8mr-uipPxAAA3I
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dispc_errata_i734_wa_init() allocates a dma buffer but the buffer
is not freed if something goes wrong later. Add an error path to
release the memory.

Fixes: fbff010bd0b4 ("drm/omapdrm: Workaround for errata i734 (LCD1 Gamma) in DSS dispc")
Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 2a23b4c59c29..7435abff3321 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -4627,14 +4627,14 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 	dispc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dispc->base)) {
 		r = PTR_ERR(dispc->base);
-		goto err_free;
+		goto err_fini;
 	}
 
 	dispc->irq = platform_get_irq(dispc->pdev, 0);
 	if (dispc->irq < 0) {
 		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
-		goto err_free;
+		goto err_fini;
 	}
 
 	if (np && of_property_read_bool(np, "syscon-pol")) {
@@ -4642,20 +4642,20 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 		if (IS_ERR(dispc->syscon_pol)) {
 			dev_err(&pdev->dev, "failed to get syscon-pol regmap\n");
 			r = PTR_ERR(dispc->syscon_pol);
-			goto err_free;
+			goto err_fini;
 		}
 
 		if (of_property_read_u32_index(np, "syscon-pol", 1,
 				&dispc->syscon_pol_offset)) {
 			dev_err(&pdev->dev, "failed to get syscon-pol offset\n");
 			r = -EINVAL;
-			goto err_free;
+			goto err_fini;
 		}
 	}
 
 	r = dispc_init_gamma_tables(dispc);
 	if (r)
-		goto err_free;
+		goto err_fini;
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -4680,6 +4680,8 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
+err_fini:
+	dispc_errata_i734_wa_fini(dispc);
 err_free:
 	kfree(dispc);
 	return r;
-- 
2.25.1

