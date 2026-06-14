Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1E2CD98D6
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FE310E23F;
	Mon, 15 Jun 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iJ09+Qev";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C133D10E0ED
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 20:08:42 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8ccf7b7d188so33071466d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781467721; x=1782072521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qu5+bIQSk8l7rGQCe26ymBQKDA4my8QPuaUxaRTH6o=;
 b=iJ09+QevSlujgEUDor650gdwWi97CvYjUScTz6paXnzfP90KKy20LYe7JhffkpVDDl
 gza5es9z2qKtOXvPlFXtHGgidd0BhDCLXYc8TkPGhF7su/PPWsvoMiYTGzi7kgbs6IjG
 DIe6Hwxwus7PDbeFt/v8fVB0YqUQykquPUGfszUzI9sHeHmG8tgsWr5AUdv1py33cgl/
 yEVcQ6tnm4m0eKfrzJo0B+saBnw6EH8vLxKudyaLZ7zqlnOgQOV9ncOZHDVg+EPWv7Yf
 u8/dbU3qUn01EgnUsy7fjWY4zFfuuXZw+unRb4KJScJMPvql8ArcTsPA7rwvgdWNCyr/
 ZDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781467721; x=1782072521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Qu5+bIQSk8l7rGQCe26ymBQKDA4my8QPuaUxaRTH6o=;
 b=QuPP3XubXp+Fq5wSqhT45zNXXTMTXNW0zZOf8skcwYbE1lLVYQcCdCYkFymRfZhTEF
 u57zPdqDnLbJcojvExU0tmLX/hsQhrI3Je0rm640fSgOxqhSU0H2opdBtbIcGvDj7JIk
 Ge0XgsDo5XpTj6/gQHGr6fN6m/fe56zbgFved//TcLIwhIPprYT0HB0EWgEtd4+zM3Dg
 SQUnbj7+rI0tXfxBYQUud0gckvm/vpIkIf8Wq43D8kkbJj3pEFoEmqo5dGOw3DxmqiCI
 QcjBWldKB+MMdsTky5jJwTzGkoWRi7MEVeN1LzQVFm+/ql47XH8lHUuIhzfKW0uES0g3
 yW1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8S5WeYBTrWu+Ey6fYO5Y09LHoR2JDclfto6TkFfdrN+4iGDGfOPrn2nIIrPE/ZsU7gggEHI8otpjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwweyNWxZZ4H/a9Oq+lSTZH90MDrqHIQCZAA+/QrpCn4HGtTYHu
 KSZrG90yli+eqDoh4WG6ciQaE1LvBRXjM+4/VR5kyb1czmiI526E2Re7
X-Gm-Gg: Acq92OGX5pw7MhGsmv+jA8yrw9Wu/scC09Sfn4X52uyj0DmADY3xCiXotqf9rIiR7r2
 zXp1+gGOqmfqUWmfQl6ks1JGT8cBDIxiRU6PX59HDSIekiDpNYcw/+HzrgMIeafuJK44xR54Rp7
 L3bYATTPCh5623rnLspr4zkdLlNwsFS5vgT9Yw0IIEJtgy+5gJzYWybct/LIu1wKxZRX3RLUutR
 OovAyI0mT0iNkB0RWo5amPgjDhlw86IlssBvl24F8ePHIahApbuL1yiZWedkYgnicOsi1Apocxe
 HdQWLgxAWnhAKZDZETZPbUBRnkIvh7mXJtvMq9eus2sFM9Yz89HP96nORVyqEvhsSP22br9xBzv
 EabXAWv91VX4AFaR3po5QwF+mKJz7cNwCzsW96yIUmaAqQnENNY8liBXm/HjxtXpzFotOoAL25Q
 jOcAyJQL4FRufU2r2XH2bCb82XdxLcsFN0Mm6CSXxcfXWymEByK0WXHtg=
X-Received: by 2002:a05:6214:3189:b0:8ce:cc38:e496 with SMTP id
 6a1803df08f44-8d32e30f3f0mr196398416d6.22.1781467721402; 
 Sun, 14 Jun 2026 13:08:41 -0700 (PDT)
Received: from localhost.localdomain ([38.174.6.30])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d300f6af40sm90192986d6.8.2026.06.14.13.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 14 Jun 2026 13:08:40 -0700 (PDT)
From: Keefe Reeves <reeveskeefe@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: abdun.nihaal@gmail.com, error27@gmail.com, chintanlike@gmail.com,
 namcao@linutronix.de, niejianglei2021@163.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Keefe Reeves <229415268+reeveskeefe@users.noreply.github.com>
Subject: [PATCH] staging: fbtft: use %pe for backlight errors
Date: Sun, 14 Jun 2026 17:08:37 -0300
Message-ID: <20260614200837.17908-1-reeveskeefe@gmail.com>
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

From: Keefe Reeves <229415268+reeveskeefe@users.noreply.github.com>

Coccinelle found two places where backlight registration errors are
printed by passing PTR_ERR() to dev_err().

Use %pe instead so the error pointer can be printed directly. This keeps
the behavior the same and just makes the error printing cleaner.

Signed-off-by: Keefe Reeves <229415268+reeveskeefe@users.noreply.github.com>
---
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

