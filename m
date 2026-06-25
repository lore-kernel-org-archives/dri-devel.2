Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D725CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4782E10F29F;
	Thu, 25 Jun 2026 12:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oJXBjFFV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6260F10F29F
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391236;
 bh=H2vAHHHsjLs0xG6S2+xUXGAtGgZm00QhXu+uCO/wy8E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oJXBjFFVMXlXslaBOJPvMkf1M4BiqgkgAYbyGmSSdXlkyHWwiBewd3mmQV2GqUnsD
 sb/lOqhVVHWRIokQK+MDZEfo2EVjo2LrWGh7vX+WGF1e8+cvZR+iztu4XMR5d1sIGw
 yNiwVvoRHUwMYCinQLm3v93aZshmbkbLlLr5Q/EEK5xgp3bgKyCq1uI/jUSbGkJe1n
 X7+BBkl+vO/jXhOKhnKVJ5MRLCNKC4ida9SQG2ByElsYS4p48/O7sJJRpRfztxEI1X
 uyAr7/cZDvpYxjI758H+PpnzJKfautpZDhpnHLizvrz/2ZED9/d0xhsuRrDtLO17xw
 SVXnlPv2V8/tA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D0BD17E0909;
 Thu, 25 Jun 2026 14:40:35 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:35 +0200
Subject: [PATCH 09/11] drm/panthor: Fix a leak when a group is evicted
 before the tiler OOM is serviced
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-9-b67ed973fea6@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1131;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=H2vAHHHsjLs0xG6S2+xUXGAtGgZm00QhXu+uCO/wy8E=;
 b=TvCoSXXes1TtdhDhLrdSfsF/b8epTv2YVYi4V+2CBgTLspmL0N9uLXbLutDFvOiGe6y+oStPR
 qjpO7SwdxYfCmOSfOi2F2V9RBZ5VqQ1r1VaXuWgSEtRdP21kvovdsR7
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
index ab3e13e44a26..5fe95d03f23e 100644
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

