Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550BACD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9E710E7A2;
	Wed, 10 Jun 2026 07:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f2AyLcbZ";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE2710E350
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 16:00:34 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2bf1cda2b17so42443535ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781020834; x=1781625634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I13MawXg0cVVfgeTQBDKuPQbb4kgdF9QdrPA6/FJBmI=;
 b=f2AyLcbZlHqvQqIkpduA02eQbzRoN4u0iJHMEzHd4hwBhq7YHOCEHd9tMbD0Gc2FQr
 WzFi7uMUxtOcs+hXMUl2JspPGyL4J1x2sezCF1yEmvetExFI6KfpLSb6N5nteFzxvflP
 ZdGkbhlC8pdGxbBFksmu6VOwWLJ5O650SncOZYyVrxSlMXwmJNTk8fyB6IGz2NNZgNF9
 IwjwPiCobYiyaWwm42AJaIwlvrqqvWlUugEWhPd2jwpx4jjKFIoLwxXUQJe1XwZPq27c
 M6RBjVgZ8KVkSUKB6cJxLd66UywoX34GpHtTZuqYZMKGabaMsKuVEwcKSi5dGYCebK1+
 /eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020834; x=1781625634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I13MawXg0cVVfgeTQBDKuPQbb4kgdF9QdrPA6/FJBmI=;
 b=chnhSOUvfxDEOEn1iPWga6KhSYEnsVNgX4gWsF3AfPzc5fi6Ox+GJNCJBFXN5A6PIr
 eT6D/wSe86u1hIf41i7ge98eBJaMhJhGRISDf1uJ0REYCtW9zJghY0DEQ6JgjvOCNa5K
 yyTjHh3XdQrK8FzlAg1mp9Sglo+URB8t75JYoMxdtJNQDoI5B1P8LGfN4wXUd1gIfxfI
 KWm7e9z5ZNX3ZOYNOFLVfBadElrMVXZf/DdTpAqLdpZWcYAGS3ieSA0YnyMKibyiAqAD
 IbotLxV9QLJvaa/mqf1wRLyikpkGTRZwK3pJmeagnS3a/buhbgu86zeVjAvY9JjjjxMe
 698w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7iM5X1dxA04R5VSOWbLYntQU5J3Kc0nNgXxrD/6DcNjzWZYNgOsE7jRxrJe9uaOTn+93j/MvGhbY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW5LwHI9+K7CiZag+hJVmhVzGnuJd6njY0XZOzgl42PIGXEgDB
 JTqDeMkAotdBR4dCbUhfLfJr9W80KdZqJxtV5rdX4d1tE4XnoFiGnyp5
X-Gm-Gg: Acq92OHHiOYoVHwcc6yB2roBvzQIaoNhoPZyiMRNmTqiujDc/xct0/2M0PvfYFiXfEh
 h6Jc7yvDs1esiX7sADX1zYUSZmIDXw9s5OBjhNLbME7fRTXawKkgIawhpSAVyW3y7rKbv07rHIY
 lR6JzEexDSx3CE5+GuhGo6qCkWYZKcTQ9jfUgjv08WT61GO6IRqUqPSjy+iluh70PXhUwue4wgn
 wBTiov/MzFoeKaKggxvaQ/sgzWScMB4tDMOI1TOvjl8rD1WL/KHxM4ejfjMl6NaEBid7Iv1pA69
 M6ePGyNxnYWvUGRPMIbufusZtyP4EborRpT4ekdmnsgrNH44IW+iRv10mYKMGHTgdfsQ8SVaViH
 Adp/FUGa+Fpv5FOwYcIflRaxjtz9eyOHANNBtbU1rlEIwugcF+vJtDPBO5Q8rGvJe/2jK3BMiGn
 rfMXP4FadgrDvRCu02b8IBxjaCdX/k14bRN9woAxkxjMJoVIU/dtrL1A==
X-Received: by 2002:a17:902:e5cc:b0:2c0:ccdf:5e61 with SMTP id
 d9443c01a7336-2c1ec66c7e6mr175806875ad.6.1781020833563; 
 Tue, 09 Jun 2026 09:00:33 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c249aeb62csm96424255ad.68.2026.06.09.09.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 09:00:33 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] fbdev: modedb: keep mode option buffer until parsing completes
Date: Wed, 10 Jun 2026 00:00:28 +0800
Message-ID: <20260609160028.5-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:35 +0000
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

When fb_find_mode() obtains the mode option from fb_get_options(),
mode_option_buf owns the returned string and name points into that
buffer. The done label frees mode_option_buf before the database
fallback has finished using name in name_matches(), so the fallback can
read freed memory.

Move the free to a common exit path and convert the successful returns
that can use mode_option_buf into jumps to that exit path.

Fixes: 089d924d03d5 ("fbdev: Read video= option with fb_get_option() in modedb")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 41 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec322..82f6ea38e1fb8 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -627,7 +627,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		 unsigned int default_bpp)
 {
 	char *mode_option_buf = NULL;
-	int i;
+	int i, ret;
 
 	/* Set up defaults */
 	if (!db) {
@@ -724,10 +724,9 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
-			int ret;
+			int cvt_ret;
 
 			DPRINTK("CVT mode %dx%d@%dHz%s%s%s\n", xres, yres,
 				(refresh) ? refresh : 60,
@@ -745,11 +744,12 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			else
 				cvt_mode.vmode &= ~FB_VMODE_INTERLACED;
 
-			ret = fb_find_mode_cvt(&cvt_mode, margins, rb);
+			cvt_ret = fb_find_mode_cvt(&cvt_mode, margins, rb);
 
-			if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
+			if (!cvt_ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
 				DPRINTK("modedb CVT: CVT mode ok\n");
-				return 1;
+				ret = 1;
+				goto out;
 			}
 
 			DPRINTK("CVT mode invalid, getting mode from database\n");
@@ -793,8 +793,10 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!interlace_specified ||
 				    db_interlace == interlace)
 					if (refresh_specified &&
-					    db[i].refresh == refresh)
-						return 1;
+					    db[i].refresh == refresh) {
+						ret = 1;
+						goto out;
+					}
 
 				if (score < diff) {
 					diff = score;
@@ -804,7 +806,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		}
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
-			return (refresh_specified) ? 2 : 1;
+			ret = (refresh_specified) ? 2 : 1;
+			goto out;
 		}
 
 		diff = 2 * (xres + yres);
@@ -831,21 +834,29 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		}
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
-			return 5;
+			ret = 5;
+			goto out;
 		}
 	}
 
 	DPRINTK("Trying default video mode\n");
-	if (!fb_try_mode(var, info, default_mode, default_bpp))
-		return 3;
+	if (!fb_try_mode(var, info, default_mode, default_bpp)) {
+		ret = 3;
+		goto out;
+	}
 
 	DPRINTK("Trying all modes\n");
 	for (i = 0; i < dbsize; i++)
-		if (!fb_try_mode(var, info, &db[i], default_bpp))
-			return 4;
+		if (!fb_try_mode(var, info, &db[i], default_bpp)) {
+			ret = 4;
+			goto out;
+		}
 
 	DPRINTK("No valid mode found\n");
-	return 0;
+	ret = 0;
+out:
+	kfree(mode_option_buf);
+	return ret;
 }
 
 /**
-- 
2.51.0
