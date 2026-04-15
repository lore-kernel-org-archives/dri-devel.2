Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D786DF4213B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E73710E73A;
	Wed, 15 Apr 2026 19:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZP1+HJP";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B4A10E73A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 19:17:59 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c795f75e971so391598a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776280679; x=1776885479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
 b=BZP1+HJP44um10xANtiqxtU3bAIKJzk42tZKIWlHLD8iWU/L/yXVlgcCvCz7PPd4nc
 KhK5+zocvldavXDs2IAjNf6Uw9qthI+SwiM9+RQ3p8xwksLLpEgmLYr228nFkea5CnA6
 LTzhNSnT61iYx291bkg1NVLTRqEeE63gY9O5/Ug7lfQMYcS3DKwWjLHvzThkIcTaSG/t
 VBoxuKo/m779vkRZNLor4iypZv9jWlwmUbVIc9sHCZEIYbzn3hm8kx+PIoMWeesmlNWx
 OSPkGajlvhePZm0uDroJjV7ttK7PV1O80ynDZnBpXLWoCMOwZdPa9fxSstC2NfAdAvfq
 eddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776280679; x=1776885479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=db1viqbuVUDqwJpETiZkl//3ER+sg+ZcMt0690Q+Yiw=;
 b=l9JJOTuIyO1hfDxnjzrJlC+8Px2edubDx7Gq5Ebbfac7AcJb6gmb/7G0ROa9HmMHpJ
 qGi0L3OWytewHiKuft/audRGIzprgoPR2eZtHkrP8LCNw9vfARmBWo+qA3nIz/GYpOdW
 FfYJTEx68vCEEN/qeVeMEitFxgprxIpMz118Ax85EDNDzc0k4WE7E6k6Z+eFfUP1LCLf
 u8HRE6ITAr1gJ6IGvMLRR+erGZSBySoH7QhRJ7f1c4W11QHbGsumOC27+wUI4DuhlJPE
 A4L2WXfrdfOoNQ5HL/O3fYnT39gTef1BQhBh9QP8AR4QJtGPoVRwITepX1jTt9MADH8R
 Oryg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PetG9e3zGQDrJ6h2QSS4rEWEhFcYwVuVwj+goZjzrlMyizj55j5eQrv+ywuOtMxvsRwbJQ44lzLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjdNwCzHRL6BnA+IR4BIeBfKvks9tHnh3QepsSFvGAzSxXvytW
 6ABz56BqvC1PhWNyyv5qP8dj/lCU2lzqxKgWd/3SfkXUWmP5HvZxeRQe
X-Gm-Gg: AeBDiesSp3/OtQytF07M9Y8Sh4pg0i8X4vZz62ntAxX0RrkwWZcKcYeWqMd4UyKICk4
 SCyT9n9XTOCd4v32cIDrgqodhYHhM6wDfdP4XIhtL/uX0eTXendc2lC66iXiwT8+Di9/qJHV/N8
 SA9Y9b4m6iVTO2zJGcK4Nt98Jm5mpWbQUWiSTEZ4h2jQm2fZ7pdQcbs9FPrwwd/KrXg1uzX4YuO
 gmLMJtqkQSTqeq3yN0GPr+ydmmKYB7oICVG0Faf6w8KA6KOo6MNS6p56oayFQRjXiOCn3pd/PD5
 VVoAqYmyJ04l1bRkD+OzdCx8IUPxTROXo2MqrOiSg1XW4DrBID84Sl0ja6hpCtAIiFtfbKalC/n
 leEDgcHx8n3f41TCFbfNW2g2HvT/soFt/9o1WK48gWsQLAvE4fkgGJB7fptcNyz/TaUiJxNAHUy
 2A6vmWPRFn8O/IVc4g1f9PtBtuHDUE1rUz2CQ=
X-Received: by 2002:a17:903:284:b0:2b2:5822:7a70 with SMTP id
 d9443c01a7336-2b2d5a63d4dmr227552715ad.38.1776280678725; 
 Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782acaf0sm32022445ad.67.2026.04.15.12.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 12:17:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Kees Cook <kees@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org,
 linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: omapfb: fix reference leak on failed device
 registration
Date: Thu, 16 Apr 2026 03:17:47 +0800
Message-ID: <20260415191747.3845525-1-lgs201920130244@gmail.com>
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

When platform_device_register() fails in omapfb_probe(), the embedded
struct device in omapdss_device has already been initialized by
device_initialize(), but the failure path only reports the error and
returns without dropping the device reference for the current platform
device:

  omapfb_probe()
    -> platform_device_register(&omapdss_device)
       -> device_initialize(&omapdss_device.dev)
       -> setup_pdev_dma_masks(&omapdss_device)
       -> platform_device_add(&omapdss_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: f778a12dd3320 ("OMAP: OMAPFB: fix clk_get for RFBI")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index cafe859d6e5a..0d47a8aec5c5 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1768,6 +1768,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	r = platform_device_register(&omapdss_device);
 	if (r) {
 		dev_err(&pdev->dev, "can't register omapdss device\n");
+		platform_device_put(&omapdss_device);
 		return r;
 	}
 
-- 
2.43.0

