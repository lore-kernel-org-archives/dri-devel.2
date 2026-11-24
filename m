Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF86606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=LWPg5PLb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C481010F5C0;
	Tue, 24 Nov 2026 13:58:54 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06B110F5C0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:58:46 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb9f;
 Tue, 24 Nov 2026 21:58:42 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] fbdev: s3c-fb: Fix potential registration corruption on
 probe failure
Date: Tue, 24 Nov 2026 21:58:40 +0800
Message-ID: <20261124135840.2276343-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa20dda064003a1kunma2178d373424ae
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTExLVk1NT0sdHkgYHUJIHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=LWPg5PLb9d6gzJORAqlgK8DHlzCNVSaYpI4KfipNPdYA+XydQSYkdramj35/25nIPUmVuwHaqa5nL+7ui10BOaIg3lQZS+mT6oPuGvB/+i5QykrN5JbjRW9hA4xSrGmAPGu74EQLjZtQU60V1R4yM5eky1pMAjwzOGKLb47IlR0=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=+HySKkOVbW474osHQ9Y0YmzT/kE7CKLfCjwENY+Iv3I=;
 h=date:mime-version:subject:message-id:from;
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

s3c_fb_probe_win() publishes its window before registration succeeds.
On failure, the caller unregisters that unregistered framebuffer, whose
zero-initialized node can remove another framebuffer from registered_fb[0].
Colour-map allocation failure is also ignored.

Unwind failed windows inside s3c_fb_probe_win() and publish them only
after successful registration. Stop the window before freeing its display
memory if registration fails, and skip empty slots in the caller's cleanup.

This issue was found by our static analysis tool under development.

Fixes: ec549a0fdc32 ("fb: add s3c-fb driver for newer Samsung SoC framebuffer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Unwind failed windows in s3c_fb_probe_win() and publish the window
    only after registration succeeds, without a registration flag.
  - Stop on colour-map allocation failure and skip empty cleanup slots.
  - Blank the enabled window before freeing memory if registration fails.

 drivers/video/fbdev/s3c-fb.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index fde78707d313..8fae4d909bb7 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1197,7 +1197,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	WARN_ON(windata->yres == 0);
 
 	win = fbinfo->par;
-	*res = win;
 	win->variant = *variant;
 	win->fbinfo = fbinfo;
 	win->parent = sfb;
@@ -1208,7 +1207,7 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_alloc_memory(sfb, win);
 	if (ret) {
 		dev_err(sfb->dev, "failed to allocate display memory\n");
-		return ret;
+		goto err_release_fb;
 	}
 
 	/* setup the r/b/g positions for the window's palette */
@@ -1249,16 +1248,17 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = s3c_fb_check_var(&fbinfo->var, fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "check_var failed on initial video params\n");
-		return ret;
+		goto err_free_memory;
 	}
 
 	/* create initial colour map */
 
 	ret = fb_alloc_cmap(&fbinfo->cmap, win->variant.palette_sz, 1);
-	if (ret == 0)
-		fb_set_cmap(&fbinfo->cmap, fbinfo);
-	else
+	if (ret) {
 		dev_err(sfb->dev, "failed to allocate fb cmap\n");
+		goto err_free_memory;
+	}
+	fb_set_cmap(&fbinfo->cmap, fbinfo);
 
 	s3c_fb_set_par(fbinfo);
 
@@ -1269,12 +1269,22 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
 		dev_err(sfb->dev, "failed to register framebuffer\n");
-		return ret;
+		goto err_blank;
 	}
 
+	*res = win;
 	dev_info(sfb->dev, "window %d: fb %s\n", win_no, fbinfo->fix.id);
 
 	return 0;
+
+err_blank:
+	s3c_fb_blank(FB_BLANK_POWERDOWN, fbinfo);
+	fb_dealloc_cmap(&fbinfo->cmap);
+err_free_memory:
+	s3c_fb_free_memory(sfb, win);
+err_release_fb:
+	framebuffer_release(fbinfo);
+	return ret;
 }
 
 /**
@@ -1470,7 +1480,8 @@ static int s3c_fb_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(dev, "failed to create window %d\n", win);
 			for (; win >= 0; win--)
-				s3c_fb_release_win(sfb, sfb->windows[win]);
+				if (sfb->windows[win])
+					s3c_fb_release_win(sfb, sfb->windows[win]);
 			goto err_pm_runtime;
 		}
 	}

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

