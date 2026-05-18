Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFCFCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 21:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB01C10E342;
	Mon, 18 May 2026 21:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gpum6Tps";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAFE10E342
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 21:13:22 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-82f8893bff3so1255645b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779138802; x=1779743602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5kHLteZtDYYZ0uPDSlKWBJ8+KtD0htFyv3V8YBKOEqE=;
 b=Gpum6Tps6tP7SN287c3ugFdUqYVqK+2PNoTRTo1LgpdEN7bM5ma3OVFB9AHJA76eam
 awudHJ7lxufJgr3uP9FEnERwbnTJFSbXxu+QGBD6aEfnnlu+Tz/mPmc6CCFFvOvO8g+a
 GIg8WfOQu4qiYRME/rRHLl6bvFN2zfanSnAg7rqdWZLP/ERvgduZDW4dmFLP1BkQnynY
 U+pB2pUXEOpXMGDU0h66hsSZSr3qll1s0Oa6vYDiuRc8czB5roMZgZRRadsFT8mzYuiK
 rh6+IMljfccCjhy7ZvkNV1uBh74KdODtWlm8/o091tDevnafZVfx9FWEZD564sPvfuS1
 GAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779138802; x=1779743602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kHLteZtDYYZ0uPDSlKWBJ8+KtD0htFyv3V8YBKOEqE=;
 b=YyAvCRVa0j20GdROIjeuE47TP61c8xrtR4Xab2xsuiTKL0hLvPalc1hdF3DEWzqT3z
 TJNeiL4qRX7km/QsQ0zMvetCZnEHGVLt/966ADUEa4WeU9XYXp6ja7Of3iY+aWX6cs1N
 WFNrgFrhZpLrqAzQ5er8HJZD2slRE0FhQF7v0dbpw/eYPUsQAE43RKzgf6p7C6K1k8Yr
 ObCoahqSHYSJf4/UiG0+8KpAhNL/dX+EtH7VLT0AZEqlcy60876/sSBZY4Fca6coL899
 apvfU81cPP3e2wIuu9GTY/ck0Bs9EyULJRprHTYBK0X2mPqFNUwBZFoXEH+QLBPReQGr
 MWRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2yWdn7tNuDWWPTOuoH15a74LCFxXHSoIXxZT6tmg+DOYGpr2NduM0upW2VKlUV200PIxmw7O+F74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlSiNnb8Uju3Mnk/cG5gaRkBBKNPK0nGhUqnkm5MXtGUlBRqYc
 xsCMmsiXx/2KvSqTXkgwmK2PxAVyEI8S8H7luqKw+tn/qMZZ6nyYVPLN
X-Gm-Gg: Acq92OGWIXDYjSYUfN4bVMi2XrRjkzminsQ9XDCc7kKcoUBZZEsSKke9mnu6H7wZ48x
 XfyHaNT1d4MUjJfR2VQCi7nKcd9hY2UJEpV48JInErnZzpJ5ky4oflCk7hV5otsknOaRB8asuhe
 5lluOJI1LM3WEa33x/U6nOFajruMgGTBFxz7taK0u62wLzbFq8C88HYGBKfd14R+HbXilXHP4pf
 O7nV6xp0iT4HmgQBK1vMKCn+BBg/yl/MKSP8CgT2UgivAVcdHDvB1RG+DA0j3EeDtpJUxw5AcNQ
 NUMTNDcW/4Sa3QviSeaTgY2PwYJRO3mU7aF9XEhqCDtdolocse0fRSwCm19BKD95VjxgoKwSYZ6
 ICpZtNbSJqO9lM4IehbasBzKkkwimXGnvta7cia4JOerqQrmk/NbXD2K3IcNk6Iax58X88OdOhi
 unaM0l/BIyInCoNmuBhLwptF4tJVwQtdqJjsebLAjOml4pwN9NMXuVDtk5HoTAR7yZ8envhyRNS
 95hF0kzBMKYmznio0TA9AE1++b08t5JkPO2LUTZD8+ekg==
X-Received: by 2002:a05:6a00:88e:b0:829:7e6d:cf22 with SMTP id
 d2e1a72fcca58-83f33dbe4famr15918075b3a.43.1779138801540; 
 Mon, 18 May 2026 14:13:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196638d0sm18775306b3a.7.2026.05.18.14.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:13:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Helge Deller <deller@gmx.de>, Frank Li <Frank.Li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE IMX / MXC
 FRAMEBUFFER DRIVER), 
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: imxfb: Use of_device_get_match_data()
Date: Mon, 18 May 2026 14:13:03 -0700
Message-ID: <20260518211303.10777-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Use of_device_get_match_data() to fetch the platform ID entry directly
instead of open-coding an of_match_device() lookup. No NULL check is
needed as every compatible string has a corresponding data section.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/video/fbdev/imxfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index a077bf346bdf..7a021da0a32a 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -30,7 +30,6 @@
 #include <linux/lcd.h>
 #include <linux/math64.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/bitfield.h>

 #include <linux/regulator/consumer.h>
@@ -880,7 +879,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	struct lcd_device *lcd;
 	struct fb_info *info;
 	struct imx_fb_videomode *m;
-	const struct of_device_id *of_id;
 	struct device_node *display_np;
 	int ret, i;
 	int bytes_per_pixel;
@@ -891,9 +889,7 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;

-	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
-	if (of_id)
-		pdev->id_entry = of_id->data;
+	pdev->id_entry = of_device_get_match_data(&pdev->dev);

 	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
 	if (!info)
--
2.54.0

