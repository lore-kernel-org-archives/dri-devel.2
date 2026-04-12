Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87ACE937E8
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 15:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C0C10E029;
	Sun, 12 Apr 2026 15:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JebsrzBE";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BE110E037
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:46:45 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-483487335c2so37627855e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776005204; x=1776610004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bBPvbkrYp9W7ICoOlah1q6oHXqyE/KvHmdfXYMP2BrU=;
 b=JebsrzBEGHYU49gBF3e374CU564QQuVtqKT35/sPqndMHPo0iDaaGiKNv0nueETr+A
 1FXfnAXHyDrcX796cvXC/o6PWLaTUqKl2PNQLWlmNAR6G2KmTt7kNO8nk9mBwjSZV/z5
 7iE9gfgpO9KWaN1BTS3e9Bf1eo/STf9m0J+01Iyqv4PfWRhYQVLzBONn7a8n+F27CFQA
 T5iWbYXjjYbwxhsX3I+DWQxPsoZAUUs7zc80JY4jbAiKA39htuxY0s5TK6j72OjZXWwm
 3tym9pAfrbIZR9YSzC9kCDAWBK7idsqvth8FLSB/Al55YKNuGjeNjcXPziwQ9zFtdtY4
 oayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776005204; x=1776610004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBPvbkrYp9W7ICoOlah1q6oHXqyE/KvHmdfXYMP2BrU=;
 b=dhNQpqGCGeAbkGNIbrhEq4c+T25khWO7OoUXteh5KSd3AA6G1zhCYaL6IdcVqcwi4t
 54Z+pJA4yIiAvCehFTSNV8mlNgv1CMg0LxJ7gNPAH/gCxFsZ0WPDrbP9xEwxyp2HKbjE
 mf9nZ6vDKjPUScHTpdjEPnMsT9DConUO+kCNx/S+ge3hHoBeWSDAs7VKf3WbSrdK0YnH
 UZf3xiRgwqHhFgIAFsqhZo/r7nqeMrG1UjL5kG46DACeEkSZMC8U1LYndd1SSw7jbMpR
 nY8FZWZl9NIsTGmkmdP4JyrUhYL9X46c1h0LZkk/vU+dF57wXIVZFmW1Tqq3fkk9fCa/
 H/iQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dg1YnJCmOb2ukT+Bz+pHZrqo8i/D8u/Y9tbSm9Y4bF1MEbH+DVbexLe9W79x5B7nF+rlnWUbcbBI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1TsAO284j4HfLR+USvAgKQFiW0xo4LnJ3d/557J53RlZXzAQM
 e9TKiGIZWpE+iJ9ACASWwMFG+a+LokEVY9Y08UR7PSZA4byfKLvpPBfFc9w2TQ==
X-Gm-Gg: AeBDievcI7FY01myzzNUCCUOJYeVdPyT8cru2lpwsGHGCzXwtOuCmAWYC+VSz7Y0jFR
 0Su89D2VEAurA7CcTWY/FFo8wzOWS9UiypiL5+a8m5yDT+aaFhap1g27wABDlw4221vEVcajFzG
 cGbDSUCJ7b2xcMguoKp1u+d8x+SDlinEGR8sH2U8Kmw2a3EWCf/tty3wfTXuBj/5+eqe8HOM30Q
 xA/q5t/isl3vuTG6XUK9+qiEydsjxFREHVr+DAsiylLqELqH95kvyoSU6zi48G5lP+SgJlhsGso
 wxDYWEGX/sr5l5pMDi0WW8N74nhxDMMGMAnI09cfOB7deIP/RkvCUGpsrXFlG5yXS/9fI6odl9o
 6urF+684fwDb8djWl9ovEuOno9+JZY2kYS7EjQin3xnHzrvimVwzZkYEJydCiKzKmOuxlOG3REP
 ipFZPos7PHRhacpen4T9GfK4Mor8XQVC0XSC82YPOj0tz1gJBTsA==
X-Received: by 2002:a05:6000:2489:b0:43d:77c6:be6d with SMTP id
 ffacd0b85a97d-43d77c6c43bmr1268704f8f.7.1776005203537; 
 Sun, 12 Apr 2026 07:46:43 -0700 (PDT)
Received: from localhost.localdomain ([72.255.58.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5ccdasm26622541f8f.34.2026.04.12.07.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 07:46:43 -0700 (PDT)
From: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Subject: [PATCH] staging: fbtft: Use %pe format specifier for error pointers
Date: Sun, 12 Apr 2026 10:45:52 -0400
Message-Id: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:30:50 +0000
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

The %pe format specifier resolves error pointers to their symbolic
representation. Previously %ld with PTR_ERR() was being used, %pe is a
better alternative.

Fixes the following coccinelle warnings reported by coccicheck:
WARNING: Consider using %pe to print PTR_ERR()

Testing: I do not own the hardware, therefore I could not perform
hardware testing. Compile tested only.

Signed-off-by: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1351.c | 3 +--
 drivers/staging/fbtft/fbtft-core.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 6736b09b2f45..15524b80035a 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -218,8 +218,7 @@ static void register_onboard_backlight(struct fbtft_par *par)
 				       &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n", bd);
 		return;
 	}
 	par->info->bl_dev = bd;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914907..823315dfbf5d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -187,8 +187,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 				       &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
+			"cannot register backlight device (%pe)\n", bd);
 		return;
 	}
 	par->info->bl_dev = bd;
-- 
2.39.5

