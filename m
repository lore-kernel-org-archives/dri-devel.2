Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7716CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 02:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57AA10E41B;
	Wed, 10 Jun 2026 02:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eB8bGhGG";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F7A10E6B0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 02:50:26 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8423f626a65so2694307b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781059826; x=1781664626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=New9XIBi5RYOIip+hYx53iokI1SR5R7v21yzx2FBPSs=;
 b=eB8bGhGGAkqlbMB1+A6lb1S8kFaWsRiETc/wYqVdU8ej4TTFPpSPrvNc2ZkW5RcXGH
 hoWuSlYfm3L/SmVP2wPzc4Xix91TajDGwy5nN2eik9E2vNSfVO/UqDEU0BSzhZFwGDF2
 M7HZCktYhdztJSKx4GKoXEP1kjEcO48/C9VQKo/KvyrGMdyQ+MGTJssFkfOru5bxGd+t
 /6h+2JqhwtWpNsnVqn4xeSozDGlydYqHfR/bmC6AWBZ4Qva6Bpno/bs95C0fBcjIApbC
 dS+zILQk1oE/goMer0zN0hWsepvVasmO29FJwuHMSuw01Y+fkkcfacM/JJltNklTkvJs
 9zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781059826; x=1781664626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=New9XIBi5RYOIip+hYx53iokI1SR5R7v21yzx2FBPSs=;
 b=s9vhxU8VMgN7atAunqSqVyV3IQDl4ThE9P89eDyLnpjppRtKdRWEQ0G/q6yr94/uGy
 tXFRS5Lfg7JSjUDy4estpa4mAkROw2p6pm/Big+uXL6FZf0RdMrBsZUGmieVEwAs0uzg
 bgcbp+VJY4r6XPhUqyQc+YvHe/pZCTvvJ+xH6kgxkPOwwO8recG3IO9SqhO0ltkky0nr
 K322vh+ABz9Sf/cXav3L8GPluQblwQUkJNgxy95PNG41kF9A4W4vXVURfQ3+RIMyyMyd
 QDeSnXzV7uJ1/GldOpPjaP+WDql7Iuxdb4etCDRADuxqIXoK3tKkvGBXDYYZOoFQw5Rq
 p/RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l4t2+rCQPr4nqtLF/PrCq48yX5pIPgMxlPIdKQC54EsqnHyzZT7TP/YyDk/r3OlHUTxKmuwoZQ80=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyCl+exdXBZfOtGeZoWJZwEhZ5L5X6jvdH2EY/PaAwQ7e6GA1A
 hoP/+xuhml1J7z5gbg3ukLzDIYjaxT4v0pCKmTyb/QkPXEEmEy7r8or6
X-Gm-Gg: Acq92OHT4HEHmXoINfBJtIIaa3lydibKRYKW4ZUBumFieh02ZekrKSxioArT6DAtmq7
 c9Nm6bjeqLUQeJEVVsmmjS+K/6QQgPff98Ms44kRtez60l/WkMSAY2ceqwFK6zYSKcbDXu37OuW
 B7tWq355fWiwm9A/NamaIQRv4bi4fW+7bjhqAA6aROEh8RG2fynAIEarD5TM40CEk4EEzxiuQDF
 g5A/6vPdiCrzQUHle+ZpTxuVNddX3hWS8lambi7ZxuYZ4sz3DKf3V5T4DOEQsZY8RAtxRa+AHQi
 pap1IkTTkdF1b4fNluOf0r3d3xrB2yw4SiycuwPnbtkGyIHj1Q2YUMHi35qVUfw3JwXoUZCxY4F
 6p7YMolERwW1/fMrY8Xsxe4PgcqWx/jXhNs/nu37sVWW7Bfjql/HavgfuAK3zNY13t5M5mxfiN/
 l9QrPFFu4Go7MoeTCBNlVr9F/dpY8zckeQyO8+s+22k0HbL4AZt3HsW24uHOXq0VT/iao=
X-Received: by 2002:a05:6a00:4fc9:b0:842:5931:7b8c with SMTP id
 d2e1a72fcca58-842b0e20598mr22341362b3a.1.1781059826283; 
 Tue, 09 Jun 2026 19:50:26 -0700 (PDT)
Received: from oslab.. (n058152109039.netvigator.com. [58.152.109.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842820e8e6asm22196451b3a.0.2026.06.09.19.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 19:50:25 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de,
	tzimmermann@suse.de,
	kees@kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>
Subject: [PATCH v2] fbdev:modedb: fix a possible UAF in fb_find_mode()
Date: Wed, 10 Jun 2026 10:50:14 +0800
Message-ID: <20260610025014.5913-1-islituo@gmail.com>
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

Fix this by extending the lifetime of mode_option_buf until the end of the 
function and using scope-based resource management for cleanup.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Use scope-based resource management instead of manual kfree() calls.
  Thanks to Helge Deller for the helpful advice.
---
 drivers/video/fbdev/core/modedb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec32..b6926764a99c 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -626,7 +626,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		 const struct fb_videomode *default_mode,
 		 unsigned int default_bpp)
 {
-	char *mode_option_buf = NULL;
+	char *mode_option_buf __free(kfree) = NULL;
 	int i;
 
 	/* Set up defaults */
@@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
 			int ret;
-- 
2.43.0

