Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F1606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lQ2GUzQY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FB211235D;
	Fri, 27 Nov 2026 06:16:03 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082F211235D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gQ
 XNbkQwAa7GjvSJmbGidTm7gfji+hVb6jO+DrLVuPs=; b=lQ2GUzQYRkEG7j4day
 cGKQ84LSs998FiD4xd+aYtZlMvPQbdylHu6dsRtPtVLgOKiF2gSdPE9R9hk0gesJ
 4Yx7Ua47hdJL9Gdc/hpffjO96V2PbM/dOGS1vX0mirMFlPxIDt6+Qa0cBNBWJr9p
 rkd9VaYkm5oxSpK7FMnQT+fcU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3_xUBIAlrQbxTKg--.62791S2; 
 Fri, 27 Nov 2026 14:15:31 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de, david.laight.linux@gmail.com, akpm@linux-foundation.org,
 haojian.zhuang@gmail.com, zzhu3@marvell.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: mmpfb: destroy modelist on probe error handling path
Date: Fri, 27 Nov 2026 14:14:58 +0800
Message-Id: <20261127061458.387484-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_xUBIAlrQbxTKg--.62791S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrykCw17CFW3tr45Gr1rZwb_yoW8GFW8pF
 ZxJFW5KrWYq34UKF48G3WUXFy0ka4rJrW7GrW29rZ5u3W5trWDWFZ3XFyj9a93CFWDJ3Z0
 qF9rtry8Xa47uF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNeHDUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gMlk2sJIAMIOwAA3p
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

In modes_setup(), fb_videomode_to_modelist() allocates memory
for modelist. These memory should be freed if something fails in
modes_setup() after modes_setup() succeeds. Add a goto label and
call fb_destroy_modelist to do so.

Fixes: d2e8bae6d72f ("video: mmp fb support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index fc09d3ec3487..514b4b9c95e3 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -605,7 +605,7 @@ static int mmpfb_probe(struct platform_device *pdev)
 	if (fbi->fb_start == NULL) {
 		dev_err(&pdev->dev, "can't alloc framebuffer\n");
 		ret = -ENOMEM;
-		goto failed_destroy_mutex;
+		goto failed_destroy_modelist;
 	}
 	dev_info(fbi->dev, "fb %dk allocated\n", fbi->fb_size/1024);
 
@@ -634,6 +634,8 @@ static int mmpfb_probe(struct platform_device *pdev)
 failed_free_buff:
 	dma_free_coherent(&pdev->dev, PAGE_ALIGN(fbi->fb_size), fbi->fb_start,
 		fbi->fb_start_dma);
+failed_destroy_modelist:
+	fb_destroy_modelist(&info->modelist);
 failed_destroy_mutex:
 	mutex_destroy(&fbi->access_ok);
 	dev_err(fbi->dev, "mmp-fb: frame buffer device init failed\n");
-- 
2.25.1

