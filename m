Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271DDC982C4
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7737310E31B;
	Tue, 15 Sep 2026 19:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VD+/ygA/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7A510E316;
 Tue, 15 Sep 2026 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=svSPdeEUOLX5lErFCLopS0+LnK6sYanW8ToDUc05U4s=; b=VD+/ygA/mmmjlkgJirn2YBGMnk
 EIyp/ArrVkrweQPIB7DaGeEEwgP3h3iDnc1xQEcuLegglpADYvYkpGFou5i4z2ZOr8u1Ypxya9jQ9
 Nk0jWCNT9LNMUXjABChFVYa12On537C6wmJP2TIzxjeVaYqw705DwsJep9xpHodLgUaCJA8ExxMhD
 p4hMqL8r3M8c9hRW0FqeE/rAchtXlhT/RcWUIYM9WXcyBecxee0Bl9/LehfQG0GuHTD/OtzmHeQB3
 MXVg1rm3GEBWcKfnmPNZXy1P+VaDbM9NY3QIe35yfsOEveq3nm2L9H6aSB48MqnofHVXj6vwR8bpd
 KAWmQXtw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6Z3L-002bhq-3h; Tue, 15 Sep 2026 21:42:51 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 15 Sep 2026 16:42:16 -0300
Subject: [PATCH v3 1/7] drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-drm-timeout-helpers-v3-1-f2ae987d861f@igalia.com>
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
In-Reply-To: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8867; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=X4GnEbhc8fv1JJjoGrqmfaJd6Wfx7TQZHQDc0AXHrUE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqZ+oWTPSMGWSd43BdX31Cggdxfaju/kTitlIc
 Un9dukoCriJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmfqAAKCRA/8w6Kdoj6
 qrusCACRUrM8Awl2401Ni3Hdquiy+FAjTBsZcu6ruzMekLcGwyHrRm8CetIl0N7UOx9ZVy2A1yQ
 OYYFTbugcgB4wtqNOEGVvxT/tnDBcA8oIqvsC5GSye8rxE+CmsV90+YBHm6yGgcUErejawuLbss
 EKrBCwA4jxphw1Aoi+IwtyHQ04anDBMaWGD1+3IPzpvx9L2O7EQ/9/oe+pVG+tQWLhCkioML7kw
 nKpT136vpznlnlW1h3y50zcA+gjpW+nBnfydkpOiuQx2iznYXLf73G7BkfynQGZLe8OP5igkI0P
 eQp5SLXuEmnLHZWvVFtNZZBzhXde+YgxsEiLLvXxFZdpCLtN
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

drm_timeout_abs_to_jiffies() began as a static helper inside the syncobj
wait implementation and was later exported in place, so that it could be
called by multiple drivers (e.g. panfrost, lima, tegra and accel
drivers). All of them reach it through drm_utils.h.

Give it a file of its own, so that timeout conversion helpers have a
home, which will be useful when we add new timeout handlers. Also create
a drm_timeout.h header to host all timeout-related helpers.

No functional change.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/accel/ethosu/ethosu_drv.c       |  2 +-
 drivers/accel/ivpu/ivpu_gem.c           |  2 +-
 drivers/accel/rocket/rocket_gem.c       |  2 +-
 drivers/gpu/drm/Makefile                |  1 +
 drivers/gpu/drm/drm_syncobj.c           | 35 +----------------------
 drivers/gpu/drm/drm_timeout.c           | 50 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/lima/lima_gem.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/tegra/uapi.c            |  2 +-
 drivers/gpu/drm/xe/xe_wait_user_fence.c |  2 +-
 include/drm/drm_timeout.h               | 16 +++++++++++
 include/drm/drm_utils.h                 |  2 --
 12 files changed, 75 insertions(+), 43 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 1cf284e7f300..1ac08f09fde8 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -12,10 +12,10 @@
 
 #include <drm/drm_drv.h>
 #include <drm/drm_ioctl.h>
-#include <drm/drm_utils.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_accel.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_timeout.h>
 #include <drm/ethosu_accel.h>
 
 #include "ethosu_drv.h"
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 4f2005a8d496..563eeffb5736 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -12,7 +12,7 @@
 #include <drm/drm_cache.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_file.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 
 #include "ivpu_drv.h"
 #include "ivpu_fw.h"
diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index a5fffa51ff35..d981c6a93ff1 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -3,7 +3,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_print.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 #include <drm/rocket_accel.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..7283cf87880f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -68,6 +68,7 @@ drm-y := \
 	drm_rect.o \
 	drm_syncobj.o \
 	drm_sysfs.o \
+	drm_timeout.o \
 	drm_trace_points.o \
 	drm_vblank.o \
 	drm_vblank_work.o \
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index c23a5de27eff..f1d4da168545 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -208,7 +208,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 
 #include "drm_internal.h"
 
@@ -1193,39 +1193,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 	return timeout;
 }
 
-/**
- * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
- *
- * @timeout_nsec: timeout nsec component in ns, 0 for poll
- *
- * Calculate the timeout in jiffies from an absolute time in sec/nsec.
- */
-signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
-{
-	ktime_t abs_timeout, now;
-	u64 timeout_ns, timeout_jiffies64;
-
-	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
-	if (timeout_nsec == 0)
-		return 0;
-
-	abs_timeout = ns_to_ktime(timeout_nsec);
-	now = ktime_get();
-
-	if (!ktime_after(abs_timeout, now))
-		return 0;
-
-	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
-
-	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
-	/*  clamp timeout to avoid infinite timeout */
-	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
-		return MAX_SCHEDULE_TIMEOUT - 1;
-
-	return timeout_jiffies64 + 1;
-}
-EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
-
 static int drm_syncobj_array_wait(struct drm_device *dev,
 				  struct drm_file *file_private,
 				  struct drm_syncobj_wait *wait,
diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
new file mode 100644
index 000000000000..35e10293e0a1
--- /dev/null
+++ b/drivers/gpu/drm/drm_timeout.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Timeout conversion helpers for wait ioctls.
+ *
+ * Copyright 2017 Red Hat
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/export.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/sched.h>
+
+#include <drm/drm_timeout.h>
+
+/**
+ * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
+ * @timeout_nsec: timeout nsec component in ns, 0 for poll
+ *
+ * Calculate the timeout in jiffies from an absolute time in ns. The result is
+ * clamped to MAX_SCHEDULE_TIMEOUT - 1 to avoid infinite timeouts.
+ *
+ * Returns:
+ * The number of jiffies until the given timeout, or the upper limit.
+ */
+signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
+{
+	ktime_t abs_timeout, now;
+	u64 timeout_ns, timeout_jiffies64;
+
+	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
+	if (timeout_nsec == 0)
+		return 0;
+
+	abs_timeout = ns_to_ktime(timeout_nsec);
+	now = ktime_get();
+
+	if (!ktime_after(abs_timeout, now))
+		return 0;
+
+	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
+
+	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
+	/*  clamp timeout to avoid infinite timeout */
+	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
+		return MAX_SCHEDULE_TIMEOUT - 1;
+
+	return timeout_jiffies64 + 1;
+}
+EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 0c73860bb501..97e1dc541c2e 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -10,7 +10,7 @@
 
 #include <drm/drm_file.h>
 #include <drm/drm_syncobj.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 
 #include <drm/lima_drm.h>
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 96a66d673ba6..70c05210ea84 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -18,7 +18,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
 #include <drm/drm_syncobj.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 
 #include "panfrost_device.h"
 #include "panfrost_drv.h"
diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index c0ac6b45f2d7..bee310b07eb0 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -7,7 +7,7 @@
 
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 
 #include "drm.h"
 #include "uapi.h"
diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index 51eb940ceb4e..e241f3ec3547 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -7,7 +7,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
-#include <drm/drm_utils.h>
+#include <drm/drm_timeout.h>
 #include <uapi/drm/xe_drm.h>
 
 #include "xe_device.h"
diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
new file mode 100644
index 000000000000..cd9621c52062
--- /dev/null
+++ b/include/drm/drm_timeout.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Function prototypes for timeout conversion helpers for wait ioctls.
+ *
+ * Copyright 2017 Red Hat
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DRM_TIMEOUT_H__
+#define __DRM_TIMEOUT_H__
+
+#include <linux/types.h>
+
+signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
+
+#endif
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 7e077484c5bb..c61dee76451c 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -25,6 +25,4 @@ struct drm_panel_backlight_quirk {
 const struct drm_panel_backlight_quirk *
 drm_get_panel_backlight_quirk(const struct drm_edid *edid);
 
-signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
-
 #endif

-- 
2.55.0

