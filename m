Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B1C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F31010EB1B;
	Tue, 11 Aug 2026 10:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iMB9nbYx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FDE10E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443469;
 bh=0OePKVAEPcE3PmS+UKX8kJpdcShf9zGywxXUPRUZm6U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iMB9nbYxz+LKH7bR7fg/EUBLMp2ouxBkDAM/4umFfijvIQgWOFjKsCKDwM9MHdNPo
 Y6AETdl/ll7nnStC98yFj8hrygOARxqOmXlI0dBtfAFYNdcWP4+2kTb589+ambysji
 aGe204b5fU2qC/rRvoXO3zUPBRmXqegQsX7yBgEsO9575AkzcB7tb6k7MIX1H5oXoQ
 n/WxM5iL+3VG6RjCyBjM8xYboA9HFqjKnNpfVYxNgMnoLyMR7eZV1yQvfRpTWlXKZz
 coA3PqEWH5uhulnOoxKRMseUhinuFg18COX+YcnksSXQiT6zbf3ccjSxC35TWljhec
 RqAXgRWtP2X+A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A8D1317E0F35;
 Tue, 11 Aug 2026 12:17:48 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:37 +0200
Subject: [PATCH v2 03/17] drm/panthor: Make sure reset requests in the
 resume path are not lost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-3-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=1203;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=0OePKVAEPcE3PmS+UKX8kJpdcShf9zGywxXUPRUZm6U=;
 b=/8vHXxwABB8nXP1nq4deTo04O3q+XmvP5i0H07rSdxcACNg8albv6BGrMMwOqp8AXlnfCRDgx
 YDFNjSJCP+XBGZewyC7o3MH5VDYsixXJrnYgcVOzS5P0+SH9nL9Rta0
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
 drivers/gpu/drm/panthor/panthor_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 5355c4074f1f..2520158adb03 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -570,6 +570,13 @@ int panthor_device_resume(struct device *dev)
 			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
 	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_ACTIVE);
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

