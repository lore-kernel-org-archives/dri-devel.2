Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFF2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3E810F29E;
	Thu, 13 Aug 2026 10:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OJM9LTmd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FD210E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618624;
 bh=PBdu+Xj63LwmT7Unn82JWPZ339qRisXyIRnL2Axpdyw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OJM9LTmdoWjr4bsY+auFS01tvIu60GV+cSoc2Y5wnyNAoMQkJ2urr7NA4QRRGzY/b
 NbKfguRUngnXJlO2Jchq7D4Svo0jhZbTKSqMf3ZYctZtInwW6Z8gk2RoHfpHkNJPRK
 MmIKTeM6+hu/FI8w9bSyO8qYSRs7yHcBJWyM0j6vJZrEwkJXPKMZ0cpBGceTMw1tFz
 zVsK79z2ATN3PQ4RTmD15ZkAXKkh5BEc4MrQxxX6rbTQTwE/Osa2SkDUCusgFtFc/x
 hnHs/3He0ZngB8VgVBdmtKlgMWUkfp7r1UC329J+/UxDaHiLgmzpApLx59862e+gqU
 AHfLFfqgciYcQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A457817E0F85;
 Thu, 13 Aug 2026 12:57:03 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:00 +0200
Subject: [PATCH v3 02/17] drm/panthor: Further delay reset work enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-2-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=1731;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=PBdu+Xj63LwmT7Unn82JWPZ339qRisXyIRnL2Axpdyw=;
 b=UjNZNkX6p71jkYa/1EjQxJ03t3LbvTv5I/ZhkuQxthtwtxfSxFpqrEgTXTfI0NaeN4pr0HGpm
 3NZ8234/3xeCGH2+RqUS7VPzzS3hKqUMMO54Okq89gH2Um2c5jou1WB
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

There's no point re-enabling the reset work before the DRM device
registration succeeds, so move the enable_work() after the point where
nothing can fail anymore, and in the unlikely event where a reset was
pending, reschedule it.

Fixes: 1b8d771fb214 ("drm/panthor: Keep the reset work disabled until everything is initialized")
Closes: https://sashiko.dev/#/patchset/20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 7c55d0c45cfd..47dc7faf9728 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -305,9 +305,6 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	panthor_gem_init(ptdev);
 
-	/* Now that everything is initialized, we can enable the reset work. */
-	enable_work(&ptdev->reset.work);
-
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);
@@ -316,6 +313,14 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_disable_autosuspend;
 
+	/* Now that everything is initialized, we can enable the reset work.
+	 * If there was a reset pending, clear and reschedule, otherwise the
+	 * reset.pending bit is stuck.
+	 */
+	enable_work(&ptdev->reset.work);
+	if (atomic_read(&ptdev->reset.pending))
+		queue_work(ptdev->reset.wq, &ptdev->reset.work);
+
 	pm_runtime_put_autosuspend(ptdev->base.dev);
 	return 0;
 

-- 
2.55.0

