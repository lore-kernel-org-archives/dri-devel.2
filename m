Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03BBC5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2AC10E91F;
	Mon, 17 Aug 2026 21:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jKVx+g+O";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40ADC10E26E;
 Mon, 17 Aug 2026 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=I9LfdHwEpmjddHy7Cynq9ae2O+hHFJFd0Hyk61bbenE=; b=jKVx+g+OgTXieGHX9cGQ41Q6op
 klkFmfn+ckAZRuWToqDnzzueiAdHKm66r1XjmxsQO5/MqHlcupHAS8mbaG95rfZlcF1QtJZU2CMt2
 fRerKyxJDXCKpXr4C/da3qOPUGyHM9+vwAFCzgZyWi2qneEwl3XJzACUT+eQRzlATKq11DTllikRl
 crVGT8+d1hEfBksB/HYpE8145p1U2JqI99PPLafZdOvxNOTgKEbF9HMUwiT7DVKaLtRUVaaqxBm7W
 rsGw6oLyQpv2zkQHr9SvzMCyrOQEC9eypDvymeBmdOPo9Xk8HRiPRcK91mHFgdn6YAQOSeWZBMmrq
 o2ET/JDQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww4Wz-00504Q-Ql; Mon, 17 Aug 2026 23:06:06 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 18:05:42 -0300
Subject: [PATCH v2 2/6] drm: Add drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-drm-timeout-helpers-v2-2-73052b669f49@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=+6+OcRy6H5DTo1QCbuXhYYd3t7M4ftGwSe9XsEBekB0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqg3eqDhkCu87zOapidcmR0DR2lBMms91gQcZ+K
 KT7hCBKkxGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoN3qgAKCRA/8w6Kdoj6
 qqtyB/9zYK915S+wT8YI+90A/uCTrRkqIWN2S6NPodmax5vK5fe6XIeUkyDQofv8chJQtc2H2Ow
 yH2SMWMM+7YOp0ibVdZIrMmizPUAOC93kjTIn9S1LkzYXZqhR8Q0l4LFlUoMr3sW9NQaWIo9e4e
 aAs6t+tobz4VqkNgQBBeZKF6Nvo6Juq8Xanbho0/MeVXrVk2biujsdbCkkb/s3cda0aiAoCoxw1
 /s4gRdDxLT93XGHEYBloA19GfEMCruBwpxwlYsBfr1AlyMYybgSKzE4be7E0jtz4IG/owF3sz9B
 mw/RyxVITNVZ2HI6sApXhsB+AMHyov7AOuzexeMFV8sJWFdT
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

drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
absolute deadline, but there is no equivalent for the drivers that
express a wait as a duration. Drivers such as i915 and v3d convert the
value themselves.

Converting a nanosecond duration to jiffies needs some care.
nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
userspace-supplied timeout overflows its range and is silently truncated.

i915 already handles both cases in a local helper, which v3d has a copy
of. Add the same conversion to the core, so that it is available to any
driver and both copies can be dropped.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_timeout.c | 34 ++++++++++++++++++++++++++++++++++
 include/drm/drm_utils.h       |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
index 78e9f65e5477..18c2719d1fe9 100644
--- a/drivers/gpu/drm/drm_timeout.c
+++ b/drivers/gpu/drm/drm_timeout.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/sched.h>
 
 #include <drm/drm_utils.h>
@@ -45,3 +46,36 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
 	return timeout_jiffies64 + 1;
 }
 EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
+
+/**
+ * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative value
+ *
+ * @timeout_nsec: relative timeout in ns, 0 for poll
+ *
+ * Calculate the timeout in jiffies from a relative timeout in ns, for drivers
+ * whose UAPI expresses a wait as a duration rather than as a deadline.
+ *
+ * The result is clamped to MAX_JIFFY_OFFSET. That keeps it positive once it is
+ * converted to the signed long taken by dma_fence_wait_timeout() and friends,
+ * which matters on 32-bit, and keeps it distinct from MAX_SCHEDULE_TIMEOUT so
+ * that a finite wait is never understood as an infinite one.
+ *
+ * It's strongly discouraged to use relative timeouts in uAPIs, as they do not
+ * survive a restarted ioctl. A signal-interrupted ioctl is re-entered with the
+ * same arguments, so the duration starts counting from zero again. New uAPIs
+ * should take an absolute deadline and use drm_timeout_abs_to_jiffies().
+ */
+unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
+{
+	/* make 0 timeout means poll, as for the absolute variant */
+	if (timeout_nsec == 0)
+		return 0;
+
+	/* nsecs_to_jiffies64() does not guard against overflow */
+	if ((NSEC_PER_SEC % HZ) != 0 &&
+	    div_u64(timeout_nsec, NSEC_PER_SEC) >= MAX_JIFFY_OFFSET / HZ)
+		return MAX_JIFFY_OFFSET;
+
+	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(timeout_nsec) + 1);
+}
+EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 6a46f755daba..8c0cc9835413 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -25,5 +25,6 @@ const struct drm_panel_backlight_quirk *
 drm_get_panel_backlight_quirk(const struct drm_edid *edid);
 
 signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
+unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
 
 #endif

-- 
2.55.0

