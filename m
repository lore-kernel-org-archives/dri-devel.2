Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC64C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625A910E937;
	Mon, 17 Aug 2026 21:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZPGMvt7B";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4EF10E470;
 Mon, 17 Aug 2026 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=NQg0IZhJtYy5AhjEShPnOuW+9zHJ7qX9x6QAvqaExHE=; b=ZPGMvt7BgRGFoELLUDQnMaVs/m
 kkfpDjod2jovI5VFB1xz3iskmdZnLR1oiXEob2QN8g/Pj0epqK6ANnKDM0Bik8kyCLK6aTvVwkEkb
 C2E0rLePysyqfnoiXKNDPKhcGzlAoyeIu3fZLwAQVmVInNg93cEoJzpITa3+xarf0BU6mXD7MsU60
 4X+T1MCmtJXeBHDAZH6D652NO6tT4jxmZ6HrV7P3uFpxTiHCgejxoiCgGN0rOFLKf4EHCipzEMYS9
 WsbTfGO8WsmI8u/3x9ecvvLzUlYXI6rE0XqLqMyozftGWxfZwMsC0AW9k9ye58fsKjmEGpJrOJUay
 GLWxtEFw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4X5-00504Q-Pf; Mon, 17 Aug 2026 23:06:12 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:43 -0300
Subject: [PATCH v2 3/6] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-3-73052b669f49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2456; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=ULDgTasgtitUkOJTp2isre/vzyCVk7FgXNsC/s07nkk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eqNpHTfrpn7MTTQD1ugG3dCmRV0IjnoVtO/
 L64awHKdh2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qmOHB/9+jyvEuakoQDAaXuo8mszOjuu7v6TJVIgUYDd8OcnC40ugI9aedlp0/owdOVppZf0HFK7
 JmJXfdvT5FKZ/bF5HmYT42IvjrqcX6ueUqq35S0wAtp2PLZ33Me0kXCh93Lt4T8K0Mfbeb5nxQ3
 Rx+gE+i1dki2HGVEWodpp5bSM90wgZk6E8zEPs9MfJ3cRBB9kbdrgxKeGI/ZI95wvRNe6+K1iLD
 Ab4C9HEW0J4J8+sWGhO/viTQr/3wKv2IAbZoU4E08Jkvf6MNWs2+ztONCc0AaYJ5rHVXhOEbtlJ
 nvYBm/4LWKqUvYSnyw/Aepkfra/6heDQLaDsXOPqCu4sfjh7
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

As a note, this patch can be merged independently to the AMD tree
without any dependencies.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbc..beadd657c09a 100644
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
+#include <drm/drm_utils.h>
 
 #include "amdgpu.h"
 #include "amdgpu_display.h"
@@ -622,23 +622,11 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
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

