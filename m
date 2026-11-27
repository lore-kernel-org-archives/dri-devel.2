Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD7606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ZNs+536t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7237C10E1B1;
	Fri, 27 Nov 2026 05:33:15 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB67710E1B1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H9
 /l8zrbjI1Fi8JYq3QN58ALIk2gWRpzKtBMdgpzqe8=; b=ZNs+536tdlkUt0VJ4L
 CpakhHsJnl5bGBN+H1QEWUD9mKWbE6ENFGdu2n5E/VD6HXNKKXxnfDh1XpOtl7dI
 8ldcGiqmoxMe2JcbCGUln8TuG8bfkzSQ4kwdFIW6qlGQ3a2yQ7JsqCRo2D9N1bjE
 e9XBNlYwImNILF9A98W6ZtbBo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wB3Ps7+FQlr8ZpFKQ--.60941S2; 
 Fri, 27 Nov 2026 13:32:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de,
	fberckel@xs4all.nl,
	davem@davemloft.net
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: fbdev: Free color map if framebuffer fails to register
Date: Fri, 27 Nov 2026 13:32:42 +0800
Message-Id: <20261127053242.361218-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3Ps7+FQlr8ZpFKQ--.60941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw13ZrWrZFWUZr48WF4Durg_yoWkZFb_C3
 4Fvry8Xa4UKr1fGr1xAr15Ary2yws7Zrn3uF1vqasxGFy3Wr1rXr48Zrn5X3WUuF18KFsx
 CryqgF4xCw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXYFXUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gCiEWsJFgA0nAAA3B
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

gfb_set_fbinfo() allocates color map via fb_alloc_cmap().
If register_framebuffer() fails, the memory should be freed.
Add a goto label and call fb_dealloc_cmap() to do so.

Fixes: 2d378b917988 ("sparc64: Add very basic XVR-1000 framebuffer driver.")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/sunxvr1000.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr1000.c b/drivers/video/fbdev/sunxvr1000.c
index a93b06614187..b77e5ad16f1b 100644
--- a/drivers/video/fbdev/sunxvr1000.c
+++ b/drivers/video/fbdev/sunxvr1000.c
@@ -154,18 +154,21 @@ static int gfb_probe(struct platform_device *op)
 	if (err < 0) {
 		printk(KERN_ERR "gfb: Could not register framebuffer %pOF\n",
 		       dp);
-		goto err_unmap_fb;
+		goto err_dealloc_cmap;
 	}
 
 	dev_set_drvdata(&op->dev, info);
 
 	return 0;
 
+err_dealloc_cmap:
+	fb_dealloc_cmap(&gp->info->cmap);
+
 err_unmap_fb:
 	of_iounmap(&op->resource[6], gp->fb_base, gp->fb_size);
 
 err_release_fb:
-        framebuffer_release(info);
+	framebuffer_release(info);
 
 err_out:
 	return err;
-- 
2.25.1

