Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA89BC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 00:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C262F10E243;
	Sun, 23 Aug 2026 00:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="flFxT6p2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B03510E243
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787445246; x=1818981246;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SZCguxSUJcC+bS+kDuWpIDqhRj/W+oA5tXyZTadgcEg=;
 b=flFxT6p27Fhgev1yCwLvPQ8O+Olq74B7mjtbOXeAqfoGF+TO9DU9I21s
 e0B1/Tjt5/4RpXJwV8bC3N3o/qfgETpzvG/lNSwekxX0pRZ/swOWb+7nw
 t+Ly5mlz98MNFVmY5S33gMUXTO5YoJgh/9s2f3+nZxF9kq/+CAtzAEJ/4
 JzLzkdaakl/3Z5u/xbaDsByQUPSbWoZSMp3mjR5m0XgRVggWsq/a4Jy+g
 u2SHqeYg2+3EzRiWkDZjuzrVrMFo9w9cib8469uw9VxwYWNjniouRW5GQ
 +FfcO8UBbuEBnB/xEIA6g62igO3FsxcxguPv6KZ0ZjajgDFHpOCB2Wev/ A==;
X-CSE-ConnectionGUID: MPdbvpufRrGDyFawyV5lgA==
X-CSE-MsgGUID: mMp29PZ0SBWxQIB34XedQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="86892117"
X-IronPort-AV: E=Sophos;i="6.25,237,1779174000"; d="scan'208";a="86892117"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2026 17:34:05 -0700
X-CSE-ConnectionGUID: A6adOKs6Qe+bamK29gvrxA==
X-CSE-MsgGUID: N1XF4zNmQ+S+RZbnaDE4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,237,1779174000"; d="scan'208";a="270482404"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 22 Aug 2026 17:34:01 -0700
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
Subject: [PATCH v6] drm/drv: Convert wedged event string building to seq_buf
Date: Sun, 23 Aug 2026 06:03:50 +0530
Message-ID: <20260823003349.587495-2-mallesh.koujalagi@intel.com>
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

On overflow, a warning is issued, len retains the position of the
last successful write, so the trailing comma is stripped cleanly
without including any partial method name in the uevent payload.

Assisted-by: Claude:claude-Sonnet-4.6
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

v6:
- Rebase.
- Drop fix. (Raag)
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

