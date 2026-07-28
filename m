Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A3DC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB99710E910;
	Tue, 28 Jul 2026 14:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wi0XNT3u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FC710E910
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785247614; x=1816783614;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TZINwW7YB7EhgbrD5JVJnkAjPkelIORdV7sgpRwLNIQ=;
 b=Wi0XNT3ujHkb4n++Uj4OSvFXsRAc1Ufqs0JJ8tbmxxrqIWnYK7aH8GP5
 ZlSncv7+JqxYETDF9ehodU9+Sbq6Oxelqjo+SHRdGtTXHSXT+9GuT0UGF
 FD0rM57AqHjWYmhLbyLB/SfiRes9659m3bR54qKtX6uQpuTe/h82WWk80
 H1ng2odW8b7LRNv+xr8y0oJFOsZDg/FvZCpq7EaL7Px3H7kESoIPKb6Eo
 GTRZMviJOE3n4LgU/FTgSNI4pu/8h/eJ3rxXC7FkPiCrmNeWfAuusaBZZ
 T3sfMrwqr7vCdfXsSoQ3Cq8FmaLVWMHCPeHrLXwFd6IOTwQOY947vg3AP A==;
X-CSE-ConnectionGUID: lIAMBDUOSXWxxLYtlWU0qw==
X-CSE-MsgGUID: 6c5L5yebSUGdNPSXx/BaBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85775156"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85775156"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 07:06:54 -0700
X-CSE-ConnectionGUID: ObVYU6/LR6+HOStR4Ue6QQ==
X-CSE-MsgGUID: mX5nnkaeT+6A7hqMrlENVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="255789521"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa010.fm.intel.com with ESMTP; 28 Jul 2026 07:06:49 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: dri-devel@lists.freedesktop.org,
	rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v3] drm/drv: Convert wedged event string building to seq_buf
Date: Tue, 28 Jul 2026 19:36:31 +0530
Message-ID: <20260728140630.891508-2-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
buffer, and seq_buf_has_overflowed() detects truncation immediately
after the write that caused it — using drm_WARN_ONCE() to report it.

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
---
 drivers/gpu/drm/drm_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e51ed959da89..6a5e3fa1350c 100644
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
@@ -578,15 +579,22 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
 	char *envp[] = { event_string, NULL, NULL, NULL };
 	const char *recovery = NULL;
 	unsigned int len, opt;
+	struct seq_buf buf;
 
-	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
+	seq_buf_init(&buf, event_string, sizeof(event_string));
+	seq_buf_puts(&buf, "WEDGED=");
+	len = seq_buf_used(&buf);
 
 	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
 		recovery = drm_get_wedge_recovery(opt);
 		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
 			break;
 
-		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
+		seq_buf_printf(&buf, "%s,", recovery);
+		if (drm_WARN_ONCE(dev, seq_buf_has_overflowed(&buf),
+				  "WEDGED event string truncated\n"))
+			break;
+		len = seq_buf_used(&buf);
 	}
 
 	if (recovery)
-- 
2.48.1

