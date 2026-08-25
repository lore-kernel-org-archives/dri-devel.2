Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8601FC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAAD10E939;
	Tue, 25 Aug 2026 08:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="I+HzgIHi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FED110E93F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787644892;
 bh=Xf1RMzh8zNMc/EUp+sv/qMuFLlV70LvZ6DH8SenbbpA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=I+HzgIHikLvmfP62ws6RnebEFYr9mFrdUopUP6j+/PLaQ5/a592Mz9YAAABi/JypE
 pTBA0ZC98bmwv0fH3ELsP93AWLsayRYHvFL3p5U8UOvxTw6PyieQkz0Oa9JWkw0PB0
 n1vsFEIJpW5eniPdfgUauouclbmiFx0+SB0RbI0ArjFxbkznQnSYxpMrKMQXEAiSuT
 Wqb3ZQ8qeDD9zeZdJ2K9RylUGfDbMMvh9OtsK9IjBypSWxXI4r0KxxgB5OfJ0fizq+
 zJENaqYNb8/VcuyCuTK2lOcIDkDToZ8xVbR0BuVNlfUerdJFwzpbhrnXAFu6nZ3P63
 aLyowSVi2TGRQ==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F316B17E0B92;
 Tue, 25 Aug 2026 10:01:31 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 25 Aug 2026 10:01:25 +0200
Subject: [PATCH v7 4/9] drm/panthor: Don't update might_have_idle_groups in
 process_idle_event_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-panthor-signal-from-irq-v7-4-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
In-Reply-To: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787644889; l=1083;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=Xf1RMzh8zNMc/EUp+sv/qMuFLlV70LvZ6DH8SenbbpA=;
 b=oAFvWIOFi9MJfczVyKXWN2NFaVUoHJzC9JS5nxcDcK6OD4HDPfTEH+TYpcyESrVdJKy/RqESJ
 5JZsD5oEi7HAvxq2b/D3xXqKlkC7YEF4w2F7PnG/jIaLrmyFhsW0/ej
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

By scheduling an immediate tick, we already force idleness re-evaluation,
which gives the scheduler the opportunity to evict idle groups
and schedule onces that have jobs pending.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..baa06731797c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1733,8 +1733,6 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 
 	lockdep_assert_held(&sched->lock);
 
-	sched->might_have_idle_groups = true;
-
 	/* Schedule a tick so we can evict idle groups and schedule non-idle
 	 * ones. This will also update runtime PM and devfreq busy/idle states,
 	 * so the device can lower its frequency or get suspended.

-- 
2.55.0

