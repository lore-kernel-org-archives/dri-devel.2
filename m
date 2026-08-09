Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3EFC5AD7B
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B1810E5A4;
	Sun,  9 Aug 2026 19:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ETGdS75W";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E599910E5A0;
 Sun,  9 Aug 2026 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=g4PfPwOWktCQOPot6AdJmsyxg9Ej9xZvyueDT6OquJE=; b=ETGdS75Wmm8Yu6lzsk1qrHp8dm
 gBzFedhSDtA3aFaAeVLcZc8/grGKVaGQSdL3CrYL5xgSh5ytVAiQBtnyhH+EsHN+OCioezerPpd+G
 PtGr13iZ2+pTRSsYpYxWGjxNd8ZWG+PyD3UnIpV6oonvDSpDP3Zv+0BZbXVzhwJisZNbwD0mGS/7k
 UxPaCZIpi3mhNxYPCbi8elqUOAlxR4eFaSvDYLUKmaDKNFUXBwQyvDdmXNjsSIs3ECipUeeJioo80
 oSPiJllhWUEBkAQ5QWoFNYRSYX08NQb5gsKFItemQQnk5WryPuUnkXrLg3z9JYoMRPSeDjcis5ef1
 6yfzjKBg==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wt98N-00GH3T-Hu; Sun, 09 Aug 2026 21:24:35 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 09 Aug 2026 16:23:59 -0300
Subject: [PATCH 3/6] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-drm-timeout-helpers-v1-3-2de67405a145@igalia.com>
References: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
In-Reply-To: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=t/cWI6bykFXRsaSNJI3Q9tfcC5h9gDcSo24yddeUFhY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqeNPY/U52Z5zSQ5SSKh/OvONISAY7qKVT0o7nD
 DY0Miz2/9qJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCanjT2AAKCRA/8w6Kdoj6
 qj4jB/0Q+niJfGm5BIuC/kIL9jNUApU/Adm4Kd8UbLlCgLB7GFGqeLCp0t0hcgsQ3hcwJjQIfGw
 TL4TR1syuZdimQ2QsoqbYFHTPoVHpxWPnwGlEL9ujqwWbS/d72a3FhRmy3NVN9eBJ8ZksuMovQ/
 MJOPnAVvfI8lzCBzB2mKhvVBVTjgObyWpfr5cVInrGcP6KZAXKZsv5+k00CEeOBWRJJA4db+HfN
 cg9MD9DS1X5LXlzKFYBiGRhCUMYvNJhPKKda7fouEqX+rhHpynkq2/ZCRHxwb0bi3IGwyWcpdi5
 3fBEMg9kQU4GWUd/aoOV3zbN4/aiU0G/OzvEKYjgUn1CbIrW
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
only the part that is specific to amdgpu.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbc..84b509a484b0 100644
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
 	/* clamp timeout if it's to large */
 	if (((int64_t)timeout_ns) < 0)
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

