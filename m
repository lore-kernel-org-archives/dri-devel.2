Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA91CDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3951C10F161;
	Thu, 25 Jun 2026 07:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IeFTsAUw";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35B710E1B3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373114;
 bh=a7ii+9rfC/tKr/MGqcO0Pa/aQ2x3shxvSHmJWjGJbLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IeFTsAUw1DMF3AqV/oOfWw0Rv6GNvO3kTMTKLCKg+oGypkttTIKwSaqB4BUS2pSzU
 I95tGgtbNz7Ug8CYkgQgHU0cbt4mj3/2r6uRYWyY6gHs4LR4pDVY8dhzwxg5u3vLMI
 KlB1CjiSjOgxHQ9pQ6TnOdOy+MiMMGBBq8Hf6/dNYmjZcavZZJbu0vGUiU+tHW0QM9
 8FUFf1tMlogmYgookWlSQ2ye2fDnqxwtH18rL2qz6jFNpNQGo9uJlOEEQWNlT5eRsr
 3zrssdHs3SpBBjszDR1aO6SwhpQGaAOaP6D6GNNR2/QT8aoT1ZPGmgT+azVBVTr/Xr
 1sYu6ITQdHxfQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 28DC817E0CF3;
 Thu, 25 Jun 2026 09:38:34 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 09:38:13 +0200
Subject: [PATCH v4 03/14] drm/panthor: Fix a leak when a group is evicted
 before the tiler OOM is serviced
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v4-3-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=1131;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=a7ii+9rfC/tKr/MGqcO0Pa/aQ2x3shxvSHmJWjGJbLU=;
 b=22HB+QZGewnpRDmFWYFcQnK9GV0nJ9ji83g+cz/x9dAVr8D6hS5taH3X0LMm7MvUVOWlUZU6J
 ZZImh+0na3gAdr3IiVfs0msvlJoDHRLsehX84I9LvDUuhflfh2yCkBl
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

A group ref is tied to the pending tiler_oom_work, so we need to release
it if the cancel was effective.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=7
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..a19285806c66 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1057,7 +1057,8 @@ group_unbind_locked(struct panthor_group *group)
 
 	/* Tiler OOM events will be re-issued next time the group is scheduled. */
 	atomic_set(&group->tiler_oom, 0);
-	cancel_work(&group->tiler_oom_work);
+	if (cancel_work(&group->tiler_oom_work))
+		group_put(group);
 
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = -1;

-- 
2.54.0

