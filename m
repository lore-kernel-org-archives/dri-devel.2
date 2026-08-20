Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB2BC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E3610EFA1;
	Thu, 20 Aug 2026 10:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cox9vBty";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F56910EF78
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:49:44 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ced3386430so16953855ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787215784; x=1787820584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/nis+wMxJNSnWBwBYR9N68PT1SwcPxqID1Z4/fwfULc=;
 b=cox9vBtyg8dRyKwXvHV9mrqMvVW+69yU8+Tg1cQaAgI2eQ+cgYDOXez7YEk4jAznkQ
 ZvwAS8D6BgllsNFiZvM9QfLfLkbHfTxqwoqNnSab+FWpK1TQk9JmhBzgUU5tscQWflbZ
 Z7G59h+O24gqc+qOpN53b7w5gSkQVuE7oibxCupiDfxW2IEoBWkNqoMpuVFo7mNvHGk6
 1RiytoRBKkhi1CMKIvIjmMKLE1Is6vy4txPEyy3Oz+nIMgfFPAJVCfwUXrr5hYS6ExHM
 mjWmULoIEJhApL3pa6zCWkwlf05I3d5ReurxKAbi/F+JPJ0wuw+CKDjgG106P92Jpobr
 WiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787215784; x=1787820584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/nis+wMxJNSnWBwBYR9N68PT1SwcPxqID1Z4/fwfULc=;
 b=CPaIgXO4mg0A/Ie0CQZU5m3sa42Z3WKvHFWyXWyF2wIY+Ak+DxBRh22jaPMqgaHbkp
 6vbgnUQmgEHLUS1bRPFEh+Lfu4yCMRid5HZ9JJmpryMN4T8JtFBN/zbexRFmgTeeYZGG
 +grUwiz4YrfUQ9LrBpzRnH8PEKkdV/J9qH4M/pIAvwIU+Bzy4LWWD28ijWeqlq6q74pt
 +Lj/Z+/HSBYAyaL+KbZARXTbNwP8JEHt/lQDafWlnynpzyFmpO6b131m8SS/8GlMPRDM
 1yJKyS8p12ELoAuYwI5IjzKslpJFiKSaketIjn4hPlmHB2KN6im/Vk0zS4E7BLnnkwp1
 c/nA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4Hq1vpjVgghS/aowZ8S+rY+v8LxDoITGt1Omm056LN7j0Ema+G/jbx8+Ficb6oCUZYgJtznSPDT8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mm3aZtqDRiPhJopHSL/CtiOpVNvAzIqJuj6emdnuiS0mcPPYgb
 lVtBxs0DdHJmqgnB4GkVJeVBjaBNBkQpa1dquS9GenfzL0dl2QyTrMg=
X-Gm-Gg: AR+sD113qQ8Uxdx7ERFbgrOcDWOelXYNQcsjaBdNECuAQp8TYhCq3hRxg6RRqDqxihJ
 cHXfFHDdQ5ElHam9J518GD+pZZ+qi0y1Lp5vzcs3eBFv0B0ib4kxc0tKHfXMXfP/H0FmhqNKn8m
 k3daGWuoAPEBp3NGiYJVoglpietdtBPZ8dmEuTDH7v5mRPVefgbZvtKZUU2ngbDJgNxERC9cQWp
 LpvZvtBLhuliIN7wnyTtQ/CGFKqjncdr3pZFsWI2mjEEx21DaMmsmk+EG/8NGIDgDkVFKlIagRK
 1/Krpa/p8bzZJEyFf+54TlpIKSDH+uHpVvNfs/nD11fR7GWrwfHFBSBMwX93zw75Wgujw5ru515
 yRk72WfKvJAjqzNu+zwg8U3TcnNW1++WqKuDfHrZaK7iwOBKnY/fWBnkeRyu1Mwpo0HXbQmhBPj
 tQKKeu0m7P6PbkZyLJ3oALM5S8Njo634OjaDilcBNKhwTSY2zg8BMQV7dK8eGIpVmNK5fTLmR2T
 g==
X-Received: by 2002:a17:903:3d0f:b0:2d3:14c6:2372 with SMTP id
 d9443c01a7336-2d5fd684c16mr222947865ad.1.1787215783957; 
 Thu, 20 Aug 2026 01:49:43 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d58a7a9sm3949955ad.20.2026.08.20.01.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:49:43 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: liviu.dudau@arm.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/arm/hdlcd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 15:49:37 +0700
Message-ID: <20260820084937.2098450-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 81d45f2dd6a7..f60211de8e59 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -385,14 +385,14 @@ static const struct of_device_id  hdlcd_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, hdlcd_of_match);
 
-static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
+static int hdlcd_pm_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_suspend(drm);
 }
 
-static int __maybe_unused hdlcd_pm_resume(struct device *dev)
+static int hdlcd_pm_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
@@ -401,7 +401,7 @@ static int __maybe_unused hdlcd_pm_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(hdlcd_pm_ops, hdlcd_pm_suspend, hdlcd_pm_resume);
 
 static struct platform_driver hdlcd_platform_driver = {
 	.probe		= hdlcd_probe,
@@ -409,7 +409,7 @@ static struct platform_driver hdlcd_platform_driver = {
 	.shutdown	= hdlcd_shutdown,
 	.driver	= {
 		.name = "hdlcd",
-		.pm = &hdlcd_pm_ops,
+		.pm = pm_sleep_ptr(&hdlcd_pm_ops),
 		.of_match_table	= hdlcd_of_match,
 	},
 };
-- 
2.53.0

