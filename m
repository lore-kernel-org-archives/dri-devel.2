Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ABCC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4767510E82E;
	Mon, 17 Aug 2026 15:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="dSIpQtNp";
	dkim-atps=neutral
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com
 [203.205.221.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E760310E428
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786979515; bh=v1c8fm9eLtnFH0Vss94ZcHWkJdE+BcQJ/A6Az0/GRxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dSIpQtNpPDQ/Ug5AnncNkbpSDkcaMyjFB89qQZYzEUr38j8goM4f4d3VlJ2GWNuXa
 temvcGq0+7iujZurZWwenqRibWY8Ihd3O6fNcww4Z9tlt1PtzZlU7s/CRA6+A88uKt
 8bxgx1k/YQNkO1Q74L7u5guFCJcJeCh1eHT0w0rw=
Received: from lxu-ped-host.. ([111.198.231.89])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 2F48BA9D; Mon, 17 Aug 2026 23:11:52 +0800
X-QQ-mid: xmsmtpt1786979512tn7yayvmx
Message-ID: <tencent_A65509B5AED3AEFE4C80E7C646C892F1C606@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoBWBKSkQOlhqWOyX95UtyihhLglHzOACjevRiOeQptYH+vy17SE
 RuqNNjHu9YWSx6pXq/4MHVSJaC87kkXsgBejJxJ5uAh0M0af82dx+dEn2Z+SXKrT5ukCHBSyfbEF
 Mb0H0hijHpfkGFlwUqTnfyHAPToU5KC2I+v4rd1Zygu8VstWhAX1hCjmTQGoeI9SheGJB2dtZqdz
 G2ZGD/janPLhO1w2honoJfvsRGTKZWe0/yUM7IgH+eSnhQ5q/TyHmwp/JMJNgyJpiiP6pCX+SigS
 8dFdnZMNyWJRgyeWGI/GG5i26+bV1DaWz5CSNWgVhgSO7m5qQz9z/TWFEtH0uXWUSW/bM5hE/yW1
 r7Q+zLrsE/8Tdkjp4HnI8Iz7eGZUBTF2UdUUluc3pyK9lKVhBNKdirTqOFKhnnTUu7Yc3hf0EsTz
 jB9ZeK2dxhaJacL4dgz0y6YZ+o58XaMsalGui0LkWrO2ztGT3lwcW+/aumj4ES7d86iqeyOVbydH
 JxFE4vTUDQL1DS/pcW995ZyptlP5tqXZeVdlVgxwbch5B4AgxAADeCOCmNMDDeTGA5MvC+LUK9Om
 iT9MUR+Ey78oQ63R2sZruBy2BgC7caSPxcAmkpqurjxgxxG2o+vNqadHCl3GH8BWBiJFn+GGYcxH
 h/D+EMDQstENF1fiY7PP8n45lMeV71f/6WdmmQs/NiKM2sXBNoE5TuOLNBkgX1UBSuAYNd1iIOI4
 aDDB7b3/S0HmgwBuEjwz13C+4sF6dDIfzl5LZQB0CQbrG3o/MKy7Z6LmXjjWl0hN8BUaD9rJPptS
 aQ4NhN97x8chFQ+nRUT4gGVhl0K3RCz39RfKlo7XqpZyhckJ0IPMnYQ4n7IKa3oN7qvW9DCtVnUg
 3RbfyXV1awCJB1+zirxrtjwnJlSU1SxEbuPms5ferscRNIABtEUMWcxh65YIhR2M0uhFNexAT0/P
 TnJYiq7EbQflEKqcF4SLlTrb3FSPmhPW9nh3x2soAPV0H/DNgXPtA/4WaxCoQoaWFd+pMl8K4I2+
 QlOymubm7wmEjHXTjM49SA4toQ3X1BEMDw1Djo3D3v+kws+69yRLoAH8yavf0pTp6bJP4XyV1hL0
 5tEunh
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: sashiko-bot@kernel.org
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, rubenru09@aol.com, simona@ffwll.ch,
 syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Subject: [PATCH v2] drm: Optimize tv properties creation
Date: Mon, 17 Aug 2026 23:11:53 +0800
X-OQ-MSGID: <20260817151152.377161-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817124959.DDCF81F000E9@smtp.kernel.org>
References: <20260817124959.DDCF81F000E9@smtp.kernel.org>
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

When adding gud properties for drm connector within the function
gud_connector_add_properties(), if the TV modes property is not added
first, drm_mode_create_tv_properties_legacy() would fail to add the TV
modes property because the tv_select_subconnector_property has already
been added. Other properties (such as brightness, contrast, etc.) are
affected by the same issue.

This causes gud_connector_property_lookup() to fail when looking for
the TV modes property (returning NULL), which subsequently triggers
issue [1] when a NULL property is passed to drm_object_attach_property().

The fix ensures that within drm_mode_create_tv_properties_legacy(), the
TV modes property is correctly added regardless of whether the subconnector
property exists.

Recreation of properties brightness(contrast, flicker reduction, overscan,
saturation, hue) must be prevented.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
RIP: 0010:drm_object_attach_property+0x85/0x3b0 drivers/gpu/drm/drm_mode_object.c:240
Call Trace:
 gud_connector_add_properties drivers/gpu/drm/gud/gud_connector.c:572 [inline]
 gud_connector_create drivers/gpu/drm/gud/gud_connector.c:680 [inline]
 gud_get_connectors+0x86e/0x1700 drivers/gpu/drm/gud/gud_connector.c:717
 gud_probe+0x17aa/0x1c20 drivers/gpu/drm/gud/gud_drv.c:635

Fixes: f453ba046074 ("DRM: add mode setting support")
Reported-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1944765c3659f63d3777
Tested-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: avoid recreate brightness/contrast/.../hue properties;
	  update subject and comments

 drivers/gpu/drm/drm_connector.c | 106 ++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 11646453aaac..800fcc44e3f4 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2175,29 +2175,30 @@ int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
 	struct drm_property *tv_subconnector;
 	unsigned int i;
 
-	if (dev->mode_config.tv_select_subconnector_property)
-		return 0;
-
-	/*
-	 * Basic connector properties
-	 */
-	tv_selector = drm_property_create_enum(dev, 0,
-					  "select subconnector",
-					  drm_tv_select_enum_list,
-					  ARRAY_SIZE(drm_tv_select_enum_list));
-	if (!tv_selector)
-		goto nomem;
+	if (!dev->mode_config.tv_select_subconnector_property) {
+		/*
+		 * Basic connector properties
+		 */
+		tv_selector = drm_property_create_enum(dev, 0,
+					"select subconnector",
+					drm_tv_select_enum_list,
+					ARRAY_SIZE(drm_tv_select_enum_list));
+		if (!tv_selector)
+			goto nomem;
 
-	dev->mode_config.tv_select_subconnector_property = tv_selector;
+		dev->mode_config.tv_select_subconnector_property = tv_selector;
+	}
 
-	tv_subconnector =
-		drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
-				    "subconnector",
-				    drm_tv_subconnector_enum_list,
-				    ARRAY_SIZE(drm_tv_subconnector_enum_list));
-	if (!tv_subconnector)
-		goto nomem;
-	dev->mode_config.tv_subconnector_property = tv_subconnector;
+	if (!dev->mode_config.tv_subconnector_property) {
+		tv_subconnector =
+			drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
+				"subconnector",
+				drm_tv_subconnector_enum_list,
+				ARRAY_SIZE(drm_tv_subconnector_enum_list));
+		if (!tv_subconnector)
+			goto nomem;
+		dev->mode_config.tv_subconnector_property = tv_subconnector;
+	}
 
 	/*
 	 * Other, TV specific properties: margins & TV modes.
@@ -2205,7 +2206,7 @@ int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
 	if (drm_mode_create_tv_margin_properties(dev))
 		goto nomem;
 
-	if (num_modes) {
+	if (num_modes && !dev->mode_config.legacy_tv_mode_property) {
 		dev->mode_config.legacy_tv_mode_property =
 			drm_property_create(dev, DRM_MODE_PROP_ENUM,
 					    "mode", num_modes);
@@ -2217,35 +2218,48 @@ int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
 					      i, modes[i]);
 	}
 
-	dev->mode_config.tv_brightness_property =
-		drm_property_create_range(dev, 0, "brightness", 0, 100);
-	if (!dev->mode_config.tv_brightness_property)
-		goto nomem;
+	if (!dev->mode_config.tv_brightness_property) {
+		dev->mode_config.tv_brightness_property =
+			drm_property_create_range(dev, 0, "brightness", 0, 100);
+		if (!dev->mode_config.tv_brightness_property)
+			goto nomem;
+	}
 
-	dev->mode_config.tv_contrast_property =
-		drm_property_create_range(dev, 0, "contrast", 0, 100);
-	if (!dev->mode_config.tv_contrast_property)
-		goto nomem;
+	if (!dev->mode_config.tv_contrast_property) {
+		dev->mode_config.tv_contrast_property =
+			drm_property_create_range(dev, 0, "contrast", 0, 100);
+		if (!dev->mode_config.tv_contrast_property)
+			goto nomem;
+	}
 
-	dev->mode_config.tv_flicker_reduction_property =
-		drm_property_create_range(dev, 0, "flicker reduction", 0, 100);
-	if (!dev->mode_config.tv_flicker_reduction_property)
-		goto nomem;
+	if (!dev->mode_config.tv_flicker_reduction_property) {
+		dev->mode_config.tv_flicker_reduction_property =
+			drm_property_create_range(dev, 0, "flicker reduction",
+					0, 100);
+		if (!dev->mode_config.tv_flicker_reduction_property)
+			goto nomem;
+	}
 
-	dev->mode_config.tv_overscan_property =
-		drm_property_create_range(dev, 0, "overscan", 0, 100);
-	if (!dev->mode_config.tv_overscan_property)
-		goto nomem;
+	if (!dev->mode_config.tv_overscan_property) {
+		dev->mode_config.tv_overscan_property =
+			drm_property_create_range(dev, 0, "overscan", 0, 100);
+		if (!dev->mode_config.tv_overscan_property)
+			goto nomem;
+	}
 
-	dev->mode_config.tv_saturation_property =
-		drm_property_create_range(dev, 0, "saturation", 0, 100);
-	if (!dev->mode_config.tv_saturation_property)
-		goto nomem;
+	if (!dev->mode_config.tv_saturation_property) {
+		dev->mode_config.tv_saturation_property =
+			drm_property_create_range(dev, 0, "saturation", 0, 100);
+		if (!dev->mode_config.tv_saturation_property)
+			goto nomem;
+	}
 
-	dev->mode_config.tv_hue_property =
-		drm_property_create_range(dev, 0, "hue", 0, 100);
-	if (!dev->mode_config.tv_hue_property)
-		goto nomem;
+	if (!dev->mode_config.tv_hue_property) {
+		dev->mode_config.tv_hue_property =
+			drm_property_create_range(dev, 0, "hue", 0, 100);
+		if (!dev->mode_config.tv_hue_property)
+			goto nomem;
+	}
 
 	return 0;
 nomem:
-- 
2.43.0

