Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62076C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 19:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63FB10E5AA;
	Sun,  9 Aug 2026 19:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pEkVnxvI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3A910E5BC;
 Sun,  9 Aug 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=lw3psvBeh1SE1nFc8VfpjEE8M7kEBECR1jNY8g4tKvs=; b=pEkVnxvIhXa81edmtFZO1XMzdD
 wWc8DnYHR7UDns0/Hx14CzVaWEU2eJenYjjHllQSKenG3/xkvfdp7/LVcnd/RBMcnzkwJp+LreE19
 uEEse7eV0JK/15+xG/ygXVilJZsh1nM1H/EUX9KBM2uJ3NimYp0DOKv4nyGoAtJxsS6rjCbw1ytPK
 fZ4eeJblHtpr/5eh6eWsrKjiJUO2jPB1Zu+AX5kT+NtW/CBxGLwXe962gB3CLDlUAX1O8beRYWq+0
 6SD5F0NDgKJ8D+MYFY4Kg+Dwe6CE3ljTbhudE6y4s6XmRwidpJEbX/i8EI4O381M9cVq+okll2HmC
 +xV1/vow==;
Received: from [187.36.208.132] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wt98a-00GH3T-VK; Sun, 09 Aug 2026 21:24:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 09 Aug 2026 16:24:01 -0300
Subject: [PATCH 5/6] drm/i915: Use drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-drm-timeout-helpers-v1-5-2de67405a145@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=PsGoN4+6l5T0DQgCz7JXX4O+5Rg5wQ/vxnQpeUTRTsQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqeNPY4pVGf4+jiUnpQcy8qjLuYr8m99pCsxueq
 riuFDj8fNSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCanjT2AAKCRA/8w6Kdoj6
 qm1qCADN4eT/agCmtsD2XytkLwEs3fcaRGAt7tuM1Gc1nLpMpdouxpOsJKbxgmXJH4JLQlNuEw+
 FbCEqeIGejRPwkJGb2yixir7q0e8caX4XVn4Xvc7ph47mGfkUVZkf2A5h3GSNAMiyhhMt/9gktw
 sqsM6GkBKZZ3EEldFP2SLqFPjVL/Qu3pdIyoS0jht28Y3xm2tDP87f7jE1qKzf+avjRCk5o1nMV
 BrHja9AHjinzSYXoxpCquNyZ0qo51Rv0ElPQRFxDKNUJ9Nt5CGxHm6+NHb6ZAhatvedyzhQPRmE
 HhzinWzYgP1Jpu/QUDypBPBpUJp5YiY1IlcQu8VV+vrxQzSJ
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

