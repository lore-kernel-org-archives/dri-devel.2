Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EB1C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC7510E12F;
	Tue,  4 Aug 2026 10:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jBeIo4MS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB1010E12F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838195;
 bh=bw8BRqvrbmjm2Ay6J4F1Fc0dW2CKmWRpBs5XRbS00t8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jBeIo4MSY3clcXip4Bd9qsbehpIkIUkbhWBStAaEz3sPxjcSj1OlhqRYqzRzvW6ib
 6z8TJC5XXBRQxdv2kJBQ1XnCdgZSjISuJom4lXOTcuGwK+p9i7TidF2BLevzrmu2dO
 60QwSJ+45wVLiCcKZLTSxTKAd5TWV4vf77kVQ+VBFbSqAQFr+DszyicSh1W0s6t/MV
 UdZQn0SI3rWi8K5GZq8xPkPXdvgFTHCGWSBzsbRRIo/rAgAsUBtwP0Hg1yZTKBwWQw
 oPx6QHYI4JxC/HAVVVD85KZq02Iw1Qc4vj+IvHDl/er89a1T6IqOuw0CIp2xpHmcRq
 NOZa//4gArKuA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 72BF217E08F0;
 Tue, 04 Aug 2026 12:09:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:41 +0200
Subject: [PATCH 02/12] drm/panthor: Further delay reset work enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-2-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=1523;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=bw8BRqvrbmjm2Ay6J4F1Fc0dW2CKmWRpBs5XRbS00t8=;
 b=jDRrvR9u2E3k4UcOAUI6nDgdY1gOwLvjeWack6yZDh5a+787VadxFqGDlGj7z1CVBJKrp7JG/
 h/rIhIYnfU7A366ca4TasEqiKxE9x8Uw0MlOXuwG5MRYnpvNnrwnhbK
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

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index e7f5744bc1e3..1aa86d00646f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -289,9 +289,6 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	panthor_gem_init(ptdev);
 
-	/* Now that everything is initialized, we can enable the reset work. */
-	enable_work(&ptdev->reset.work);
-
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);
@@ -300,6 +297,14 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_disable_autosuspend;
 
+	/* Now that everything is initialized, we can enable the reset work.
+	 * If there was a reset pending, clear and reschedule, otherwise the
+	 * reset.pending bit is stuck.
+	 */
+	enable_work(&ptdev->reset.work);
+	if (atomic_cmpxchg(&ptdev->reset.pending, 1, 0))
+		panthor_device_schedule_reset(ptdev);
+
 	pm_runtime_put_autosuspend(ptdev->base.dev);
 	return 0;
 

-- 
2.55.0

