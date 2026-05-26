Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A071CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 09:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52E610E484;
	Tue, 26 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPnwdnDU";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D33310E1A5
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:15:20 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2bdeed4f717so55089465ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779786920; x=1780391720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zcJdTmTjfiBuviJiW8pIvbqp3hR7VDqq1Y5TAU3hp2Q=;
 b=DPnwdnDUi2Lmjcm2zAw9VlLsrS3zWYoCTB2w1aQt78cQr9Lk6av7AaFDEWG3vXf/yW
 G37ijGkzIQXGlCwZxUrKlUbE5q6tB7IycATefyiaGnzrYrqHow0vxh0rL4TiovkYCn78
 hPNuIoN4q+rYV+OEOvuPZDbiMgVxqbDrADut3EIfiK5LzlqvMcbWIAJi5ByfMF+GmFGM
 i364HFwCJc8gDyZhzPSOaBp2xE/HbJzW4f3ShReyW8Q8M94gvmJPrjuqxnliJnSQcAgf
 E2qxwEn+ABY6pxTpwOpMBwgLo517oDiHlM6RkFx8pIYE3UF2f/Q+B/ZGgR75NGagTkPW
 MsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786920; x=1780391720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcJdTmTjfiBuviJiW8pIvbqp3hR7VDqq1Y5TAU3hp2Q=;
 b=b5aE8kc0eX6b3sQoBbivRzU+xkW/5CSSVc/3PrF1azNN8ci/fL1Xby/Ht6ScfZTYgY
 KB/HcO+QOP7V9IV/GeC6oILqc+rGCpIMtq8etAM6khbSZ3j6eWQZlLTfCmfp6AXJX8Hy
 se+ksfQi1dBDBdTKD1VEV0cB1s0jNmulwmEKIH23t52BWHF1qZ+ZDOoT6iO5xAcSZWaQ
 6rxn2JbqNfdY0+E7uncKdNGhlytRxsAmgcrV/f5sVgR+pwSy2eUKIbnGMGOwectiiz4e
 xf1G3J/vattcMecxo5mTkhIcxRC/M93/ZtMy7QMetj79BEv/wrdUBmw1EAs7F+RFpmKz
 0Wkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U9I6w299bqPEqHXXIZp3XQXoMP6SNcENwNwUTRjlETt5+T7ITy3pLaS3BfvCzZFGJpbGvxeABAlo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyX5VyOMxDMEkYVZjvOME81ZvZuEQ9BcQGoobE+UFLGkzWBfp3
 /gkwLaN2Gv6TzMzL0qRiI5gIrV3QzxYIZuynFwecX6N1D6qvCrLmDHcU
X-Gm-Gg: Acq92OGAMR3nPsuE1Tjank0F172YPlJ2JGE7ebJEhXK1O37ZLZYjHVcq9HpuR1pJWS8
 EOcqIvtolP8GbQG3K+X265LswB30qCRqEaMykmW/qhG1A9BU4r5Df8egR1N58fHwGVXyIIBiz3B
 aFUrFpF5yJVHnZ6nDhKclR69kzu5Yh28d4KtCE4X/w/v3MXHCyC/pl2aptEODBtsYqWRnrCGBc8
 gGA5FFKZW1LAb7g+xJ0JbAVJ0t8ey/k4cpQOApJCaEapwcB9j1QF2PavYIHw79I/sqtcVL4uJZz
 W4fJEBxA2GMVwgSPG8S11hBhgoMLk1tGfj6mQf4OqM7Jx4QUQNOz0zU/tjchmvpgXpPN+hIIvuC
 XW0BZO1s8pJKtBjOFviD4y2DdgLdIfDeRr4VlQqbigQkjMICw0bCnB4hTwxwbmQuDYSr56MzR5n
 bQvIYlpBbiC0yY2oH5YM86rKgMthIHIs/tymxvrXx83K7pxSCsiOw8gcQ3qg==
X-Received: by 2002:a17:903:faf:b0:2bd:2439:25fc with SMTP id
 d9443c01a7336-2beb033f460mr169505875ad.7.1779786919586; 
 Tue, 26 May 2026 02:15:19 -0700 (PDT)
Received: from oslab.. (n058152109154.netvigator.com. [58.152.109.154])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beca535bc1sm71381615ad.56.2026.05.26.02.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:15:19 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de,
	kees@kernel.org,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>
Subject: [PATCH] fbdev:modedb: fix a possible UAF in fb_find_mode()
Date: Tue, 26 May 2026 17:15:07 +0800
Message-ID: <20260526091507.421730-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

If mode_option is NULL, it is assigned from mode_option_buf:

  if (!mode_option) {
    fb_get_options(NULL, &mode_option_buf);
    mode_option = mode_option_buf;
  }

Later, name is assigned from mode_option:

  const char *name = mode_option;

However, mode_option_buf is freed before name is no longer used:

  kfree(mode_option_buf);

while name is still accessed by:

  if ((name_matches(db[i], name, namelen) ||

Since name aliases mode_option_buf, this may result in a
use-after-free.

Fix this by moving the kfree(mode_option_buf) call behind the access, and
add corresponding cleanup before early returns.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec32..91f6c78f9e19 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
 			int ret;
@@ -749,6 +748,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 
 			if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
 				DPRINTK("modedb CVT: CVT mode ok\n");
+				kfree(mode_option_buf);
 				return 1;
 			}
 
@@ -793,8 +793,10 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!interlace_specified ||
 				    db_interlace == interlace)
 					if (refresh_specified &&
-					    db[i].refresh == refresh)
+					    db[i].refresh == refresh) {
+						kfree(mode_option_buf);
 						return 1;
+					}
 
 				if (score < diff) {
 					diff = score;
@@ -802,6 +804,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				}
 			}
 		}
+
+		kfree(mode_option_buf);
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
 			return (refresh_specified) ? 2 : 1;
-- 
2.43.0

