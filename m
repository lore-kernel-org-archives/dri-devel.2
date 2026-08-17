Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11196C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382D810E927;
	Mon, 17 Aug 2026 21:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b+DVfo2U";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1175910E468;
 Mon, 17 Aug 2026 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=GOiih112IF4qvl6Tdu0625xlcBMjCPj4P2KK6AXRbTg=; b=b+DVfo2UhzYoLl+hGK++U+RsXF
 54tDOnKfHT0MivyEJDJSooEYuXybd2M0ZnvdSTP290FTvgWO+yCeigwaEFgzRQRk2EOS1srPoVcJa
 tvyK4TTqKYXEOpUmwB5d3lxPWlvzDfRWOGI5jE29nxfJr1//udTzeUhZM+lgf9uaRxr37BeV1jKL9
 fzTRnGl517IQB2PTzo23BXeVwtyloKXzkVJ8I9MZlaWdv1xMLRnDXNiIe7f1sVl3l48pjeaiC6WED
 NrADYcCjrRb95dEFGSoW7OMmTxwbM7RxTNUIqwfrr/WRPWT+qlbfJxAbiVMLD7HSdz95tKYejwM3X
 t678XCMQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4Wt-00504Q-Dr; Mon, 17 Aug 2026 23:05:59 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:41 -0300
Subject: [PATCH v2 1/6] drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-1-73052b669f49@igalia.com>
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
In-Reply-To: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Itvq22A+UCopDH3ddQA2XO3z3mhutCFuUiSFKH9lZ7s=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eqDpP3TAIruX1lywhqyAehmCI35tj48+G5p
 8vxfINhmNmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qqOHCACq8THrR00MTnN8yzZ1YjpIYydMLw/NRZE4BqPGzzgoF4+MmzuzSlGouUZwpi9+sV2UIFa
 6aAibsFZXu9DzBng6PEM5X7PDWYHY3jvJecGbrhBOkJ8mHGDRhdp8EyaCLQ8JSnM715j7QhSjvJ
 IBIE+rPGHp+boa0H6jRgJcDxucY+5yvBTzeI96Aj5esLxeiM9MqvjpGm7SQybozv137aQe97B97
 rY5kHXN96JVpeArGgfdBv5bH+C5ryNs2wsfyPFzM0KRuFjLAFJcScdgrj7ZoLyJqK5/SA34+rjD
 MIONGuzMts3SR9zVBj0jGV20Du8+8PlnBeXt+BP7/80ldJzq
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
home, which will be useful when we add new timeout handlers. The
declaration stays in drm_utils.h, so no caller changes.

No functional change.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/Makefile      |  1 +
 drivers/gpu/drm/drm_syncobj.c | 33 ------------------------------
 drivers/gpu/drm/drm_timeout.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..0a0d7ea08347 100644
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
index 2fa170a29a62..cf03681de6f7 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
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
index 000000000000..78e9f65e5477
--- /dev/null
+++ b/drivers/gpu/drm/drm_timeout.c
@@ -0,0 +1,47 @@
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
+#include <drm/drm_utils.h>
+
+/**
+ * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
+ *
+ * @timeout_nsec: timeout nsec component in ns, 0 for poll
+ *
+ * Calculate the timeout in jiffies from an absolute time in sec/nsec.
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

-- 
2.55.0

