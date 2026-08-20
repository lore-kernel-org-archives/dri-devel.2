Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CC2C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5174C10EFA3;
	Thu, 20 Aug 2026 10:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4tm+vss";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838DC10E175
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:53:07 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d5655cc850so23062955ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787215987; x=1787820787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CVrmcqpW4KNovZRTuW0b5RuV8gPq19U6OAFR+9mBT0o=;
 b=H4tm+vssES7xVOhW/n1lmayzPPFv5HgQlA41Jeqv4OjvwWcbY5kHKLS5rKGxM2pVnV
 CbHQujpNRDGlTYGUIsJxhYA3ATyXDyCjw1LwMqV030J/XPt0ZdV1xwQywcClZzVe5G+7
 Dg+YKqI2XuVHl6ZJMZEI0qdhizyAf+ZpW3//jNvd3evFCU9mWGUrlG1Ne5P2CMSqraf6
 ioGdv7WaAQIny+OwzrZbuAZ9wk/YqZ3a1P80jmy6znYuJ8MtTcMWl0H1kGjwJTS2Vbhh
 ol181F/iNccDaia6PDxGVypCJXyODvvgGjizCBADWM7KmLQXoUzX9fw30q0CGM6wLzmm
 Y8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787215987; x=1787820787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CVrmcqpW4KNovZRTuW0b5RuV8gPq19U6OAFR+9mBT0o=;
 b=o/PwzAGRB9JNRKJu+Z+W3lvreaCgUQNRkH3xdw5CFXnKlw7s8XCEt/MbAiTCGzza7e
 E+XlBgtxzjmChCDrApHIceSYmBWdOeXdjYr75vwmijXDNVwr59LeYDdy85FhTNbcFnkc
 Z1I7GbftFKLb8lpKDMmlA4ORfEEVaArREfhQP5gAlP63fCksRXRqTbRLkevUT9KiTsNN
 bI5jW6tIeofVJ0GUYzvM9EQtPC6uZhMksCuKFFkZyTEYVqZvlU9GkYuyrT2VD+gdM251
 AYUC0q+wLaB+3UXz2yq+GSOmP6GDC99vJR9H66FYH6KyUtuqC2ab7oh/WxmE4XXiRpip
 bz+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgPW4U6Z8WGsfZIN/2SwM/3jhjFLmlZX4BMh6/buGTeyoMGUf8Pfgmrdi5E0Rhfc8ejkSi/V5RtlM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmQCEbO3ZcyQ91k3FQpbRj/kiKbszR22o/I+COyxi3H6QGtz6f
 z1/V6EZfRIb8YUk6N23ToAHkEm9KET0ASv+8uGB09dN+5s1ZQ4vOw3o=
X-Gm-Gg: AR+sD10LDreaTiBGfUd9CKBfxc1wkt0vkbHEsKu5bhBpUzbOKIowpq2V2FsYeCY6CHN
 LndZMvPuqJIa6aTm8zsw73wCytlLI9by4QOWPWdnpesgEGSDz4fwEqrK9FuYaojIL7haH0xj3yv
 5K4EehCdAB69640uIACFVsmrQIUVSXvrpY3OaTpk6bQQ73A8XtUNQLnx9lWu7EOBjmS3mQ3Dzlg
 wydashvEPpmf40LEj5i11AFUIhj+zY8/NUsx9ApGihEn9nX8gfCsftm4+q5dpP/ypPjKjlGO40H
 9n2EHUumk/kd+xfB9D2FQGdhna2UO/qdIgYSvg0j4To+38aV/k+6c1/ovasyBtMF6CiWiAzjA+m
 f6vAehPXnD7L+ikYLap9Y4Assc1x/Y3mzZ0gC7/KUNqpFR2STNhrm7s4lSvZkPllwClRYC9HmYo
 EIL7niKmZkqAYSLBVhChN2SP/Zus4+YaHa6blJ1qSaItZFPiv6WvHQ9wDi6euiWTY68bzkzNpqU
 Q==
X-Received: by 2002:a17:902:f689:b0:2ca:6eca:492f with SMTP id
 d9443c01a7336-2d5fe6905acmr191957325ad.14.1787215986919; 
 Thu, 20 Aug 2026 01:53:06 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62e3a2713sm3935505ad.58.2026.08.20.01.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:53:06 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: anitha.chrisanthus@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/kmb: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 15:53:01 +0700
Message-ID: <20260820085301.2101138-1-triet.hoang.dev@gmail.com>
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

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..1a5ff6067eb4 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -588,7 +588,7 @@ static const struct of_device_id kmb_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, kmb_of_match);
 
-static int __maybe_unused kmb_pm_suspend(struct device *dev)
+static int kmb_pm_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct kmb_drm_private *kmb = to_kmb(drm);
@@ -604,7 +604,7 @@ static int __maybe_unused kmb_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused kmb_pm_resume(struct device *dev)
+static int kmb_pm_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct kmb_drm_private *kmb = drm ? to_kmb(drm) : NULL;
@@ -618,14 +618,14 @@ static int __maybe_unused kmb_pm_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(kmb_pm_ops, kmb_pm_suspend, kmb_pm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(kmb_pm_ops, kmb_pm_suspend, kmb_pm_resume);
 
 static struct platform_driver kmb_platform_driver = {
 	.probe = kmb_probe,
 	.remove = kmb_remove,
 	.driver = {
 		.name = "kmb-drm",
-		.pm = &kmb_pm_ops,
+		.pm = pm_sleep_ptr(&kmb_pm_ops),
 		.of_match_table = kmb_of_match,
 	},
 };
-- 
2.53.0

