Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B64105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E3310EC22;
	Fri, 13 Mar 2026 13:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+wULDJl";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB2110EC10
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:13 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4645dde00a7so2693550b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408252; x=1774013052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctYWbn5zpBxXKFAUFmjBfsapEiOXJnCJVZtfjZFl2eo=;
 b=c+wULDJlfHph7p2oCOqbbfRX9rrZpxRpgfnR/mFKfv86NGGscjA0sy5CI4SFN7LFPo
 Z1oG4MPg+RZafDhT3s4Bvz8GXhWEcdd2Kad/6teKHVL2XQwWo/MgEoT7ykJZHL3uxdqE
 JllTXJSudradDk+TL1cxktNZcwkOUIVc98/rWL4JfOrY1yWtU+QMT7NDENqe7TFMsqIw
 sH7ws06WF36i6zzlIa65iXnD8CYCvgYZzO+dY0OH6/m0F9BAQPKlT5/sW9+J582CO8pn
 F6nBqWUp4sLG3KWnoCDczPjKC/Dd7qf4i+K7tXSiMMO53QW0SaM4BghnVnx+CdbOg3B4
 qr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408252; x=1774013052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ctYWbn5zpBxXKFAUFmjBfsapEiOXJnCJVZtfjZFl2eo=;
 b=TZFbcoM2uZubohKJzlRrluB0ZohkxFZrBbNC6GXsnk5SQno2+0r8W+qiHQoH3IABV+
 XSoqkouDzU0DpfQRoSbsyHV0yEGBmSBw6OJexjh+hRT5Jji6QwG+c7NU4PD97jJ4IkA4
 E7bg1KPAJmGEsI5bgnEcuED+dmZGMWije9QgZOAYateuP25cLKUvuvS32PMT8F+EKvcC
 l5TwPgkKBFJFTd+D1IcAztbnjswAy5Nb1Qsl2cV2GvEM4NF2nwAiBQaVM9tms/aYnyVs
 F0DS3buvcL3NPXdatT3vjupHGciKhXU/j0r+U899W2odMBe9lJHsfT/VhUXSZ6MjIYz6
 r4BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6aQ9K0C8/18jq+ynusxth2qc4bk53h10hRDaVKQnYCqfFkssn04E9jnaPlKTvGi/yC3Uff+xhuHA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCCpVuTYN5vjDIfRD/QHvC+XcNzfvVRhc3R0srt/nYCST7OBLB
 UsM6ug60TY9NKkTJH5Bnsxppcfpx1EZwZcVCVCGVinKRZJg3Oi1Nrnbe
X-Gm-Gg: ATEYQzxsmq/D2CLnj0mwh/92hWzYW4j9F40bXTS6DMDtozAHTpUUbHCOlY5NGN9vxTw
 puvqe/q4ZVAW3djtj/gGTfhVPfYAT+sWwyr15fQ2mm5BdrhL/3XOpI1ajSkAdTITf/FseqHXtZX
 BOY4EcGAhHNBZztmk2OFH6Y1/rZ1m4QNfxLzWXUxpDkeoPqaPO54f5bteIAdMVZWm5bhWlYw/RE
 7ugVmmHrJpdgSjO/jiCT8+r0H0P4Aj94Z0OnuYRkmwWVqf7HqtLBtXh518LSkFQFksp02UuvqBG
 90eCZTpCfzqdkfJkyIXhBmRMIGxHAuh8pRtd1qtitDUdWKyYGFtVz+8PjnkEAhWLg1clgFhyuUL
 dHyAgn3d9p8GkdsZ9HgOteJDMJPPiaE3Vcaaq1vNs+Afzf2YHaFhb3bi+Hjw1C1EiRF+CtE6KWK
 yq3ffNRe0QCdjRFoQIi9lRD9hLw9eFuSA/jBPR/LBf5UfWCzDy
X-Received: by 2002:a05:6808:14c8:b0:467:5f1:fcac with SMTP id
 5614622812f47-4675552aa1cmr1830167b6e.5.1773408252422; 
 Fri, 13 Mar 2026 06:24:12 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:11 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 35/65] drm-dyndbg: adapt drm core to use dyndbg
 classmaps-v2
Date: Fri, 13 Mar 2026 07:20:00 -0600
Message-ID: <20260313132103.2529746-36-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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
index ded9461df5f2..d07e7953c9fc 100644
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

