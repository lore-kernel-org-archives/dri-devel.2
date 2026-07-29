Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E2AC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFA310E64D;
	Wed, 29 Jul 2026 05:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2zIH2d+";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7528C10E1BE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:31:19 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-92e602d2c0fso120913985a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785303078; x=1785907878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A63ysZ+YgReIu06v3k8w/vOA2fjDEAUGCMr8WX2T8BU=;
 b=T2zIH2d+azx86pG4LXp1JUQ2q3wb5mdVlTGlf5LJQjxBFMMKyN/J73joDhkD3oF6Cy
 ubZ7pZccjFtEiR/8IRk1rFt6lyz53hNyIGyHdlge8Qq871k3PtpdxqAHtgqpmYtmb3If
 X36+Id6d0k1CSIFi3GEM8PhXQzZ2+kkQ+jNUgAox2rBlKOuEp/yhASukwYlONQATRTJN
 SvKXNWbLWnvbI9vDWenKPUlUXZucx9rDQLYd1e/+5jFTKaBJ6jyiPoY1fCKgXPwuM2Gp
 EbQxj/rtHJdNO0PBhtB4x5CNmpvuvBtClrhuXD+OY9svI4jHw0pOlSrCqkvrVHG8JZ4X
 SFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785303078; x=1785907878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A63ysZ+YgReIu06v3k8w/vOA2fjDEAUGCMr8WX2T8BU=;
 b=XgloZm/Tsa5luXap6ktWM1//BMFHoR74iCCRVxuA1hDWdxmxwqK+1YHvi/ZdgqoYd4
 Vn83JQKUoqG6hCgxrqJEfVyRtFX1ee7kxSPxZJvsXtTVLYNb/KycoZZ6R8sg9FoglwHi
 HU9pcnisPUF632MNyi8Ay4ogirtjBZ+a/Ihr/Te11iikxJtRf+4B6KrAPDubejOdfGHe
 RNqUrbOVP4t/O9bJevdjyB3PAGPoegx0Rv46cOQcvrbY95vSj5tCZG/SIrNoG+09wGVq
 PytGwzUQhjTJBQcq1XlQRwxbU84mUuPFUhOaOliI7nLSNRDJaTBcRZgQP0rBg4m/mR9Q
 KQtA==
X-Gm-Message-State: AOJu0YwGEXVN2QeRKmV2JqWwJFn8xYovNOo4zaYnzXP6eIOt1tb3v9uF
 YpzmQwo3WpADrX4aYzfwNvOdYwp7p2lwGzptlZvR4odYP7gPHhCleknq
X-Gm-Gg: AR+sD10Jxa0Non4PK6CoM9x1qZ823OfSLljNg2ejlZ5ws7tPFbtvhRm8ZpyYFaSpwK8
 KscTHNDnCTc0zkKxPJTQXAcrn6T52vk/tOSb0+ThFAjiQtjffmES6qGTM1Cx6rBsyMEw/SBpywA
 8UfhlLlV7WNnYi0oe4OhOyxkVtxCllT0xXyLQHEkrxR0MhH9pXFpFVzrlqweaZXNyPu1mIH/i92
 dl5rYVcwfeNztFehKKm40DxIf+87dOixQ6NYDdShrR9mD4C56JcfjmOgccM9Dfy10rYoWt/pMFF
 kCpmuxyHFQnMysoBmdc1A16eFIMHspvy3c2e5ze2SQfBt0IkUYoHeBAaziul+6OOwaacCFtNorZ
 cmvK3N+jZpb+oTgTXOsYDrhbH2uly6hSl2nPxClxjWIhZdIIKeU6efEoQN53yvaLAUToa7W0JsL
 G99mx1KYjaizzQPhDNlVd0KdXDIqzbl9Kk2o7R0QCAu/0T5o9Qw5uqychYzp1n7LiHibTYqQ==
X-Received: by 2002:ac8:5fd3:0:b0:527:6dc7:5c36 with SMTP id
 d75a77b69052e-52b2ae07ce8mr5991571cf.33.1785303077994; 
 Tue, 28 Jul 2026 22:31:17 -0700 (PDT)
Received: from thinker ([65.195.2.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2b1a1ddsm12592861cf.5.2026.07.28.22.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:31:17 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 1/2] drm/ssd130x: Scale ssd133x per-channel contrast by
 brightness on init
Date: Wed, 29 Jul 2026 08:30:53 +0300
Message-ID: <20260729053054.29374-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729053054.29374-1-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
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

ssd133x_init() wrote the SSD133X_CONTRAST_A/B/C commands with magic hex
values (0x91/0x50/0x7d).  These are a per-channel white-balance
calibration: the A/B/C channels drive sub-pixels whose OLED materials
differ in luminous efficiency, so the values set the white point at full
brightness.

Extract them into ssd133x_set_contrast(), which scales each channel by a
requested brightness via ssd130x_scale_contrast(), instead of writing the
calibration unconditionally.  This makes the sequence readable, avoids
repetition, and is a prerequisite for wiring up an ssd133x backlight
controller that dims while preserving the white point.

Note this changes the ssd133x power-on brightness.  Previously the init
wrote the calibration unscaled and ignored ssd130x->contrast, so the
panel always booted at full brightness.  It now scales by the shared
default contrast of 127, i.e. half of MAX_CONTRAST (255).  This is
intentional and matches ssd130x, whose contrast register also defaults
to 127 (mid-scale), so all families now power on at ~50% and report
props.brightness = 127 / max_brightness = 255 to userspace.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 43 ++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0940eae7a2e4..f49e5245b216 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -14,6 +14,7 @@
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/math.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
@@ -140,6 +141,11 @@
 #define SSD133X_SET_PRECHARGE_VOLTAGE		0xbb
 #define SSD133X_SET_VCOMH_VOLTAGE		0xbe
 
+/* ssd133x A/B/C channel contrast at full brightness (white balance) */
+#define SSD133X_DEFAULT_CONTRAST_A		0x91
+#define SSD133X_DEFAULT_CONTRAST_B		0x50
+#define SSD133X_DEFAULT_CONTRAST_C		0x7d
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -582,12 +588,37 @@ static int ssd132x_init(struct ssd130x_device *ssd130x)
 	return ssd130x_run_cmd_seq(ssd130x, cmds);
 }
 
-static int ssd133x_init(struct ssd130x_device *ssd130x)
+/* Scale a channel's white-balance calibration contrast by the requested brightness */
+static u8 ssd130x_scale_contrast(u8 calibration, u32 brightness)
+{
+	return DIV_ROUND_CLOSEST(calibration * brightness, MAX_CONTRAST);
+}
+
+/*
+ * The A/B/C contrast channels drive sub-pixels whose OLED materials differ
+ * in luminous efficiency, so the per-channel values are a white-balance
+ * calibration.  Scale them by the requested brightness instead of
+ * overwriting them, to keep the white point while dimming.
+ */
+static int ssd133x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
 {
 	const u8 cmds[] = {
-		2, SSD133X_CONTRAST_A, 0x91,
-		2, SSD133X_CONTRAST_B, 0x50,
-		2, SSD133X_CONTRAST_C, 0x7d,
+		2, SSD133X_CONTRAST_A,
+		ssd130x_scale_contrast(SSD133X_DEFAULT_CONTRAST_A, brightness),
+		2, SSD133X_CONTRAST_B,
+		ssd130x_scale_contrast(SSD133X_DEFAULT_CONTRAST_B, brightness),
+		2, SSD133X_CONTRAST_C,
+		ssd130x_scale_contrast(SSD133X_DEFAULT_CONTRAST_C, brightness),
+		0,
+	};
+
+	return ssd130x_run_cmd_seq(ssd130x, cmds);
+}
+
+static int ssd133x_init(struct ssd130x_device *ssd130x)
+{
+	int ret;
+	const u8 cmds[] = {
 		2, SSD133X_SET_MASTER_CURRENT, 0x06,
 		3, SSD133X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
 		3, SSD133X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
@@ -614,6 +645,10 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
 		0,
 	};
 
+	ret = ssd133x_set_contrast(ssd130x, ssd130x->contrast);
+	if (ret < 0)
+		return ret;
+
 	return ssd130x_run_cmd_seq(ssd130x, cmds);
 }
 
-- 
2.55.0

