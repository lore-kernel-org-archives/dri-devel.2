Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734ECCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F0110E246;
	Mon, 15 Jun 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pf/leJpN";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7223B10E10F
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 20:16:12 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8cceaacd07bso33814636d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781468171; x=1782072971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7MKHApoD4FmbO7LLQOWnCTjAAZ+14mTiiY6a3gJWdwY=;
 b=Pf/leJpNdmDw8EaLH/IoSk54wICoXD4JE3JCvD1fjfB0c4IgmXDQSwHvzU+Jt489N+
 yy5/t5HOhkixN0hLqvAOHXUtJsrXp8Nw42+VKoy4YFZnGdUi5+wCEWmJta+uk7t9nUf+
 Nm51s6izKcnwHydlmTX7ij84JOgui8LW4lR92Jm+nB5wbzru4W4szqVdg5VBVK2cOK+d
 RGUQ0H21okKI47ZimX4PFCCRimjMzH0wz3JjYE4wqdj8ug1oD42KcIH65YEH3C0w6yea
 a60lc6iFMo0pPn6KNjT8EAkUEq/mkB+9MkR1cPR4OmjcUmrlxMPGOARmvf0zwb6XOhVf
 eMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781468171; x=1782072971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MKHApoD4FmbO7LLQOWnCTjAAZ+14mTiiY6a3gJWdwY=;
 b=lkBuJ/GkpbhfhwG47wRkTpWBvzllFV4MVa12eNKcpgB7kRiZHlL+pXgMVuYtCnMBuw
 Uf9GyH3O/RJ/3FDYUpiQDOloJIA3tkO5CPh8ZZ/FuerZCoeT2Ukd+EcYVTxRskkjVo2t
 TQrb914p/MYNm/s2nkQLdoLGK32ucPu6zzwTeUB3P3cN0UHEPKJZhLamsewv6iqBxCGC
 eAZXger2cU+H5nh8rTj3hs0O5rV8Gt3nXvv24+SGmQnP6biv5AMSSTGzlyRiK27Dknhr
 Z40oGqkTBIudds7aJi939MU0K4uutQcj3xqXJCfSobxMYWlThCDGRNwcW0245tQamdBC
 wcaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+z/+qoUoG6M0Fq9ukQ00RcrGk0FutcOrGWc5KmYnpi0SAhFg76002LlG8ZQfq4GhqCq3FT9xKhcno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyH3x83SyK1of20JtYAPB48azJZ60X+jR92iHDMhvScy2iHz3QC
 JIDeqxkjRry+Gcrth3QhP/jHG+MmBVJOb5VdvltptFGITiaJjZ0G+/fH
X-Gm-Gg: Acq92OG00viKYZkQobWL9Dg7GJOE8vjoWNb5MEkfw1GTT3sA1j2PyZ9FN8JitymQBnz
 6BYnux+lHWVAIGRq7mJ6tx8Z6yDDZjLY9IEZae15PhiU5aamKNK9/y1i4NkuNCiBOGWyxDD+CvD
 8OCQrKHFjVe0K6fD2ukXdjCwmpvHGllFyCEpcZjqPTW8+xRmVNu8+Q63/FMCNWAvT3ZpZDzb7hA
 vsCYHJ1xF8J05YG8eaNUX7viBU6xOl1rWo5BxiFfXp05vWUAIunk3uLNQxSKL1z9rlC4unxo7mX
 9+QNJoW9iGnCjHUk7thMr6cmOtfcHLTGSuySzSFpaBQkY0kGRLKrmS2FVHr7XA6wVOsVxHZTcFZ
 pgKgFrOZqfb9jMC5Do87GVbMJ8VjrQKarQMM5R/eewmvR1xRql5C6EQtBAaq1B4n6dcDTAAJec3
 Aftxgt5bA4S433E30Xno30mWvZ0jO7YCIhOuRxpcwdoERU
X-Received: by 2002:ad4:5bc6:0:b0:8ce:abea:4723 with SMTP id
 6a1803df08f44-8d32f599636mr195018916d6.40.1781468171377; 
 Sun, 14 Jun 2026 13:16:11 -0700 (PDT)
Received: from localhost.localdomain ([38.174.6.30])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d304f3e55fsm90190706d6.39.2026.06.14.13.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 14 Jun 2026 13:16:10 -0700 (PDT)
From: Keefe Reeves <reeveskeefe@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: abdun.nihaal@gmail.com, error27@gmail.com, chintanlike@gmail.com,
 namcao@linutronix.de, niejianglei2021@163.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Keefe Reeves <reeveskeefe@gmail.com>
Subject: [PATCH v2] staging: fbtft: use %pe for backlight errors
Date: Sun, 14 Jun 2026 17:15:51 -0300
Message-ID: <20260614201551.20542-1-reeveskeefe@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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

Coccinelle found two places where backlight registration errors are
printed by passing PTR_ERR() to dev_err().

Use %pe instead so the error pointer can be printed directly. This keeps
the behavior the same and just makes the error printing cleaner.

Signed-off-by: Keefe Reeves <reeveskeefe@gmail.com>
---
Changes in v2:
- Use reachable Gmail address for author and Signed-off-by.

 drivers/staging/fbtft/fb_ssd1351.c | 4 ++--
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 6736b09b2f45..b6cb60f20b11 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -218,8 +218,8 @@ static void register_onboard_backlight(struct fbtft_par *par)
 				       &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n",
+			bd);
 		return;
 	}
 	par->info->bl_dev = bd;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 3da42c8ca6e3..b6a846ada3e0 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -187,8 +187,8 @@ void fbtft_register_backlight(struct fbtft_par *par)
 				       &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n",
+			bd);
 		return;
 	}
 	par->info->bl_dev = bd;
-- 
2.54.0

