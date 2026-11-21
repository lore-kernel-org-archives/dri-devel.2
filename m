Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71086606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E4610E6A2;
	Sun, 22 Nov 2026 17:14:43 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Sat, 21 Nov 2026 15:32:41 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1247F10E219
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 15:32:40 +0000 (UTC)
Received: from Mogu.localdomain (unknown [202.197.100.81])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5583120b3;
 Sat, 21 Nov 2026 23:27:31 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: boris.brezillon@collabora.com
Cc: adrian.larumbe@collabora.com, Haoming Gao <Naixumogu@whut.edu.cn>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix overflow in fdinfo engine time conversion
Date: Sat, 21 Nov 2026 23:27:28 +0800
Message-ID: <20261121152728.210765-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1feb845b703a1kunm82fa9b59271cb4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0NIVhhJTBgYQkxNQkIfGlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJS0lVSkJMVUpLS1VDSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
 Y+
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The timestamp counter accumulates GPU ticks per DRM client. Multiplying
that counter by NSEC_PER_SEC in u64 can overflow before the division by
the timer frequency, even when the result in nanoseconds fits in u64.

On an RK3588 with a 24 MHz timer, drm-engine-panthor dropped from
768569012750 ns to 422647638 ns between two reads of the same client's
fdinfo. The GPU cycle counter continued to advance.

Use mul_u64_u64_div_u64_roundup() to preserve the full product and keep
the existing rounding. The helper was checked against a 128-bit
reference on the board, including at the first wrap boundary.

Fixes: e16635d88fa0 ("drm/panthor: add DRM fdinfo support")
Signed-off-by: Haoming Gao <Naixumogu@whut.edu.cn>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..39b827a9b9cc 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -8,6 +8,7 @@
 #endif
 
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/pagemap.h>
@@ -1708,8 +1709,8 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP) {
 #ifdef CONFIG_ARM_ARCH_TIMER
 		drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
-			   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
-					    arch_timer_get_cntfrq()));
+			   mul_u64_u64_div_u64_roundup(pfile->stats.time, NSEC_PER_SEC,
+						       arch_timer_get_cntfrq()));
 #endif
 	}
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)

base-commit: 878c885830ef004a32e8974c4d1ae14e2ea30c5a
-- 
2.43.0

