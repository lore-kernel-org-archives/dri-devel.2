Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A43F327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE82410E7FE;
	Tue, 21 Apr 2026 07:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eqOx1HZI";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2376C10E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:45:05 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so1413803f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776692703; x=1777297503; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqCHN1cCEt3ASeaIcQIdHw02mQbDZZaQMdp0xTMA86A=;
 b=eqOx1HZIwPpScvRY95bbYQD7/FbViljf1NqJZIwwoNnP1T3R3xRAsKoPpIK+Ni0Dbu
 uiZJ3iFMKuvHTU7yLJhX/s7xqZDtuM4swUYAzVXHq7T3uo2D9hx5mp5Oih+d1G+lqw4U
 zWZ3RInAshNqkuYUK/+NH+VGKEZb/hybivWvpJHPV5/GINy6JfoLtA/UeQp12CgwONau
 Zh6+ZoTj1Xut10jZFaZwTwJP0b+W4uU8/KHiQCImddSY0u+gi80phlYwg7Qg/tUA6iNg
 vVUo7U7d6lF5FUOWqiHSBIOAEv36JqkY8QQZPoK74yY+G8yB0aqYN8iVRE/7gY8bSFkP
 Q+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692703; x=1777297503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RqCHN1cCEt3ASeaIcQIdHw02mQbDZZaQMdp0xTMA86A=;
 b=G+Vn5qaagvyEaO+X2KqDe0SOLyf3HadVuL5VcupTqVREGNiTLjMzmjFjUWXTZUrYNd
 15fW+Djwb8ucBGljBo1pLZQxGvmGtnTTfcwRuN+ex6ltvX5F+hUNEpCf9+FBQQjzrQ0q
 7EwY2nZ96Uqqh8tNrFC+TUHdCJgLAqQgMFWUZ69Y6Y2C0vJGFVRsJEHmPnw6pY80YNLW
 T1g8kG2+ogkHhqist1mZZyS2vSCnaqJhGeV5VNMhBtJNx5kGJ/axo2VGkp2+kIiOVGYe
 +0X6p3PjZwe8eAFZTpacLQh0YSXYG1BSsswXR3vXNPEMkItGIcC5PCahJnBkgV7GvuJQ
 CAyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OctYcFJ6Q678e9+UDXTU26wluAGySyvUFJY6cgtllYRJcLbelWFLXX1RWbxVeocQgb9saOl7EFHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyu5IO2DJBV4VMPZsLaeI0NmI/F3VVwxc7X6+S4kgLo7J8aHGo1
 EXXizOKEo8Ak9mjy8lk1olutGfk/3uV8zYmp8fTgEleLPzmJTo4GSC+AkdG9SmmI
X-Gm-Gg: AeBDiesOq1INimgeMOcQdlNoS4LxYyBnW3IbWlflscb08ryeFloqIPBjzo4ZVfmYKHa
 Jvkq5gxXlmiDxWCstgZjK93kcgkidOG2wAn8EF+T0/WfukBf4qUmTBwOiwE5GNAKC0Y3h9tlA1l
 E4TmtUzEcEbjkhqQQ2tT/pOTbR9fi59B64tZ2qZ1K2mNvRDGyP9fpQ+Lkwd/pZzR6dSn414SRze
 c3fMG9dkqLJEaoEvqaDkbDn4hWtcIfu4PJ7VlfIDmTDLkbTV79DOIojQbJayYfn16OAKchqK3Av
 1hox+Ju0vkd0+nhDXp1LO2qF6pUZXDU8/vlFkvPwCiLZg7oHHHgNAacDwA7LlkUrk87o1a8ipSg
 FhoOC+98r29zAfcPwJSBzni9aTfEmVxd48MHyukydgpFgZdYh1lCyFZlblabspkKbTUx2cNqi7V
 uIQTHjL/wsBnpgqD6ChBBmJI188iZ3nQh26mleGed4xZhNuITTX5Q=
X-Received: by 2002:a05:6000:1889:b0:43d:6244:f8b with SMTP id
 ffacd0b85a97d-43fe3dc3824mr21219986f8f.13.1776692703207; 
 Mon, 20 Apr 2026 06:45:03 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:45:02 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 3/3] fbdev: goldfishfb: Request memory region
Date: Mon, 20 Apr 2026 16:44:24 +0300
Message-ID: <20260420134424.77494-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Use devm_ioremap_resource() instead of plain ioremap(). The helper
requests the memory region before mapping it, which registers the range
in /proc/iomem and prevents another driver from mapping the same
registers. As it is device-managed, remove the corresponding iounmap()
calls from the error unwind path and the remove function.

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/goldfishfb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index ffe33a36b944..14a7cb0a7a1c 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -194,9 +194,9 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto err_no_io_base;
 	}
-	fb->reg_base = ioremap(r->start, PAGE_SIZE);
-	if (fb->reg_base == NULL) {
-		ret = -ENOMEM;
+	fb->reg_base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(fb->reg_base)) {
+		ret = PTR_ERR(fb->reg_base);
 		goto err_no_io_base;
 	}
 
@@ -273,7 +273,6 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 				fb->fb.fix.smem_start);
 err_alloc_screen_base_failed:
 err_no_irq:
-	iounmap(fb->reg_base);
 err_no_io_base:
 	kfree(fb);
 err_fb_alloc_failed:
@@ -291,7 +290,6 @@ static void goldfish_fb_remove(struct platform_device *pdev)
 
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
-	iounmap(fb->reg_base);
 	kfree(fb);
 }
 
-- 
2.53.0

