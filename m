Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D80C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6CB10E990;
	Tue,  4 Aug 2026 10:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LI6crjvx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32BD10E687
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838195;
 bh=4PEo6ltYK2sqYwCSiPvreVKFxzAiD3FX1R2hrd+AH3U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LI6crjvxTIltXjO90Pi3swewEMUtJJDKDw3R8nLTyiv8QKuJEsGxAtjNXf7W0Ng/b
 eVoqQKyA/9mmeC6YmyNcmS/6K3q1eckeWg+Qg6sZ/Hup8/7dlxmqw+jL9tD/KphWjO
 9zZkL7uFUuAGyfEZuBM3BspDpL8kAgmZwkRRbiBlzVKchPclkBQN2FLulawJEP1fTq
 XMPD7tbYwcuNZ35KC4PG4gfkElPmxojvBXPrdxz4xbDBfGpQW8pvDwwsjvAe97qObG
 WHwZfUmLR83luC9l26xW7Z09wujM9d5kZ6ngXi977bqETCR0pU4NkSTfyupFSjSphL
 HWp+Wdy+MPIbQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA9EF17E0896;
 Tue, 04 Aug 2026 12:09:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:40 +0200
Subject: [PATCH 01/12] drm/panthor: Disable reset work before unplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-1-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=848;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=4PEo6ltYK2sqYwCSiPvreVKFxzAiD3FX1R2hrd+AH3U=;
 b=8nNhBu4EHMzZ3AIzEC7YY7+Renks/fLDZZHuV5IlF3GxaRIRd4+Rs9owJzfBztP6OsgygCZcd
 IqjEJSwOLaFBKx1bP5/qno68gaT8MggcBBVFTRqcxbhS3LZKkx4bYkE
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

Make sure we're not interrupted by resets while we're unplugging.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 0b25abebb803..e7f5744bc1e3 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -86,6 +86,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	drm_dev_unplug(&ptdev->base);
 
+	/* Make sure we're not interrupted by resets while we're unplugging. */
+	disable_work_sync(&ptdev->reset.work);
+
 	/* We do the rest of the unplug with the unplug lock released,
 	 * future callers will wait on ptdev->unplug.done anyway.
 	 */

-- 
2.55.0

