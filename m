Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B4C5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0905010E945;
	Mon, 17 Aug 2026 21:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CqnLHRYf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA24010E93A;
 Mon, 17 Aug 2026 21:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=yXFacfDbJLHTqNoS24sp4YM8TiL+bcaLDnbkQqcM1rY=; b=CqnLHRYfZ3qzT/9xJeQIsFwBh9
 NbbuRCY4ZVFBESGaPt2xx8+b2+8HE72WO7JUEWtwCR8718rIqo40DpJ6pBT7yI5idNF6yCGFpoqNa
 9HNKOswiEui4+amwR0P9RlVQq6nn7LUswvi25xOw3CcasACA907Er3l3RVWYn5cZ4AvdQdcHjeXoP
 jPxXKHfJis1wDUcncFyqs3wWDIbqNONoF5yWJUmbH5GQ4erHqu0gaqVUYiXOnKi/DdJ+gwmKLVPTO
 9By6nmKLDD8fSw6dIJwBjUfdw6Att76hrf0HuiuzlPuKLJEsENZt3yqxM9NXXcelogPqxW/c5vdjz
 YyLlD1Vg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4XB-00504Q-G6; Mon, 17 Aug 2026 23:06:17 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:44 -0300
Subject: [PATCH v2 4/6] drm/v3d: Use drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-4-73052b669f49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=JZEqjwDs1WiTRZ75ffa4W7BZKNy05D9P6yZ6TbFqQN0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eqTwSgXC+Yv7UrldDAAUoNpJAxsXSWKNYHM
 3yVu1qhlBmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qrnHCACjC2CzHJrz/8IifdHsTSDe/yj8jBwso5ztgJ6eoHEL4UYLBms50Z4WE8s4MszTqPBvZaN
 BqHnqfutfjQ83LgWDUJ8Z97TrFD63iOiEd7Z2viiJ8NyGyn/wqDTVL8AJ3Ax4RkKo78eSpSzaMD
 SGa8sgB02kDiENicR5aZQXuLo/IdgVCZd2/71RfLrQQjpLO7tF0pcv63FhRbFWtoJKmnoCOZgs3
 5TOAkusqYY3PVbrs1kpy6j78sliaEV/oHhcu+EMmG3PHmnQapG5DIRk5X0CkUfzeyv9HdeDOB4e
 egjA5RwBzy4UXb4MLvkC8gziirPqhCAiqMbBeE6m1tAxfrZL
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

v3d carried an exact copy of i915's nsecs_to_jiffies_timeout(). Now
that the conversion lives in "drm_timeout.c", drop the copy and use it.

The core helper also returns 0 for a zero timeout. i915 has that check in
to_wait_timeout(), but v3d only ever copied the conversion, so
DRM_IOCTL_V3D_WAIT_BO with timeout_ns == 0 was turned into a one jiffy
wait and could block for a tick before reporting -ETIME. It now returns
without waiting.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_bo.c  |  3 ++-
 drivers/gpu/drm/v3d/v3d_drv.h | 10 ----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a847d2f0ccf5..919bdff1036e 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 
 #include <drm/drm_print.h>
+#include <drm/drm_utils.h>
 
 #include "v3d_drv.h"
 #include "uapi/drm/v3d_drm.h"
@@ -281,7 +282,7 @@ v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 	ktime_t start = ktime_get();
 	u64 delta_ns;
 	unsigned long timeout_jiffies =
-		nsecs_to_jiffies_timeout(args->timeout_ns);
+		drm_timeout_rel_to_jiffies(args->timeout_ns);
 
 	if (args->pad != 0)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 8c46ed09f5c4..595c61a955e8 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -578,16 +578,6 @@ struct v3d_submit_ext {
 						   (Wmax))
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
-static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
-{
-	/* nsecs_to_jiffies64() does not guard against overflow */
-	if ((NSEC_PER_SEC % HZ) != 0 &&
-	    div_u64(n, NSEC_PER_SEC) >= MAX_JIFFY_OFFSET / HZ)
-		return MAX_JIFFY_OFFSET;
-
-	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(n) + 1);
-}
-
 /* v3d_bo.c */
 struct drm_gem_object *v3d_create_object(struct drm_device *dev, size_t size);
 void v3d_free_object(struct drm_gem_object *gem_obj);

-- 
2.55.0

