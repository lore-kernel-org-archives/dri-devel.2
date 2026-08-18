Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A98C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571A210EB7D;
	Tue, 18 Aug 2026 13:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QbU+LKQX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C7210EB7D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060195; x=1818596195;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CoTnLQemTMDsxvQIlve7squDku5kGOe7+80gs2nfAb4=;
 b=QbU+LKQXgzTd6vmr4iC8ALf7rpthcIQfZx1GkaVH9g93xHi/Nal9LMwM
 J+o0N0zCIoKmHqAFL4+Vp/o88zUHErmZfLYpbei4bdB2MqRt2GxERJsYw
 BI2VBXH3t7NJXscuiAp1ofLqoMEa5anR/zC9tHwca8QuXWDlYTJzD85tU
 myhxk3iYMAaORHug6fjky7iLMnsGtAYt2/X1IEKG8urD8VbA+kESkZGaR
 jkGIjbun/2MhT3Ahox1UiPMaLTewCBKOuDA9nMZ1pj7lVQ98Whn2RfQfU
 003AU6QuiKL4MQBJh/k/3LHWiKCisXZQaBpH6f4/6wD8rXjKePatLRaIW Q==;
X-CSE-ConnectionGUID: Gr8LmrNWRiG796IqADnLQQ==
X-CSE-MsgGUID: T6K4Q78dR1OuAg3WXapmqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87406944"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87406944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:36:34 -0700
X-CSE-ConnectionGUID: qQ6cOLshRyKjisLdlAT5nQ==
X-CSE-MsgGUID: lJ4SUUeaQpyOPiWGCyi0sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269536948"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 18 Aug 2026 06:36:30 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: dri-devel@lists.freedesktop.org,
	rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 jani.nikula@linux.intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v5] drm/drv: Convert wedged event string building to seq_buf
Date: Tue, 18 Aug 2026 19:06:11 +0530
Message-ID: <20260818133610.496374-2-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
The original scnprintf()-based loop required a manual pre-flight
bounds check.

Replace the manual bookkeeping with seq_buf, which tracks overflow
internally. seq_buf_printf() writes each "method," token into the
buffer.

On overflow, len retains the position of the last
successful write, so the trailing comma is stripped cleanly without
including any partial method name in the uevent payload.

Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v2:
- Add proper logic to handle recovery string. (Raag)

v3:
- Convert manual bounds check to seq_buf. (Jani Nikula)
- Use drm_WARN_ONCE() instead of drm_WARN_ON() for overflow. (Raag)

v4:
- Use DECLARE_SEQ_BUF. (Jani)
- Warn overflow at end of loop.

v5:
- Check and warn overflow inside loop. (Raag)
---
 drivers/gpu/drm/drm_drv.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index cb53baa70995..8c0879c336e5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/sched.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 #include <linux/srcu.h>
@@ -576,27 +577,31 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
 int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 			 struct drm_wedge_task_info *info)
 {
-	char event_string[WEDGE_STR_LEN], pid_string[PID_STR_LEN], comm_string[COMM_STR_LEN];
-	char *envp[] = { event_string, NULL, NULL, NULL };
-	const char *recovery = NULL;
-	unsigned int len, opt;
+	DECLARE_SEQ_BUF(event_string, WEDGE_STR_LEN);
+	char pid_string[PID_STR_LEN], comm_string[COMM_STR_LEN];
+	char *envp[4] = { };
+	unsigned int len = 0, opt;
 
-	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
+	seq_buf_puts(&event_string, "WEDGED=");
+	envp[0] = event_string.buffer;
 
 	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
-		recovery = drm_get_wedge_recovery(opt);
+		const char *recovery = drm_get_wedge_recovery(opt);
 		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
 			break;
 
-		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
+		if (drm_WARN_ON_ONCE(dev, seq_buf_printf(&event_string, "%s,", recovery)))
+			break;
+
+		len = seq_buf_used(&event_string);
 	}
 
-	if (recovery)
-		/* Get rid of trailing comma */
-		event_string[len - 1] = '\0';
+	if (len)
+		/* Strip trailing comma; also discards any partial overflow entry */
+		event_string.buffer[len - 1] = '\0';
 	else
-		/* Caller is unsure about recovery, do the best we can at this point. */
-		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
+		/* No complete entry written, do the best we can at this point. */
+		snprintf(event_string.buffer, event_string.size, "%s", "WEDGED=unknown");
 
 	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
 		 "but no recovery needed" : "needs recovery");
-- 
2.48.1

