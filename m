Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C9EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272F410F215;
	Thu, 16 Jul 2026 08:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCliEOZR";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944CD10E2EC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:51:15 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc891373e0so75002035ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784184675; x=1784789475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=REWe9N83SgNKp6Wro3KoC+qLSEUgRwmdDgJzNFegwYo=;
 b=BCliEOZRyFW4zl7of3zyuBBb46c7+RGiyWjmiU6/hs+JwNVkE/8VABGwOTe5fBVOqH
 0JXt/hRlXNIgcTStKJKT8r+BPOPYLK3pAh24g5fghSDXc/8AMMoaldDpBpi4ueb8IUc4
 kBaRwRh6Ti/GqPG7lqXZdDSfnAML3IT+Za9C2GUfiwxIHKtnqrOl4FpFm1KXdhnsg1A/
 S58kRWK5dIxC8rhH4MU3ffW7RvHSdI9Tb3VoXpkPn8lBBLe8sTY6g8tT4ZhXdQiYjZP+
 HaT6MRJZ1rtLmbUL2OkDd4hSRt3WRG2LerziOKJzJuyWeNmIvS98wk9Mn9T6xpQL3SXM
 +YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784184675; x=1784789475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REWe9N83SgNKp6Wro3KoC+qLSEUgRwmdDgJzNFegwYo=;
 b=VBRG659RAbGxSMHj+fNi2oVc9GMXoRF7qaTe6xoQxW2M/hsKu0pUI/Kd3pKoCpHxQl
 vKvpeoW/Bp7ZuZ79CSpKA4NNTrDs3SsQZzfBbEYwoh2kKHO6lxTlTH7W6pqbk4rVadz5
 ATUwd7fnfLzfX3MO8gAgDbO5GfJ+xbH+vJP8aAjb2olX4sCBeHuuqCCPPGyWGVK2ltgK
 ujLZXfWvzyGz4Jlju4I406rBWHUl0/zaTIJipQAbtIlJt4cpLNqNOLRyNvk2rZ6L7zaZ
 nAxIiHdLE9qChg7aKk0oEOSjdIKkEp7mn5NrojAgi5+xdEmVH2YKoaW5zDX9i1IuErHm
 TzEw==
X-Gm-Message-State: AOJu0YykZIX5icVby0YwvfGP9povgrLi42JjKnF+CnNObOwFTWZlhaHX
 tbyZNPdpdZ841O+5Sf/DtfKZ89JKtdaYkmMQcLG1c6frEfp5Jip5rjFeyU84crr95Hs=
X-Gm-Gg: AfdE7cnZvAJLfSpO9WisOv/LXlD+gEFaxZ3BVFcDFVQ+UKIVktMShEStkNWASpKH3G8
 CDKynIvCrB+pSJWRWxRRH/3BL0qyUBP3XlkbvBZkBSI61CjGwwq1WoPRaVza+UT73ucZ+OfVUC1
 YkrXUlc0K+CDWu5BcrxrWHmcI6Am8iheuAFvErZFnmxIFIuQzW7tb8U1BcyK2dOqA+cnh+GzGbh
 T6Q0VfEm5T1ALQJK8PB/q5Sd8jjIivGB/TUyHgF1+OWuHKPaWyIOfJHexbkfPOqZZPq9K0pxWbM
 dujv6gxm7Bp/7MkP2j6T+/gFClfhtHZn9dUG0Wn2k5MYyNPS9fWSsREpO16ihLht/fSSSfUdy5z
 1zUJCGfCxoud7pfel1D+fIFhESeAgVq58I0PPzS1qfx+g4QcqvYkDwf7T2LI9nJy0HxQwjMIF+C
 fkkiZq
X-Received: by 2002:a17:902:f787:b0:2cc:89ce:2ef8 with SMTP id
 d9443c01a7336-2cf03de86a5mr57535365ad.40.1784184675029; 
 Wed, 15 Jul 2026 23:51:15 -0700 (PDT)
Received: from XiaomiLaptop ([182.239.122.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10120441sm14918565ad.20.2026.07.15.23.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 23:51:14 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Andrew Zhou <zhoulol888@gmail.com>
Subject: [PATCH] drm: make panel orientation quirks optional
Date: Thu, 16 Jul 2026 14:51:06 +0800
Message-ID: <20260716065106.150760-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

DRM currently selects DRM_PANEL_ORIENTATION_QUIRKS unconditionally,
forcing all DRM users to compile embedded LCD panel quirk detection.
This is unnecessary on desktop and server systems with external
monitors.

Add a static inline stub in drm_utils.h that returns
DRM_MODE_PANEL_ORIENTATION_UNKNOWN when the option is disabled,
and make the Kconfig option user-visible with a description.

Compile-tested with CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y and =n.
Boot-tested in QEMU with TinyCorePure64.

Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
---
 drivers/gpu/drm/Kconfig                        | 14 ++++++++++++--
 drivers/gpu/drm/drm_panel_orientation_quirks.c |  6 ++++--
 include/drm/drm_utils.h                        |  8 ++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..da4ac94bbf61 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -8,7 +8,6 @@
 menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
-	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI
 	select I2C
 	select DMA_SHARED_BUFFER
@@ -369,4 +368,15 @@ endif
 
 # Separate option because drm_panel_orientation_quirks.c is shared with fbdev
 config DRM_PANEL_ORIENTATION_QUIRKS
-	tristate
+	tristate "Panel orientation quirks for DMI-based detection"
+	depends on DRM
+	help
+	  Enable DMI-based quirk detection for devices where the
+	  built-in LCD panel is mounted in a non-standard orientation
+	  relative to the casing (e.g., handheld PCs, tablets).
+
+	  This allows userspace to automatically rotate the display
+	  to match the physical orientation of the device.
+
+	  Desktop and server systems with external monitors do not
+	  need this. If unsure, say N.
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..fb09078a831a 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -14,7 +14,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_utils.h>
 
-#ifdef CONFIG_DMI
+#if defined(CONFIG_DMI) && defined(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS)
 
 /*
  * Some x86 clamshell design devices use portrait tablet screens and a display
@@ -589,7 +589,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
 
 #else
 
-/* There are no quirks for non x86 devices yet */
+/* Fallback stub when DMI or the entire quirk module is disabled. */
 int drm_get_panel_orientation_quirk(int width, int height)
 {
 	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
@@ -598,5 +598,7 @@ EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
 
 #endif
 
+#ifdef CONFIG_DRM_PANEL_ORIENTATION_QUIRKS
 MODULE_DESCRIPTION("Quirks for non-normal panel orientation");
 MODULE_LICENSE("Dual MIT/GPL");
+#endif
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 6a46f755daba..947b8e71260e 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -11,10 +11,18 @@
 #define __DRM_UTILS_H__
 
 #include <linux/types.h>
+#include <drm/drm_connector.h>
 
 struct drm_edid;
 
+#ifdef CONFIG_DRM_PANEL_ORIENTATION_QUIRKS
 int drm_get_panel_orientation_quirk(int width, int height);
+#else
+static inline int drm_get_panel_orientation_quirk(int width, int height)
+{
+	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+}
+#endif
 
 struct drm_panel_backlight_quirk {
 	u16 min_brightness;
-- 
2.54.0

