Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF6606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=II0AlLSQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E99F10E864;
	Wed,  4 Nov 2026 08:46:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0AC10E864
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793781969; x=1825317969;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QQPB+l/8r1l1JqwpEkuoPg/A3wTnA4sP9cSgtX9V9os=;
 b=II0AlLSQk3+DYDc5sdyH+BudjownmwqV5yVrUlOuN6ZtWsMGmShf4MfL
 rVFAJGfv/4Gal8nSJkkqsvHwBPjVU5qyKnoA+Mpw90rXPMf+kWipiy2D4
 GrukP3itThy2yLFchhEkHNsmhLjWa3/DRlU65evAROE0i9v0csMTSZGEY
 rsKbupa4Ce4A0vFiVRmbFc8WqHfHdtVD2ni1h/+mb27oxGdLBblklKROX
 dWl4YSTnQQNhvnN5Z148evZ9h2++BovtKrX1S5JylpuVDTf534n8zUX8J
 DOvjHHXIGv/mosqR8IE3HXdOnAUIc2kHv6MDTpsE3Cu105ZbaqajTFNDX w==;
X-CSE-ConnectionGUID: izexVut9S1q3bpWb/3JDDw==
X-CSE-MsgGUID: dmvBj9bxTHWe87AAVNyfdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2542463"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2542463"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:46:08 -0800
X-CSE-ConnectionGUID: ImrgDv3dQp6unV3JJ8hMtg==
X-CSE-MsgGUID: MUO8KXLkRYy2YYy3WkKY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6671252"
Received: from yufei-super-server.sh.intel.com ([10.239.92.104])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:46:06 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Sean Paul <sean@poorly.run>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 linux-kernel@vger.kernel.org,
 syzbot+f5ecf25277b844fd38f2@syzkaller.appspotmail.com,
 Fei Yu <fei.yu@intel.com>
Subject: [PATCH] drm/probe-helper: Don't run output polling on an unplugged
 device
Date: Wed,  4 Nov 2026 16:51:59 +0800
Message-ID: <20261104085159.1074597-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fei Yu <fei.yu@intel.com>

syzbot reported a use-after-free in the output poll worker of a udl
device that was being disconnected:

  BUG: KASAN: slab-use-after-free in kobject_get_path+0x91/0x2f0 lib/kobject.c:158
  Read of size 8 at addr ffff88802a29ee18 by task kworker/1:2/1654
  Workqueue: events output_poll_execute
  Call Trace:
   kobject_get_path+0x91/0x2f0 lib/kobject.c:158
   kobject_uevent_env+0x29e/0x9e0 lib/kobject_uevent.c:548
   drm_sysfs_hotplug_event+0x10e/0x150 drivers/gpu/drm/drm_sysfs.c:451
   output_poll_execute+0x846/0xab0 drivers/gpu/drm/drm_probe_helper.c:854
  ...
  Freed by task 25:
   kobject_put+0x222/0x550 lib/kobject.c:737
   cleanup_glue_dir+0x1b2/0x220 drivers/base/core.c:3487
   device_del+0x77d/0x8f0 drivers/base/core.c:3986
   drm_minor_unregister drivers/gpu/drm/drm_drv.c:226 [inline]
   drm_dev_unregister+0x436/0x700 drivers/gpu/drm/drm_drv.c:1185
   drm_dev_unplug+0x4b/0xb0 drivers/gpu/drm/drm_drv.c:507
   udl_usb_disconnect+0x3e/0x50 drivers/gpu/drm/udl/udl_drv.c:115

udl calls drm_dev_unplug() on disconnect and stops the output polling
only later from the managed release of the drm_device. In between, the
poll worker keeps running. When the device goes away, the EDID read in
the connector's detect fails, the connector status changes, and the
worker sends hotplug uevents on dev->primary->kdev. This runs
concurrently with drm_minor_unregister(), whose device_del() drops the
"drm" class glue directory that is the parent of the minor's kobject.
kobject_get_path() then walks the freed parent.

Since commit ff9cb6d2035c ("drm/udl: Unregister device before cleaning
up on disconnect"), nothing orders the poll worker against the
unregistration. Any driver that uses drm_dev_unplug() together with
connector polling has the same problem.

Make the poll worker a drm_dev_enter()/drm_dev_exit() critical section.
drm_dev_unplug() sets dev->unplugged and calls synchronize_srcu() before
drm_dev_unregister(), so a running poll pass finishes before the minors
are unregistered, and later passes return without probing or sending
events. A poll pass on an unplugged device has nothing useful to report
anyway. Drivers that never call drm_dev_unplug() are not affected,
because drm_dev_enter() always succeeds for them.

Fixes: ff9cb6d2035c ("drm/udl: Unregister device before cleaning up on disconnect")
Reported-by: syzbot+f5ecf25277b844fd38f2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f5ecf25277b844fd38f2
Signed-off-by: Fei Yu <fei.yu@intel.com>
---
The fix is in the probe helper rather than in udl, because every driver
that calls drm_dev_unplug() while connector polling is still active has
the same race: udl and vc4 (poll cleanup is drmm-managed) and imx/dc
(drm_kms_helper_poll_fini() after drm_dev_unplug()). gud is not affected,
it stops polling before the unplug. A udl-only alternative is to call
drm_kms_helper_poll_disable() before drm_dev_unplug(). That reverts the
ordering that ff9cb6d2035c wanted, and userspace can still re-arm the
poll work through a connector probe in between.

Testing (v7.4-rc1, x86_64 KASAN, QEMU, same config for both kernels,
emulated DisplayLink adapter on raw-gadget/dummy_hcd):
- syzbot has no reproducer. A deterministic test opens the card, unplugs
  the device and watches kernel uevents for 25 s (poll period 10 s).
  base: 2 "change@/card1" HOTPLUG uevents for the already removed card
  (DEVPATH without its parent: the poll worker is still running on the
  unregistered device). patched: 0.
- Stress with connect/unplug cycles while the connector status flips on
  every probe: no KASAN report on base or patched in ~165 cycles each.
  The UAF window itself is very narrow, so the KASAN splat has not been
  reproduced locally.
- DRM KUnit: 667/667 on base and patched. W=1: no new warnings.

 drivers/gpu/drm/drm_probe_helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 856b40fdaac4..a10e72ff2d3f 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -35,6 +35,7 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_managed.h>
@@ -775,10 +776,19 @@ static void output_poll_execute(struct work_struct *work)
 	enum drm_connector_status old_status;
 	bool repoll = false, changed = false;
 	u64 old_epoch_counter;
+	int idx;
 
 	if (!dev->mode_config.poll_enabled)
 		return;
 
+	/*
+	 * Don't poll an unplugged device. drm_dev_unplug() waits for this
+	 * section to finish before it unregisters the device, so the hotplug
+	 * events below never race with the removal of the sysfs device.
+	 */
+	if (!drm_dev_enter(dev, &idx))
+		return;
+
 	if (!drm_kms_helper_poll) {
 		if (dev->mode_config.poll_running) {
 			drm_kms_helper_disable_hpd(dev);
@@ -793,12 +803,12 @@ static void output_poll_execute(struct work_struct *work)
 		if (changed)
 			drm_kms_helper_hotplug_event(dev);
 
-		return;
+		goto out;
 	}
 
 	if (!mutex_trylock(&dev->mode_config.mutex)) {
 		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
-		return;
+		goto out;
 	}
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
@@ -874,6 +884,9 @@ static void output_poll_execute(struct work_struct *work)
 
 	if (repoll)
 		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
+
+out:
+	drm_dev_exit(idx);
 }
 
 /**

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

