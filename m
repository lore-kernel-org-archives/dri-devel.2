Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA9610F29B;
	Thu, 13 Aug 2026 10:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HI5Hesp2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07A410E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618623;
 bh=xI8I0lr4pGuzLdwHDJZn57UgsOKNKdZVy3qzaWJ4aSY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HI5Hesp2TywEI3909E1KMKOn8lfeYfeVfVA1Fldrdl2LPFFSkRury58LPU4qHAqbV
 TlUnDxhMoPC2UdFFqWzNh5avDT2bLOwDnNg0Ft/irn/NbxJalrRY/uUiVp8UPLw0ku
 A37OLW9b81DQfe8WZhV8p+s2sYwtxVOgp9TdoouOSVOJOo8B9YghLSOlL/xzkeQ39B
 FbQcoSE5W0zDkmTvsNHZJ/vVZvOVgS4jMgP8hfSG+OJ6uBz35PrGTaN7ASy7NGEHAM
 MIbB/v8jzdYrqnRK4hj5486wGYyc3cn+s5cXywCVcHx3rTFJqiGHszwEqD1/Eha7/w
 XT9URLcWHIn+Q==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 086A917E074F;
 Thu, 13 Aug 2026 12:57:02 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:56:59 +0200
Subject: [PATCH v3 01/17] drm/panthor: Disable reset work before unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-1-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=3456;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=xI8I0lr4pGuzLdwHDJZn57UgsOKNKdZVy3qzaWJ4aSY=;
 b=oYx8CxgnoOGDmQYptPXUEpQ5xQ+hZOP054vXJAXqipDwRXznpRk6+M4rj5SPBYTGR6GCY+qNv
 67sElHkScPEB6xj4Yl0+sA6DJhGMNKiV5GA3P3V3x+DhL5fRYVQNire
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

Unplug is supposed to be the end of the road, so we need to make sure
reset works won't execute while we're cleaning up everything as part
of the unplug, otherwise it would mess up the internal state.

In order to be able to call disable_work_sync() in the unplug
path, we need to defer the unplug triggered by the reset logic,
otherwise we would deadlock.

Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_device.h |  3 +++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 0b25abebb803..7c55d0c45cfd 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -79,6 +79,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 		return;
 	}
 
+	/* Make sure we're not interrupted by resets while we're unplugging. */
+	disable_work_sync(&ptdev->reset.work);
+
 	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
 
 	/* Call drm_dev_unplug() so any access to HW blocks happening after
@@ -91,6 +94,13 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	mutex_unlock(&ptdev->unplug.lock);
 
+	/* Unplug triggered by a device removal might race with the deferred
+	 * one queued by the reset work. The function covers this concurrent
+	 * unplug situation, but if we can disable the work before its
+	 * execution, that's still better.
+	 */
+	disable_work(&ptdev->unplug.work);
+
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
@@ -114,6 +124,13 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	complete_all(&ptdev->unplug.done);
 }
 
+static void panthor_device_unplug_work(struct work_struct *work)
+{
+	struct panthor_device *ptdev = container_of(work, struct panthor_device, unplug.work);
+
+	panthor_device_unplug(ptdev);
+}
+
 static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
 {
 	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
@@ -148,8 +165,9 @@ static void panthor_device_reset_work(struct work_struct *work)
 	drm_dev_exit(cookie);
 
 	if (ret) {
-		panthor_device_unplug(ptdev);
+		disable_work(&ptdev->reset.work);
 		drm_err(&ptdev->base, "Failed to boot MCU after reset, making device unusable.");
+		queue_work(ptdev->reset.wq, &ptdev->unplug.work);
 	}
 }
 
@@ -206,6 +224,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	 */
 	*dummy_page_virt = 1;
 
+	INIT_WORK(&ptdev->unplug.work, panthor_device_unplug_work);
 	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
 	disable_work(&ptdev->reset.work);
 	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq", 0);
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0fda64fbe5f2..ea23dde90fea 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -264,6 +264,9 @@ struct panthor_device {
 		 * operation is done.
 		 */
 		struct completion done;
+
+		/** @work: Unplug work. */
+		struct work_struct work;
 	} unplug;
 
 	/** @reset: Reset related fields. */

-- 
2.55.0

