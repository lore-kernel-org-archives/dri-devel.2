Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EBCC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B9610E24E;
	Tue, 15 Sep 2026 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Kh03kdxR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9F610E24E;
 Tue, 15 Sep 2026 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Ezb9exZFXR1kpk77rgdROXrSaOrc4NevhRRfe+jt6lE=; b=Kh03kdxRuyiuJrxeovOexR0FTO
 jQV6u2qAUR9xSJ3iuKA7/BJGMHVWsb+sC+xpuWlYBcv1tIA2u9Z51LnZKkUo6hvdVexVykqtd/oz8
 99hgJHbnrMzBCKZDcRqQYYI9SGOkZmA1yiZ27Jie9bwb8a+whMagf2LWOG0kJJ2kRPraNMU2UcX4Y
 VZvxZWwIR7FNTlHRauDr5Ml6rBc5U0SjKj3x7SQKVYEvvlTmVC4ELRhaaU1mA9jVlC0gssWUy/Qox
 +FTExAapq+yAhvl2B6LnfHiipdVmgd4yzRhIKKATsBPeRn5cBhrY4Pha8AYVQaMQfYLqREEFDcdHS
 4TvVERVA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6Z3X-002bhq-1p; Tue, 15 Sep 2026 21:43:02 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 15 Sep 2026 16:42:17 -0300
Subject: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3524; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=O8cS9MO2LE0LRxyfXTRCCuva5bynUSzuXO6qGOlbLG0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqqZ+oLbkJYWOjAQi5MsqoL1jqPO8mkW+mtg7aZ
 niicX/az1+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaqmfqAAKCRA/8w6Kdoj6
 qjElCADA5zZn2tM07GquZNsPJ0AH1KN9/36T6Lc7J8v6PqvJBHaWyN6volcyuwaEbuCX5HL81id
 +uaBSPj0Xfrsa+icjJAQV7p/ZsRrA9JyMWvlh9pN0DF6a+uVnEYAO0h6BFE1ZnH5ed102hu8moe
 LZYs1MjSCIxKp2sTiweauDVAEL1NhgCe3u7grdSaMhoJcVh/+4pI/sVpjJ7SyFsGeVad7oIkJw7
 goZAO2xhoKB2etyttUIAQ30nPEdma1StB8atUhebvb46RkO53y1DvjukHvo999RJxJBcOSwIcBO
 NSXlYjU4I3beXHiEqr02xslUZGMaRx8NtfMfDNldoLWoM1so
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
 drivers/gpu/drm/drm_timeout.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_timeout.h     |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
index 35e10293e0a1..ee545475429c 100644
--- a/drivers/gpu/drm/drm_timeout.c
+++ b/drivers/gpu/drm/drm_timeout.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/sched.h>
 
 #include <drm/drm_timeout.h>
@@ -48,3 +49,47 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
 	return timeout_jiffies64 + 1;
 }
 EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
+
+/**
+ * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative value
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
+ *
+ * Returns:
+ * 0 if @timeout_nsec is 0. Otherwise the equivalent number of jiffies and
+ * clamped to MAX_JIFFY_OFFSET.
+ */
+unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
+{
+	u64 secs;
+	u32 rem;
+
+	/* Make 0 timeout means poll, as for the absolute variant. */
+	if (timeout_nsec == 0)
+		return 0;
+
+	/*
+	 * As nsecs_to_jiffies64() does not guard against overflow, split
+	 * the timeout into whole seconds and nanoseconds. This way
+	 * nsecs_to_jiffies64() is always handed a value below a second.
+	 */
+	secs = div_u64_rem(timeout_nsec, NSEC_PER_SEC, &rem);
+	if (secs >= MAX_JIFFY_OFFSET / HZ)
+		return MAX_JIFFY_OFFSET;
+
+	return min_t(u64, MAX_JIFFY_OFFSET,
+		     secs_to_jiffies(secs) + nsecs_to_jiffies64(rem) + 1);
+}
+EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
index cd9621c52062..6ee222a3e97c 100644
--- a/include/drm/drm_timeout.h
+++ b/include/drm/drm_timeout.h
@@ -12,5 +12,6 @@
 #include <linux/types.h>
 
 signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
+unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
 
 #endif

-- 
2.55.0

