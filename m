Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D74C5CFD9
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4B10EB33;
	Tue, 11 Aug 2026 10:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PrRsa3Bp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406ED10E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443476;
 bh=7N37NOXE6t6LYdtHY0SctYLGB3NwQAvWVebTTDpQLj0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PrRsa3BpGICCHsRY14WqT0OWimJLNCQzl1BCmU9s1jIXl794EP2Lcs136evfpMI6e
 SndTPSTux1U0X6OAW1oxonFIZLqUeLUen0QH3Y3ZjkgbldtNX6fPyC8mV5or40abo4
 PmdhQIC237R/2vgLM1AKLDxvkQAj9C7wSxBw98mg5LRJvv61WPnAmHlOKppnf3r0vO
 Xw2xTJFEj4xalPC9GMXVCDJeVmZWjvNWZ6PsYTJOOjrct+Fo7al7zgXojB5TxkPN9i
 ZelJ7LWIqJn40VgQMbGrRBd0PLo+SeQlxbnJVEeN2BdAOWweJyRmvT555WCeiQRATo
 Ka5UMkegPyI4w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A444017E12AC;
 Tue, 11 Aug 2026 12:17:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:50 +0200
Subject: [PATCH v2 16/17] drm/panthor: Add a debugfs knob to simulate
 unplug failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-16-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443467; l=3076;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=7N37NOXE6t6LYdtHY0SctYLGB3NwQAvWVebTTDpQLj0=;
 b=eIwFSb1TMMVWONvICcJN0HA92yitzHVt2oSWHWis4iLtsPgz1EV79nZAPD4ChAr5B91x75j+I
 G+IXEk2YD7WCui198R3h9sPDFhGr+rC1PvbQaJO1ngzf6LDZjvpetyR
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Unplug failures are almost impossible to reproduce in practice, so let's
add a debugfs knob to simulate those.

With this new knob, we can check this error case with the following
sequence:

 # echo 1 > /sys/kernel/debug/dri/128/fake_unplug_failure
 # <start-some-GPU-workload>
 # echo fb000000.gpu > /sys/module/panthor/drivers/platform\:panthor/unbind
 # <stop-the-GPU-workload>

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index d037c89e6198..012edf5d590c 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -4,6 +4,7 @@
 /* Copyright 2023 Collabora ltd. */
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
@@ -81,6 +82,8 @@ static int panthor_device_stop_before_unplug(struct panthor_device *ptdev)
 	 * procedure.
 	 */
 	ret = panthor_hw_soft_reset(ptdev);
+	if (!ret && ptdev->unplug.fake_failure)
+		ret = -EIO;
 
 	clk_disable_unprepare(ptdev->clks.core);
 	return ret;
@@ -676,8 +679,33 @@ int panthor_device_suspend(struct device *dev)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static int panthor_device_fake_unplug_failure_get(void *data, u64 *val)
+{
+	struct panthor_device *ptdev = data;
+
+	*val = ptdev->unplug.fake_failure ? 1 : 0;
+	return 0;
+}
+
+static int panthor_device_fake_unplug_failure_set(void *data, u64 val)
+{
+	struct panthor_device *ptdev = data;
+
+	ptdev->unplug.fake_failure = val ? true : false;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_unplug_failure_fops,
+			 panthor_device_fake_unplug_failure_get,
+			 panthor_device_fake_unplug_failure_set, "%llu\n");
+
 void panthor_device_debugfs_init(struct drm_minor *minor)
 {
+	struct panthor_device *ptdev = container_of(minor->dev, struct panthor_device, base);
+
+	debugfs_create_file("fake_unplug_failure", 0644,
+			    minor->debugfs_root, ptdev,
+			    &panthor_device_fake_unplug_failure_fops);
 	panthor_mmu_debugfs_init(minor);
 	panthor_gem_debugfs_init(minor);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 8c9177cf5da2..b2788373bfa9 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -282,6 +282,14 @@ struct panthor_device {
 		 * any BO attached to an active VM, ...).
 		 */
 		bool leak_active_resources;
+
+		/**
+		 * @fake_failure: When true, pretend the SOFT_RESET in the unplug path failed.
+		 *
+		 * This is important to check that we're doing the right thing in this very
+		 * unlikely case.
+		 */
+		bool fake_failure;
 	} unplug;
 
 	/** @reset: Reset related fields. */

-- 
2.55.0

