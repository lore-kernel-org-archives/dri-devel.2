Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D9CC5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E67A10F2BF;
	Thu, 13 Aug 2026 10:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lXPypXlK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5048010F2BD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618636;
 bh=yvjNyDvIDWUHmkQb8BXOUq7ZO1YV8XU+9xgQkA7MlMc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lXPypXlKbouWAudnrLLJ+zjTgs/0GJPu/PeJyWSrwbo/dC+1/uP+Vy68gGPDZ55NI
 7IFbrRQ+2ZFfLF19qD3LxcIFzbkTHTOwDsG0WaHVMn/7PvAYkcroeeLtCefMPFgpAh
 6ZOym6kK1yY9vt2ovJ+tZeLoVFvLSjTTR7VtkI2WrTGFq7Q1cI5WGLFeeJbGCPM5DS
 IRhcZSsPfN1rHBtxKNW4inxmayTkpLdO2Z6djRDoYd83gSjYWssdUrhP6UShn0zA+7
 nxdqiZWvgVwf6RwA4wo4GQ6aHmFaV8TyEQgE5l9Xh9sMvHGt4TbRnPCvc2ib5nvqE0
 asMUSFdQnNAkA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5FC9817E0FE2;
 Thu, 13 Aug 2026 12:57:15 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:14 +0200
Subject: [PATCH v3 16/17] drm/panthor: Add a debugfs knob to simulate
 unplug failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-16-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=3076;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=yvjNyDvIDWUHmkQb8BXOUq7ZO1YV8XU+9xgQkA7MlMc=;
 b=fSbKqlIex6R/Acibkrhgu/QuJjQrUEkpddwHaCws/BfR2GAqZrxHUq6iwZjop7PyTK9odX55C
 663yZa7GCXRDLyZAeARvZKHLhyT18mDh8H3EpJMJGnmnPskN3yDZB2O
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
index db7bbe503d53..c6d4a97d60f6 100644
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
@@ -690,8 +693,33 @@ int panthor_device_suspend(struct device *dev)
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

