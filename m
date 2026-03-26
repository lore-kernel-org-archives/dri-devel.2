Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4829210AB810
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F09310EC0A;
	Thu, 26 Mar 2026 18:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efrYnTab";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D335110EBF2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:13 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-679b072ed3aso790151eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551373; x=1775156173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgXq6jE50vtzY84cY1V8ERFkQj1I8fWL7chL4/tqUbE=;
 b=efrYnTabT5PosLMfK9xl79O3HVi+hloAlJzaiPtkdmX6Cc2zQGd+N+bwbscdhG1TXS
 7ah8ECRFInP1EsIjFYxLGZUA0SYsQP72ZnjfyFHtGC8wMisxe/KxBG4ZNmTSSwLQTOIP
 wjqtUk4P0GJoP6/U0ln2PWmBeh040kvuB3PHeDg0goVWnkHHUTfcPC84rnNyIAm2Ka74
 Xb4vL9G5LpAvFAVcMpb/XVkz+gkr+KXwJ/pi/Ot1taCbX++ON4+7D1Q1wm8mAe1FIY/D
 xjglKxqmq9euyqhnKuuOgvsYaAkoUo23jX7OK7FnrM76wynAEPLcSXqm80pUGM0SqmfZ
 OItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551373; x=1775156173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgXq6jE50vtzY84cY1V8ERFkQj1I8fWL7chL4/tqUbE=;
 b=I79PjktBPo4DEf9z9bC8LljmnJDee+tG6qrhVqLBR1PRzREQRv/zoi79cO70HrX2lA
 jzZndQM9Rgp0ffZFON+dNRsFlNczrpKLAZJbCEUNaI+bNd8SX9ALOkj6zX2/WoLX3Wx4
 cbvd4OF1KsPUyDoVP8QdQhljKOif0HOphW5lDE63VOAn055bP+VRqLBjulXhYGkCqDeu
 5eRBUtLDHz2E8aOy9JfaUxb2oEfrY0+ksUWuWTxyvw08JZeUVWIHwAuHLltBvTbjKnpj
 wG+qbS12vr6t1XTtEOojUhT9ZYRHBTwO0cLeUZrFvEKY9k7+dBLG6JIdK3bNcYIuBE1b
 cCVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgQ9DQmk9kHNKsNysnT6aiqAi+t/8q40mLxFVY0qE0JUNosB8Sm3RMaj8Ml6JdDV1rD61kZscWod0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI/tZ6x8oza20w5ZKCWnYlMVjUtj1h89535wBlC1Ae+3h0hzUt
 TEgkGhDI0uRUxRCmANR40bhaZgGX2sKm9+6XNnz70Lm8q4MEZcJ/Wttc
X-Gm-Gg: ATEYQzxXpxy7onvsdEBd3060hizFZrXAkddE4wkcycevTbecmKHONbBfm3Hsmwln9AR
 dbLKEad1MYnai7I0EqavuNZKcemnjCJQo6n/eXmDLiKp4uI5LY4n0PXdbQKedSLn//xnMCzJCH1
 TK58kaYO0YlXa0Stw3LJUtoRjc0zx19zmgTQWyDuK27ycLYjboqCE2rVNPdTAoNK90qwM7M/R4m
 ok0Ln7rUVs+grZ9SIXzrjYsq6/Zm+pPYxh325RgEIYCXDxseqXmHsvoTdRCfVcO4BioHT8FlZld
 imB9aWwLBb0FD3WeMmffUx27vvHHufgX2zJCKbGep92UJVg895M1lQESNVfcjhpQ8oYJemzR1NA
 o3T7qYHYuN0SXgEar6y9W+XV9SRMdIzeRDN/T8MorBTWZuJn6x67q3eSn83yxt01X8zZc1eiJ4L
 H4Ohnu0lsnW54LjdK3T8cQjw6KDkD1Ow+CPWtTe6TVBXL0WIQp
X-Received: by 2002:a05:6820:3106:b0:67d:e17b:31ac with SMTP id
 006d021491bc7-67dff51609emr4069367eaf.45.1774551373018; 
 Thu, 26 Mar 2026 11:56:13 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:12 -0700 (PDT)
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
Subject: [PATCH v12 67/69] accel/ivpu: implement IVPU_DBG_* as a dyndbg
 classmap
Date: Thu, 26 Mar 2026 12:54:11 -0600
Message-ID: <20260326185413.1205870-68-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_DEFINE to create a classmap of
class-ids/categories for ivpu_dbg().

This brings static-key optimized-off benefits to the ivpu_dbg()
callsites.  DRM_CLASSMAP_PARAM_REF wires the sysfs kparam to the
classmap.

This is the 1st real-world example of a module avoiding another
module's classmap's class_id range reservation.

Its also something of an oddity: it "is" a DRM module only cuz

1. CONFIG_DRM_ACCEL_IVPU exists.

2. code therefore uses CONFIG_DRM_USE_DYNAMIC_DEBUG, so must also use
   it's dependent wrappers: DRM_CLASSMAP_*

accel/amdxdna is already using drm.debug via dev_dbg(), so it is more
fully DRM but iirc its a single call.

Anyway, to play nice with DRM, we change all the constants, from
macros calling BIT(X), to an explicit "enum ivpu_dbg_category"
starting at 16 to avoid DRM_UT_CORE..RES.  This is all in an indef to
avoid changing the constants for the non-dyndbg case.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 27 +++++++++++++++++++--
 drivers/accel/ivpu/ivpu_drv.h | 45 ++++++++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 5900a40c7a78..214fdbf06470 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2025 Intel Corporation
  */
 
+#include <linux/dynamic_debug.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -37,8 +38,30 @@
 #define DRIVER_VERSION_STR "1.0.0 " UTS_RELEASE
 #endif
 
-int ivpu_dbg_mask;
-module_param_named(dbg_mask, ivpu_dbg_mask, int, 0644);
+unsigned long ivpu_dbg_mask;
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
+module_param_named(dbg_mask, ivpu_dbg_mask, ulong, 0644);
+#else
+DRM_CLASSMAP_DEFINE(ivpu_dbg_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		IVPU_DBG_REG,
+		"IVPU_DBG_REG",
+		"IVPU_DBG_IRQ",
+		"IVPU_DBG_MMU",
+		"IVPU_DBG_FILE",
+		"IVPU_DBG_MISC",
+		"IVPU_DBG_FW_BOOT",
+		"IVPU_DBG_PM",
+		"IVPU_DBG_IPC",
+		"IVPU_DBG_BO",
+		"IVPU_DBG_JOB",
+		"IVPU_DBG_JSM",
+		"IVPU_DBG_KREF",
+		"IVPU_DBG_RPM",
+		"IVPU_DBG_MMU_MAP");
+DRM_CLASSMAP_PARAM_REF(dbg_mask, ivpu_dbg_mask, ivpu_dbg_classes, p);
+#endif
 MODULE_PARM_DESC(dbg_mask, "Driver debug mask. See IVPU_DBG_* macros.");
 
 int ivpu_test_mode;
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 5b34b6f50e69..ef5a96b961fc 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -65,6 +65,10 @@
 
 #define IVPU_SCHED_MODE_AUTO -1
 
+extern unsigned long ivpu_dbg_mask;
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
 #define IVPU_DBG_REG	 BIT(0)
 #define IVPU_DBG_IRQ	 BIT(1)
 #define IVPU_DBG_MMU	 BIT(2)
@@ -81,6 +85,41 @@
 #define IVPU_DBG_MMU_MAP BIT(13)
 #define IVPU_DBG_IOCTL   BIT(14)
 
+#define ivpu_dbg(vdev, type, fmt, args...) do {				\
+	if (unlikely(IVPU_DBG_##type & ivpu_dbg_mask))			\
+		dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);	\
+} while (0)
+
+#else /* !!CONFIG_DRM_USE_DYNAMIC_DEBUG */
+
+enum ivpu_dbg_category {
+	/*
+	 * since accels are drm-devices (CONFIG_DRM_ACCEL_*), adjust
+	 * IVPU_DBG_* to avoid DRMs 0..10 class_id reservations.
+	 */
+	IVPU_DBG_REG = 16,
+	IVPU_DBG_IRQ,
+	IVPU_DBG_MMU,
+	IVPU_DBG_FILE,
+	IVPU_DBG_MISC,
+	IVPU_DBG_FW_BOOT,
+	IVPU_DBG_PM,
+	IVPU_DBG_IPC,
+	IVPU_DBG_BO,
+	IVPU_DBG_JOB,
+	IVPU_DBG_JSM,
+	IVPU_DBG_KREF,
+	IVPU_DBG_RPM,
+	IVPU_DBG_MMU_MAP,
+	IVPU_DBG_IOCTL
+};
+
+#define ivpu_dbg(vdev, type, fmt, ...)                    \
+	_dynamic_func_call_cls(IVPU_DBG_##type, fmt, __dynamic_dev_dbg,	\
+			       (vdev)->drm.dev, fmt, ##__VA_ARGS__)
+
+#endif /* !!CONFIG_DRM_USE_DYNAMIC_DEBUG */
+
 #define ivpu_err(vdev, fmt, ...) \
 	drm_err(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
@@ -95,11 +134,6 @@
 
 #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
 
-#define ivpu_dbg(vdev, type, fmt, args...) do {                                \
-	if (unlikely(IVPU_DBG_##type & ivpu_dbg_mask))                         \
-		dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
-} while (0)
-
 #define IVPU_WA(wa_name) (vdev->wa.wa_name)
 
 #define IVPU_PRINT_WA(wa_name) do {					\
@@ -197,7 +231,6 @@ struct ivpu_file_priv {
 	bool aborted;
 };
 
-extern int ivpu_dbg_mask;
 extern u8 ivpu_pll_min_ratio;
 extern u8 ivpu_pll_max_ratio;
 extern int ivpu_sched_mode;
-- 
2.53.0

