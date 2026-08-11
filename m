Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBF3C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B35F10E2F7;
	Tue, 11 Aug 2026 10:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EuXIA5lu";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625AD10E2F8
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443468;
 bh=ycLtDUILBUNGvGA3TCZuAZrvo03VF+JiaIir96T3EKQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EuXIA5luX54UHnD5ViwyRpm0i69gStmk6K4DIyFIiDilYjP6VV73DYCL9cG4xXvmC
 VJMEQbEMqmmS658YBzvs6coez1VwpE210eA7IBs0geN+9A8IIZyoM0PBgUwgd6syG1
 tuI4ubPsUTkZNW+y4sqGBmLXvu822NHDBh2br7oUNzGXk2NpXYj7ZUGWEi1+YGHZK+
 3hKQW+DS+AjEeXqiZNMBkGzg7bFzSGsVSzi0Z9jOL3loV/KvT04S3YUVeQu/6lBwG0
 /qSk4oArOOHe4MSMo2NJx4o3VWqg+nWCOI4ev4xeijJ/shcw3JLQfJfP495Q3Y1O1h
 X6Q3/48oZLslg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9DE0917E0778;
 Tue, 11 Aug 2026 12:17:47 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:35 +0200
Subject: [PATCH v2 01/17] drm/panthor: Disable reset work before unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-1-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=3214;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ycLtDUILBUNGvGA3TCZuAZrvo03VF+JiaIir96T3EKQ=;
 b=UaWMZzECfriH7c2mI5nVv+K1t5Pcuwy7hfBFBQQQ2zsv78tVj9wFPEij3gdcIAqYf3jWxa8Df
 P7RKw/ZytyOBHqnlufo3RweVTFv4a+8P/fckK/hooMqAdpZU2qP8jTE
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
index 0b25abebb803..c41de1b61533 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -91,6 +91,16 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	mutex_unlock(&ptdev->unplug.lock);
 
+	/* Unplug triggered by a device removal might race with the deferred
+	 * one queued by the reset work. The function covers this concurrent
+	 * unplug situation, but if we can disable the work before its
+	 * execution, that's still better.
+	 */
+	disable_work(&ptdev->unplug.work);
+
+	/* Make sure we're not interrupted by resets while we're unplugging. */
+	disable_work_sync(&ptdev->reset.work);
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

