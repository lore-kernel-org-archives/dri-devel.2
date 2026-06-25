Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C92CDE00A
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76BE10F29A;
	Thu, 25 Jun 2026 12:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IVqE8aEn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B49110E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391232;
 bh=svc/sSg0MQErtiJsmeWhPL35iTOYisGGDBfUUJZ83XI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IVqE8aEnvO5m1Bwqc64rcbJJfj/CSMbzSrd/dYGFdVpQvMR+aUXRV6lby/XXK4cXa
 gUVDmTlcbjx/U0GAvy4MezLxNvfC/49zrKwmzMvsND3rSsFYcU3D6VlqEjlVUNfzG6
 fhJSnYWXEltLYlQk2g6PvtXOS+6EQHtVE2HKRpxpxPeVdufq7zFlTHk/3wnhZQpP+5
 vbAFzsjCYYstq+wWOBy0ljG2tjxj0J0PO50YFxwwsMYOSn2gkdG9uLLzwEemkU6HvD
 WXDfwHMwLJIq0hG6VpDgXbOPHQAGKfMDhLf+ZJhxL4g4JMyOQlMNMkxzYam6WrFlOS
 t/rZojiNv979g==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 928DB17E0E48;
 Thu, 25 Jun 2026 14:40:31 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:29 +0200
Subject: [PATCH 03/11] drm/panthor: Fix UAF on works queued to
 panthor_cleanup_wq
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1347;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=svc/sSg0MQErtiJsmeWhPL35iTOYisGGDBfUUJZ83XI=;
 b=8jhS++k+3i31gOxoKbPAUjOPEhesK5G4rJdspiVQSsqao8JCu99Tl0JAgUKAmb5mAJJfH3i9J
 //9rPfZxYK6BRRO+8rbg30OaMkcz4j4kZTAJjvTXoQibPS6y1Ra8ruD
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

If we don't drain the panthor_cleanup_wq before
unregistering/destroying the panthor_device, we might end up with
cleanup works that are executed after the device is gone.

Add a drain_workqueue() call in panthor_device_unplug() to prevent
that.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 0b25abebb803..a0774e28aa94 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -101,6 +101,11 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_gpu_unplug(ptdev);
 	panthor_pwr_unplug(ptdev);
 
+	/* Make sure works queued to panthor_cleanup_wq are executed
+	 * before the device is destroyed.
+	 */
+	drain_workqueue(panthor_cleanup_wq);
+
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 

-- 
2.54.0

