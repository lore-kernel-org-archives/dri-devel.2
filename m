Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204E2C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE1310F2A5;
	Thu, 13 Aug 2026 10:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dCiRGtYa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D44810E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618624;
 bh=EHCETmmaBKY4tlCFOl7DXmSmcJX3/lRHG/Z0dhkCCBI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dCiRGtYapTiehGuf3TK0ETgAZgK7QLB5897Oln4X/SElVwy8WM7TIde/37AoswLMl
 92DP3sX5zbPxXaKcOB5vkOVCkQq5j4N1vnB5BRPpmYxclCmHgfWz3Mr6hUcsXlVUgw
 qcECujPKkaHOcZrPG1dLFdMLCFwraFZKvLanHVzzF3mnKZHbHmE5BU3s95eDEgMi4x
 My+z0drnfHOVWRRK9CSGRDUwLEKgiWAdU9kvdCfg80b04oOPm73R2GjyWB3k2Fhnjn
 kcKKP131fnVuY+XmA4G5GycTbuIwL6jX5r60mxvaoxlk7oG+sNF3KP+QfqJ8XhIHnt
 Y1HMoXX6ZGXrA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 48FB317E0FE2;
 Thu, 13 Aug 2026 12:57:04 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:01 +0200
Subject: [PATCH v3 03/17] drm/panthor: Make sure reset requests in the
 resume path are not lost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-3-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=1748;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=EHCETmmaBKY4tlCFOl7DXmSmcJX3/lRHG/Z0dhkCCBI=;
 b=8oiVHgawooU/wPCe2cx8tk8l4PkTHAWIhtEnN0I+mju2AVvu1CXK2DzOU2w9x7Qlp16dbnox9
 4GKWUbq/QFXB/lmkSHxZYPqIsku8uSyHyrBjXygJWjPlFMZiDOMtADA
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

A reset might have been queued while we were resuming. Make sure it's
not lost by rescheduling it.

Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 47dc7faf9728..1a8f5ac24399 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -569,7 +569,24 @@ int panthor_device_resume(struct device *dev)
 	unmap_mapping_range(ptdev->base.anon_inode->i_mapping,
 			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
 	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_ACTIVE);
+
+	/* The smp_mb__after_atomic() is here to make sure the pm.state update
+	 * is flushed before we check the reset.pending bit, otherwise,
+	 * according to Sashiko, there's a with the checks that exist in
+	 * panthor_device_schedule_reset().
+	 * Not sure how real this is, because the try_cmpxchg_release() in
+	 * the mutex_unlock() path also acts as a barrier, but it's not a
+	 * fast-path anyway, so better safe than sorry.
+	 */
+	smp_mb__after_atomic();
 	mutex_unlock(&ptdev->pm.mmio_lock);
+
+	/* A reset might have been queued while we were resuming. Make sure
+	 * it's not lost by rescheduling it.
+	 */
+	if (atomic_read(&ptdev->reset.pending))
+		queue_work(ptdev->reset.wq, &ptdev->reset.work);
+
 	return 0;
 
 err_suspend_devfreq:

-- 
2.55.0

