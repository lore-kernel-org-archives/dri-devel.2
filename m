Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FAA105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD4010EC37;
	Fri, 13 Mar 2026 13:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hTdyY45m";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A4110EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:00 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-467161c4b89so1365885b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408299; x=1774013099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSI+J0679V/DmlJlREZ5wQ9k+pFMYu6PsZxwHc99Yws=;
 b=hTdyY45mvr2XhOdbaKznl2huansZYxi0c3QF0/LeT9rSvMnPD6sUQ61sSnp3P82eNw
 1fmGSS+JrQcvWeLJ8GDI0znAy6HywqtbAcPN26ujeczJNpDmqAVUJj9Z2tPWFlD0M6ZA
 Yqu8tz02rfeWP3XRakpCvEK9tkudyRbpFfwNoHebPkM411KicZWF7IfJ+djM9NRWJjw1
 ml2wSBH1zjp2HbuktXmn9T9gKt2sYwxfMFw8gX6BN/U8xy0RoPLKZnfkwUbZ086ft4mg
 U49CYwhqsgyta0F3eSGySoq2PmqMbDkXKMUeHtR+EsHrpWZqt7wrCyoe5jnTZv28Uion
 zywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408299; x=1774013099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MSI+J0679V/DmlJlREZ5wQ9k+pFMYu6PsZxwHc99Yws=;
 b=iLIbgC/pfzLpsBAKRNlgpX4geAeLYadEZVY9zbRdbG4mGZq3Wn+nJMtQpg62fvAHC6
 Hm4E6Ewy9AKFFu0D5PgnBlMCOWAwD/sUTW9njjrMqqefUobQaxSbPrfrJ+nvZZKcJK5t
 b/On0k1hry+hHk2aPA1qMdNbCLFJiFjy4+LA6/eq5zH1c0SlZkICikiILwoV1q9Un91M
 +YYW4mPW3eIxmpFhEq9bLlCBpvs+rIsWqbROn6U7oa2IV1gRzWjsPSBrAAeSaPpUrQkx
 XNHiBzluUgHK9B8UDVK/65RaVpDDzg7CI++ahQOZC4dHGLNpIm3NVpM1E/WCqHddU+hc
 Grsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuaPot73lVWe7si+2UQYejeGbYaXMVS0Gt02BNJRXEgbSUlcWvmxvgv7KupSJKX/fOO+9LUekiQ4k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfwLhQzALU0/0UF3oSKhLuP6PCWnA5VPaKBsj7kD7fklWo3SgH
 43VHBghTHXxvRUGsctvf4+P6G/ZHsJzjtbjVcRJePN8f7z5Kpao9LPJI
X-Gm-Gg: ATEYQzxutfGbD7rywG+LtdWZpj6GHWirYsGA4Ce+kCLlQIDWthSJwrGVhgRk3YCVdNK
 PKhMPjCFtmIPPMT9bJ4djB+rNz/d7OteM9r69xSQr2bMB4+T8mNgcvFfniW7jGl9TE3k06DCD6Y
 bYyuzd7+7TyyX/CkKd455aPDdrlGvSKhpbXFnVh1dl5EQnDcIOhsp4dGLLKydQMlDnGHq+zV3P9
 HvkmJtzNzr+Qe4I6vZy/hF6vPDkilCCMt6yJg4UlOBp5frMOOx1+Zds5R7OpgrOEMWWH8C24LjL
 k8ks8gli6va9ypR4aehCt7cbSBt8h8dLlF99qkbos9Id4NvKn1YAZyNdFn/Jr8x6Gee4QvM3gmF
 lFtpuDlgJ0VBL6Of9kAg6DARMPyQQE4YQxdxsf5o6R6KJrqpSJe3gdf+dEMHbt44FuSG8Nkb2lL
 +IgApwPKNgfQE2+QrwBkgPe2YeRC50Qv4Y74jzHtEhhoqtBIWy
X-Received: by 2002:a05:6808:444b:b0:455:7fe4:b215 with SMTP id
 5614622812f47-467575d484amr1587635b6e.53.1773408299425; 
 Fri, 13 Mar 2026 06:24:59 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 59/65] accel/ivpu: implement IVPU_DBG_* as a dyndbg
 classmap
Date: Fri, 13 Mar 2026 07:20:24 -0600
Message-ID: <20260313132103.2529746-60-jim.cromie@gmail.com>
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
index dd3a486df5f1..2d7d290eb8bb 100644
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
index 6378e23e0c97..b59aa0759e26 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -63,6 +63,10 @@
 
 #define IVPU_SCHED_MODE_AUTO -1
 
+extern unsigned long ivpu_dbg_mask;
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
 #define IVPU_DBG_REG	 BIT(0)
 #define IVPU_DBG_IRQ	 BIT(1)
 #define IVPU_DBG_MMU	 BIT(2)
@@ -79,6 +83,41 @@
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
 
@@ -93,11 +132,6 @@
 
 #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
 
-#define ivpu_dbg(vdev, type, fmt, args...) do {                                \
-	if (unlikely(IVPU_DBG_##type & ivpu_dbg_mask))                         \
-		dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
-} while (0)
-
 #define IVPU_WA(wa_name) (vdev->wa.wa_name)
 
 #define IVPU_PRINT_WA(wa_name) do {					\
@@ -208,7 +242,6 @@ struct ivpu_file_priv {
 	bool aborted;
 };
 
-extern int ivpu_dbg_mask;
 extern u8 ivpu_pll_min_ratio;
 extern u8 ivpu_pll_max_ratio;
 extern int ivpu_sched_mode;
-- 
2.53.0

