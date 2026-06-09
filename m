Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52533CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C94310E7C2;
	Wed, 10 Jun 2026 07:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXO7q7Sy";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C2C10E139
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 07:34:14 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-37474afe908so644958a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780990454; x=1781595254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eXLhOufDUGH9RyGTzlJd0uwXniEfiIM0oyP9s5OGvWg=;
 b=MXO7q7Symupy+OtFcehkT/2WC7xnXVQMP3bp71FSDEVrqdfZ2G4CFWxe9KECY3Hs4U
 mmI1sARYHSpzUmpZr2AfDU+nFfvObh0aSMIhkThRbjTZXWKbBGBSGJyRo1uc/t1h+0q2
 Y7Ydr2pQZkpmZulpAwFpBklOvCUdHT7O2lf3FJsQYsIoFPoTPr/OmkpuolZlG8oKsKyZ
 Oj2/zTFkF/vH+LgBKnXUuXjFLQgPgsVywT2FDOSzFqxxYG4PxgHB7QfDp79b9SrY0xow
 LoGZgXV0R4v2KgBc9ydZ5Qr5td1kxUlz8PHstBMoKCc1OxfvgB9bI2Ff8dbF68GGvRhC
 bjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780990454; x=1781595254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXLhOufDUGH9RyGTzlJd0uwXniEfiIM0oyP9s5OGvWg=;
 b=ZOL0h8q7YQfuQuqlyr+mit+UM5XQLRZT/btYxJgB7nb0opXVIiYOou+VqtCmc09Vyi
 xRtqJwjjSzJibOsPA/Pj1rDg5vQrnG4CvSGVWMEl8cgJ4cjHvMZng06KH0oCGk/z0Vlk
 qGpjprLZqYcpUnCBw7N6En4twLvwtPI72J/t8WRknnhQsFNPw29/Ovqqk1iE1cTmkOe4
 sxvWkDVZJJGwMqnBHG4w+txPrXcyiU8CymOXKnFy2jqJCwC/QcyBYpuEMZE3FGKqmthM
 P3hOY/hdeqniSnNzGdTQiKHWiGuXNIWv6oPSXhb6AvhbH7oj87MMbtylknWS1YNsyiCs
 1Oew==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3H+/drYHmt3EAs5092SYS0LAPtJHjHJn4jXXL9MAEm0UlLctS0m5/KLiTHM1+PxWCbBpJ7yo1Sbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyid4crvLsbO3C4Hd0kJVZoFuJUVVlDMo2cuBI2007XGKpGQxOf
 HkCHCSr8muezYHICnf5WbXIwKSvieVU5IZDWuYx1YCE97mjZZkFHwIRW
X-Gm-Gg: Acq92OFF8gg86yEl00lXlZn7rpunkcvKq+SeETQQ96dBbEfygFATR06wCpfNJ+/jZMP
 Q77VNkfVW3kcLKjM/QNFi1EDWC3i9t3BmYYLb/BPMz65Z06qAFwcU1pp/W9ucoI92HDUSLfYYNk
 +dJGUOaR/mUSbYpSIQSmy2sbMacZtEjU8E7ErE73YZ5m/kjbfwCvB8zgTFr6aqmKY7CF8b0w29w
 EcYlLXP69HNMJ/OYnQGqAVwwgA5o9RYOSkBcGqDdenHA5sRfkn5Fz3vl852pYWMqcQvY/fJcR5O
 A08hRcVanHDrGRbcTsnIbmxi3C7zaL0NCjW/ZWhu+IyettXcTMqYIQP9TbxKw80NzxcQFQmAYaq
 A+x501AsALEpaMNeB8LHL30IS+o1Y00Ecm9CfYT00K8IldATJGVJB+NPV6rPX9zntBU7lBYoWDc
 UNHeixppQlftPI5HKPnu5/mXVojMYXWao9/v1SeO94SVGO/lRQaxS9xA==
X-Received: by 2002:a17:90b:380a:b0:36b:b06c:30a1 with SMTP id
 98e67ed59e1d1-370ee447ddemr19641700a91.1.1780990453907; 
 Tue, 09 Jun 2026 00:34:13 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c76f55asm18214326a91.7.2026.06.09.00.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:34:13 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/panfrost: fix runtime PM leak on remove
Date: Tue,  9 Jun 2026 15:34:07 +0800
Message-ID: <20260609073407.5-1-ruoyuw560@gmail.com>
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

pm_runtime_get_sync() increments the runtime PM usage counter even when it
returns an error. panfrost_remove() uses it to keep the GPU active while
runtime PM is disabled and the device is finalized, but the usage counter
is not dropped afterwards.

Balance the get with pm_runtime_put_noidle() after disabling runtime PM.
This drops the extra usage count without requesting a runtime suspend,
preserving the existing teardown sequence that avoids suspending after
panfrost_device_fini().

Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 074c0995ddc26..d78ea7d4d099e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1027,6 +1027,7 @@ static void panfrost_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
+	pm_runtime_put_noidle(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
 }
-- 
2.51.0

