Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC376C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E913A10EB09;
	Tue, 11 Aug 2026 10:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g8btHzNm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C273C10E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443468;
 bh=fzLWUDPtqoIwG8+ccSWaLGPju4rxuXjgRSA/ZeNnC6E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g8btHzNmnHcZ/N36x8L0IRMZMWbrhUFj3yteqbte6AGhUy8FuPLgRgOH62j0uYmfx
 lTBFatH658IgIVBM2aon7TS7NsbAK9ePQn8xVvPrGGaaVXvcciMZmL+WpO4EvJHAMT
 xznZPv1VXXnnghzKDnh6rMKBMeSaXUNvH2kT93GSI5duRb6/LjIlDDz3cP8Zoi0nxU
 EIl5OrfaCHnoHQ5Nl4JXNbFgK9ngEuqEqjY1d5+v5f9mIR8r4T8mf4AIMFu7n8EcCH
 /5nrmFLQ3jyEcSGlK6ueXffHxW7+UEYlkzdcun3GM3RjD4I1Ikncug74FXjHAerI8B
 7aw51Sq0VOedg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 287F317E0EF0;
 Tue, 11 Aug 2026 12:17:48 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:36 +0200
Subject: [PATCH v2 02/17] drm/panthor: Further delay reset work enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-2-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=1731;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=fzLWUDPtqoIwG8+ccSWaLGPju4rxuXjgRSA/ZeNnC6E=;
 b=v4QUI2eEqCE7l0H1iOl8FYGceTetF0ckuE0U63QSdLYPeVsRHBo+njSpylXOytl3AWnZwOBuZ
 dkuYk/sZV8nAb9Vb+rBv5HIXPNqDFh3ikRWfqACLMayuod2fQqRR7JA
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
index c41de1b61533..5355c4074f1f 100644
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

