Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49903C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58E110E31E;
	Tue, 15 Sep 2026 19:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="p+tAy1i+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB78510E316;
 Tue, 15 Sep 2026 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=KGGTewqicwfQXFEgshG2MVi4wmq2aNbYV/iwQzql6O4=; b=p+tAy1i+5A6cfQFnxRLLfs9R/1
 RBkxeMsoxeEKdfu+HC0axDVkAc4ERa3cD+8OZ+xepalQXDq4/c816nB+YE+fZ9H3k6fT1C7tXQp/Q
 Vhdeze0JLlvxywutu7QcJDfFWWJYDszOBZa7JkRXwMWAYF83tzbjAyWKKxZjIgUQj6mBKHPZq/83H
 S/BZJR1y3nx7dwlDFDGLMCSiUFe1VH0ojqTpOZHIGgrTUEoU3BNabniY5/8KCa3dvFOcVyNjV9ewd
 5YSWtVAQrvUDtScDZRpHlrMfCb11N/xUQvAnT3U2WmBQwjrcb0NPHqpD5WNJcjF0aRG5/PF0MNZTa
 cSGt1+vA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6Z3g-002bhq-OM; Tue, 15 Sep 2026 21:43:13 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 15 Sep 2026 16:42:18 -0300
Subject: [PATCH v3 3/7] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-drm-timeout-helpers-v3-3-f2ae987d861f@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=s48TSB8yEiMXWuhVCzV9dnNmm4d39vj2FQu6yuTF63w=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqZ+ohJfGS8onQhcuuwm7HD99pac1O+VCnM/x/
 bA7ornywFmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmfqAAKCRA/8w6Kdoj6
 qhCmCADFsa3dmSrI5747j05az9R4Oe7UoJE/k3vJLaxJ678RDPG2UIW0QO7H9OL0SQ4gqZVR+oE
 ecSCROYREtLR078iEwOKBPdyHNY2Eka8r3MK9cEfvKR+JumK1Nt5ji3arvj3j8u4Xw40uv5ZWT5
 F7iH/GUXsnrBLBm6gBtdOYDogVRI9Du8iIFrUum6P5yWdtNheWRk608hLJqc5wy/2XFx7nxdUWp
 Onxxe+oA+eODUUQy/1n6BwgaeqsXpqcDuKDdv70W9jDs4bIL6DihWJt9zNwmHlUDWlArIJNjd5E
 E33M4pEdPRusrfvHuC/lZ0bjTARm3sp8qahst1aDfEAilzgk
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

amdgpu_gem_timeout() converts an absolute deadline in ns into jiffies,
which is what drm_timeout_abs_to_jiffies() already does for the other
drivers whose wait UAPI takes a deadline. Use the shared helper and keep
only the part that is specific to amdgpu, which was improved with a
clearer comment.

Two details change along this conversion: the helper rounds up rather than
truncating, so a deadline less than a tick away now waits for one jiffy
instead of returning 0. It also uses nsecs_to_jiffies64(), so the
conversion no longer truncates on 32-bit, where a large deadline could
previously be reduced to an arbitrary shorter one.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 165344f7197f..bf5fcc6a254d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -25,7 +25,6 @@
  *          Alex Deucher
  *          Jerome Glisse
  */
-#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/pagemap.h>
@@ -40,6 +39,7 @@
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_tt.h>
 #include <drm/drm_syncobj.h>
+#include <drm/drm_timeout.h>
 
 #include "amdgpu.h"
 #include "amdgpu_display.h"
@@ -643,23 +643,11 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
  */
 unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)
 {
-	unsigned long timeout_jiffies;
-	ktime_t timeout;
-
-	/* clamp timeout if it's to large */
-	if (((int64_t)timeout_ns) < 0)
+	/* Map anything that doesn't fit in a s64 to an infinite wait */
+	if (timeout_ns > S64_MAX)
 		return MAX_SCHEDULE_TIMEOUT;
 
-	timeout = ktime_sub(ns_to_ktime(timeout_ns), ktime_get());
-	if (ktime_to_ns(timeout) < 0)
-		return 0;
-
-	timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
-	/*  clamp timeout to avoid unsigned-> signed overflow */
-	if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
-		return MAX_SCHEDULE_TIMEOUT - 1;
-
-	return timeout_jiffies;
+	return drm_timeout_abs_to_jiffies(timeout_ns);
 }
 
 int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,

-- 
2.55.0

