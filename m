Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABB6C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9622D10E48A;
	Mon,  7 Sep 2026 07:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VWsHbS1G";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1346E10E386
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 02:18:51 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso1655998f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788747529; x=1789352329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AIZYWJVjQUnBNnHeOHBqUSKoQJf+SCAcPIAInF4Y+OU=;
 b=VWsHbS1G+xOxm/DGsiENxe+sUR3PIuJ0xmNuz3d/vwZBQh+bFfRTlwkEKIadBzQLlJ
 wtYgSozetISL53pF+mqrOVZw1ivPLpbzeWiiTloIML2NMZQIXjsiGAME3Ul1jtrs/f7N
 TYnwOpuTq/9C1UxIdCgVpp6Iya13i++GDjv4ldrYvmUrNSxrpG+1pFm4RU/Cw97YxFmZ
 UIhHsGc2N4JqOd1h6iZkUS2P///9dJnbVCseBFArU84XtmMk/5hSPZ9jTKJsZ3Nay4qY
 xw7vt9G88DMOVqapFPQfzVQDnTHiFgIPG+YS88IZZaur44LZ2HInde6DXcDIUbnuw4vu
 qFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788747529; x=1789352329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AIZYWJVjQUnBNnHeOHBqUSKoQJf+SCAcPIAInF4Y+OU=;
 b=XGsM1mxDKdfGzGBk4WvewH8pWMKBkf/MrLIUC4p2+Vi09lEtsT3PYZfvSmclG7ylRh
 SNmytZWzrDCuT/+1bgP1NTgHMNRWw7UMkwGYiqV6R9Pp8NPvqU29Aw+2AwUduuXpKsuX
 ASo6qpRJ5GxGAMvmZ1irUF2Hr3XLfu3b7ze7D72LTEvmNwQf+W/GU7NFQBr0kqhPwNyI
 FnZMfyrLCFaa8Z+kN9lPa4r5hMHV54f038qRrqA0Nmsy43La1QpBsizN/4OrIF5ciOqS
 puezfoHMplvSBEUlinMISfA9I1gLLtNH/qG/79wA7l+FxsrocrhTMtZV6OpqpGfQCK31
 jvCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXhZ8YIfFu4PJFW8dI5AEwi7OyEP1Y8+OGnj5DjrJ9BOX5sz1INDJpWnt13zfS5yvOOFP6Uf+nSwM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfWhqUAcvNdpojCwVbduDR9UK42o4AznU4IaHZfjyGagH1oTag
 gNFK0FYRJz2TbiEd+UJePMAyxjShNQe8hLI75YNcHHAgALAt1VxWkxkU
X-Gm-Gg: AYBFou223lIjpokLguSKAk6OVsMZiQ4NNoDaBaL8tCDpIuB8Vv2dDFuXPV2stZR1Kla
 oTCwnGNm4LegEw/+z+oQXu2Sro4KjfIjneIEHbxABcCAQLgWyaobY2uq9SpLzNpshvVRMTGPVkN
 bbLrRg+YIOaEg747OorySk1oGtw9nINfrfxz6MqiJ5R65J1yZV/Q7gtKUBkbT43rWadjh/+QPZ5
 nbbjHBVSU6LFJssvFPBXDmFWoxe6Q8biyHDTYdfsIvdnjxijQmpqnsnpecqIv/CFbFS9z/dIOmU
 ZUEJ7vPEGQMKrsl708wrr3G5q/xYW3Dz/UgyZZ9XkMg9e0mzmgzPbOGirQDmk4YPDJKGRjn47Yw
 /2TdIoxqqbZh2GDNpnSggWCtQHGNuYCHjDY27vfGhipuw0Muq/tfVXAwl6CHed5DdTXf+wVxCq6
 rxXNBQ7ESXffldxZmQ53O1oktDIyV0xgCac5VmXNexsI/2PKGlYTC7DX85ZIgiRGElHsY4IDxCd
 0x1jv8qmyXlBx+XTWHnE33jNRxBHJCyIjHRkN34Gq2S5e4CShLjbpHY2b/aNBSIRCDHoNRGZamL
 9enXH3+E6IWfGXzNRUSA01+GBxysFwYme/xAHqn19+FwRVcjcuuwesD7qYVyMOSSP/6EPTF8inT
 wTfELFom51mkRAWas
X-Received: by 2002:a05:6000:4703:b0:485:93c5:856e with SMTP id
 ffacd0b85a97d-48593c58629mr10071101f8f.9.1788747529298; 
 Sun, 06 Sep 2026 19:18:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-b0c9-3601-9daa-d59e-970b-f46c.310.pool.telefonica.de.
 [2a02:3100:b0c9:3601:9daa:d59e:970b:f46c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm21411912f8f.2.2026.09.06.19.18.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 06 Sep 2026 19:18:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Shixiong Ou <oushixiong@kylinos.cn>, Chintan Patel <chintanlike@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes
Date: Mon,  7 Sep 2026 04:18:44 +0200
Message-Id: <20260907021844.25497-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

The ovl_* files documented in
Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
longer exist.

Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver
core") moved the attributes from each overlay's framebuffer device to
the platform driver's dev_groups and renamed them overlay_*. There is
now only one set of attributes for the whole LCDC. The callbacks still
expect dev_get_drvdata() to return a struct fb_info, but the platform
device holds struct sh_mobile_lcdc_priv, so they access the wrong
structure.

Restore the documented names and register the group on each overlay's
framebuffer device with device_add_groups(). Remove it with
device_remove_groups() before unregistering the framebuffer. Skip
creation when info->dev is NULL, as the old device_create_file() calls did.

Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.

Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver core")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Found while reviewing the sysfs ABI documentation.

Compile-tested only (allmodconfig, W=1), I have no SH-Mobile hardware.

 drivers/video/fbdev/sh_mobile_lcdcfb.c | 37 +++++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f..18fc4e465283 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR_RW(overlay_alpha);
-static DEVICE_ATTR_RW(overlay_mode);
-static DEVICE_ATTR_RW(overlay_position);
-static DEVICE_ATTR_RW(overlay_rop3);
-
-static struct attribute *overlay_sysfs_attrs[] __maybe_unused = {
-	&dev_attr_overlay_alpha.attr,
-	&dev_attr_overlay_mode.attr,
-	&dev_attr_overlay_position.attr,
-	&dev_attr_overlay_rop3.attr,
+static struct device_attribute dev_attr_ovl_alpha =
+	__ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);
+static struct device_attribute dev_attr_ovl_mode =
+	__ATTR(ovl_mode, 0644, overlay_mode_show, overlay_mode_store);
+static struct device_attribute dev_attr_ovl_position =
+	__ATTR(ovl_position, 0644, overlay_position_show, overlay_position_store);
+static struct device_attribute dev_attr_ovl_rop3 =
+	__ATTR(ovl_rop3, 0644, overlay_rop3_show, overlay_rop3_store);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&dev_attr_ovl_alpha.attr,
+	&dev_attr_ovl_mode.attr,
+	&dev_attr_ovl_position.attr,
+	&dev_attr_ovl_rop3.attr,
 	NULL,
 };
 
-#ifdef CONFIG_FB_DEVICE
 ATTRIBUTE_GROUPS(overlay_sysfs);
-#endif
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
@@ -1513,6 +1515,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 	if (info == NULL || info->dev == NULL)
 		return;
 
+	device_remove_groups(info->dev, overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 	if (ret < 0)
 		return ret;
 
+	/* The framebuffer device is optional, see fb_device_create(). */
+	if (info->dev) {
+		ret = device_add_groups(info->dev, overlay_sysfs_groups);
+		if (ret < 0) {
+			unregister_framebuffer(info);
+			return ret;
+		}
+	}
+
 	dev_info(lcdc->dev, "registered %s/overlay %u as %dx%d %dbpp.\n",
 		 dev_name(lcdc->dev), ovl->index, info->var.xres,
 		 info->var.yres, info->var.bits_per_pixel);
@@ -2637,7 +2649,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
-		.dev_groups	= overlay_sysfs_groups,
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0
