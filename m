Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3334C5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E183910E948;
	Mon, 17 Aug 2026 21:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QQjmN1El";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8612610E947;
 Mon, 17 Aug 2026 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=lw3psvBeh1SE1nFc8VfpjEE8M7kEBECR1jNY8g4tKvs=; b=QQjmN1ElLBTLu2PIVfueuSZ161
 AID0ql3taLS/koWEEf+wBibh1P1I5BNgXlUcXbESM48TSPYrNa5bRlXvsJmTxcxTkAPZhuoz1o7kw
 OMUVudTiSBErY/gg68Jz7FxTo4H9XMeDC5kmHu0Ob5WF/MgWy1kH7lbEcN8MCMKlcDV4VMi7ib9H8
 7QfbnWs5evavNIIapROS+9Zwz/iTrbgniqatmZWMTbmHfTsanISjR4mEC4Pzz0FNyABG3yu5TLniV
 sB67IX35UBKbpbwtBtw9tIEFxfpXOjc2FFLVVKRKxb1qZj0yb7O5lSSkhtB3S3OM/qEJP36VkUaI/
 uNJz10Og==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4XH-00504Q-Tl; Mon, 17 Aug 2026 23:06:24 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:45 -0300
Subject: [PATCH v2 5/6] drm/i915: Use drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-5-73052b669f49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=PsGoN4+6l5T0DQgCz7JXX4O+5Rg5wQ/vxnQpeUTRTsQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eqf5VnKUic/OUEOkLvJzvny88SgYRt0DhAT
 peSrIIjYhqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qvL8B/9NXb9WEkGIYyh2MkFCUZF2mbRJ5Q1GI3LSZURojiDEfqAth6EZzO06JE0uyFRor+aJ5vL
 iAfN+ODMdCJn4Gj4bqieWZ9xP19PkirxBxmKmui+q7WZ0MYTLFbAHLOS2IR4Gy9UMBBTFDKmjVD
 dtYmGtj8dgJMnGZZWlaCAbTchuA26ZFjqnVvmvU2lAl5QPWoExKOfhTIrV7lHvzO24ctedmjkoW
 ZKVq7LOddUkpdVgpJSfO+p2EYEdC69Aou0vJ1Ta1vF3BrHepZhLZovAimNeDxtRsrmJytkzbD1i
 tpHFxVCVC5VYb8ARJlqleBiBVgd2ab9Np7hBlTtgyrIuIDAc
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

nsecs_to_jiffies_timeout() originated here and has since been copied into
another driver. It is now available in "drm_timeout.c", so use it and drop
the local definition.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index 2893df65c359..1c189d4d7ad8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -7,6 +7,8 @@
 #include <linux/dma-fence-chain.h>
 #include <linux/jiffies.h>
 
+#include <drm/drm_utils.h>
+
 #include "gt/intel_engine.h"
 #include "gt/intel_rps.h"
 
@@ -184,25 +186,12 @@ i915_gem_object_wait(struct drm_i915_gem_object *obj,
 	return !timeout ? -ETIME : 0;
 }
 
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
 static unsigned long to_wait_timeout(s64 timeout_ns)
 {
 	if (timeout_ns < 0)
 		return MAX_SCHEDULE_TIMEOUT;
 
-	if (timeout_ns == 0)
-		return 0;
-
-	return nsecs_to_jiffies_timeout(timeout_ns);
+	return drm_timeout_rel_to_jiffies(timeout_ns);
 }
 
 /**

-- 
2.55.0

