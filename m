Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADBDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC4710E8DB;
	Mon, 13 Jul 2026 10:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ve9xb9cF";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9530810E8DB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:19:59 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so3044904f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783937998; x=1784542798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9jAAyHAI2D1PucdtnorXSHGwmyQhG7HWP4Mt9DkiF0=;
 b=Ve9xb9cFkvpXXNk24lAf5V+DNxJBD36bjIzdDPBOVebqV49KlZast8QdNoxjDMht8m
 p37McDFs275fueWkG2mAHHq05+nB8exJHyQPa7ldNIpw+yJniZP7zR5UkCeogvy1b5Mn
 tNFDLQyHNGQkhmQWsDxB7Npexum6imGtidiWvoMjVcEqT8GNSJ4U6neLbjUKmdaTYEbF
 A5MI/Ic53+sx148teNbqOIaQ1nYByRlS7bgc1xUuNgawHPyb3mVlkfTbcc+Myc+5PmmO
 HGJpQdzWN7dcYWV7tjW25FeWEQcPhI95B3QX9gRd2NjJvyBJ1kIHGb1LIpphkittvSgZ
 XK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783937998; x=1784542798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9jAAyHAI2D1PucdtnorXSHGwmyQhG7HWP4Mt9DkiF0=;
 b=Efa9R+ZetsTYk2IbXWfqk2Ol2KxHpITxEcB5l2YjV+NraweJ+7ZBJRwXFjazDwoEcs
 z4WTSA44GuShWRgslhpArQLFxCIB5sWTmeenMf30aIO6STagwjpvYBZHPHfznuZiUijF
 ll+xd6l6jLwY9pSqPM/a+s4ZQJLdSA9f5lbN4U5oDIF1WTpQjbyk1dQexYAd9mgOSTVN
 wdvSX14OkDRK7U9DH7eoIAMb6A7ixboIIYMxuPtJx6OcL2tCWUNRMAM42t2kMDbkZBvi
 JlEIO0PkqV5xaUHe1zcU0velbfZC5qg6wGi5rLCQxCAjt8S5/Z4e16T8hDaD2iz6UgIg
 NfQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxyFe4ft6GBh2Wcqlne2WBtJqN2FMZuULHtgY3FvvVF+GlQsBVhxuPaTTNKmEKEeUpSun6lMdsXsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmxMZvhsZ9x2iNZRXQrxObNAQq8Ecl7b1SfuoIPjRTVO+BNRnM
 96jB5KteSoeDaHAJIFvHLsct8CG5Gz3g/qEX1yqi6bayVXD9wAJxpB4=
X-Gm-Gg: AfdE7cmr3NTNsGhIyaw1IoK4yGhF27mMS5vkY3gCrvxczO4cguryspZx2z64+vBmuM5
 0aCcHp9+/ACtBnuf6Mcyq4dUVHkBGnnSVyVcmW++2sLJBoMgwxk/8tyBM7LiVOSFKpn2x5WhHVY
 Y6xb1pS1Zk2/IyARnYL1OaH9e8HeT2vk9lySGLnKgxvi4eGzjsGAy2cnbF6J153bBdmrmN/y98v
 C7DPL/hl23wUL+JvXC6vRVraZckG6/uZ7n6QXMVw1k6xUGz59ZIVN0j2RJvVNxOkOp1mX8tiHMU
 YIdAUfHqiiPCvnzEYeAHX9r31gyj5I3TU5lIBPm31t/oZ7WLFRNnSG4JmuNO/34vrQNNgb8dsx8
 uRQKYxwpd2SpYq86PsO8SfRdv8mRVEmBjhTqB5QuoEzNXbr6nGzHWjYm3jFf8Q9tQc3Kml0dn+Y
 WBezL5F+mRtyfgyJwTpjkBh3vpJ1GWltX23/FzCneaOEEO1PrKJdV85HSeDTQW6OWMU2TPdw==
X-Received: by 2002:a05:6000:22c7:b0:472:8343:7f5e with SMTP id
 ffacd0b85a97d-47f2dc8ce54mr9184872f8f.5.1783937997743; 
 Mon, 13 Jul 2026 03:19:57 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:ceac:ba6c:1653:e93a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47aa0f213e8sm83332478f8f.34.2026.07.13.03.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:19:57 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Helge Deller <deller@gmx.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Florian Fuchs <fuchsfl@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] fbdev: pvr2fb: correct user pointer annotation and sentinel
 initializer
Date: Mon, 13 Jul 2026 12:16:38 +0200
Message-ID: <20260713101638.600333-1-fuchsfl@gmail.com>
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

Add __user annotation to buf, as it is passed as a user pointer in
pin_user_pages_fast(). Use an empty initializer for the sentinel
board-table entry to avoid initializing a function pointer with an
integer literal.

Fixes: 5f566c0ac51c ("fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607131247.fpQ6eTc7-lkp@intel.com/
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Not sure, if we do such changes, but as I received a test robot email, I
leave it up to you all :) (I also compiled and tested the change)

 drivers/video/fbdev/pvr2fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 9428716e2dc4..a6e7abca7a06 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -639,7 +639,7 @@ static irqreturn_t __maybe_unused pvr2fb_interrupt(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_PVR2_DMA
-static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
+static ssize_t pvr2fb_write(struct fb_info *info, const char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	unsigned long dst, start, end, len;
@@ -1077,7 +1077,7 @@ static struct pvr2_board {
 #ifdef CONFIG_PCI
 	{ pvr2fb_pci_init, pvr2fb_pci_exit, "PCI PVR2" },
 #endif
-	{ 0, },
+	{ },
 };
 
 static int __init pvr2fb_init(void)
-- 
2.43.0

