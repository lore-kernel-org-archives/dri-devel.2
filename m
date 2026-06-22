Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22163CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8078310E4BB;
	Mon, 22 Jun 2026 06:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="GEAh3FmK";
	dkim-atps=neutral
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Mon, 22 Jun 2026 06:55:47 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF2810E4BB
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JM
 u/grGaexoffKjwUAwcH2phMjsPJMeGjxVjgQkm/4I=; b=GEAh3FmKzRYAwZMHbo
 Y+4tvWTPWjJ7zqs0Hg/NadlY6BCeCIcaRh5zFJaI5s1TlMiezOl2h/MB6toVYKmr
 6fdD4n7Y4xLPmRHUoV7PGvKUASx0XcSm+VoiLeCE/KUdlho33xS2dDho+d2S7ZYW
 H/ucOGt28+XsLMa0YiD0JPYU8=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgBnhyPs2jhqX8kADg--.55168S2;
 Mon, 22 Jun 2026 14:49:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: hpfb: Unregister DIO driver on init failure
Date: Mon, 22 Jun 2026 14:49:15 +0800
Message-Id: <20260622064915.767194-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgBnhyPs2jhqX8kADg--.55168S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF15Wr47GFykZr4xAF1fJFb_yoW8JryUpa
 1jka90vrWjqw47WrsrtF1fXFyUX3Z3JrZF9r47uwnIqanYyF4DW3y7tFyjgF45ArWxuF13
 tw15Jw43ua4Y9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEEfOUUUUUU=
X-Originating-IP: [240e:604:311:e68d:9586:9dd0:bd4b:6902]
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxg6aCWo42u5uGAAA3L
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

hpfb_init() registers the DIO driver via dio_register_driver().
If a later error occurs, the function returns directly without
unregistering the DIO driver. Unregister the DIO driver before
returning from these error paths.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/hpfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index a1144b150982..1405712e5b4f 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -407,10 +407,13 @@ static int __init hpfb_init(void)
 	err = copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DIO_IDOFF, 1);
 
 	if (!err && (i == DIO_ID_FBUFFER) && topcat_sid_ok(sid = DIO_SECID(INTFBVADDR))) {
-		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
+		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) {
+			dio_unregister_driver(&hpfb_driver);
 			return -EBUSY;
+		}
 		printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid);
 		if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
+			dio_unregister_driver(&hpfb_driver);
 			return -ENOMEM;
 		}
 	}
-- 
2.25.1

