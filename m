Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F142C88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88ED10EA08;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9qG40wu";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96D510E6D5
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:21:59 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso4700575e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789208518; x=1789813318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VW8CDL+OlGvA4xfcKvR9tcTjyC7BYLpejsNtiZcjZVQ=;
 b=U9qG40wuXT/XOL4K/x153JxegTRzgLBFdihES2nvXct81OxOIcgycFb2Z/n3F4NR4e
 5ndOoYEaS0JPXnNost4yhjNeIn+ZjbXvS+Vvtop/fuJtjE6EMPj7YxHaczH+s6K4Sce4
 GbAsvRvtyKZoCKgFx94Ez7LBlANrh0A1ARmj5dF64Jxk0Mi4XY5s4GH3g3gkaKcuauX5
 drGMqfBjEk4nWUWY/gDLQkEcg77RJfg+PZ6QRk8sauxe/kk163plxqFTiAOqjo4Fbuft
 EwIUviYlyuYgWRKd5oOXX4HE+aZJ9sg5JahmcYI2IVvbYJwTzjPI3FtZRMqJDQuU/uuM
 PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789208518; x=1789813318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VW8CDL+OlGvA4xfcKvR9tcTjyC7BYLpejsNtiZcjZVQ=;
 b=lann6Z+MiprNQByNq+K253ClGljPhhUnVcoJTyw19fbUPNUsmu325+n5Fo7SEPIv3E
 NL+Veo7FWrrEA4ZlEqyousgn3JFMXHJjEof/jol0P+4xAvkDHBnhWFl8brSuYmisT0td
 lKm5VPUBG/YItUBsiRADLtgrgeuCv68uov9Re8lyhue3WDo494o15bTPb4S/X5ofgS/A
 qQLJctWMBk/2L905A1Jc0rOjCO96tEAwnnA1PtynXWQJ46f/hsHYhBOlxZObq6WGIEr1
 QY5OW8Wnc4zjMKk6OWNVbbJ5bUSBO80BLFwX1jA9B1xCL2kPbpp2P0fvb1gBo8/b7LuT
 tGng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmvI3xZO+VZEYW5WTcGgNotaWnKbIaK/sYhPK+JDzlclqQl+PSC2SuKU2AmMH/P3su3hPTaaSdeBo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++liWrUkHl+cubRoerwsRTunAK6hqpVg4GUGEHB5cLV7GFAm5dde
 7huDKWgIyA+UOp8c/LVwSrkMDTNuHGPC3VF4k3WIM+9GtAvlMwsid3PH
X-Gm-Gg: AYBFou2aQSZOFrl7v/QsK7VhoDIaifdlYDrEauCa6TVfl4mfZrOdS5L93yFbk1MmX+1
 L+bNUeTG8v0K9yfDxjKH81TuUQvHzAC9tvhqDvaughhI/nUvIdH1drDV1sfFmRWZAoVj7/wq2gG
 CP6XQudGLBeq44IhCCw2FBhnYFNv7E4zn6hxTJiFEVW2ht3Fpv9tVYaLproiGPW9WXClo0xpQkg
 0vlRRUyXwbWJsH9qSZJ1EoCc284RCPYud5mqnrpBoUEEOFhSbmcA1YvTQZYjIiQ8mx5ClXXj9Ma
 rZk4fowk7pp5ogwZhr01bcuvZfZ0VsniLi+Ob3WeZQ4ciotPczDVG+g9dOE0kgvEcesu3azV8/X
 Lxz9bMsi6+JZDtm4FxapV7/G7JZ0RIAuvnDJ5GC8LbVHdqOBnK/TCIk6WWScKdXTVlnN4YymX+B
 ACtPDtI36H7UkzR/LxYe245zZI1SmdLG5RETuKI8Sur4w3rlOrN6jNhv2ytL/EY3mlAlzyFSifA
 9Oc+cDsQhEWur8qpHEwMUlXgG6ZRDQr5mOU+jbtU5oeE21nWvLG/BOWxDppPdNZ6Bd8oDPHy957
 NmenlWoAqHBqFDjxyxzvekO4PO64QadZIzqUvsvF77S+0cAOh38E7S8n+UhBnSQYO9EDg/r73MC
 uDQ==
X-Received: by 2002:a05:600c:4e88:b0:49e:6a2e:d2c5 with SMTP id
 5b1f17b1804b1-49e6a2ed2ffmr41782035e9.18.1789208517912; 
 Sat, 12 Sep 2026 03:21:57 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de.
 [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm239346045e9.13.2026.09.12.03.21.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 12 Sep 2026 03:21:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Shixiong Ou <oushixiong@kylinos.cn>, Chintan Patel <chintanlike@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH v2] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes
Date: Sat, 12 Sep 2026 12:21:52 +0200
Message-Id: <20260912102152.86744-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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
creation when dev_of_fbinfo(info) is NULL, as the old device_create_file()
calls did.

Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.

Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through driver core")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Use dev_of_fbinfo() for overlay sysfs registration and removal (Helge).

v1: https://lore.kernel.org/r/20260907021844.25497-1-kmehltretter@gmail.com/

Found while reviewing the sysfs ABI documentation. Shixiong confirmed
that using the platform driver's dev_groups is wrong here.

Compile-tested with Clang 22.1.8, ARCH=arm and W=1, using multi_v7_defconfig
with COMPILE_TEST=y, FB_DEVICE=y and FB_SH_MOBILE_LCDC=m.

Also checked FB_DEVICE=n: olddefconfig disables FB_SH_MOBILE_LCDC because
of its existing Kconfig dependency, and the framebuffer core compiles.
This does not test the driver with FB_DEVICE=n; removing that dependency
requires additional changes outside the overlay sysfs paths.

No runtime test; I have no SH-Mobile hardware.

 drivers/video/fbdev/sh_mobile_lcdcfb.c | 39 +++++++++++++++++---------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f..5743c96d5481 100644
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
@@ -1510,9 +1512,10 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
 
-	if (info == NULL || info->dev == NULL)
+	if (!info || !dev_of_fbinfo(info))
 		return;
 
+	device_remove_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
 	unregister_framebuffer(ovl->info);
 }
 
@@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct sh_mobile_lcdc_overlay *ovl)
 	if (ret < 0)
 		return ret;
 
+	/* The framebuffer device is optional, see fb_device_create(). */
+	if (dev_of_fbinfo(info)) {
+		ret = device_add_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
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
2.39.5 (Apple Git-154)

