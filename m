Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CDA10AB808
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA7410EC02;
	Thu, 26 Mar 2026 18:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7A8l/Ng";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C730B10EBE6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:37 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-67bb3fe55a5so465694eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551337; x=1775156137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaS+vAPe+o14cf01tnHTOxQ9DFEqgjCQ99ScUUNb7AU=;
 b=l7A8l/NgaYmte1+s/N3GaZ26vD/wdo3Jqkkct2+QjMzrTiDaRUWixPeiq0tnaUgq/y
 AyEt4r7nrS0ZODSD/NVNLNe/iDsU607Q58Pl1gPhwRF4P6QhlUvlpkxKKgK71W8v8L2D
 BPLWlN/wUtN69cbttSDd3IEqiyug9cYd+c/wCvfu7HEctBVKepiUJj/03zr2nw31gHyz
 S24+1WKAwRoaVJd62MPz2BK7hAveyJEz/vEtzXst34tsojb4s00R/8NXZk/u2Rdjqyjf
 nS/wZE9KL3QlLDxJ6PARJZPpXdtZES2P8BCw2VD3CppMbNjVet3SPT+fzzbngDIWb3xO
 E1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551337; x=1775156137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaS+vAPe+o14cf01tnHTOxQ9DFEqgjCQ99ScUUNb7AU=;
 b=aguuvefoaOy0jFs6F9UhRtqvrURs9E6Q4D19zoSa5wCzeyL5u2Ojdi/w16arZ7R5xz
 /ei4E5V+OukZnM6lth4+5VICuS5fSHZfBM47WyCh2zWXxFVf1zLrah1hMIVRo5EUtjWv
 +bq1jxICa2YPEM9ZqD/hIpYphQAdzw0iBNAelUyfO2BKr/YXoG35tRXLEKmqQyc1z66n
 xhNiaoDkHXI0IjKbL6KFzowI+0Sr0boQnf57MnNbPMMjtd3m4lwpADyrBASrHermBKmn
 nIC59mywVGXsVjFmmSBKNWdXxIcT5UYkvZKR7LH1UihuRuV5zg0T8HPmm8JvtQKiYVbH
 rUuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcrm2y1EVmCaj5FqodYTqrIpKREJBilC0Iu1QJ1KH5vN2Rvs+BcaszvlqGlTDY93C/JxnjYOvBE/M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRULeALlYzrw/1w6y9hBoTJ3ml2nolM447P1LfTVClNiat0trE
 kbEfa8In/MgaPBKiHNm6wsWU4UPt8e31JS/rygrDYzD1IiBOws9ug8AM
X-Gm-Gg: ATEYQzwl8bh0kwbwTE1+9SElp1vADo7zC+b/uZgStMNeKeR14ND4iJW+tpN+SF0NkRx
 vlLDjfsTdM667qjDSVnQDsBdgmn4XSOYiGD4/zJG45VQrxgsYBH2OqvEXTHAWdNEz0UQOEL2WwL
 wFqg624htbyDsClTs3SDSZurLXN3PjaplwRsDUdlAFKWwBzZLMuUPObBReXLJpXPNI22JAKe9dm
 JaiO/Et+iHd6ME/WZeOMfRfZ8meq+tduNsUJwKBzKWyF4F7pfzsEwKmptgn59NBo6eey7mv42cd
 9eRFE9wsEl+RPXEB61zCD2O2t5G+zeK5gBV8v9HBW7cpeklV6kxAJViSZiQjytw8RhOGSt/X3ck
 ieHzboJQgsJm8sMscJ1Q0cm5kchZnA+mnyHlgF4HRYlou0s+B7AzwBzblt7tp5JMIwb+rL2Kws3
 Xa81b5zwl8KmVixqyJuzwZB+7VocLpOMbJmb4XgxKwVCOMtS2q
X-Received: by 2002:a05:6820:338a:20b0:67e:f8c:6bcf with SMTP id
 006d021491bc7-67e0f8c6db0mr1039841eaf.21.1774551337025; 
 Thu, 26 Mar 2026 11:55:37 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 42/69] drm-dyndbg: adapt drm core to use dyndbg
 classmaps-v2
Date: Thu, 26 Mar 2026 12:53:46 -0600
Message-ID: <20260326185413.1205870-43-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
do too much.  Its replaced by DYNAMIC_DEBUG_CLASSMAP_DEFINE which
creates & EXPORTs a classmap, and DYNAMIC_DEBUG_CLASSMAP_USE which
refers to that exported classmap, creating a module dependency.  DRM
gets DRM_CLASSMAP_* wrappers to hide the DRM_USE_DYNAMIC_DEBUG ifdef.

The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
redundantly re-declare the classmap, but we can convert the drivers
later to DYNDBG_CLASSMAP_USE, at which point they'll respond to the
echo class FOO >control commands.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
this ignored a checkpatch
 WARNING: Argument 'name' is not used in function-like macro
 #70: FILE: include/drm/drm_print.h:148:
 +#define DRM_CLASSMAP_USE(name)

the macro is empty, and correct. only 1 arg is expected.

v++: fix old CLASSBITS/CLASSMAP comment
---
 drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
 include/drm/drm_print.h     | 13 ++++++++++++-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 9b622345e2eb..c0ec866f31dd 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -56,18 +56,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 module_param_named(debug, __drm_debug, ulong, 0600);
 #else
-/* classnames must match vals of enum drm_debug_category */
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+/* classnames must match value-symbols of enum drm_debug_category */
+DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		    DRM_UT_CORE,
+		    "DRM_UT_CORE",
+		    "DRM_UT_DRIVER",
+		    "DRM_UT_KMS",
+		    "DRM_UT_PRIME",
+		    "DRM_UT_ATOMIC",
+		    "DRM_UT_VBL",
+		    "DRM_UT_STATE",
+		    "DRM_UT_LEASE",
+		    "DRM_UT_DP",
+		    "DRM_UT_DRMRES");
 
 static struct ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index ab017b05e175..b743ee3f8f5e 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -96,7 +96,10 @@ extern unsigned long __drm_debug;
  *
  */
 enum drm_debug_category {
-	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
+	/*
+	 * These enum-names are reused in DRM_CLASSMAP_DEFINE to
+	 * expose them as classes in /proc/dynamic_debug/control
+	 */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
@@ -141,6 +144,14 @@ enum drm_debug_category {
 	DRM_UT_DRMRES
 };
 
+#ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
+#define DRM_CLASSMAP_DEFINE(...)    DYNAMIC_DEBUG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)      DYNAMIC_DEBUG_CLASSMAP_USE(name)
+#else
+#define DRM_CLASSMAP_DEFINE(...)
+#define DRM_CLASSMAP_USE(name)
+#endif
+
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 {
 	return unlikely(__drm_debug & BIT(category));
-- 
2.53.0

