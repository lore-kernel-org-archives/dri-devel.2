Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7820CCDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F32310F177;
	Thu, 25 Jun 2026 07:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SjhfxARZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9321F10E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373119;
 bh=Xr/nGJhr4vmnsJyHEbBKAAc1Bov0m9Nj0zHBTBkh3sI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SjhfxARZ0heGwmLWU8GurVoNdrAjGi0jANu81/jwA0VGXRSQiiGlByZiIDDDuY+6X
 zAMk3AG5ceGTRglSW6DY6NyuCpixMKhbxgDJH9mM7fRSR5M57sYjrhWP5QRC/4SBJA
 GpPUF36GFfsAN993sSERprf403FoyFGWA+vYaIZ19vxxmfwMeq4k5ZbMeALt+CKcNe
 RLcoktLbmco/zm7UZGBJ2T/A3DQzW/9N8z+2EXuQb0N7WsUO3pBBkBoMuv/KVguKh7
 wakOcn851KkmjCVCscBTnF7RHWY/FbOxw6cKyUbpl52b7/4+XZrE2IS07WGG0C+HqO
 4dgfKaluw1bQg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C019317E14FA;
 Thu, 25 Jun 2026 09:38:38 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 09:38:20 +0200
Subject: [PATCH v4 10/14] drm/panthor: Get rid of panthor_group::fatal_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v4-10-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=1093;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=Xr/nGJhr4vmnsJyHEbBKAAc1Bov0m9Nj0zHBTBkh3sI=;
 b=qb/8HNMjzWFGK0tbv0Ysb318acm46/EskrhWtKg6wKbfaGlY17BjrzMbSXRVXo0MDenbog/T7
 0CMajDa4WqJDbawKDij7YprtH+sshHMPnIGoRbXZi7k0+UTglxKEyov
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

This lock is never used, and we're about to make fatal_queues an
atomic to cope with concurrent updates.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 99381b71dd58..c361cbaac0cd 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -565,9 +565,6 @@ struct panthor_group {
 	/** @idle_queues: Bitmask reflecting the idle queues. */
 	u32 idle_queues;
 
-	/** @fatal_lock: Lock used to protect access to fatal fields. */
-	spinlock_t fatal_lock;
-
 	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
 	u32 fatal_queues;
 
@@ -3671,7 +3668,6 @@ int panthor_group_create(struct panthor_file *pfile,
 	if (!group)
 		return -ENOMEM;
 
-	spin_lock_init(&group->fatal_lock);
 	kref_init(&group->refcount);
 	group->state = PANTHOR_CS_GROUP_CREATED;
 	group->csg_id = -1;

-- 
2.54.0

